# -*- coding: utf-8 -*-
require 'rubygems'  # RubyGemsでインストールした時には記述
require 'dbi'
require 'date'

# 変数：title,author,page,publish_date
# 変数の初期化とか出力フォーマットとか
class BookInfo
  def initialize( title, author, page, publish_date )
    @title = title
    @author = author
    @page = page
    @publish_date = publish_date
  end

  # 最初に、検討する属性に対するアクセサを提供する
  attr_accessor :title, :author, :page, :publish_date

  # BookInfoクラスのインスタンスの文字列表現を返すようにする。
  def to_s
    "#{@title}, #{@author}, #{@page}, #{@publish_date}"
  end

  # 出力フォーマットの定義
  def toFormattedString( sep = "\n" )
    "書籍名：#{@title}#{sep}著者名：#{@author}#{sep}ページ数：#{@page}ページ#{sep}発刊日：#{@publish_date}#{sep}"
  end
end



# 蔵書情報管理のメイン処理部
class BookInfoManager
  def initialize ( sqlite_name )
    # SQLiteデータベースに接続
    @db_name = sqlite_name
    @dbh = DBI.connect( "DBI:SQLite3:#{@db_name}" )
    puts "DBと接続しました。"
  end

  def initBookInfos
    puts "\n0. 蔵書データベースの初期化"
    print "初期化しますか？(Y/yなら削除を実行): "
    # 読み込んだ値を大文字に揃える
    yesno = gets.chomp.upcase   # upcaseは大文字に変えてくれる
    if yesno =~ /^Y$/
      # Yが1文字の時だけ初期化
      # 既にDBにテーブル'bookinfos'があれば削除
      puts "\nDBの初期化を開始します。"
      @dbh.do("drop table if exists bookinfos")
      # 新しく'bookinfos'テーブルを作成
      @dbh.do("create table bookinfos (
              id            varchar(50)   not null,
              title         varchar(100)  not null,
              author        varchar(100)  not null,
              page          int           not null,
              publish_date  datetime      not null,
              primary key(id)
             );")
      puts "\nDBを初期化しました。"
    else
      puts "\nDBの初期化をしませんでした。"
    end
  end

  def listAllBookInfos
    # テーブル上の項目名を日本語に変えるハッシュテーブル
    item_name = {
      'id' => "キー",
      'title' => "タイトル",
      'author' => "著者名",
      'page' => "ページ数",
      'publish_date' => "発刊日"
    }

    puts "\n1. 蔵書データの表示"
    puts "\n蔵書データを表示します。"
    puts "----"

    # テーブルからデータを読み込んで表示する
    sth = @dbh.execute( "select * from bookinfos" )

    counts = 0
    sth.each do |row|
      # rowは1行分のデータを保持
      row.each_with_name do |val,name|
        # 項目名を変換して表示（ハッシュを使う）
        puts "#{item_name[name]}：#{val.to_s}"
      end
      puts "----"
      counts = counts + 1
    end
    
    # ステートメントハンドラを開放する
    sth.finish
    
    puts "\n#{counts}件表示しました。"
  end

  def addBookInfo
    puts "\n8. 蔵書データの登録"
    puts "\n蔵書データを登録します。"

    # 蔵書データ1件分のインスタンスを作成する
    book_info = BookInfo.new( "", "", 0, Date.new )
    print "\n"
    print "キー: "
    key = gets.chomp
    sth = @dbh.execute( "select id from bookinfos" )
    flag = 0
    sth.each do |row|
      if row = key
        puts "\n----"
        puts "Error : 既にキーが登録されています。蔵書データを登録できませんでした。"
        puts "----"

        flag = 1
        break;
      end
    end
    
    if flag == 1
      sth.finish
    else

      print "書籍名: "
      book_info.title = gets.chomp

      print "著者名: "
      book_info.author = gets.chomp

      print "ページ数: "
      book_info.page = gets.chomp

      print "発刊年を入力してください: "
      year = gets.chomp.to_i
      print "発刊月を入力してください: "
      month = gets.chomp.to_i
      print "発刊日を入力してください: "
      day = gets.chomp.to_i
      if Date.valid_date?( year, month, day )
        book_info.publish_date = Date.new( year, month, day )

        # 作成したデータ1件分をDBに登録する
        @dbh.do("insert into bookinfos values (
              \'#{key}\',
              \'#{book_info.title}\',
              \'#{book_info.author}\',
              \'#{book_info.page}\',
              \'#{book_info.publish_date}\'
      );")

        puts "\n登録しました"
      else
        puts "\n----"
        puts "Error : 指定の日付が存在しません。\n蔵書データを登録できませんでした。"
        puts "----"
      end
    end
  end

  def run
    while true
      print "
      --- Main Menu ---
      0. DBの初期化
      1. 蔵書データの表示
      8. 蔵書データの登録
      9. 終了
      番号を選択してください(0,1,8,9): "

      # 文字の入力を待つ
      num = gets.chomp    # chompはgetsした文字列の最後の改行を削除してくれる
      case
      when '0' == num
        # DB初期化
        initBookInfos
      when '1' == num
        # 全件表示
        listAllBookInfos
      when '8' == num
        # 登録
        addBookInfo
      when '9' == num
        @dbh.disconnect
        puts "\nDBとの接続を終了しました"
        break;
      else
        # 処理選択待ち画面に戻る
      end
    end
  end
end

book_info_manager = BookInfoManager.new("bookinfo_sqlite.db")

book_info_manager.run