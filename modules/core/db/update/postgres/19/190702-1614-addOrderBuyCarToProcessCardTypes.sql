--Update process card_types for entity teziscontrolwork$OrderBuyCar
update wf_proc set card_types = regexp_replace(card_types, E',teziscontrolwork\\$OrderBuyCar', '') where code in ('Endorsement','Resolution','Acquaintance','Registration')^
update wf_proc set updated_by='admin', card_types = card_types || 'teziscontrolwork$OrderBuyCar,' where code in ('Endorsement','Resolution','Acquaintance','Registration')^
