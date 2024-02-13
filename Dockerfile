#Usar una imagen de nodejs para crear la aplicacion
#En un directorio intermedio build
FROM node:latest AS build
#Establecer directorio de trabajo del contenedor
WORKDIR /app
#Copiar los archivo package.json y packager-lock.json 
COPY package*.json ./ 
#Instalar dependencias 
RUN npm install 
#Copiar todos los archivos al directorio de trabajo 
COPY . . 
#Buildear la aplicacion 
RUN npm run build Usar una imagen base de apache 
FROM httpd:latest 
#Copiar los archivos desde el directorio temporal donde hemos realizado el build con la imagen de node (--from=build), copiar la carpeta dist al directorio de trabajo /app y a nuestro servidor apache 
COPY --from=build /app/build/ /usr/local/apache2/htdocs/ 

#Exponer el puerto 80
EXPOSE 80