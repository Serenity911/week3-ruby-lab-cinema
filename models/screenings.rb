require_relative("../db/sql_runner")

class Screening

  attr_reader :id
  attr_accessor :screening_time, :film_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @screening_time = options['screening_time']
    @film_id = options['film_id']
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql).map{|screening| Screening.new(screening)}
    return result
  end

  def save()
    sql = "INSERT INTO screenings (screening_time, film_id) VALUES ($1, $2) RETURNING id"
    values = [@screening_time, @film_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, film_id) = ($1, $2) WHERE id = $3"
    values = [@screening_time, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def get_film()
    Film.find(@film_id)
  end

  # find the screening given a screening id
  def self.find(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return result == nil ?  nil : self.new(result)
  end



end
