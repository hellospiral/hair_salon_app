require('spec_helper')

describe(Client) do
  describe('#name') do
    it('should return the clients name') do
      test_client = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      expect(test_client.name()).to(eq('Mike Smith'))
    end
  end

  describe("#==") do
    it('is the same client if it has the same name, phone, email, stylist id, and id') do
      client1 = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      client2 = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      expect(client1).to(eq(client2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Client.all()).to(eq([]))
    end

    it('returns an array containing all instances of Client') do
      client1 = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      client1.save()
      client2 = Client.new({name: 'Bob Smith', phone: '306-111-2343', email: 'bob@gmail.com', stylist_id: 1, id: nil})
      client2.save()
      expect(Client.all()).to(eq([client1, client2]))
    end
  end

  describe('#save') do
    it('adds a client to the array of saved specialties') do
      client1 = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      client1.save()
      expect(Client.all()).to(eq([client1]))
    end
  end

  describe('.find') do
    it('returns a client by its ID') do
      test_client = Client.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', stylist_id: 1, id: nil})
      test_client.save()
      expect(Client.find(test_client.id())).to(eq(test_client))
    end
  end
end
