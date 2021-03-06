import java.util.Observable;
/**
 * La siguente clase representa la pelota que rebota en el campo de juego, esta actua como una
 * entidad observable que emite eventos hacia las entidades observadoras que serian los jugadores.
 * Los eventos se dan cuando la pelota colisiona con el jugador
 **/
class Ball extends Observable {
  private PVector posicion;
  private float diam;
  private boolean isUp;
  private float limiteIzq, limiteDer, limiteTop;
  private int velocidad;
  private ObjectFiller ballFiller;
  private float speedX, speedY;
  private String estadoTurno;//Nos indica que jugador puede pegarle a la pelota, dos valores posibles {"A", "B"}
  private boolean fueraDelCampo;//Indica si la bandera esta dentro(false) o fuera(true) del campo
  
  public Ball(PVector posicion, int velocidad, ObjectFiller objectFiller) {
     this.posicion = posicion;
     this.diam = 20;
     this.velocidad = velocidad;
     this.isUp = true;
     this.ballFiller = objectFiller;
     this.fueraDelCampo = false;
     speedX = -6;
     speedY =  6;
  }
  
  public void listenerCollisionPlayer(Player player) {
      strokeWeight(5);
        fill(0);
        ellipse(player.position.x, player.position.y, 10, 10);//Pto IZQ
        fill(255);
        ellipse(player.position.x + player.ancho, player.position.y, 10, 10);//Pto DER*/
     // Si la pelota golpea al jugador se invierte la direccion de esta
     if ( this.posicion.x > player.position.x && this.posicion.x < (player.position.x + player.ancho)
           && this.posicion.y > (player.position.y) && this.posicion.y < (player.position.y + player.alto)
           && player.name.equals(this.estadoTurno)) {
        isUp = true;
        if (player.name.equals("B")){
          speedX = speedX * random(-4, 4);
          speedY = speedY * -2;
          this.estadoTurno = "A";
          this.ballFiller.fillIt();
          if(!this.fueraDelCampo) {
            setChanged();
            notifyObservers(this);
          }
        } else {
          speedX = speedX * random(-4, 4);
          speedY = speedY * -2;
           this.estadoTurno = "B";
           this.ballFiller.fillIt();
           if(!this.fueraDelCampo) {
             setChanged();
             notifyObservers(this);
           }
        }
      }   
   }
   
   public void listenerCollisionWall() {
       //Listener del Muro Izquierdo
      if (this.posicion.x < limiteIzq){
        if(isUp) {
          speedX = 2;
          speedY = -random(1, this.velocidad);//Hacia Arriba
          this.posicion.x =  this.posicion.x + speedX;
        } else if (!isUp){
          speedX = 1 * random(1, this.velocidad);
          speedY = random(1, this.velocidad);//Hacia Abajo
          this.posicion.x += speedX; 
        }
      } else if (this.posicion.x > limiteDer) { //Listener del muro derecho   
        if(isUp) {
          speedX = -1 * random(1, this.velocidad);
          speedY = -1 * random(1, this.velocidad);//Hacia Arriba
          this.posicion.x += speedX;
        }else{
          speedX = -1 * random(1, this.velocidad);
          speedY = 1 * random(1, this.velocidad);//Hacia Abajo
          this.posicion.x += speedX;
        }
      }   
      // Si la pelota golpea el muro de enfrente la pelota cambia su direccion
      //en sentido Contrario
      if (this.posicion.y < limiteTop) {
        speedY = 1 * random(1, this.velocidad);  //Hacia Abajo
        this.posicion.y += speedY;
         isUp = false;
      }
   }
   /**
    * @param coordX representa el punto inicial en X donde se encuentra el limite del campo de juego
    * @param coordY representa el punto inicial en Y donde se encuentra el limite del campo de juego
    * @param ancho representa el ancho del campo juego
    */
   public void listenerOutOfField(float coordY) { 
       if(this.posicion.y > coordY && !this.fueraDelCampo) {  
            this.fueraDelCampo = true;
            setChanged();
            notifyObservers(this);
       }
   }
   
   public void dibujarPelota(){
      this.posicion.x = this.posicion.x + speedX;
      this.posicion.y = this.posicion.y + speedY;
      noStroke();
      this.ballFiller.fillIt();
      ellipse(this.posicion.x, this.posicion.y, diam, diam);
   }
   
   public void definirLimites(float limiteIzq, float limiteDer, float limiteTop) {
       this.limiteIzq = limiteIzq;
       this.limiteDer = limiteDer;
       this.limiteTop = limiteTop;
   }

}
