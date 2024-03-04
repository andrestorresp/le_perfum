# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.destroy_all
Product.destroy_all

# db/seeds.rb

# Crear usuarios con imágenes de perfil adjuntas
juan = User.create!(
  email: 'juan@gmail.com',
  password: '12345678',
  name: 'Juan',
  last_name: 'Pérez',
  phone_number: '123456789',
  address: 'Calle Principal 123'
)
juan.photo.attach(io: File.open('app/assets/images/perfiles/User_Hombre.jpg'), filename: 'User_Hombre.jpg', content_type: 'image/jpeg')

maria = User.create!(
  email: 'maria@gmail.com',
  password: '12345678',
  name: 'María',
  last_name: 'López',
  phone_number: '987654321',
  address: 'Avenida Central 456'
)
maria.photo.attach(io: File.open('app/assets/images/perfiles/User_Mujer.jpg'), filename: 'User_Mujer.jpg', content_type: 'image/jpeg')

perfumes = [
  { name: 'Sauvage', image: 'Sauvage.jpg' },
  { name: 'Vogue', image: 'Vogue.jpg' },
  { name: 'Chanel', image: 'Chanel.jpg' },
  { name: 'Yves_Saint_Laurent', image: 'Yves_Saint_Laurent.jpg' },
  { name: 'Boss', image: 'Boss.jpg' },
  { name: 'Hugo', image: 'Hugo.jpg' }
]

# Descripciones detalladas para cada perfume
descriptions = {
  'Sauvage' => 'Una fragancia sensual para hombres, con notas de bergamota, ámbar y pachulí.',
  'Vogue' => 'Vogue perfume es una fragancia para mujeres que se destaca por sus notas florales y aldehídicas. ' \
           'Al aplicar el perfume, se recomienda evitar frotar las muñecas para no romper las notas y ' \
           'aplicarlo en puntos estratégicos como la parte trasera de las orejas, el escote, las muñecas, ' \
           'los tobillos y la parte trasera de las rodillas',
  'Chanel' => 'Una fragancia icónica tanto para hombres como para mujeres, con toques cítricos, jazmín y sándalo.',
  'Yves_Saint_Laurent' => 'Una fragancia atrevida y sofisticada con notas de grosella negra, rosa y vainilla.',
  'Boss' => 'Una fragancia fresca y enérgica para hombre, con toques de manzana, cítricos y sándalo.',
  'Hugo' => 'Una fragancia moderna y urbana para hombre, con notas de menta, lavanda y vetiver.'
}

# Crear productos y adjuntar imágenes
perfumes.each do |perfume|
  product = Product.create!(
    name: perfume[:name],
    description: descriptions[perfume[:name]],  # Usar la descripción detallada
    price: rand(10.0..100.0).round(2),
    user_id: User.pluck(:id).sample
  )

  # Adjuntar imagen al producto
  image_path = Rails.root.join('app', 'assets', 'images', 'perfumes', perfume[:image])
  image_blob = ActiveStorage::Blob.create_and_upload!(
    io: File.open(image_path),
    filename: perfume[:image],
    content_type: 'image/jpeg'
  )
  product.photo.attach(image_blob)
end
