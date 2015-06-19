class Pokemon

  attr_accessor :name, :type 

  def initialize(name, type, db)
    @name = name
    @type = type 
    @db = db 
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemons (name, type)
      VALUES (?,?)
    SQL

    db.execute(sql, name, type)
  end

  def alter_hp(hp_value)
    sql = <<-SQL
    UPDATE pokemons SET hp = ?
    SQL

    @db.execute(sql, hp_value)
  end

  def self.find(id, db)

    sql= <<-SQL 
    select name, type from pokemons where id = ?
    SQL
    new_pokemon_info = db.execute(sql, id).flatten

    name = new_pokemon_info[0] 
    type = new_pokemon_info[1]
    Pokemon.new(name,type, db)
  end


  
end