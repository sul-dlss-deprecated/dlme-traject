# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/csv'
extend Macros::DLME
extend Macros::Csv
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Csv

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::CsvReader'
end

# CHO required
to_field 'id', normalize_prefixed_id('OrbisBibID'), strip
to_field 'cho_title', column('Title'), strip

# CHO other
to_field 'cho_alternative', column('Variant Titles', split: '|'), strip
to_field 'cho_creator', column('Creator', split: '|'), strip
to_field 'cho_date', column('Date, created'), strip
to_field 'cho_date', column('Date, Created ISO'), strip
to_field 'cho_dc_rights', column('Rights'), strip
to_field 'cho_dc_rights', column('Item Permission'), strip
to_field 'cho_description', column('Abstract'), strip
to_field 'cho_description', column('Notes'), strip
to_field 'cho_edm_type', column('Type of resource'),
         strip, transform(&:downcase), translation_map('not_found', 'types')
to_field 'cho_extent', column('Physical description'), strip
to_field 'cho_identifier', column('Accession number'), strip
to_field 'cho_language', column('Language', split: '|'),
         strip, transform(&:downcase), translation_map('not_found', 'languages', 'marc_languages')
to_field 'cho_provenance', column('Associated Names'), strip
to_field 'cho_publisher', column('Publisher'), strip
to_field 'cho_subject', column('Subject, topic'), strip
to_field 'cho_type', column('Content Type'), strip
to_field 'cho_type', column('Type of resource'), strip

# Agg
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(
    context,
    'wr_id' => [column('Handle')]
  )
end
