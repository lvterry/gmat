task :add_exam_labels => :environment do
  Label.create(name: 'GWD', category: '模考')
  Label.create(name: 'Prep', category: '模考')
  Label.create(name: '770', category: '模考')
end
