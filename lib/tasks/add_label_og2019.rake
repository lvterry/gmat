task :add_label_og2019 => :environment do
  Label.create(name: 'OG2019新题', category: '来源')
  Label.create(name: 'OG2019', category: '来源')
end