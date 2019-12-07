require('pry')
require_relative('./models/films')

Film.delete_all()

film1 = Film.new({"title" => "The Lord of the Rings", "price" => 10})

film1.save()

binding.pry
nil
