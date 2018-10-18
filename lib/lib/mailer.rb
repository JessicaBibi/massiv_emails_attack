require 'CSV'
require 'gmail'
require 'dotenv/load'

class EMails

    def send_emails (num)
    	hash = []
        CSV.foreach("./db/townhalls.csv"){ |balek| hash << balek }
        gmail = Gmail.connect!("thp.victime@gmail.com", "thpthpthp")
        i = 0
        while i <= num
            hash.each do |value|
        gmail.deliver do
            to value
            subject "Salut c'est nous qu'on en a marre"
        html_part do
            content_type 'text/html; charset=UTF-8'
            body 
"<p>Bonjour, Je m'appelle Jean-Eustache de Pessac , je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection autre que celle d'avoir un bon PC, pas comme moi, sans restriction géographique mais bon c'est quand même mieux dans les grandes villes pasque bon courage pour trouver cybercafé dans la Creuse. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code et s'arracher les cheveux. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous (sans abandonner mais c'est raté).</p>

<p>Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de votre commune veut changer le monde avec nous ?</p>

<p>Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80<p/>"
            end
            end
            puts "Email envoyé à #{value}"
            end
            i += 1
        end
        puts "Deconnexion"
        gmail.logout
        puts "Finish"
    end
end
