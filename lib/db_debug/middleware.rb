class DbDebug
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      db_debug = env["QUERY_STRING"].gsub!(/&db_debug/, "")

      
      DbDebug.trace verbose: db_debug.present?  do
        @app.call(env)
      end
    end
  end
end