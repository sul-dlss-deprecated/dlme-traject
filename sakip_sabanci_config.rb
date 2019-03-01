# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/oai'

extend Macros::DLME
extend Macros::OAI
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Xml

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# Cho Required
to_field 'id', extract_oai('dc:identifier'), strip
to_field 'cho_title', extract_oai('dc:title'), strip

# Cho Other
to_field 'cho_contributor', extract_oai('dc:contributor'), transform(split: split('.'), strip: true)
to_field 'cho_coverage', extract_oai('dc:coverage'), strip
to_field 'cho_creator', extract_oai('dc:creator'), transform(split: split('.'), strip: true)
to_field 'cho_date', extract_oai('dc:date'), strip
to_field 'cho_description', extract_oai('dc:description'), strip
to_field 'cho_dc_rights', extract_oai('dc:rights'), strip
to_field 'cho_edm_type', extract_oai('dc:type'),
         strip, translation_map('not_found', 'types')
to_field 'cho_format', extract_oai('dc:format'), strip
to_field 'cho_language', extract_oai('dc:language'), split(';'),
         strip, translation_map('not_found', 'languages', 'marc_languages')
to_field 'cho_publisher', extract_oai('dc:publisher'), strip
to_field 'cho_relation', extract_oai('dc:relation'), strip
to_field 'cho_subject', extract_oai('dc:subject'), strip

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
