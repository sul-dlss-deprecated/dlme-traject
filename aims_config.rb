# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/date_parsing'
require 'macros/aims'

extend Macros::DLME
extend Macros::DateParsing
extend TrajectPlus::Macros
extend Macros::AIMS

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# CHO Required
to_field 'id', extract_aims('guid'), strip
to_field 'cho_title', extract_aims('title'), strip

# CHO Other
to_field 'cho_creator', extract_aims('author'), strip
to_field 'cho_date', extract_aims('pubDate'), strip
to_field 'cho_date_range_norm', extract_aims('pubDate'), strip, single_year_from_string
to_field 'cho_dc_rights', literal('Use of content for classroom purposes
                                  and on other non-profit educational websites is granted (and encouraged) with proper citation.')
to_field 'cho_description', extract_aims('summary'), strip
to_field 'cho_edm_type', literal('Sound Recording')
to_field 'cho_extent', extract_aims('duration'), strip
to_field 'cho_subject', extract_aims('image')

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_aims('link'), strip]
  )
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_thumbnail, transform(&:to_s)]
  )
end

to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country

# Arabic Agg
to_field 'agg_data_provider_ar', data_provider_ar
to_field 'agg_data_provider_country_ar', data_provider_country_ar
to_field 'agg_provider_ar', provider_ar
to_field 'agg_provider_country_ar', provider_country_ar
