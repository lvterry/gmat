task :add_label_gwd => :environment do
  Label.create(name: 'GWD', category: '来源')
end