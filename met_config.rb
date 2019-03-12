# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/met'
extend Macros::DLME
extend TrajectPlus::Macros
extend TrajectPlus::Macros::JSON
extend Macros::Met

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::JsonReader'
end

to_field 'agg_provider', provider

# MET Museum
to_field 'id', extract_json('.objectID'), lambda { |_record, accumulator, context|
  accumulator.map! { |bare_id| identifier_with_prefix(context, bare_id.to_s) }
}

# Note: Met JSON uses blanks ("") instead of nulls.

to_field 'cho_format', extract_json('.objectName')
to_field 'cho_creator', generate_creator
to_field 'cho_spatial', extract_json('.city'), transform(&:presence)
to_field 'cho_has_type', extract_json('.classification')
to_field 'cho_spatial', extract_json('.country'), transform(&:presence)
to_field 'cho_spatial', extract_json('.county'), transform(&:presence)
to_field 'cho_provenance', extract_json('.creditLine')
to_field 'cho_coverage', extract_json('.culture'), transform(&:presence)
to_field 'cho_extent', extract_json('.dimensions')
to_field 'cho_coverage', extract_json('.dynasty'), transform(&:presence)
to_field 'cho_coverage', extract_json('.excavation'), transform(&:presence)
to_field 'cho_dc_rights', public_domain
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [extract_json('.objectURL'), transform(&:presence),
                                              ->(_record, inner_accumulator) { inner_accumulator.compact! }])
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [extract_json('.primaryImageSmall'), transform(&:presence),
                                              ->(_record, inner_accumulator) { inner_accumulator.compact! }])
end
to_field 'cho_spatial', extract_json('.locale'), transform(&:presence)
to_field 'cho_spatial', extract_json('.locus'), transform(&:presence)
to_field 'cho_medium', extract_json('.medium')
to_field 'cho_date', generate_object_date, transform(&:presence)
to_field 'cho_date', extract_json('.objectDate'), transform(&:presence)
to_field 'cho_identifier', extract_json('.accessionNumber')
to_field 'cho_source', extract_json('.accessionNumber')
to_field 'cho_temporal', extract_json('.period'), transform(&:presence)
to_field 'cho_spatial', extract_json('.region'), transform(&:presence)
to_field 'cho_temporal', extract_json('reign'), transform(&:presence)
to_field 'agg_data_provider', data_provider
to_field 'cho_dc_rights', extract_json('.rightsAndReproduction'), transform(&:presence)
to_field 'cho_spatial', extract_json('.river'), transform(&:presence)
to_field 'cho_spatial', extract_json('.subregion'), transform(&:presence)
to_field 'cho_title', extract_json('.title')
to_field 'cho_edm_type', edm_type
to_field 'cho_type', literal('Image')
