require 'db/migrations/utils'

Sequel.migration do

  up do

    create_table(:donor_detail) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :json_schema_version, :null => false

      Integer :agent_person_id, :null => true
      Integer :agent_family_id, :null => true
      Integer :agent_corporate_entity_id, :null => true
      Integer :agent_software_id, :null => true

      String :number
      Integer :number_auto_generate
      String :dart_id

      apply_mtime_columns
    end

    alter_table(:donor_detail) do
      add_foreign_key([:agent_person_id], :agent_person, :key => :id)
      add_foreign_key([:agent_family_id], :agent_family, :key => :id)
      add_foreign_key([:agent_corporate_entity_id], :agent_corporate_entity, :key => :id)
      add_foreign_key([:agent_software_id], :agent_software, :key => :id)
    end

  end

  down do
  end

end
