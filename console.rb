require('pry')
require_relative('./models/films')
require_relative('./models/customers')
require_relative('./models/tickets')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()

film1 = Film.new({"title" => "The Lord of the Rings", "price" => 10})
film1.save()
film2 = Film.new({"title" => "The Hobbit", "price" => 7})
film2.save()

customer1 = Customer.new({"name" => "John Doe", "funds" => 10000})
customer1.save()

customer2 = Customer.new({"name" => "Jim Bill", "funds" => 200})
customer2.save()

ticket1 = Ticket.new({"film_id" => film1.id, "customer_id" => customer1.id})
ticket1.save()

ticket2 = Ticket.new({"film_id" => film2.id, "customer_id" => customer1.id})
ticket2.save()

ticket3 = Ticket.new({"film_id" => film1.id, "customer_id" => customer2.id})
ticket3.save()

binding.pry
nil
