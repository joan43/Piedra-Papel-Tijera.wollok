import wollok.game.*
// podemos definir objetos...



object piedra {
    method image() = "piedra_preview.png"
    method position() = game.at(11,3) 
    //method leGanaA(otra) = otra == tijera
}

object papel {
   method image() = "papel_preview.png"
   method position() = game.at(14,3) 
   // method leGanaA(otra) = otra == piedra
}

object tijera {
   method image() = "tijera_preview.png"
   method position() = game.at(17,3) 
   // method leGanaA(otra) = otra == papel
}

object humano{
	method image() = "humano_preview.png"
    method position() = game.at(14,1) 
}

object computadora{
	method image() = "compu_preview.png"
	method position() = game.at(13,10) 
}


object juego {

    const opciones = [piedra, papel, tijera]

    method jugar(jugadaJugador) {
        const compu = opciones.anyOne()

        if (jugadaJugador == compu) {
            return " Empate "
        }

        if (jugadaJugador.leGanaA(compu)) {
            return " Ganaste "
        }

        return " Perdiste "
    }
}