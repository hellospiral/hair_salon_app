class Client
  attr_reader(:name, :phone, :email, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @id = attributes.fetch(:id) || nil
  end

  define_method(:==) do |another_client|
    self.name == another_client.name &&
    self.phone == another_client.phone &&
    self.email == another_client.email &&
    self.id == another_client.id
  end

  define_singleton_method(:all) do
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each() do |client|
      name = client.fetch("name")
      phone = client.fetch("phone")
      email = client.fetch("email")
      id = client.fetch("id").to_i()
      clients.push(Client.new({:name => name, :phone => phone, :email => email, :id => id}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone, email) VALUES ('#{@name}', '#{@phone}', '#{@email}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id() == id
        found_client = client
      end
    end
    found_client
  end
end
