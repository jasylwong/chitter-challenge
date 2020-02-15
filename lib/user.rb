class User

  attr_reader :id, :name, :email, :username, :password
  
  def initialize(id:, name:, email:, password:, username:)
    @id = id
    @name = name
    @email = email
    @password = password
    @username = username
  end

  def self.create(name:, email:, password:, username:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'peep_manager_test')
    else
      connection = PG.connect(dbname: 'peep_manager')
    end
    result = connection.exec("INSERT INTO users (name, username, email, password) VALUES ('#{name}', '#{username}', '#{email}', '#{password}') RETURNING id, username, name, email, password;")
    User.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end

  def self.find(id)
    return nil unless id

    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'peep_manager_test')
    else
      connection = PG.connect(dbname: 'peep_manager')
    end
    result = connection.exec("SELECT * FROM users WHERE id='#{id}';")
    User.new(id: result[0]['id'], name: result[0]['name'], username: result[0]['username'], email: result[0]['email'], password: result[0]['password'])
  end
end