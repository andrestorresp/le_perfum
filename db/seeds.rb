Review.destroy_all
Checkout.destroy_all
User.destroy_all
Product.destroy_all

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
  { name: 'Valentino_Assoluto', image: 'Valentino_Assoluto.jpg' },
  { name: 'Hugo_Boss_Bottled', image: 'Hugo_Boss_Bottled.jpg' },
  { name: 'Armaf_Club', image: 'Armaf_Club.jpg' },
  { name: 'Nautica_Voyage', image: 'Nautica_Voyage.jpg' },
  { name: 'Lattafa', image: 'Lattafa.jpg' },
  { name: "Giorgio_Armani", image: "Giorgio_Armani.jpg" }
]

# Descripciones detalladas para cada perfume
descriptions = {
  'Dior_Sauvage_Elixir' => 'Las notas de salida son canela, nuez moscada, cardamomo y toronja, la nota de corazón es lavanda, las notas de fondo son regaliz.',
  'Versace_Eros' => 'Dylan Blue pour femme es un tributo a la feminidad. Una fragancia intensa, sensual y refinada creada para una mujer la elegancia de su espíritu.',
  'Dolce_Gabbana' => 'Esta fragancia está diseñada para el hombre conceptual, sofisticado y masculino.',
  'Yves_Saint_Laurent' => 'El jugo de esta nueva fragancia es profundo, fresco, masculino y es un intenso fougère blanco, oscuro.',
  'Valentino_Assoluto' => 'Valentina, de la firma italiana Valentino, En ella, Valentino, quiere describir la esencia de la mujer que identifica su marca.',
  'Hugo_Boss_Bottled' => 'La fragancia icónica de hombre a nivel mundial que captura la elegancia de un traje en un frasco.',
  'Armaf_Club' => 'Armaf es una marca de fragancias que ofrece una amplia gama de perfumes para hombres y mujeres.',
  'Nautica_Voyage' => 'Es una fragancia para hombres lanzada por la marca Nautica. Es conocida por su frescura y su aroma marino.',
  'Lattafa' => 'Las notas de salida son pimienta negra, tabaco y piña, las notas de corazón son pachulí, café y iris.',
  "Giorgio_Armani" => "La última fragancia refrescante y limpia, la colonia de este hombre se abre con un toque de fragancia marina."
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
