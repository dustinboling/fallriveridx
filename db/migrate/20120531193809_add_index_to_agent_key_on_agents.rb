class AddIndexToAgentKeyOnAgents < ActiveRecord::Migration
  def change
    add_index :agents, :AgentKey
  end
end
