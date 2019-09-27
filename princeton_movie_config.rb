# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::JSON

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::JsonReader'
end

# Cho Required
to_field 'id', extract_json('.identifier'), strip
to_field 'cho_title', extract_json('.title'), strip

# Cho Other
to_field 'cho_contributor', extract_json('.director'), strip
to_field 'cho_contributor', extract_json('.rendered_actors'), strip
to_field 'cho_date', extract_json('.date_created'), strip
to_field 'cho_date_norm', extract_json('.date_created'), strip
to_field 'cho_dc_rights', literal('https://rbsc.princeton.edu/services/imaging-publication-services')
to_field 'cho_description', extract_json('.member_of_collections'), strip
to_field 'cho_edm_type', literal('Image')
to_field 'cho_extent', extract_json('.extent'), strip
to_field 'cho_identifier', extract_json('.local_identifier'), strip
to_field 'cho_language', extract_json('.language'), strip
to_field 'cho_type', extract_json('.resource_type')
to_field 'cho_type', extract_json('.genre')

# Agg
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_json('.identifier'), strip]
  )
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_json('.thumbnail'), strip]
  )
end

to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country
