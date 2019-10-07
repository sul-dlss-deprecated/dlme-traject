# frozen_string_literal: true

require 'traject_plus'
require 'dlme_json_resource_writer'
require 'macros/dlme'
require 'macros/post_process'

extend Macros::PostProcess
extend Macros::DLME
extend TrajectPlus::Macros::JSON

settings do
  provide 'writer_class_name', 'DlmeJsonResourceWriter'
  provide 'reader_class_name', 'TrajectPlus::JsonReader'
end

to_field 'id', lambda { |_record, accumulator, context|
  identifier = default_identifier(context)
  accumulator << identifier_with_prefix(context, identifier) if identifier.present?
}
to_field 'cho_title', extract_json('$.label')

# Aggregation Object(s)
to_field 'agg_data_provider', data_provider
to_field 'agg_provider', provider
to_field 'agg_provider_country', provider_country
to_field 'agg_data_provider_country', data_provider_country

each_record convert_to_language_hash('cho_title')
