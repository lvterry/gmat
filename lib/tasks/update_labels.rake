task :update_labels => :environment do
  Label.where(name: 'OG15').update(name: 'OG13')
  Label.where(name: 'OG16').update(name: 'OG2016')
  Label.where(name: 'OG17').update(name: 'OG2017')
  Label.where(name: 'Manhattan').update(name: 'Prep08')
  Label.create(name: 'OG2018', category: '来源')
  Label.create(name: 'Prep2012', category: '来源')
  Label.where(name: '推理IR').update(name: '综合推理IR')
  Label.create(name: '数学DS', category: '题型')
end