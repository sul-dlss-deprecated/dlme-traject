require 'xml_reader'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/extraction'
require 'macros/xml'

extend Macros::DLME
extend Macros::Xml

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'XmlReader'
end

record = 'srw:record/srw:recordData/oai_dc:dc'

# Cho Required
to_field 'id', extract_xml("#{record}/dc:identifier", LOC_NS), strip
to_field 'cho_title', extract_xml("#{record}/dc:title", LOC_NS), strip

# Cho Other
to_field 'cho_date', extract_xml("#{record}/dc:date", LOC_NS), strip
to_field 'cho_description', extract_xml("#{record}/dc:description", LOC_NS), strip
to_field 'cho_dc_rights', extract_xml("#{record}/dc:rights", LOC_NS), strip
to_field 'cho_format', extract_xml("#{record}/dc:format", LOC_NS), strip
to_field 'cho_publisher', extract_xml("#{record}/dc:publisher", LOC_NS), strip
to_field 'cho_relation', extract_xml("#{record}/dc:relation", LOC_NS), strip
to_field 'cho_source', extract_xml("#{record}/dc:source", LOC_NS), strip
to_field 'cho_subject', extract_xml("#{record}/dc:subject", LOC_NS), strip

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/link', LOC_NS, [:trim])]
  )
end

to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/thumbnail', LOC_NS, [:trim])]
  )
end