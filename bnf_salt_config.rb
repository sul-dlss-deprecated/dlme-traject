# frozen_string_literal: true

record = 'srw:record/srw:recordData/oai_dc:dc'

to_field 'cho_contributor', extract: extract_xml("#{record}/dc:contributor", Macros::BNF::NS),
                            transform: transform(strip: true)
to_field 'cho_creator', extract: extract_xml("#{record}/dc:creator", Macros::BNF::NS),
                        transform: transform(strip: true)
to_field 'cho_edm_type',  extract: extract_xml("#{record}/dc:type", Macros::BNF::NS),
                          transform: transform(strip: true, prepend: 'text |', split: '|', default: 'text')
to_field 'cho_language',  extract: extract_xml("#{record}/dc:language", Macros::BNF::NS),
                          transform: transform(strip: true, gsub: [/Ottoman Turkish/, 'Turkish, Ottoman'])
