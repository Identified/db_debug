class DbDebug
  class Engine < ::Rails::Engine
    config.app_middleware.use DbDebug::Middleware
    
    config.after_initialize do
      ::ActiveRecord::Base.connection.class.send(:include, DbDebug::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) 
    end
  end
end
