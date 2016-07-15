require('spec_helper')

describe(Stylist) do
  describe('#name') do
    it('should return the stylists name') do
      test_stylist = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      expect(test_stylist.name()).to(eq('Mike Smith'))
    end
  end

  describe("#==") do
    it('is the same stylist if it has the same name, phone, email, and id') do
      stylist1 = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      stylist2 = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe('.all') do
    it('is empty at first') do
      expect(Stylist.all()).to(eq([]))
    end

    it('returns an array containing all instances of Stylist') do
      stylist1 = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      stylist1.save()
      stylist2 = Stylist.new({name: 'Bob Smith', phone: '306-111-2343', email: 'bob@gmail.com', id: nil})
      stylist2.save()
      expect(Stylist.all()).to(eq([stylist1, stylist2]))
    end
  end

  describe('#save') do
    it('adds a stylist to the array of saved specialties') do
      stylist1 = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      stylist1.save()
      expect(Stylist.all()).to(eq([stylist1]))
    end
  end

  describe('.find') do
    it('returns a stylist by its ID') do
      test_stylist = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      test_stylist.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('#clients') do
    it ('returns an array of clients belonging to a stylist') do
      test_stylist = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      test_stylist.save()
      test_client = Client.new({name: 'Joey Rhu', phone: '306-111-2343', email: 'joey@gmail.com', stylist_id: test_stylist.id, id: nil})
      test_client.save()
      test_client2 = Client.new({name: 'Bob Smith', phone: '406-111-2343', email: 'bob@gmail.com', stylist_id: test_stylist.id, id: nil})
      test_client2.save()
      expect(test_stylist.clients()).to(eq([test_client, test_client2]))
    end
  end

  describe('#update') do
    it('lets you update a stylists information') do
      test_stylist = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      test_stylist.save()
      test_stylist.update({name: 'Bobby Jones'})
      expect(test_stylist.name()).to(eq('Bobby Jones'))
    end
  end

  describe('#delete') do
    it('deletes a stylist from the database') do
      test_stylist = Stylist.new({name: 'Mike Smith', phone: '206-111-2343', email: 'mike@gmail.com', id: nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({name: 'Bob Smith', phone: '306-111-2343', email: 'bob@gmail.com', id: nil})
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end
end
