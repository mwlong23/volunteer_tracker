require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})
