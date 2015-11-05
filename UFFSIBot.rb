require 'telegram/bot'
require 'nokogiri'
require 'open-uri'

token = '134789758:AAGf6KYr4B8SOzlsxl7OAOpnGwTZewB1s54'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/help'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: "vou te apresentar alguns comandos:")
      bot.api.send_message(chat_id: message.chat.id, text: "/help - mostra todos os comandos")
      bot.api.send_message(chat_id: message.chat.id, text: "/cardapio' - retorna o cardapio do bandeijão!")
    when '/email'
      bot.api.send_message(chat_id: message.chat.id, text: "Em breve retornaremos email dos profesores.")
    when '/feedback'
      bot.api.send_message(chat_id: message.chat.id, text: "Ainda estamos fazendo isso. :)")
    when '/cardapio'
      begin
        doc = Nokogiri::XML(open("http://www.restaurante.uff.br/cardapiomobile.xml"))
        bot.api.send_message(chat_id: message.chat.id, text: "Prato principal - #{doc.xpath("//node//Prato-principal").to_s.sub("<Prato-principal>","").sub("</Prato-principal>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Guarnição - #{doc.xpath("//node//Guarni-o").to_s.sub("<Guarni-o>","").sub("</Guarni-o>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Acompanhamento - #{doc.xpath("//node//Acompanhamentos").to_s.sub("<Acompanhamentos>","").sub("</Acompanhamentos>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Salada - #{doc.xpath("//node//Salada-1").to_s.sub("<Salada-1>","").sub("</Salada-1>","")} & #{doc.xpath("//node//Salada-2").to_s.sub("<Salada-2>","").sub("</Salada-2>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Sobremesa - #{doc.xpath("//node//Sobremesa").to_s.sub("<Sobremesa>","").sub("</Sobremesa>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Refresco - #{doc.xpath("//node//Refresco").to_s.sub("<Refresco>","").sub("</Refresco>","")}")
        bot.api.send_message(chat_id: message.chat.id, text: "Lembre que isso 'quase sempre' muda... :P")
      rescue
        bot.api.send_message(chat_id: message.chat.id, text: "Parece que tem algo errado. Não tem cardapio no site.")
        bot.api.send_message(chat_id: message.chat.id, text: "Fique com uma imagem pra alegrar seu dia!")
      end

    end
  end
end

#
# doc = Nokogiri::XML(open("http://www.restaurante.uff.br/cardapiomobile.xml"))
