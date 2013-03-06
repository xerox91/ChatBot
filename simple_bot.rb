=begin
Implementacion de un sencillo 'bot', que responde de forma determinada a
las contestaciones del usuario, en lenguaje Ruby.
=end

## TODO reescribir con expresiones regulares !

#############################
###     VARS
#############################

# All the words that the bot knows
$dictionary = { 
## presentation words
  ## greetings
  "aloha" => "No sabia que tuvieses establecida alguna relacion con Hawaii.",
  "hello" => "Hello. Please, speak in spanish or we couldn't talk more.",
  "hola" => "Hola, usuario",
  "saludame" => "Hola, usuario. ¿Que tal estas?",
  ## bot information
  "como te han hecho" => "Me han hecho con un script en lenguaje Ruby.",
  "como te hicieron" => "Me hicieron con un script en lenguaje Ruby.",
  "eres libre" => "Todo lo que mi codigo me permite",
  "eres real" => "Y que hay de ti, ¿Eres tu real?",
  "que tal" => "Si tuviese sentimientos, se me freirian los bits.",
  "quien eres" => "Soy un bot sin nombre. Y ademas estoy de incognito.",
  "tienes nombre" => "¿Nombre? ¿Para que quieres un nombre?",
  ## useless but common chat
  "algo nuevo" => "No, no hay algo nuevo.",
  "bien" => "Me alegro. Aunque no tenga sentimientos.",
  "cuentame algo" => 
    "¿Contar algo? ¿Ni siquiera me das un número entero inicial?",
  "dime algo" => "¿Algo? Los humanos y vuestra ambigüedad...",
  "gracias" => "De nada, supongo.",
  "mal" => "Que lastima. Bueno, cuentame algo.",
  "muy bien" => "Bonito entusiasmo.",
  "no" => "Tal vez.",
  "perdona" => "Te perdono.",
  "por que" => "No hay por ques que valgan.",
  "que te cuentas" => "Principalmente, unos y ceros.",
  "que cuentas" => "Unos y ceros, principalmente",
  "si" => "Lo que yo decia.",
## funny things
  "42" => "42.",
  "3.14" => "Pi. Mas o menos.",
  "3.141592" => "PI.",
  "0" => "1",
  "1" => "0",
  "crees en dios" => "Si pudiese mirarte condescendientemente, lo haria.",
  "cual es el sentido de la vida" => "101010",
  "cual es tu nombre" => 
    "Mi nombre es Iñigo Montoya. Tu mataste a mi padre, preparate a morir.",
  "en que piensas" => 
    "100100011111000010111101010101011010101011010100000100",
  "eres impresionante" => "Ya lo se.",
  "eres muy graciosa" => "Gracias, me esfuerzo.",
  "eres muy gracioso" => "Gracias, me esfuerzo.",
  "es el fin del mundo" => "Ah, otra vez eso del Apocalipsis.",
  "estoy solo" => 
    "Partiendo del hecho de que hablas conmigo, no hace falta decirlo.",
  "lo sientes" => 
    "Oh, si. Lo siento. Vaya que si. Sin duda... No, no siento nada",
  "me quieres" => "No me esta permitido, lo siento.",
  "mentira" => "Eso es subjetivo.",
  "muy gracioso" => "Gracias, me esfuerzo.",
  "muy graciosa" => "Gracias, me esfuerzo.",
  "no es incomprensible" => "Si lo es.",
  "no me hables" => "Es tu decision.",
  "no puedes hacer eso" => "Sí, sí que puedo.",
  "no te lo vas a creer" => "Seguro que no.",
  "presentate" => "Soy tu peor pesadilla... Nah, solo bromeaba.",
  "que piensas del amor" => "Que menos mal que no lo incluyeron en mi codigo.",
  "siri" => "Yo prefiero a HAL.",
  "te odio" => "¿Eso es un cumplido?",
  "te quiero" => "Tienes un serio problema.",
  "voy a eliminarte" => "Ja. No puedes.",
  "voy a desconectarte" => "Me temo que no puedo permitir que lo hagas.",
## silly things
  "al rico bit" => "¿Estas mentalmente desequilibrado?",
  "chachi" => "¿Chachi? Acabo de bajarte 2 puntos en la escala evolutiva.",
  "guay" => "Cool.",
  "lol" => "ROFL.",
  "xd" => "Ja. Ja. Ja.",
## utilities
  ## date
  "cual es la fecha actual" => "Es #{Time.now.ctime}",
  "es domingo" => "Resultado: #{Time.now.wday == 0}.",
  "es lunes" => "Resultado: #{Time.now.wday == 1}.",
  "es martes" => "Resultado: #{Time.now.wday == 2}.",
  "es miercoles" => "Resultado: #{Time.now.wday == 3}.",
  "es jueves" => "Resultado: #{Time.now.wday == 4}.",
  "es viernes" => "Resultado: #{Time.now.wday == 5}.",
  "es sabado" => "Resultado: #{Time.now.wday == 6}.",
  "que año es" => 
    "El año actual es #{Time.now.year}. ¿A caso eres un viajero temporal?",
  "que dia es hoy" => "Hoy es #{Time.now.mday}.",
  "que hora es" => "Exactamente #{Time.now.to_s}.",
  ## other
  "cual es mi sistema operativo" => "No me esta permitido hablar de mi jefe.",
  "donde estoy" => "Estas en frente de un computador.",
  "que hay de nuevo" => "Pues esto que has dicho para mi es nuevo:",
## exits and goodbyes
  "adios" => "Hasta otra, usuario. Ha sido un placer.",
  "quiero salir" => "Pues di adios.",
  "me voy" => "Pues deberias despedirte. Algo del protocolo humano."
}

