require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")
require('pry')

DB = PG.connect({:dbname => "volunteer_tracker"})


get("/") do
  redirect('/projects')
end

get("/projects") do
  @projects = Project.all()
  erb(:projects)
end

get("/projects/new") do
  erb(:project_form)
end

get("/projects/:id") do
  # binding.pry
  @project = Project.find(params.fetch("id").to_i())
  erb(:project)
end

delete("/projects/:id") do
  @project = Project.find(params["id"].to_i)
  @project.delete
  @projects = Project.all
  redirect '/projects'
end

post("/projects") do
  title = params.fetch("title")
  project = Project.new({:title => title, :id => nil})
  project.save()
  redirect('/projects')
end

get("/project/edit/:id") do
  @project = Project.find(params['id'].to_i)
  @projects = Project.all
  erb(:project_edit)
end

patch("/project/edit/:id") do

  new_project_name = params.fetch("title")

  @project = Project.find(params["id"].to_i)
  @project.update({title: new_project_name})
  redirect('/projects')
end


post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  project_id = params.fetch("project_id").to_i
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  @volunteer.save()
  redirect("/projects/#{project_id}")
end
