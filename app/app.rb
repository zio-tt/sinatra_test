# frozen_string_literal: true

require 'sinatra'
require 'pg'

get '/' do
  conn = db_connection
  @tasks = conn.exec('SELECT * FROM tasks')
  conn.close

  erb :"tasks/index"
end

def db_connection
  PG.connect(
    dbname: 'mydb',
    user: 'user',
    password: 'password',
    host: 'db'
  )
end
