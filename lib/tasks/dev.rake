namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public', 'system')
    puts "Executando o setup para desenvolvimento..."

    puts %x(rake db:drop)
    puts "Apagando imagens de public/system #{%x(rm -rf #{images_path})}"
    puts %x(rake db:create)
    puts %x(rake db:migrate)
    puts %x(rake db:seed)
    puts %x(rake dev:generate_admins)
    puts %x(rake dev:generate_members)
    puts %x(rake dev:generate_ads)
    puts %x(rake dev:generate_comments)

    puts "Setup completado!!!"
  end

  ##########################################################################################
  desc "Gerar Administradores Fakes"
  task generate_admins: :environment do
    puts "Cadastrando Administradores..."

    10.times do
      Admin.create!(name: Faker::Name.name,
                    email: Faker::Internet.email,
                    role: [0, 1].sample,
                    password: "lucas2105",
                    password_confirmation: "lucas2105",
      )

    end
    puts "Administradores Cadastrados!!!"
  end

  ##########################################################################################
  desc "Cria Anúncios Fake"
  task generate_ads: :environment do
    puts "Cadastrando Anúncios..."

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_short: Faker::Lorem.sentence([1,2,3].sample),
        description_md: markdown_fake,
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_short: Faker::Lorem.sentence([1,2,3].sample),
        description_md: markdown_fake,
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpg"), 'r')
      )
    end
    puts "Anúncios Cadastrados!!!"
  end

  ##########################################################################################
  desc "Gerar Membros Fakes"
  task generate_members: :environment do
    puts "Cadastrando Membros..."

    100.times do
      member = Member.new(
        email: Faker::Internet.email,
        password: "lucas2105",
        password_confirmation: "lucas2105"
      )
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name
      member.save!
    end
    puts "Membros Cadastrados!!!"
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end


############################################################################################
desc "Gerar Comentários Fakes"
task generate_comments: :environment do
  puts "Cadastrando Comentários..."

  Ad.all.each do |ad|
    (Random.rand(3)).times do
      Comment.create!(
        body: Faker::Lorem.paragraph([1,2,3].sample),
        member: Member.all.sample,
        ad: ad
      )
    end
  end

  puts "Comentários Cadastrados!!!"
end

end
