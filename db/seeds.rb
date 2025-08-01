# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# コンビニデータ
convenience_stores = [
  "セブン-イレブン",
  "ローソン", 
  "ファミリーマート",
  "サークルK",
  "サンクス",
  "デイリーヤマザキ",
  "ミニストップ",
  "ポプラ"
]

convenience_stores.each do |store_name|
  ConvenienceStore.find_or_create_by!(name: store_name)
end

# カテゴリデータ
categories = [
  "お菓子",
  "飲料水",
  "弁当",
  "パン",
  "アイス",
  "お酒",
  "日用品",
  "雑誌"
]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

# 味覚タグデータ
tastes = [
  "甘い",
  "辛い",
  "酸っぱい",
  "苦い",
  "しょっぱい",
  "旨味",
  "スパイシー",
  "フルーティ"
]

tastes.each do |taste_name|
  Taste.find_or_create_by!(name: taste_name)
end

# 地域タグデータ
regions = [
  "関東限定",
  "関西限定",
  "東北限定",
  "中部限定",
  "中国限定",
  "四国限定",
  "九州限定",
  "北海道限定",
  "沖縄限定"
]

regions.each do |region_name|
  Region.find_or_create_by!(name: region_name)
end

puts "初期データの投入が完了しました！"
puts "コンビニ: #{convenience_stores.count}件"
puts "カテゴリ: #{categories.count}件"
puts "味覚タグ: #{tastes.count}件"
puts "地域タグ: #{regions.count}件"
