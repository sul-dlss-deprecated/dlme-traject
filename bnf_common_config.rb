# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/bnf'

extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Xml

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

record = 'srw:record/srw:recordData/oai_dc:dc'

# Cho Required
to_field 'id', extract: extract_xml("#{record}/dc:identifier", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_title', extract: extract_xml("#{record}/dc:title", Macros::BNF::NS), transform: transform(strip: true)

# Cho Other
to_field 'cho_date', extract: extract_xml("#{record}/dc:date", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_description', extract: extract_xml("#{record}/dc:description", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_dc_rights', extract: extract_xml("#{record}/dc:rights", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_format', extract: extract_xml("#{record}/dc:format", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_publisher', extract: extract_xml("#{record}/dc:publisher", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_relation', extract: extract_xml("#{record}/dc:relation", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_source', extract: extract_xml("#{record}/dc:source", Macros::BNF::NS), transform: transform(strip: true)
to_field 'cho_subject', extract: extract_xml("#{record}/dc:subject", Macros::BNF::NS), transform: transform(strip: true)

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/link', Macros::BNF::NS, [:strip])]
  )
end

to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/thumbnail', Macros::BNF::NS, [:strip])]
  )
end
