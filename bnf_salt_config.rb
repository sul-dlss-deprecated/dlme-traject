# frozen_string_literal: true

record = 'srw:record/srw:recordData/oai_dc:dc'

to_field 'cho_contributor', extract_xml("#{record}/dc:contributor", LOC_NS), strip
to_field 'cho_creator', extract_xml("#{record}/dc:creator", LOC_NS), strip
to_field 'cho_edm_type', extract_xml("#{record}/dc:type", LOC_NS), prepend('text |'), split('|'), first_only, strip, default('text')
to_field 'cho_language', extract_xml("#{record}/dc:language", LOC_NS), strip, gsub(/Ottoman Turkish/, 'Turkish, Ottoman')
