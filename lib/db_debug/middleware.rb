class DbDebug
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      str = env["QUERY_STRING"].gsub(/&db_debug/, "")
      db_debug = env["QUERY_STRING"] != str
      env["QUERY_STRING"] = str if db_debug 

      
      DbDebug.trace verbose: db_debug.present?  do
        @app.call(env)
      end
    end
  end
end