# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/mods'

extend Macros::DLME
extend TrajectPlus::Macros
extend Traject::Macros::NokogiriMacros

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::XmlReader'
end

# Should probably be broken out into a separate macro
NS = {
      oai: 'http://www.openarchives.org/OAI/2.0/',
      mods: 'http://www.loc.gov/mods/v3'
    }.freeze

PREFIX = '/oai:record/oai:metadata/mods:mods/'

def extract_mods(xpath)
  extract_xpath("#{PREFIX}#{xpath}", ns: NS)
end

def extract_mods_identifier
  extract_xpath('/oai:record/oai:header/oai:identifier', ns: NS)
end

# CHO Required
to_field 'id', extract_mods_identifier, strip
to_field 'cho_title', extract_mods('mods:titleInfo/mods:title')

# CHO Other
to_field 'cho_coverage', extract_mods('mods:subject/mods:geographic'), strip
to_field 'cho_creator', extract_mods('mods:name/mods:namePart'), strip
to_field 'cho_date', extract_mods('mods:originInfo/mods:dateIssued'), strip
to_field 'cho_dc_rights', literal('Open Government Licence')
to_field 'cho_description', extract_mods('mods:physicalDescription/mods:extent'), strip
to_field 'cho_edm_type', extract_mods('mods:typeOfResource'),
        strip, transform(&:downcase), translation_map('not_found', 'types')
to_field 'cho_extent', extract_mods('mods:physicalDescription/mods:extent[1]'), strip
to_field 'cho_identifier', extract_mods('mods:recordInfo/mods:recordIdentifier')
to_field 'cho_language', extract_mods('mods:language/mods/languageTerm'),
        strip, transform(&:downcase), translation_map('not_found', 'languages', 'marc_languages')
to_field 'cho_subject', extract_mods('mods:subject/mods:topic'), strip

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [extract_mods('mods:location/mods:url'), strip]
  )
end
