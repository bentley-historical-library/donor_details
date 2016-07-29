Rails.application.config.after_initialize do
    
    SearchResultData.class_eval do
        def self.AGENT_FACETS
            ["primary_type", "source", "rules", "is_donor_u_sbool"]
        end
    end
            
    AspaceFormHelper::PROPERTIES_TO_EXCLUDE_FROM_READ_ONLY_VIEW << "donor_number_auto_generate"

end
