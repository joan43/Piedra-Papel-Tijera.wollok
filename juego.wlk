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
  
  method position() = game.at(14, 10)

  method jugar() {
    // Hace la animación de selección y al final juega
    
    juego.animando(true)
    var contadorAnimacion = 0

    const animacion = game.tick(100, {
      juego.jugadaComputadora(
          [piedra, papel, tijera].anyOne()
      )
      
      contadorAnimacion += 1

      if (contadorAnimacion >= 35) {
          juego.animando(false)
          animacion.stop()

          juego.jugadaRandomDeComputadora()
          juego.jugar(
              juego.opcionSeleccionada()
          )
      }
    }, false)
    
    animacion.start()
  }
}

object btnreiniciar {
  method image() = "Re.png"
  
  method position() = game.at(1, 6)
} // cursor arriba de la opcion elegida

object cursor {
  method image() = "cursor_preview.png"
  
  method position() {
    return juego.opcionSeleccionada().position().down(1)
  }
} 

// cartel que muestra el resultado
object cartelResultado {
  method image() {
    return juego.resultado() + '.png'
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
  var property animando = false
  
  method moverIzquierda() {
    if (self.puedeSeleccionar() && seleccion > 0) {
      seleccion -= 1
    }
  }
  
  method moverDerecha() {
    if (self.puedeSeleccionar() && seleccion < 2) {
      seleccion += 1
    }
  }

  method puedeSeleccionar() = puedeJugar && !animando
  method estaTerminado() = !puedeJugar && !animando
  
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
      game.sound("empate.mp3").play()
    } else if (jugadaJugador.leGanaA(jugadaComputadora)) {
      resultado = "ganaste"
      game.sound("ganar.mp3").play()
    } else {
      resultado = "perdiste"
      game.sound("perder.mp3").play()
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