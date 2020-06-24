y = 2020 # 年
m = 6 # 月
days = 0 # 何日あるか

def LeapYear(y)
  if y % 4 == 0 and y % 100 == 0 and y % 400 == 0
      return 1 #puts "Yes(Can div 400)"
  elsif y % 100 == 0 and y % 4 == 0
      return 0 #puts "No"
  elsif y % 4 == 0
      return 1 #puts "Yes"
  else
      return 0 #puts "No"
  end
end

def MonthOfDays(m)
    case m
        when 1 then return 31
        when 2 then return 28
        when 3 then return 31
        when 4 then return 30
        when 5 then return 31
        when 6 then return 30
        when 7 then return 31
        when 8 then return 31
        when 9 then return 30
        when 10 then return 31
        when 11 then return 30
        when 12 then return 31
    end
end

def Zeller(y, m, d)
    return y + (y/4) - (y/100) + (y/400) + ((13*m + 8)/5) + d
end

print "      ", y, "年", m, "月\n"
days = MonthOfDays(m)
#puts days

# 曜日の表示
print "日 月 火 水 木 金 土\n"

i = 0
youbi = Zeller(y, m, 1)
while i < youbi % 7
    print "   "
    i += 1
end
#print youbi % 7, "\n"

i = 1
j = 1
return_point = 0
while i <= days

    # 最初の行の改行を制御
    if i + (youbi % 7) == 8
        puts "\n"
        return_point = i
    # 2行目以降の改行を制御
    elsif i == (7*j + return_point)
        puts "\n"
        j += 1
    end
    # 日付を表示
    if i < 10
        print " ", i, " "
    else
      print i, " "
    end
    i += 1
end
puts "\n"
