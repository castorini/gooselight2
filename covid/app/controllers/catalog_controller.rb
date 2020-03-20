# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      q: "*",
      'facet.mincount': 1,
    }

    # items to show per page, each number in the array represent another option to choose from.
    config.per_page = [20,50,100]

    # solr field configuration for search results/index views
    config.index.title_field = 'title'

    # facets fields
    config.add_facet_field 'publish_time', :label => 'Year', :sort => 'index'
    config.add_facet_field 'authors', :label => 'Author', :limit => 10, :sort => 'count'
    config.add_facet_field 'journal', :label => 'Journal', :limit => 10, :sort => 'count'
    config.add_facet_field 'source_x', :label => 'Source', :sort => 'count'
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    # ordering of the field names is the order of the display
    config.add_index_field 'author_string', label: 'Authors'
    config.add_index_field 'journal', label: 'Journal'

    # search fields
    config.add_search_field 'contents', label: 'Contents' do |field|
      field.solr_parameters = { :df => 'contents' }
    end

    # sort options
    config.add_sort_field 'score desc, title asc', label: 'relevance'
    config.add_sort_field 'publish_time desc, title asc', label: 'year'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    config.autocomplete_enabled = true
    config.autocomplete_path = 'suggest'
  end
end
