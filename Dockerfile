# Gunakan image Node.js sebagai base image
FROM node:20 AS build

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Salin file package.json dan package-lock.json (jika ada)
COPY package*.json ./

# Instal dependensi aplikasi
RUN npm install

# Salin seluruh kode proyek ke dalam container
COPY . .

COPY .env.example .env

# Bangun aplikasi Next.js
RUN npm run build

# # Gunakan image Node.js sebagai image final untuk menjalankan aplikasi
# FROM node:20 AS production

# # Tentukan direktori kerja di dalam container
# WORKDIR /app

# # Salin node_modules dan folder .next dari tahap build ke tahap production
# COPY --from=build /app/node_modules ./node_modules
# COPY --from=build /app/.next ./.next
# COPY --from=build /app/public ./public
# COPY --from=build /app/package*.json ./

# Ekspos port 3000
EXPOSE 3000

# Jalankan aplikasi Next.js
CMD ["npm", "start"]
