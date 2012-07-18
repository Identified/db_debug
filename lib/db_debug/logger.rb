module DbDebug
  module Logger
    COLOR_MAP = {
      :black => 30,
      :red  => 31,
      :green  => 32,
      :yellow  => 33,
      :blue  => 34,
      :magenta  => 35,
      :cyan  => 36,
      :white => 37
    }
    
    def self.log color, str
      code = COLOR_MAP[color]
      Rails.logger.debug "\033[0;#{code}m#{str}\033[0;#37m"      
    end
  end
end