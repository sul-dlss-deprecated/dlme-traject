# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/harvard'
extend Macros::DLME
extend Macros::Harvard
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Xml

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# Cho Required
to_field 'id', extract_harvard_identifier, strip
to_field 'cho_title', extract_harvard('/*/dc:title'), strip, first_only

# Cho Other
to_field 'cho_alternative', extract_harvard('/*/dc:title[last()]'), strip
to_field 'cho_contributor', extract_harvard('/*/dc:contributor'), strip
to_field 'cho_coverage', extract_harvard('/*/dc:coverage'), strip
to_field 'cho_creator', extract_harvard('/*/dc:creator'), strip
to_field 'cho_date', extract_harvard('/*/dc:date'), strip
to_field 'cho_date_range_norm', extract_harvard('/*/dc:date'), strip
to_field 'cho_description', extract_harvard('/*/dc:description'), strip
to_field 'cho_dc_rights', extract_harvard('/*/dc:rights'), strip
to_field 'cho_edm_type', extract_harvard('/*/dc:type[1]'),
         strip, transform(&:downcase), translation_map('not_found', 'types')
to_field 'cho_format', extract_harvard('/*/dc:format'), strip
to_field 'cho_language', extract_harvard('/*/dc:language'),
         split(' '), first_only, strip, transform(&:downcase), translation_map('not_found', 'iso_639-2')
to_field 'cho_publisher', extract_harvard('/*/dc:publisher'), strip
to_field 'cho_relation', extract_harvard('/*/dc:relation'), strip
to_field 'cho_subject', extract_harvard('/*/dc:subject'), strip

# Agg
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_harvard('/*/dc:identifier[last()]'), strip]
  )
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_harvard_thumb]
  )
end
to_field 'agg_provider', provider

to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country
