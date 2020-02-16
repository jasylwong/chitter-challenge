require 'user'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Eve Moneypenny', username: 'moneypenny', password: 'pennyword', email: 'secretary@mi6.com')
      expect(user).to be_a User
      expect(user.name).to eq 'Eve Moneypenny'
      expect(user.email).to eq 'secretary@mi6.com'
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('pennyword')
      User.create(name: 'Eve Moneypenny', username: 'moneypenny', password: 'pennyword', email: 'secretary@mi6.com')
    end

  end

  describe '.find' do
    it 'finds a user by id' do
      user = User.create(name: 'Eve Moneypenny', username: 'moneypenny', password: 'pennyword', email: 'secretary@mi6.com')
      result = User.find(user.id)
      expect(result.id).to eq user.id
      expect(result.email).to eq user.email
      expect(result.name).to eq user.name
      expect(result.username).to eq user.username
    end

    it 'returns nil if there is no id given' do
      expect(User.find(nil)).to eq nil
    end
  end
end
