# Usa una imagen base de Ruby con la versión correcta
FROM ruby:3.2.4

# Opcional: instala un JS runtime, necesario para algunos assets en Rails
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -y nodejs

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia el Gemfile y Gemfile.lock a /app
COPY Gemfile Gemfile.lock ./

# Actualiza Bundler
RUN gem install bundler -v 2.4.19

# Instala las dependencias
RUN bundle install

# Copia el resto de los archivos de la aplicación
COPY . .

# Expone el puerto 3000 para acceder al servidor desde fuera
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["rails", "server", "-b", "0.0.0.0"]
