# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/qnl'

extend Macros::DLME
extend Macros::QNL
extend TrajectPlus::Macros

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# CHO Required
to_field 'id', extract_qnl_identifier, strip
to_field 'cho_title', extract_qnl('mods:titleInfo/mods:title')

# CHO Other
to_field 'cho_coverage', extract_qnl('mods:subject/mods:geographic'), strip
to_field 'cho_creator', extract_qnl('mods:name/mods:namePart'), strip
to_field 'cho_date', extract_qnl('mods:originInfo/mods:dateIssued'), strip
to_field 'cho_dc_rights', literal('Open Government Licence')
to_field 'cho_description', extract_qnl('mods:physicalDescription/mods:extent'), strip
to_field 'cho_edm_type', extract_qnl('mods:typeOfResource'),
         strip, transform(&:downcase), translation_map('not_found', 'types')
to_field 'cho_extent', extract_qnl('mods:physicalDescription/mods:extent[1]'), strip
to_field 'cho_identifier', extract_qnl('mods:recordInfo/mods:recordIdentifier')
to_field 'cho_language', extract_qnl('mods:language/mods/languageTerm'),
         strip, transform(&:downcase), translation_map('not_found', 'languages', 'marc_languages')
to_field 'cho_subject', extract_qnl('mods:subject/mods:topic'), strip

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_qnl('mods:location/mods:url'), strip]
  )
end

to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country
