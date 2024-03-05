# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Review.destroy_all
Checkout.destroy_all
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
  { name: 'Dior_Sauvage_Elixir', image: 'Dior_Sauvage_Elixir.jpg' },
  { name: 'Versace_Eros', image: 'Versace_Eros.jpg' },
  { name: 'Dolce_Gabbana', image: 'Dolce_Gabbana.jpg' },
  { name: 'Yves_Saint_Laurent', image: 'Yves_Saint_Laurent.jpg' },
  { name: 'Valentino_Valentino_Assoluto', image: 'Valentino_Valentino_Assoluto.jpg' },
  { name: 'Hugo_Boss_Bottled', image: 'Hugo_Boss_Bottled.jpg' },
  { name: 'Armaf_Club', image: 'Armaf_Club.jpg' },
  { name: 'Nautica_Voyage', image: 'Nautica_Voyage.jpg' },
  { name: 'Lattafa', image: 'Lattafa.jpg' },
  { name: "Giorgio_Armani", image: "Giorgio_Armani.jpg" }

]

# Descripciones detalladas para cada perfume
descriptions = {
  'Dior_Sauvage_Elixir' => 'Las notas de salida son canela, nuez moscada, cardamomo y toronja, la nota de corazón es lavanda, las notas de fondo son regaliz, sándalo, ámbar, pachulí y vetiver de Haití',
  'Versace_Eros' => 'Dylan Blue pour femme es un tributo a la feminidad. Una fragancia intensa, sensual y refinada creada para una mujer que conoce el poder de su sensualidad y su mente. Mujeres femeninas, sexys con un fuerte poder de atracción, que dejan huella vayan dónde vayan. Esta fragancia nos aporta parte de Donatella Versace, de su seguridad y de su auto confianza.',
  'Dolce_Gabbana' => 'Esta fragancia está diseñada para el hombre conceptual, sofisticado y masculino, que se desenvuelve en la ciudad sin pasar desapercibido. Pisa fuerte, con carácter y presencia cada día de su vida, lo mismo que su perfume, que plasma su esencia de manera auténtica y única.',
  'Yves_Saint_Laurent' => 'El jugo de esta nueva fragancia es profundo, fresco, masculino y es un intenso fougère blanco, oscuro. Predomina una explosión olfativa de bergamota y jengibre la frescura es intensificada con las notas afrutadas de manzana verde. Seguido por una brisa suave de la salvia y el enebro, combinados con un toque de menta. El fondo de la fragancia resulta más intenso y masculino gracias a las maderas de ámbar, que refuerzan la misteriosa profundidad del olíbano y del haba tonka.',
  'Valentino_Valentino_Assoluto' => 'Valentina, de la firma italiana Valentino, En ella, Valentino, quiere describir la esencia de la mujer que identifica su marca. Un perfil joven, elegante y con una pizca de rebeldia.',
  'Hugo_Boss_Bottled' => 'La fragancia icónica de hombre a nivel mundial que captura la elegancia de un traje en un frasco. Es la fragancia que eligen los hombres seguros de sí mismos, elegantes, seductores y con espíritu dinámico.',
  'Armaf_Club' => 'Armaf es una marca de fragancias que ofrece una amplia gama de perfumes para hombres y mujeres. La marca es conocida por ofrecer una variedad de fragancias de alta calidad a precios asequibles. Sus perfumes abarcan una variedad de estilos y notas aromáticas, desde frescos y florales hasta amaderados y orientales.',
  'Nautica_Voyage' => 'Es una fragancia para hombres lanzada por la marca Nautica. Es conocida por su frescura y su aroma marino, inspirado en la navegación y la aventura en el mar. Esta fragancia se caracteriza por sus notas frescas y acuáticas que evocan la sensación de la brisa marina y la libertad del océano.',
  'Lattafa' => 'Las notas de salida son pimienta negra, tabaco y piña, las notas de corazón son pachulí, café y iris, las notas de fondo son vainilla, ámbar, Madera seca, benjuí y ládano.',
  "Giorgio_Armani" => "La última fragancia refrescante y limpia, la colonia de este hombre se abre con un toque de fragancia marina: bergamota de Calabria, neroli y mandarina verde. Estos matices acuáticos se mezclan con romero, caqui y pachulí indonesio para crear una fragancia aromática fresca y relajada."
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
