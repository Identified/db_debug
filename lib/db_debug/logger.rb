class DbDebug
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
      str = "\033[0;#{code}m#{str}\033[0;#37m"  
      Rails.logger.debug str
      if defined? IRB
        puts str
      end
    end
    
    def self.determine_color count, time
      if count <= 10 || time < 50.0
        :green
      elsif count <= 20 || time < 100.0
        :yellow
      else
        :red
      end
    end
  end
end