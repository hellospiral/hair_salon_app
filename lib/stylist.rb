class Stylist
  attr_reader(:name, :phone, :email, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @id = attributes[:id] || nil
  end

  define_method(:==) do |another_stylist|
    self.name == another_stylist.name &&
    self.phone == another_stylist.phone &&
    self.email == another_stylist.email &&
    self.id == another_stylist.id
  end

  define_singleton_method(:all) do
    returned_stylists = DB.exec("SELECT * FROM stylists;")
    stylists = []
    returned_stylists.each() do |stylist|
      name = stylist.fetch("name")
      phone = stylist.fetch("phone")
      email = stylist.fetch("email")
      id = stylist.fetch("id").to_i()
      stylists.push(Stylist.new({:name => name, :phone => phone, :email => email, :id => id}))
    end
    stylists
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO stylists (name, phone, email) VALUES ('#{@name}', '#{@phone}', '#{@email}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_stylist = nil
    Stylist.all().each() do |stylist|
      if stylist.id() == id
        found_stylist = stylist
      end
    end
    found_stylist
  end

  define_method(:clients) do
    stylists_clients = []
    clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id()};")
    clients.each() do |client|
      name = client.fetch('name')
      phone = client.fetch('phone')
      email = client.fetch('email')
      stylist_id = client.fetch('stylist_id').to_i
      id = client.fetch('id').to_i()
      stylists_clients.push(Client.new({name: name, phone: phone, email: email, stylist_id: stylist_id, id: id}))
    end
    stylists_clients
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @phone = attributes.fetch(:phone, @phone)
    @email = attributes.fetch(:email, @email)
    DB.exec("UPDATE stylists SET name = '#{@name}', phone = '#{@phone}', email = '#{@email}' WHERE id = #{self.id()};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM stylists WHERE id = #{self.id()};")
  end
end
