class Ave{
	method fuerza()
	method recibeDisgusto()
	method relajar()
	method conformeConIsla(isla)
	method tomarAlimento(isla)
}

class Aguilucho inherits Ave{
	var property velocidad = 20
	
	override method fuerza(){
		return if (velocidad<=60){180} else{velocidad*3}
	}
	override method recibeDisgusto() {velocidad= velocidad*2}
	override method relajar() { velocidad = velocidad-10}
	override method conformeConIsla(isla){
		return isla.alpiste() >=8
	}
	override method tomarAlimento(isla){
		isla.restarAlpiste(3)
		velocidad = velocidad+15
	}
}

class Albatro inherits Ave{
	var gramos = 4000
	var masaMus = 600
	
	override method fuerza(){
		return if (gramos<6000){masaMus} else{masaMus/2}
	}
	override method recibeDisgusto() {gramos= gramos+800}
	
	method irAlGim(){
		gramos=gramos+500
		masaMus= masaMus+500
	}
	override method relajar() {gramos = gramos-300}
	override method conformeConIsla(isla){
		return isla.avesConMasFuerza(self)<=2
	}
	override method tomarAlimento(isla){
		isla.restarMaiz(4)
		gramos=gramos+700
		masaMus= masaMus+700
	}
}

class Paloma inherits Ave{
	var ira = 200
	override method fuerza(){
		return 2* ira
	}
	override method recibeDisgusto() {ira = ira+300} 
	override method relajar() { ira = ira-50}
	override method conformeConIsla(isla){
		return isla.hayAveDebil()
	}
	method equilibrarse(){
		if(self.fuerza()<=700){
			self.recibeDisgusto()
		}
		else{self.relajar()}
	}
}

class PalomaMontera inherits Paloma{
	var property topeFuerza = 2000
	override method fuerza(){
		return if (super()>=topeFuerza){topeFuerza} else{super()}
	}
}

class PalomaManchada inherits Paloma{
	var property nidos = #{}
	
	override method recibeDisgusto() {
		super()
		nidos.add(new Nido())
	} 
	override method relajar() { 
		super()
		if(nidos.size()>=2){
			nidos.forEach({nido=> nido.aumentarGrosor()})
		}
	}
	method sumaNidosPot() = nidos.sum({ nid => nid.potencia()})
	method ira() = ira + self.sumaNidosPot()
}

class Nido{
	var property grosor =5
	var property resistencia =3
	method aumentarGrosor(){ grosor= grosor+1}
	method potencia() = grosor*resistencia +20
}

class AguiluchoColorado inherits Aguilucho{
	override method fuerza() = super() + 400
}

class PalomaTorcaza inherits Paloma{
	var huevos = 3
	override method fuerza() = super() + huevos*100 
	override method recibeDisgusto(){
		super()
		huevos= huevos+1
	}
}

class Isla{
	var property aves= #{}
	var property alpiste=10
	var property maiz=10
	
	method avesDebiles() = aves.filter({ave => ave.fuerza()<1000})
	method fuerzaTotal() = aves.sum({ave => ave.fuerza()})
	method esRobusta() = aves.all({ave => ave.fuerza()>300})
	method terremoto(){ aves.forEach({ave => ave.recibeDisgusto()})}
	method tormenta(){self.avesDebiles().forEach({ave => ave.recibeDisgusto()})}
	method aveCapitana() = self.avesEnRangoCapitan().max({ave => ave.fuerza()})
	method avesEnRangoCapitan() = aves.filter({ave => ave.fuerza().beetween(1000,3001)})
	method sesionRelax() {aves.forEach({ave => ave.relajar()})}
	method avesConMasFuerza(ave){
		return aves.filter({av => av.fuerza()> ave.fuerza()}).size()
	}
	method hayAveDebil() {
		return self.avesDebiles().size()>0
	}
	method estaEnPaz() = aves.all({ave=> ave.conformeConIsla(self)})
	method restarAlpiste(cant){ alpiste = alpiste-cant}
	method restarMaiz(cant){maiz = maiz-cant}
	method alimentar() {aves.forEach({ave => ave.tomarAlimento(self)})}
}

