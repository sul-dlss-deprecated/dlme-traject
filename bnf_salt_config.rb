# frozen_string_literal: true

to_field 'cho_contributor', extract_srw('dc:contributor'), strip
to_field 'cho_creator', extract_srw('dc:creator'), strip
to_field 'cho_edm_type',  extract_srw('dc:type'), strip, prepend('text |'), split('|'), default('text')
to_field 'cho_language',  extract_srw('dc:language'), strip, gsub(/Ottoman Turkish/, 'Turkish, Ottoman')
