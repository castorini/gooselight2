# frozen_string_literal: true
class CatalogController < ApplicationController

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SearchBuilder#processed_parameters
    config.default_solr_params = {
      rows: 50
    }

    # items to show per page, each number in the array represent another option to choose from.
    config.per_page = [50,100,200]

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
    config.add_facet_field 'year', label: 'Year', :sort => 'index'
    config.add_facet_field 'topics', :label => 'Topic', :limit => 20, :sort => 'index'
    config.add_facet_field 'subjects', :label => 'Subject', :limit => 20, :sort => 'index'
    config.add_facet_field 'authors', :label => 'Author', :limit => 20, :sort => 'index'
    config.add_facet_field 'journals', :label => 'Journal', :limit => 20, :sort => 'index'
    config.add_facet_fields_to_solr_request!

    # solr fields to be displayed in the index (search results) view
    # ordering of the field names is the order of the display
    config.add_index_field 'title', label: 'Title'
    config.add_index_field 'authors', label: 'Authors'
    config.add_index_field 'journals', label: 'Journals'
    config.add_index_field 'topics', label: 'Topics'
    config.add_index_field 'subjects', label: 'Subjects'
    config.add_index_field 'downloadUrl', label: 'URL'
    config.add_index_field 'doi', label: 'DOI'

    # solr fields to be displayed in the show (single result) view
    # ordering of the field names is the order of the display
    config.add_show_field 'title', label: 'Title'
    config.add_show_field 'authors', label: 'Authors'
    config.add_show_field 'journals', label: 'Journals'
    config.add_show_field 'topics', label: 'Topics'
    config.add_show_field 'subjects', label: 'Subjects'
    config.add_show_field 'downloadUrl', label: 'URL'
    config.add_show_field 'doi', label: 'DOI'

    # search fields
    config.add_search_field 'contents', label: 'Contents' do |field|
      field.solr_parameters = { :df => 'contents' }
    end

    config.add_search_field 'authors', label: 'Author' do |field|
      field.solr_parameters = { :df => 'authors' }
    end

    config.add_search_field 'journals', label: 'Journals' do |field|
      field.solr_parameters = { :df => 'journals' }
    end

    config.add_search_field 'topics', label: 'Topics' do |field|
      field.solr_parameters = { :df => 'topics' }
    end

    config.add_search_field 'subjects', label: 'Subjects' do |field|
      field.solr_parameters = { :df => 'subjects' }
    end

    # sort options
    config.add_sort_field 'score desc, year desc, title asc', label: 'relevance'
    config.add_sort_field 'year desc, title asc', label: 'year'
    config.add_sort_field 'author asc, title asc', label: 'author'

    # If there are more than this many search results, no spelling ("did you
    # mean") suggestion is offered.
    config.spell_max = 5

    # Configuration for autocomplete suggestor
    # config.autocomplete_enabled = true
    # onfig.autocomplete_path = 'suggest'
  end
end
