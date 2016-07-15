class Stylist
  attr_reader(:name, :phone, :email, :id)
  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @email = attributes.fetch(:email)
    @id = attributes.fetch(:id) || nil
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
end
