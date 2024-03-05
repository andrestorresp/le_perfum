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

# Usuario de Vendedores
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

# Nombre de los perfumes e imagenes
perfumes = [
  { name: 'Sauvage', image: 'Sauvage.jpg' },
  { name: 'Vogue', image: 'Vogue.jpg' },
  { name: 'Chanel', image: 'Chanel.jpg' },
  { name: 'Yves_Saint_Laurent', image: 'Yves_Saint_Laurent.jpg' },
  { name: 'Boss', image: 'Boss.jpg' },
  { name: 'Hugo', image: 'Hugo.jpg' },
  { name: 'Armaf', image: 'Armaf.jpg' },
  { name: 'Nautica_Voyage', image: 'Nautica_Voyage.jpg' },
  { name: 'Lattafa', image: 'Lattafa.jpg' },
  { name: "L'Bel_Bleu", image: "L'Bel_Bleu.jpg" }
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
  'Hugo' => 'Una fragancia moderna y urbana para hombre, con notas de menta, lavanda y vetiver.',
  'Armaf' => 'Armaf es una marca de fragancias que ofrece una amplia gama de perfumes para hombres y mujeres. La marca es conocida por ofrecer una variedad de fragancias de alta calidad a precios asequibles. Sus perfumes abarcan una variedad de estilos y notas aromáticas, desde frescos y florales hasta amaderados y orientales.',
  'Nautica_Voyage' => 'Es una fragancia para hombres lanzada por la marca Nautica. Es conocida por su frescura y su aroma marino, inspirado en la navegación y la aventura en el mar. Esta fragancia se caracteriza por sus notas frescas y acuáticas que evocan la sensación de la brisa marina y la libertad del océano.',
  'Lattafa' => 'Lattafa ofrece una variedad de fragancias para hombres y mujeres, que van desde opciones dulces y afrutadas hasta fragancias más intensas y orientales. Sus perfumes suelen ser duraderos y cuentan con una excelente proyección, lo que los hace ideales para diversas ocasiones.',
  "L'Bel_Bleu" => "L'Bel es una reconocida marca de cosméticos que ofrece una amplia gama de productos para el cuidado facial, corporal y capilar."
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

# Usuario de Comprador
carlos = User.create!(
  email: 'carlos@gmail.com',
  password: '12345678',
  name: 'Carlos',
  last_name: 'Landaeta',
  phone_number: '987654321',
  address: 'La Trinidad'
)
carlos.photo.attach(io: File.open('app/assets/images/perfiles/User_Hombre2.jpg'), filename: 'User_Hombre2.jpg', content_type: 'image/jpeg')
