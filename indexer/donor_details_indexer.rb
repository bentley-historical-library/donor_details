class CommonIndexer
  add_indexer_initialize_hook do |indexer|
    indexer.add_document_prepare_hook {|doc, record|
      if record["record"]["donor_details"]
        doc["donor_number"] = record["record"]["donor_details"].collect{|donor| donor["donor_number"]}.compact
        doc["dart_id"] = record["record"]["donor_details"].collect{|donor| donor["dart_id"]}.compact
      end
    }
  end
end