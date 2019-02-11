# frozen_string_literal: true

require 'json_reader'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/extraction'
require 'macros/json'

extend Macros::DLME
extend Macros::JSON

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'JsonReader'
end

to_field 'id', lambda { |_record, accumulator, context|
  identifier = default_identifier(context)
  accumulator << identifier_with_prefix(context, identifier) if identifier.present?
}
to_field 'cho_title', extract_json('$.label')

# Aggregation Object(s)
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
