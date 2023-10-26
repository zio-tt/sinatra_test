# frozen_string_literal: true

require 'sinatra'
require 'pg'

enable :method_override

get '/' do
  conn = db_connection
  @tasks = conn.exec('SELECT * FROM tasks')
  conn.close

  erb :"tasks/index"
end

post '/tasks/create' do
  data = JSON.parse(request.body.read)
  title = data['title']

  conn = db_connection
  conn.exec_params('INSERT INTO tasks (title) VALUES ($1)', [title])
  conn.close

  content_type :json
  { status: 'success', message: 'Task added successfully' }.to_json
end

delete '/tasks/:taskId' do
  task_id = params[:taskId]

  conn = db_connection
  conn.exec_params('DELETE FROM tasks WHERE id = ($1)', [task_id])
  conn.close

  content_type :json
  { status: 'success', message: 'Task deleted successfully' }.to_json
end

def db_connection
  PG.connect(
    dbname: 'mydb',
    user: 'user',
    password: 'password',
    host: 'db'
  )
end
