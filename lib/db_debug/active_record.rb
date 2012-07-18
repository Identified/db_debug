module DbDebug
  module ActiveRecord
    module Base
      class << self
        def included(klass)
          klass.extend ClassMethods
          klass.class_eval do
            class << self
              alias_method_chain :find_by_sql, :record_counter
            end
          end
          include InstanceMethods
        end
      end

      module ClassMethods
        def find_by_sql_with_record_counter(*args)
          if defined? request
            resp = nil
            request.env['db.count'] = request.env['db.count'] + 1
            time = Benchmark.realtime { resp = find_by_sql_without_record_counter(*args) } * 1000
            if request.params[:db_debug]
              Logger.log :white, "DB Query took: #{time} ms"
              Logger.log :white, caller.delete_if{ |str| str.include?("/gems/") || str.include?("script/rails") }.join("\n")
            end
            request.env['db.time'] = request.env['db.time'] + time
            resp
          else
            find_by_sql_without_record_counter(*args)
          end
        end
      end

      module InstanceMethods
      end
    end
  end
end

ActiveRecord::Base.send(:include, DbDebug::ActiveRecord::Base)
