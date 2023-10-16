Rails.application.config.after_initialize do
    
    SearchResultData.class_eval do
        def self.AGENT_FACETS
            ["primary_type", "source", "rules", "is_donor_u_sbool"]
        end
    end
            
    AspaceFormHelper::PROPERTIES_TO_EXCLUDE_FROM_READ_ONLY_VIEW << "donor_number_auto_generate"

    ApplicationHelper.class_eval do
        alias_method :render_aspace_partial_pre_donor_details, :render_aspace_partial
        def render_aspace_partial(args)
            if args[:partial] == "search/listing"
                if controller.controller_name == 'agents' || ASUtils.wrap(@search_data['results']).any?{|result| ASUtils.wrap(result['types']).include?("agent")}
                    # Sets @columns if it hasn't been set yet (as is the case with view-only users)
                    add_columns
                    action_column = @columns.pop if @columns.last.class.include?('actions')

                    add_column(I18n.t("donor_detail.donor_number"),
                               { :sortable => false },
                               proc {|result|
                                   result['donor_number_u_sstr'].join(', ') if result['donor_number_u_sstr']
                               })

                    @columns << action_column if action_column
                end

                if controller.controller_name == 'agents'
                    @columns.reject!{|col| col.sort_by == 'authority_id'}
                end
            end

            render_aspace_partial_pre_donor_details(args)
        end
    end
end
