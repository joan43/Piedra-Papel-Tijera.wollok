import wollok.game.*

// podemos definir objetos...
object aclaracion {
  method image() = "aclaracion.png"
  
  method position() = game.at(0, 4)
}

object dude {
  method image() = "dude.png"
  
  method position() = game.at(14, 8)
}

object piedra {
  method image() = "piedra_preview.png"
  
  method position() = game.at(11, 3)
  
  // piedra le gana a tijera
  method leGanaA(otra) = otra == tijera
  
  method nombre() = "PIEDRA"
}

object papel {
  method image() = "papel_preview.png"
  
  method position() = game.at(14, 3)
  
  // papel le gana a piedra
  method leGanaA(otra) = otra == piedra
  
  method nombre() = "PAPEL"
}

object tijera {
  method image() = "tijera_preview.png"
  
  method position() = game.at(17, 3)
  
  // tijera le gana a papel
  method leGanaA(otra) = otra == papel
  
  method nombre() = "TIJERA"
}

object humano {
  method image() = "humano_preview.png"
  
  method position() = game.at(14, 1)
}

object computadora {
  method image() = "compu_preview.png"
  
  method position() = game.at(14, 10) // cre
}

object btnreiniciar {
  method image() = "Re.png"
  
  method position() = game.at(1, 6)
} // cursor arriba de la opcion elegida

object cursor {
  method image() = "cursor_preview.png"
  
  method position() {
    if (juego.seleccion() == 0) {
      return game.at(11, 2)
    }
    
    if (juego.seleccion() == 1) {
      return game.at(14, 2)
    }
    
    return game.at(17, 2)
  }
} // cartel que muestra el resultado

object cartelResultado {
  method image() {
    if (juego.resultado() == "ganaste") {
      return "ganaste.png"
    }
    
    if (juego.resultado() == "perdiste") {
      return "perdiste.png"
    }
    
    if (juego.resultado() == "empate") {
      return "empate.png"
    }
    
    return "ganaste.png"
  }
  
  method position() {
    if (juego.mostrarResultado()) {
      return game.at(13, 6)
    }
    
    // queda fuera de la pantalla hasta que se juegue
    return game.at(0, 20)
  }
}

object juego {
  const opciones = [piedra, papel, tijera]
  // 0 = piedra, 1 = papel, 2 = tijera
  var property seleccion = 1
  var property resultado = ""
  var property mostrarResultado = false
  var property jugadaComputadora = dude
  var property puedeJugar = true
  
  method moverIzquierda() {
    if (puedeJugar && (seleccion > 0)) {
      seleccion -= 1
    }
  }
  
  method moverDerecha() {
    if (puedeJugar && (seleccion < 2)) {
      seleccion += 1
    }
  }
  
  method opcionSeleccionada() = opciones.get(seleccion)
  
  method jugadaRandomDeComputadora() {
    jugadaComputadora = opciones.anyOne()
  }
  
  method jugar(jugadaJugador) {
    if (!puedeJugar) {
      aclaracion.error("No se puede jugar, debe reiniciar")
    }
    
    if (jugadaJugador == jugadaComputadora) {
      resultado = "empate"
    } else if (jugadaJugador.leGanaA(jugadaComputadora)) {
      resultado = "ganaste"
    } else {
      resultado = "perdiste"
    }

    puedeJugar = false
    mostrarResultado = true
  }
  
  // reinicia el tablero
  method reiniciar() {
    // console.println("ENTRO A REINICIAR")
    
    jugadaComputadora = dude
    mostrarResultado = false
    resultado = ""
    seleccion = 1 // vuelve a papel
    puedeJugar = true
  }
} 

/*
Muestra la jugada de la computadora
*/
object jugadaPc {
  method image() = juego.jugadaComputadora().image()
  method position() = game.at(14, 8)
}