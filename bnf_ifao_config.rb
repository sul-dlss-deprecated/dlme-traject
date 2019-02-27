# frozen_string_literal: true

record = 'srw:record/srw:recordData/oai_dc:dc'

to_field 'cho_contributor', extract_xml("#{record}/dc:contributor", Macros::BNF::NS), strip # split('.'), first_only, strip
to_field 'cho_creator', extract_xml("#{record}/dc:creator", Macros::BNF::NS), split('.'), first_only, strip
to_field 'cho_creator', extract_xml("#{record}/dc:creator[2]", Macros::BNF::NS), split('.'), first_only, strip
to_field 'cho_creator', extract_xml("#{record}/dc:creator[3]", Macros::BNF::NS), split('.'), first_only, strip
to_field 'cho_edm_type', extract_xml("#{record}/dc:type", Macros::BNF::NS),
         default('notated music'),
         first_only,
         strip,
         translation_map('types'),
         default('image')
to_field 'cho_language', extract_xml("#{record}/dc:language", Macros::BNF::NS), first_only, strip, translation_map('marc_languages')
