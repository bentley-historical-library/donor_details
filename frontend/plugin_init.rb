Rails.application.config.after_initialize do
	
	SearchResultData.class_eval do
	
		def self.AGENT_FACETS
			["primary_type", "source", "rules", "is_donor_u_sbool"]
		end
	end
end
