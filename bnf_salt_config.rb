# frozen_string_literal: true

to_field 'cho_contributor', extract: extract_srw('dc:contributor'),
                            transform: transform(strip: true)
to_field 'cho_creator', extract: extract_srw('dc:creator'),
                        transform: transform(strip: true)
to_field 'cho_edm_type',  extract: extract_srw('dc:type'),
                          transform: transform(strip: true, prepend: 'text |', split: '|', default: 'text')
to_field 'cho_language',  extract: extract_srw('dc:language'),
                          transform: transform(strip: true, gsub: [/Ottoman Turkish/, 'Turkish, Ottoman'])
