class CommonIndexer
  add_indexer_initialize_hook do |indexer|
    indexer.add_document_prepare_hook {|doc, record|
      if  ['agent_person', 'agent_family', 'agent_software', 'agent_corporate_entity'].include?(doc['primary_type']) && record['record']['donor_details']
	doc['is_donor_u_sbool'] = !record['record']['donor_details'].collect{|donor| donor['donor_number']}.compact.empty?
        doc['donor_number_u_sstr'] = record['record']['donor_details'].collect{|donor| donor['donor_number']}.compact
        doc['dart_id_u_sstr'] = record['record']['donor_details'].collect{|donor| donor['dart_id']}.compact
        doc['beal_contact_id_u_sstr'] = record['record']['donor_details'].collect{|donor| donor['beal_contact_id']}.compact
        doc['fullrecord'] << "#{record['record']['donor_details'].collect{|donor| donor['donor_number']}.compact}"
	end
    }
  end
end
