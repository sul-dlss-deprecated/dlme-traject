# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/bnf'

extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Xml

NS = { xmlns: 'http://www.openarchives.org/OAI/2.0/' }.merge(Macros::BNF::NS).freeze

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

record = '/xmlns:record/xmlns:metadata/oai_dc:dc'

# Cho Required
to_field 'id', extract: extract_xml("#{record}/dc:identifier", NS), transform: transform(strip: true)
to_field 'cho_title', extract: extract_xml("#{record}/dc:title", NS), transform: transform(strip: true)

# Cho Other
to_field 'cho_contributor', extract_xml("#{record}/dc:contributor", NS), transform: transform(split: split('.'), strip: true)
to_field 'cho_coverage', extract_xml("#{record}/dc:coverage", NS), transform: transform(strip: true)
to_field 'cho_creator', extract_xml("#{record}/dc:creator", NS), transform: transform(split: split('.'), strip: true)
to_field 'cho_date', extract_xml("#{record}/dc:date", NS), transform: transform(strip: true)
to_field 'cho_description', extract_xml("#{record}/dc:description", NS), transform: transform(strip: true)
to_field 'cho_dc_rights', extract_xml("#{record}/dc:rights", NS), transform: transform(strip: true)
to_field 'cho_edm_type', extract_xml("#{record}/dc:type", NS),
         strip, translation_map('not_found', 'types')
to_field 'cho_format', extract_xml("#{record}/dc:format", NS), transform: transform(strip: true)
to_field 'cho_language', extract_xml("#{record}/dc:language", NS), split(";"),
         strip, translation_map('not_found', 'languages', 'marc_languages')
to_field 'cho_publisher', extract_xml("#{record}/dc:publisher", NS), transform: transform(strip: true)
to_field 'cho_relation', extract_xml("#{record}/dc:relation", NS), transform: transform(strip: true)
to_field 'cho_subject', extract_xml("#{record}/dc:subject", NS), transform: transform(strip: true)

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
