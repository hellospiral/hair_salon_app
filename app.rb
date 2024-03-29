require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/client")
require("./lib/stylist")
require('pg')
require('pry')

DB = PG.connect({:dbname => "hair_salon"})

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

get('/stylists/:id') do
  @stylist = Stylist.find(params['id'].to_i)
  @clients = Client.all()
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find(params['id'].to_i)
  erb(:edit_stylist_form)
end

patch('/stylists/:id') do
  @stylist = Stylist.find(params['id'].to_i)
  @clients = Client.all()
  name = params['name']
  phone = params['phone']
  email = params['email']
  @stylist.update({name: name, phone: phone, email: email})
  erb(:stylist)
end

delete('/stylists/:id') do
  stylist = Stylist.find(params['id'].to_i)
  stylist.delete()
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/clients') do
  name = params['name']
  phone = params['phone']
  email = params['email']
  client = Client.new({name: name, phone: phone, email: email})
  client.save()
  @clients = Client.all()
  erb(:clients)
end

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/clients/:id') do
  @client = Client.find(params['id'].to_i)
  erb(:client)
end

get('/clients/:id/edit') do
  @client = Client.find(params['id'].to_i)
  erb(:edit_client_form)
end

patch('/clients/:id') do
  @client = Client.find(params['id'].to_i)
  name = params['name']
  phone = params['phone']
  email = params['email']
  @client.update({name: name, phone: phone, email: email})
  erb(:client)
end

delete('/clients/:id') do
  client = Client.find(params['id'].to_i)
  client.delete()
  @clients = Client.all()
  erb(:clients)
end

patch('/stylist/:id/clients') do
  client = Client.find(params['client_id'].to_i)
  stylist_id = params['id']
  client.update({stylist_id: stylist_id})
  @stylist = Stylist.find(params['id'].to_i)
  @clients = Client.all()
  erb(:stylist)
end
