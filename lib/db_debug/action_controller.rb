module  DbDebug
  module ActionController
    module Base
      class << self
        def included(klass)
            klass.class_eval do
            around_filter :hack_to_pass_shit_to_rack_middleware

            protected

            def hack_to_pass_shit_to_rack_middleware
              klasses = [ActiveRecord::Base, ActiveRecord::Base.class]
              methods = ["session", "cookies", "params", "request"]

              methods.each do |shenanigan|
                oops = instance_variable_get(:"@_#{shenanigan}") 

                klasses.each do |klass|
                  klass.send(:define_method, shenanigan, proc { oops })
                end
              end

              yield

              methods.each do |shenanigan|      
                klasses.each do |klass|
                  klass.send :remove_method, shenanigan
                end
              end
            end 
          end
        end
      end
    end
  end
  
end



ActionController::Base.send(:include, DbDebug::ActionController::Base)