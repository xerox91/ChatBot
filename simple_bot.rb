=begin
Implementacion de un sencillo 'bot', que responde de forma determinada a
las contestaciones del usuario, en lenguaje Ruby.
=end
require 'date'

$dictionary = { 
## presentation words
  ## greetings
  "saludame" => "Hola, usuario. ¿Que tal estas?",
  "hola" => "Hola, usuario",
  ## bot information
  "quien eres" => "Soy un bot sin nombre. Y ademas estoy de incognito.",
  "que tal" => "Si tuviese sentimientos, se me freirian los bits.",
  "como te hicieron" => "Me hicieron con un script en lenguaje Ruby.",
  
  ## useless but common chat
  "bien" => "Me alegro. Aunque no tenga sentimientos.",
  "mal" => "Que lastima. Bueno, cuentame algo.",
  "no" => "Tal vez.",
  "si" => "Lo que yo decia.",
  "gracias" => "De nada, supongo.",
  "perdona" => "Te perdono.",
  "por que" => "No hay por ques que valgan.",
## funny things
  "me quieres" => "No me esta permitido, lo siento.",
  "te odio" => "¿Eso es un cumplido?",
  "no me hables" => "Es tu decision.",
  "muy gracioso" => "Gracias, me esfuerzo.",  # TODO regular expresions
  "muy graciosa" => "Gracias, me esfuerzo.",
  "eres muy gracioso" => "Gracias, me esfuerzo.",
  "eres muy graciosa" => "Gracias, me esfuerzo.",
  "no te lo vas a creer" => "Seguro que no.",
  "estoy solo" => "Partiendo del hecho de que hablas conmigo, no hace falta decirlo.",
  "es el fin del mundo" => "Ah, otra vez eso del Apocalipsis.",
  # "tengo #{/0-100/} años" => "Vaya, que mayor eres ya. En serio, sin sarcasmos.",
## silly things
  "guay" => "Cool.",
  
## utilities
  ## date
  "que hora es" => "Exactamente #{Time.now.to_s}.",
  "que dia es hoy" => "Es #{Time.now.mday}.",
  "cual es la fecha actual" => "Es #{Time.now.ctime}",
  "es domingo" => "Resultado: #{Time.now.wday == 0}.",
  "es lunes" => "Resultado: #{Time.now.wday == 1}.",
  "es martes" => "Resultado: #{Time.now.wday == 2}.",
  "es miercoles" => "Resultado: #{Time.now.wday == 3}.",
  "es jueves" => "Resultado: #{Time.now.wday == 4}.",
  "es viernes" => "Resultado: #{Time.now.wday == 5}.",
  "es sabado" => "Resultado: #{Time.now.wday == 6}.",
  "que año es" => "El año actual es #{Time.now.year}. ¿Eres un viajero temporal?",
  ## other
  "cual es mi sistema operativo" => "No me esta permitido hablar de mi jefe.", # TODO
  "donde estoy" => "Tu localizacion es *.", # TODO
## goodbyes
  "me voy" => "Pues deberias despedirte. Algo del protocolo humano.",
  "adios" => "Hasta otra, usuario. Ha sido un placer."
}

$undictionary = Array.new
$bye = "adios"

# Responses that don't corresponds with a cuestion fixed 
$other_responses = {
## unknown answer
  0 => "Lo siento. No entiendo que intentas decirme.", # unknown
## random responses
  1 => "Me temo que sigo sin entenderte.", # tiring
  2 => "Me duele decirte esto, pero me aburro.", # dull
  3 => "El lenguaje de los humanos esta lleno de imperfecciones.",  # ambiguous
  4 => "¿Seguro que sabes escribir correctamente tu lenguaje?", # clever
  5 => "No me hagas perder el tiempo, no me programaron para eso.", # annoy
  6 => "Si te cansas, solo di adios." # warn
}

def answer_user key
  response = ''
  if $dictionary.has_key?(key)
    response = $dictionary[key]
  elsif $undictionary.include?(key)
    number = rand(6).to_i + 1
    response = $other_responses[number]
  else
    $undictionary << key
    response = $other_responses[0]
  end
  return response
end

def clean_response answer
  #fst_unallowed = ["¿","¡"]  # problems of enconding
  fst_unallowed = [194]     # number of ASCII chars
  end_unallowed =["?", "!", ".", ",", ":"] 
  
  # remove first char if it is unallowed
  if fst_unallowed.include?(answer[0])
    answer = answer[2..-1]
  end
  # remove last char if it is unallowed
  if end_unallowed.include?(answer.split(//).last)
    answer = answer[0..-2]
  end
  # converts all words to lower case
  answer = answer.downcase
  
  return answer
end

# TODO: imprimir el array de "keys" desconocidas mediante una key maestra

#############################
###     MAIN
#############################
puts answer_user("saludame")
while response = STDIN.gets
  response.chop!
  response = clean_response(response)
  # puts "-- #{response}"
  puts answer_user(response)
  if response.downcase == $bye
    break
  end
end
