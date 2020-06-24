print "Enter year:"
y = gets.to_i

if y % 4 == 0 and y % 100 == 0 and y % 400 == 0
    puts "Yes(Can div 400)"
elsif y % 100 == 0 and y % 4 == 0
    puts "No"
elsif y % 4 == 0
    puts "Yes"
else
    puts "No"
end
