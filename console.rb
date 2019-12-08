require('pry')
require_relative('./models/films')
require_relative('./models/customers')
require_relative('./models/tickets')
require_relative('./models/screenings')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()
Screening.delete_all()

film1 = Film.new({"title" => "The Lord of the Rings", "price" => 10})
film1.save()
film2 = Film.new({"title" => "The Hobbit", "price" => 7})
film2.save()
film3 = Film.new({"title" => "Aladdin", "price" => 5})

film4 = Film.new({"title" => "Zoolander", "price" => 15})
film4.save()

customer1 = Customer.new({"name" => "John Doe", "funds" => 10000})
customer1.save()

customer2 = Customer.new({"name" => "Jim Bill", "funds" => 200})
customer2.save()

screening1 = Screening.new({"screening_time" => "19:00 GMT", "film_id" => film1.id})
screening1.save

screening2 = Screening.new({"screening_time" => "20:00 GMT", "film_id" => film1.id})
screening2.save

screening3 = Screening.new({"screening_time" => "21:00 GMT", "film_id" => film4.id})
screening3.save

ticket1 = Ticket.new({"customer_id" => customer1.id, "screening_id" => screening1.id})
ticket1.save()

ticket2 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening1.id})
ticket2.save()

ticket3 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening3.id})
ticket3.save()

ticket4 = Ticket.new({"customer_id" => customer2.id, "screening_id" => screening2.id})
ticket4.save()

# p film1.get_most_popular_time()
binding.pry
nil
