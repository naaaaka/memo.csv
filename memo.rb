def create_edit()
    puts "1(新規でメモを作成)　2(既存のメモ編集する)"
    memo_type = gets.chomp.to_i
    if memo_type == 1 
        puts "拡張子を除いたファイル名を入力して下さい"
        title = gets.chomp
        puts "メモしたい内容を記入してください\n完了したら「Ctrl」+「D」を押してください "
        content = $stdin.read
        require 'csv'
        CSV.open(title+'.csv', "w") do |csv|
            csv << [content]
        end
        puts "ファイルを作成しました"
    elsif memo_type == 2
        puts "編集したいメモ名(拡張子除く)を入力してください"
        title = gets.chomp
        title = title + ".csv"
        puts title
        if File.exist?(title)
            require 'csv'
            data = CSV.read(title)
            puts "現在の内容です。\n#{data}\n"
            puts "1(書き換えますか) 2(追記しますか)"
            type = gets.chomp.to_i
            if type == 1 
                puts "書き換え内容を入力してください\n完了したら「Ctrl」+「D」を押してください"
                content = $stdin.read
                CSV.open(title, "w") do |csv|
                    csv << [content]
                end
            elsif type == 2
                puts "追記内容を入力してください\n完了したら「Ctrl」+「D」を押してください"
                content = $stdin.read
                CSV.open(title, "a") do |csv|
                csv << [content]
                end
            end
            puts "ファイルを書き換えました"
        else
            puts "#{title}は存在しません"
        end
    else
        puts "1または2を入力してください"
        create_edit()
    end
end

create_edit()