require 'active_record/connection_adapters/postgresql_adapter'

class DbDebug
  module ActiveRecord
    module ConnectionAdapters
      module PostgreSQLAdapter
        def self.included(klass)
          klass.class_eval do
            alias_method_chain :exec_query, :db_debug
          end
        end
        
        def exec_query_with_db_debug(sql, name = 'SQL', binds = [])
          if DbDebug.enabled            
            DbDebug.count += 1
            start = Time.now
            res = exec_query_without_db_debug(sql, name, binds)
            time = (Time.now - start) * 1000
            
            if DbDebug.verbose
              Logger.log :white, ""
              Logger.log :red, "DB CALL " + "="*72
              Logger.log :green, "SQL:     #{sql.split("\n").join("").strip}"
              Logger.log :green, "BINDS:   #{binds}" if binds.present?
              Logger.log :white, "TIME:    #{time} ms"
              Logger.log :white, caller.delete_if{ |str| str.include?("/gems/") || str.include?("script/rails") }.join("\n")
              Logger.log :red, "="*80
              Logger.log :white, ""
              
            end
            DbDebug.time += time
            res
          else
            exec_query_without_db_debug(sql, name, binds)
          end
        end
      end
    end
  end
end

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, DbDebug::ActiveRecord::ConnectionAdapters::PostgreSQLAdapter) 
