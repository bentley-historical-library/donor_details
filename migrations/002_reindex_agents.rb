require 'db/migrations/utils'

Sequel.migration do

  up do
    self[:agent_person].update(:system_mtime => Time.now)
    self[:agent_family].update(:system_mtime => Time.now)
    self[:agent_corporate_entity].update(:system_mtime => Time.now)
    self[:agent_software].update(:system_mtime => Time.now)
  end

end