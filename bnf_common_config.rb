# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/srw'

extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Xml
extend Macros::SRW

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# Cho Required
to_field 'id', extract: extract_srw('dc:identifier'), transform: transform(strip: true)
to_field 'cho_title', extract: extract_srw('dc:title'), transform: transform(strip: true)

# Cho Other
to_field 'cho_date', extract: extract_srw('dc:date'), transform: transform(strip: true)
to_field 'cho_description', extract: extract_srw('dc:description'), transform: transform(strip: true)
to_field 'cho_dc_rights', extract: extract_srw('dc:rights'), transform: transform(strip: true)
to_field 'cho_format', extract: extract_srw('dc:format'), transform: transform(strip: true)
to_field 'cho_publisher', extract: extract_srw('dc:publisher'), transform: transform(strip: true)
to_field 'cho_relation', extract: extract_srw('dc:relation'), transform: transform(strip: true)
to_field 'cho_source', extract: extract_srw('dc:source'), transform: transform(strip: true)
to_field 'cho_subject', extract: extract_srw('dc:subject'), transform: transform(strip: true)

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/link', Macros::SRW::NS, [:strip])]
  )
end

to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_xml('srw:record/srw:extraRecordData/thumbnail', Macros::SRW::NS, [:strip])]
  )
end
