Factory.define :agent do |f|
  f.sequence(:AgentEmail) { |n| "agent#{n}@broker.com" }
end
