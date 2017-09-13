task :convert_pinyin => :environment do
  User.all.each do |user|
    user.pinyin = Pinyin.t(user.nickname).gsub(' ','')
    user.save
  end
end