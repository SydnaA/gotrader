pokeString="["
while IFS= read -r line; do
  pokeString+="\"$line\", "
done < pokemonlist
pokeString+="]"
echo $pokeString
