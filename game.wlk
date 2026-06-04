
// podemos definir objetos...

object piedra {
    method image() = "piedra.jpg"
    method position() = game.at(7,4) 
    //method leGanaA(otra) = otra == tijera
}

object papel {
   method image() = "papel.jpg"
   method position() = game.at(8,4) 
   // method leGanaA(otra) = otra == piedra
}

object tijera {
   method image() = "tijera.jpg"
   method position() = game.at(9,4) 
   // method leGanaA(otra) = otra == papel
}

object humano{
	method image() = "humano.jpg"
    method position() = game.at(8,2) 
}

object computadora{
	method image() = "PC-compu.jpg"
	method position() = game.at(8,10) 
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