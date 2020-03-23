module ApplicationHelper
  def get_document_link(doc)
    doi_url = " https://doi.org/"
    pmc_url = "https://www.ncbi.nlm.nih.gov/pmc/articles/"
    pubmed_url = "https://www.ncbi.nlm.nih.gov/pubmed/"
    s2_url = "https://www.semanticscholar.org/paper/"

    if doc.has?("doi")
      return doi_url + doc.fetch("doi").gsub("[", "").gsub("]", "").gsub("\"", "")
    elsif doc.has?("pmcid")
      return pmc_url + doc.fetch("pmcid")
    elsif doc.has?("pubmed_id")
      return pmc_url + doc.fetch("pubmed_id")
    elsif doc.has?("sha")
      return s2_url + doc.fetch("sha").split(";")[-1].strip()
    else
      return ""
    end
  end
end
