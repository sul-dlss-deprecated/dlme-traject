# frozen_string_literal: true

record = 'srw:record/srw:recordData/oai_dc:dc'

to_field 'cho_contributor', extract_xml("#{record}/dc:contributor", LOC_NS), split('. '), first_only, strip
to_field 'cho_contributor', extract_xml("#{record}/dc:contributor[2]", LOC_NS), strip, gsub(/. Fonction indéterminée/, '')
to_field 'cho_creator', extract_xml("#{record}/dc:creator", LOC_NS), split('. '), first_only, strip
to_field 'cho_creator', extract_xml("#{record}/dc:creator[2]", LOC_NS), strip, gsub(/. Fonction indéterminée/, '')
to_field 'cho_edm_type', extract_xml("#{record}/dc:type", LOC_NS), first_only, strip, translation_map('types')
to_field 'cho_language', extract_xml("#{record}/dc:language", LOC_NS), first_only, strip, translation_map('marc_languages')
