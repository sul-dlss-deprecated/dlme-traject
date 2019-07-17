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

# CHO Required
to_field 'id', column('Resource_URL')
to_field 'cho_title', column('Title')

# CHO Other
to_field 'cho_creator', column('Creator')
to_field 'cho_date', column('Date')
to_field 'cho_description', column('Description')
to_field 'cho_edm_type', literal('Image')
to_field 'cho_identifier', column('Resource-URL')
to_field 'cho_rights', literal("The PPPA operates according to the principles of
                               'fair use'. According to fair use principles, an author
                               may make limited use of another author's work without
                               asking for permission. Fair use is based on the belief
                               that the public is entitled to freely use portions of
                               copyrighted materials for non-commercial educational
                               purposes, commentary and criticism. For full rights
                               policy, see: https://www.palestineposterproject.org/content/faq")
to_field 'cho_subject', column('Subject')

# Agg
to_field 'agg_provider', provider
to_field 'agg_data_provider', data_provider
to_field 'agg_is_shown_at' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [column('Resource_URL')])
end
to_field 'agg_preview' do |_record, accumulator, context|
  accumulator << transform_values(context,
                                  'wr_id' => [column('Thumbnail')])
end
