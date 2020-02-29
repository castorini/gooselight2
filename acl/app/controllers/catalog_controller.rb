# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      qt: 'search',
      rows: 20,
      'facet.mincount': 1,
    }

    config.fetch_many_document_params = { fl: '*' }

    # items to show per page, each number in the array represent another option to choose from.
    config.per_page = [20, 50, 100]

    # solr field configuration for search results/index views
    config.index.title_field = 'title'

    config.add_results_document_tool(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)

    config.add_results_collection_tool(:sort_widget)
    config.add_results_collection_tool(:per_page_widget)
    config.add_results_collection_tool(:view_type_group)

    config.add_show_tools_partial(:bookmark, partial: 'bookmark_control', if: :render_bookmarks_control?)
    config.add_show_tools_partial(:email, callback: :email_action, validator: :validate_email_params)
    config.add_show_tools_partial(:sms, if: :render_sms_action?, callback: :sms_action, validator: :validate_sms_params)
    config.add_show_tools_partial(:citation)

    config.add_nav_action(:bookmark, partial: 'blacklight/nav/bookmark', if: :render_bookmarks_control?)
    config.add_nav_action(:search_history, partial: 'blacklight/nav/search_history')

    # facets fields
    config.add_facet_field 'year', label: 'Year', :limit => 10, :sort => :count, :collapse => true
    config.add_facet_field 'authors', :label => 'Author', :limit => 10, :sort => :count, :collapse => true
    config.add_facet_field 'sigs', :label => 'Special Interest Groups', :limit => 10, :sort => :count, :collapse => true
    config.add_facet_field 'venues', :label => 'Venues', :limit => 10, :sort => :count, :collapse => true
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    # ordering of the field names is the order of the display
    config.add_index_field 'author_string', label: 'Authors'
    config.add_index_field 'abstract_html', label: 'Abstract'
    config.add_index_field 'booktitle', label: 'Volume'
    config.add_index_field 'publisher', label: 'Publisher'
    config.add_index_field 'pages', label: 'Pages'
    config.add_index_field 'url', label: 'URL'

    # solr fields to be displayed in the show (single result) view
    # ordering of the field names is the order of the display
    config.add_show_field 'author_string', label: 'Authors'
    config.add_show_field 'abstract_html', label: 'Abstract'
    config.add_show_field 'booktitle', label: 'Volume'
    config.add_show_field 'publisher', label: 'Publisher'
    config.add_show_field 'pages', label: 'Pages'
    config.add_show_field 'url', label: 'URL'

    # search fields
    config.add_search_field 'contents', label: 'Contents' do |field|
      field.solr_parameters = { :df => 'contents', :qf => 'contents' }
    end

    config.add_search_field 'author_string', label: 'Authors' do |field|
      field.solr_parameters = { :df => 'author_string', :qf => 'author_string' }
    end

    # sort options
    config.add_sort_field 'score desc, title asc', label: 'relevance'

    # If there are more than this many search results, no spelling ('did you
    # mean') suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    # config.autocomplete_enabled = true
    # config.autocomplete_path = 'suggest'
  end
end
