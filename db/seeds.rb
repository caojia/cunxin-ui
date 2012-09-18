# encoding: UTF-8
#

project = Project.create(
  :canonical_name => "project1", 
  :headline => "爱心召集：给苏州12岁白血病女孩微微再一次生命！",
  :description => "她叫小薇薇,12岁,去年被查出白血病.为了给她看病,薇薇妈说能借的都借了,6岁弟弟为她用拼音写求助信乞讨,奶奶为她瞒着家人捡垃圾筹医药费...她说她想上学,想去苏州乐园,还想和同学一起去秋游...于是微博网友用爱心PS带她去了好多地方,可她的病还需要花很多很多钱,你愿意再给她一次生命希望吗？",
  :location => "苏州",
  :thumbnail_small => "/projects/1.jpg",
  :thumbnail_large => "/projects/1.jpg",
  :start_date => "2012-09-08 00:00:00",
  :donators_count => 1000,
  :target_amount => 50000
)

Carousel.create(
  :project_id => project.id,
  :position => 1
)

photo = Photo.create(
  :name => "爱心召集：照片1",
  :description => "bla bla...",
  :thumbnail_small => "/charities/1.jpeg",
  :link => "/projects/1.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 0
)

photo = Photo.create(
  :name => "爱心召集：照片2",
  :description => "bla bla...",
  :thumbnail_small => "/charities/1.jpeg",
  :link => "/projects/1.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 1
)

photo = Photo.create(
  :name => "爱心召集：照片3",
  :description => "bla bla...",
  :thumbnail_small => "/charities/1.jpeg",
  :link => "/projects/1.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 2
)

photo = Photo.create(
  :name => "爱心召集：照片4",
  :description => "bla bla...",
  :thumbnail_small => "/charities/1.jpeg",
  :link => "/projects/1.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 3
)

photo = Photo.create(
  :name => "爱心召集：照片5",
  :description => "bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla...",
  :thumbnail_small => "/charities/2.jpeg",
  :link => "/projects/1.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 4
)

project = Project.create(
  :canonical_name => "project2", 
  :headline => "【爱心衣橱】紧急为云南地震灾区小学生筹集新衣项目款",
  :description => "2012年9月7日11时19分，云南省昭通市彝良县发生里氏5.7级地震。截至9月9日11时，地震已造成81人死亡，821人受伤，20.1万人紧急转移安置。",
  :location => "云南",
  :thumbnail_small => "/projects/2.jpg",
  :thumbnail_large => "/projects/2.jpg",
  :start_date => "2012-09-01 00:00:00",
  :donators_count => 1000,
  :target_amount => 50000
)

Carousel.create(
  :project_id => project.id,
  :position => 2
)

# Same photo for two project
ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 2
)

photo = Photo.create(
  :name => "爱心衣橱：照片1",
  :description => "bla bla",
  :thumbnail_small => "/charities/1.jpeg",
  :link => "/projects/2.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 0
)

photo = Photo.create(
  :name => "爱心衣橱：照片2",
  :description => "bla bla bla...",
  :thumbnail_small => "/charities/2.jpeg",
  :link => "/projects/2.jpg"
)

ProjectPhoto.create(
  :project => project,
  :photo => photo,
  :position => 1
)

charity = Charity.create(
  canonical_name: "charity1",
  name: "壹基金",
  thumbnail_large: "/charities/1.jpeg",
  thumbnail_small: "/charities/1.jpeg",
  published: true,
  description: "chartity 1",
  short_description: "charity 2",
  published_at: Time.now.utc)


charity = Charity.create(
  canonical_name: "charity2",
  name: "免费午餐",
  thumbnail_large: "/charities/2.jpeg",
  thumbnail_small: "/charities/2.jpeg",
  published: true,
  description: "chartity 2",
  short_description: "charity 2",
  total_amount: 1000000,
  published_at: Time.now.utc
)


charity = Charity.create(
  canonical_name: "charity3",
  name: "chartity 3",
  thumbnail_large: "/charities/3.jpeg",
  thumbnail_small: "/charities/3.jpeg",
  published: true,
  description: "chartity 3",
  short_description: "charity 3",
  published_at: Time.now.utc
)

charity = Charity.create(
  canonical_name: "charity4",
  name: "chartity 4",
  thumbnail_large: "/charities/4.jpeg",
  thumbnail_small: "/charities/4.jpeg",
  published: true,
  total_amount: 100000,
  description: "chartity 4",
  short_description: "charity 4",
  published_at: Time.now.utc
)

consult = Consult.create(
  canonical_name: "consult1",
  name: "王庆",
  thumbnail_large: "/consults/1.jpeg",
  thumbnail_small: "/consults/1.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

consult = Consult.create(
  canonical_name: "consult2",
  name: "林毅夫",
  thumbnail_large: "/consults/2.jpeg",
  thumbnail_small: "/consults/2.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

consult = Consult.create(
  canonical_name: "consult3",
  name: "王石",
  thumbnail_large: "/consults/3.jpeg",
  thumbnail_small: "/consults/3.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

consult = Consult.create(
  canonical_name: "consult4",
  name: "刘强东",
  thumbnail_large: "/consults/4.jpeg",
  thumbnail_small: "/consults/4.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

consult = Consult.create(
  canonical_name: "consult5",
  name: "黄奕",
  thumbnail_large: "/consults/5.jpeg",
  thumbnail_small: "/consults/5.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

donator = Donator.create(
  canonical_name: "donator1",
  name: "中金公司",
  thumbnail_large: "/donators/1.jpeg",
  thumbnail_small: "/donators/1.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

donator = Donator.create(
  canonical_name: "donator2",
  name: "摩根大通",
  thumbnail_large: "/donators/2.jpeg",
  thumbnail_small: "/donators/2.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

donator = Donator.create(
  canonical_name: "donator3",
  name: "万科",
  thumbnail_large: "/donators/3.jpeg",
  thumbnail_small: "/donators/3.jpeg",
  published: true,
  description: "bla bla bla...",
  short_description: "bla bla bla...",
  published_at: Time.now.utc
)

