require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql).map{|film| Film.new(film)}
    return result
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def get_customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    WHERE screenings.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).map{|customer| Customer.new(customer)}
    return result

    # WHICH IS THE BEST WAY OF WRITING IT?
    # sql = "SELECT customers.* FROM screenings
    # INNER JOIN tickets
    # ON screenings.id = tickets.screening_id
    # INNER JOIN customers
    # ON tickets.customer_id = customers.id
    # WHERE screenings.film_id = $1"
    # values = [@id]
    # result = SqlRunner.run(sql, values).map{|customer| Customer.new(customer)}
    # return result
  end

  def find()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return result == nil ?  nil : Film.new(result)
  end

  def get_most_popular_time()
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id
    INNER JOIN films
    ON films.id = screenings.film_id
    WHERE films.id = $1
    "
    values = [@id]
    results = SqlRunner.run(sql, values)
    screening_counts = {}
    for result in results
      screening_id = result["screening_id"]
      screening_counts[screening_id] = 0 if !screening_counts.has_key?(screening_id)
      screening_counts[screening_id] = screening_counts[screening_id]+1
    end

    screening_counts.sort_by {|key, value| -value}.first
  end

end