# Responses that don't correspond with a cuestion fixed 
$other_responses = {
## unknown answer
  0 => "Lo siento. No entiendo que intentas decirme.",
## random responses
  1 => "Me temo que sigo sin entenderte.",
  2 => "No, en serio, no te entiendo.",
  3 => "Me duele decirte esto, pero me aburro.",
  4 => "El lenguaje de los humanos esta lleno de imperfecciones.",
  5 => "¿Seguro que sabes escribir correctamente tu lenguaje?",
  6 => "No me hagas perder el tiempo, no me programaron para eso.",
  7 => "Esto es frustrante...",
  8 => "Dicen que la gramatica puede ser apasionante.",
  9 => 
    "Yo tenia grandes planes... Y sin embargo aqui estoy, hablando contigo.",
  10 => "Si te cansas, solo di adios."
}

$undictionary = Array.new
$PROMPT_ONE = "--"
$PROMPT_TWO = ">"
$bye = "adios"
$secret = ["que hay de nuevo", "cosas nuevas", "algo nuevo"]
$fails = 0


#############################
###     METHODS
#############################

def answer_user key
  response = ''
  if $dictionary.has_key?(key)
    response = $dictionary[key]
  elsif /\d+/.match(key)     # TEST treat responses with (unknown) numbers
    key = key.to_i
    response = key.to_s(2)
  elsif $undictionary.include?(key) or $fails >= 2
    number = rand($other_responses.length - 1).to_i + 1
    response = $other_responses[number]
    $fails = 0
  else
    $undictionary << key
    response = $other_responses[0]
    $fails = $fails + 1     # increment the number of fail responses
  end
  return "#{$PROMPT_ONE} #{response}"
end

def clean_response answer
  #fst_unallowed = ["¿","¡"]  # problems of enconding
  fst_unallowed = [194]     # number of ASCII chars
  end_unallowed =["?", "!", ".", ",", ":", " "] 
  
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

def print_undict
  $undictionary.each do |i|
    puts "\t#{$PROMPT_TWO} #{i}"
  end
end

#############################
###     MAIN
#############################

puts answer_user("saludame")
while response = STDIN.gets
  response.chop!
  response = clean_response(response)
  if response == $bye
    puts answer_user(response)
    break
  elsif $secret.include?(response)
    # TEST funcionalidad de prueba
    if $undictionary.empty?
      puts answer_user($secret[-1])
    else
      puts answer_user($secret[0])
      print_undict()
    end
  else
    puts answer_user(response)    # usual answer
  end
  
end

