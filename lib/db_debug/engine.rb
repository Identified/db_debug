module DbDebug
  class Engine < ::Rails::Engine
    config.app_middleware.use DbDebug::Middleware
  end
end