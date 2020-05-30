import json
import os
import argparse

def convert_collection(args):

    print("Converting collection...")
    # initiating input json
    input_path = os.path.join(args.collection_path)
    input_file = open(input_path)
    json_array = json.load(input_file)

    # initializing output jsonl file
    #output_path = os.path.join(args.output_folder, "output.json")
    #output_jsonl_file = open(output_path, 'w', encoding='utf-8', newline='\n')
    output = []
    document_count = 0

    # iterating through the json objects
    for json_object in json_array:

        # extracting the geoblacklight properties
        geoblacklight_version = "1.0"
        dc_description_s = json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:abstract"]["gco:CharacterString"]
        dc_format_s = "Paper"
        dc_identifier_s = json_object["gmd:MD_Metadata"]["gmd:dataSetURI"]["gco:CharacterString"]
        dc_language_s = json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:language"]["gco:CharacterString"]
        dc_publisher_s = json_object["gmd:MD_Metadata"]["gmd:contact"]["gmd:CI_ResponsibleParty"]["gmd:individualName"]["gco:CharacterString"]
        dc_rights_s = "Public"
        dc_title_s = json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:citation"]["gmd:CI_Citation"]["gmd:title"]["gco:CharacterString"]
        dc_type_s = json_object["gmd:MD_Metadata"]["gmd:hierarchyLevel"]["gmd:MD_ScopeCode"]["#text"]
        dct_temporal_sm = [json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:extent"]["gmd:EX_Extent"]["gmd:temporalElement"]["gmd:EX_TemporalExtent"]["gmd:extent"]["gml:TimePeriod"]["gml:beginPosition"],json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:extent"]["gmd:EX_Extent"]["gmd:temporalElement"]["gmd:EX_TemporalExtent"]["gmd:extent"]["gml:TimePeriod"]["gml:endPosition"]]
        dct_issued_s = json_object["gmd:MD_Metadata"]["gmd:dateStamp"]["gco:Date"]
        dct_provenance_s = json_object["gmd:MD_Metadata"]["gmd:contact"]["gmd:CI_ResponsibleParty"]["gmd:organisationName"]["gco:CharacterString"]
        # generating the coordinates of the box
        solr_geom = "ENVELOPE("
        for word in ["west", "east", "north", "south"]:
            solr_geom += json_object["gmd:MD_Metadata"]["gmd:identificationInfo"]["gmd:MD_DataIdentification"]["gmd:extent"]["gmd:EX_Extent"]["gmd:geographicElement"]["gmd:EX_GeographicBoundingBox"]["gmd:"+word+"Bound"+("Longitude"if word in ["west", "east"] else "Latitude")]["gco:Decimal"] + ("," if word != "south" else ")")
        layer_slug_s = json_object["gmd:MD_Metadata"]["gmd:fileIdentifier"]["gco:CharacterString"][:-8]
        layer_geom_type_s = "Point"



        # writing the new json to output.json
        new_json = {"geoblacklight_version": geoblacklight_version,"dc_description_s": dc_description_s, "dc_format_s": dc_format_s, "dc_identifier_s": dc_identifier_s, "dc_language_s":dc_language_s, "dc_publisher_s": dc_publisher_s, "dc_rights_s": dc_rights_s, "dc_title_s": dc_title_s, "dc_type_s": dc_type_s, "dct_temporal_sm": dct_temporal_sm, "dct_issued_s":dct_issued_s, "dct_provenance_s": dct_provenance_s, "layer_slug_s": layer_slug_s, "layer_geom_type_s":layer_geom_type_s, "solr_geom":solr_geom}

        #output_jsonl_file.write(json.dumps(new_json) + ')')
        output.append(new_json)
        document_count += 1

        if document_count % 1000 == 0:
            print(document_count, "documents have been converted")
    with open("test.json", "w") as f:
        json.dump(output,f)
    #output_jsonl_file.close()
    print("Converted", document_count, "documents")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='''Converts iso19115 files to Anserini jsonl files.''')
    parser.add_argument('--collection_path', required=True, help='iso19115 collection file')
    parser.add_argument('--output_folder', required=True, help='output file')
    # not used yet since dataset is very small
    parser.add_argument('--max_docs_per_file', default=1000000, type=int, help='maximum number of documents in each jsonl file.')

    args = parser.parse_args()

    if not os.path.exists(args.output_folder):
        os.makedirs(args.output_folder)

    convert_collection(args)
    print('Done!')