require "db_debug/middleware"
require "db_debug/active_record"
require "db_debug/version"
require "db_debug/logger"
require "db_debug/engine"

class DbDebug
  cattr_accessor :count, :time, :verbose, :enabled
  
  def self.trace opts = {}
    DbDebug.enabled   = true
    DbDebug.count     = opts[:count] || 0
    DbDebug.time      = opts[:time]  || 0
    DbDebug.verbose   = opts[:verbose] || false
    
    res = yield
    
    color = Logger.determine_color DbDebug.count, DbDebug.time
    Logger.log color, "You hit the database #{DbDebug.count} times and it took %5.3f ms" % DbDebug.time
    
    DbDebug.enabled   = false
    res
  end
end
