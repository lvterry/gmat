task :add_camp_labels => :environment do
  Label.create(name: '逻辑训练营', category: '训练营')
  Label.create(name: '数学训练营', category: '训练营')
  Label.create(name: '语法训练营', category: '训练营')
end