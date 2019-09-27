# frozen_string_literal: true

# Numismatics CSV Mapping Configuration

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/csv'
require 'macros/numismatic_csv'
extend Macros::DLME
extend Macros::Csv
extend TrajectPlus::Macros
extend TrajectPlus::Macros::Csv
extend Macros::NumismaticCsv

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::CsvReader'
end

# CHO Required
to_field 'id', normalize_prefixed_id('RecordId')
to_field 'cho_title', column('Title')

# CHO Other
to_field 'cho_contributor', column('Authority'), split('|')
to_field 'cho_coverage', column('Findspot')
to_field 'cho_creator', column('Mint')
to_field 'agg_data_provider', data_provider
to_field 'cho_date', column('Era')
to_field 'cho_date', column('Year'), gsub('|', ' - ')
to_field 'cho_date_norm', column('Year'), gsub('|', ' - ')
to_field 'cho_description', column('Denomination')
to_field 'cho_description', column('Manufacture')
to_field 'cho_description', column('Obverse Legend')
to_field 'cho_description', column('Obverse Type')
to_field 'cho_description', column('Reverse Legend')
to_field 'cho_description', column('Reverse Type')
to_field 'cho_description', column('Weight')
to_field 'cho_edm_type', literal('Image')
to_field 'cho_extent', column('Diameter')
to_field 'cho_format', column('Object Type')
to_field 'cho_identifier', column('URI')
to_field 'cho_identifier', column('RecordId')
to_field 'cho_medium', column('Material')
to_field 'cho_source', column('Reference')
to_field 'cho_spatial', column('Region')
to_field 'cho_temporal', column('Dynasty')

# Agg
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [column('URI')])
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [column('Thumbnail_obv')])
end
to_field 'agg_provider', provider

to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country
