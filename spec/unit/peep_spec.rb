require 'peep'

describe Peep do
  describe '.all' do
    it 'returns all the peeps' do
      connection = PG.connect(dbname: 'peep_manager_test')
      connection.exec("INSERT INTO peeps (name, username, content, time) VALUES ('Jason Wong', 'jasylw', 'Hello!', '2020-02-15 11:13:01');")
      connection.exec("INSERT INTO peeps (name, username, content, time) VALUES ('Jason Wong', 'jasylw', 'Hello again!', '2020-02-15 11:46:25');")
      peeps = Peep.all
      expect(peeps).to include("Hello!")
      expect(peeps).to include("Hello again!")      
    end
  end

  describe '.create' do
    it 'creates a new peep and adds to collection' do
      Peep.create(content: "No time to die")
      expect(Peep.all).to include "No time to die"
    end
  end    
end