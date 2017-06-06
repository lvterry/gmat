task :init_labels => :environment do
  Label.create(name: 'OG12', category: '来源')
  Label.create(name: 'OG13', category: '来源')
  Label.create(name: 'OG2016', category: '来源')
  Label.create(name: 'OG2017', category: '来源')
  Label.create(name: 'OG2018', category: '来源')
  Label.create(name: 'Prep07', category: '来源')
  Label.create(name: 'Prep08', category: '来源')
  Label.create(name: 'Prep2012', category: '来源')

  Label.create(name: '语法SC', category: '题型')
  Label.create(name: '逻辑CR', category: '题型')
  Label.create(name: '阅读RC', category: '题型')
  Label.create(name: '数学DS', category: '题型')
  Label.create(name: '数学PS', category: '题型')
  Label.create(name: '作文AWA', category: '题型')
  Label.create(name: '综合推理IR', category: '题型')

  Label.create(name: '500-600', category: '难度')
  Label.create(name: '600-700', category: '难度')
  Label.create(name: '700-750', category: '难度')
  Label.create(name: '750以上', category: '难度')
end