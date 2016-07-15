require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require('pg')

DB = PG.connect({:dbname => "hair_salon_test"})

get('/') do
  erb(:index)
end

get('/stylists/new') do
  erb(:stylist_form)
end

get('/clients/new') do
  erb(:client_form)
end

post('/stylists') do
  name = params['name']
  phone = params['phone']
  email = params['email']
  stylist = Stylist.new({name: name, phone: phone, email: email})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end
