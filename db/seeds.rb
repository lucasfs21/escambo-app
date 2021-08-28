# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts "Cadastrando Categorias..."
categories = [ "Animais e acessórios" ,
               "Esportes",
               "Para a sua casa",
               "Eletrônicos e celulares",
               "Música e hobbies",
               "Bebês e crianças",
               "Moda e beleza",
               "Veículos e barcos",
               "Imóveis",
               "Empregos e negócios" ]
categories.each do |category|
  Category.find_or_create_by(description: category)
end
puts "Categorias Cadastradas!!!"

####################################################

puts "Cadastrando Administrador Padrão..."
Admin.create!(name: "Administrador Geral",
              email: "admin@admin.com",
              role: 0,
              password: "lucas2105",
              password_confirmation: "lucas2105")

puts "Administrador Cadastrado!!!"

####################################################

puts "Cadastrando Membro Padrão..."
member = Member.new(
  email: "user@user.com",
  password: "lucas2105",
  password_confirmation: "lucas2105"
)
member.build_profile_member
member.profile_member.first_name = "Lucas"
member.profile_member.second_name = "Ferreira"
member.save!

puts "Membro Cadastrado!!!"
