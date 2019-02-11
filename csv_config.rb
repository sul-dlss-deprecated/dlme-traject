# frozen_string_literal: true

require 'csv_reader'
require 'dlme_json_resource_writer'
require 'macros/csv'
require 'macros/dlme'
require 'macros/extraction'

extend Macros::DLME
extend Macros::Csv
settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'CsvReader'
end

# MET Museum
to_field 'id', column('Object ID')
to_field 'cho_title', column('Object Name')

# Aggregation Object(s)
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
