json.extract! @user, :id, :name, :email, :description, :phone, :gender, :birthday, :created_at, :updated_at

json.address do
  # Devolve um endereço se o endereço existir
  json.extract! @user.address, :country, :city, :state, :neighborhood, :street, :number if @user.address
end
