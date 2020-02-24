require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end


  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
    # return nil unless play.length > 0

    Play.new(play.first) # play is stored in an array!
  end

  def self.find_by_playwright(name)
    plays = PlayDBConnection.instance.execute(<<-SQL, name)
      select id, title, year
      from plays
      where playwright_id in (select id from playwrights where name = ?)    

    SQL
    plays.map { |play| Play.new(play) }
  end
  
end



class Playwright

  def self.all
    data = PlayDBConnection.instance.execution("SELECT * FROM playwrights")
    data.map { |record| Playwright.new(record) 
  end

  def self.find_by_name(name)
    data = PlayDBConnection.instance.execution(<<-SQL, name)
      SELECT * from playwrights where name = ?
    SQL

    data.map { |record| Playwright.new(record) }
  end

  def initialize(options)
    @id = options[id]
    @name = options[name]
    @birth_year = options[birth_year]
  end






end
