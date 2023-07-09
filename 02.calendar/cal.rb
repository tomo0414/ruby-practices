#!/usr/bin/env ruby
require "date"
require "optparse"

class Calendar
  def initialize
    opt = OptionParser.new
    options = {
      option_y: false,
      argument_y: Date.today.year,
      option_m: false,
      argument_m: Date.today.month
    }

    opt.on("-y year") do |year|
      options[:option_y] = true
      options[:argument_y] = year
    end
    opt.on("-m month") do |month|
      options[:option_m] = true
      options[:argument_m] = month
    end
    opt.parse!(ARGV)

    print_month(options[:argument_y].to_i, options[:argument_m].to_i)
  end

  def print_month(year, month)
    japanese_wdays = ["日", "月", "火", "水", "木", "金", "土"]
    #月の最初の日を取得
    first_day_of_month = Date.new(year, month, 1)
    #月の最後の日を取得
    last_day_of_month = Date.new(year, month, -1)
    #カレンダーの年月を表示
    puts "#{month}月 #{year}".center(20)
    #カレンダーの曜日を表示
    puts japanese_wdays.join(" ")

    #カレンダーを表示
    print " " * (first_day_of_month.wday * 3)
    (first_day_of_month..last_day_of_month).each do |day|
      if day == Date.today
        #背景色を白、文字色を黒に変更
        print "\e[47m\e[30m#{day.day.to_s.rjust(2)}\e[0m "
      else
        print "#{day.day.to_s.rjust(2)} "
      end
      if day.saturday? || day == last_day_of_month
        print "\n"
      end
    end
  end
end

calendar = Calendar.new
