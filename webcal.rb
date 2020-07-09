require 'sinatra'
require 'date'

set :environment, :production

class CalCal
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
        else return 31
        end
    end

    def Zeller(y, m, d)
        return y + (y / 4) - (y / 100) + (y / 400) + ((13 * m + 8) / 5) + d
    end
end

get '/' do
    @error = 1
    erb :index
end

get '/:year/:month' do
    @y = params[:year]
    @m = params[:month]  
    @error = 0
    if @m.to_i > 12 or @m.to_i <= 0 or @y.to_i <= 0
        @error = 1
    end
    cal = CalCal.new() # メソッド使うためのインスタンス
    d = Date.today # Dateメソッドを使う
    @mybirth = Date.new(2001, 8, 20)
    @born = d - @mybirth
    year = @y.to_i
    month = @m.to_i
    @today = d.day
    @last_month_year = year
    @last_month = month - 1
    @this_month_year = d.year
    @this_month = d.month
    @next_month_year = year
    @next_month = month + 1
    @mybirthyear = @mybirth.year
    @mybirthmonth = @mybirth.month
    
    if @last_month == 0
        @last_month_year -= 1
        @last_month = 12
    elsif @next_month == 13
        @next_month_year += 1
        @next_month = 1
    end

    print "      ", @y, "年", @m, "月\n" # このとき表示で変数を使うので以下.to_i必要
    days = cal.MonthOfDays(@m.to_i) # その月が何日あるか
    # うるう年対策
    if cal.LeapYear(@y.to_i) == 1 and @m.to_i == 2
        days += 1
    end

    # 曜日の表示
    print "日 月 火 水 木 金 土\n"

    # 初日の曜日を求める(0=日,6=土)
    if @m.to_i == 1
        youbi = cal.Zeller(@y.to_i - 1, 14, 1)
    else
        youbi = cal.Zeller(@y.to_i, @m.to_i, 1)
    end
    rownum = (((youbi % 7) + days) / 7.0).ceil # 行の数
    colnum = 7 # 列の数(一週間は7日間)
    @calday = Array.new(rownum).map{Array.new(colnum, " ")} # 日付を格納する二次元配列
                                                            # mapの方で配列の要素数、初期値
    cnt = youbi % 7 # 二次元配列の操作に使う
    i = 0
    while i < youbi % 7
        print "   "
        i += 1
    end

    i = 1
    j = 1
    return_point = 0
    while i <= days
        # 最初の行の改行を制御
        if i + (youbi % 7) == 8
            puts "\n"
            return_point = i
            # 2行目以降の改行を制御
        elsif i == (7 * j + return_point)
            puts "\n"
            j += 1
        end
        # 日付を表示
        if i < 10
            print " ", i, " "
        else
            print i, " "
        end
        @calday[cnt / 7][cnt % 7] = i # ここでerbで表示する値を入れる
        i += 1
        cnt += 1
    end
    puts "\n"
    
    @dayday = youbi
    erb :index
end # getのend
