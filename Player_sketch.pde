import java.util.Collections;
import java.util.Observer;
/**
 * La siguiente clase representa a un jugador, 
 */
class Player implements Observer{
  private PVector position;
  private String name;
  private float ancho;
  private float alto;
  private int score;
  private float lastPosX, lastPosY;
  private int partidasGanadas;
  private ObjectFiller playerFiller;
  
  public Player(PVector position, String name, ObjectFiller objectFiller, int score) {
    this.position = position;
    this.name = name;
    this.ancho = width * 2/16;
    this.alto = 11;
    this.score = score;
    this.playerFiller = objectFiller;
  }
  
  public void movePlayer(float origenX, float ancho, float largo) {
   
     strokeWeight(5);
     point(origenX, 100);
     point(origenX + ancho , 100);
     if(this.position.x > (origenX - this.ancho) && this.position.x < origenX + ancho
     && this.position.y > (largo*.53) && this.position.y < largo){//Esta dentro de la cancha
       noStroke();
       this.playerFiller.fillIt();
       rect(this.position.x, this.position.y, this.ancho, 10);//draw the player
       this.position.x = this.position.x;
       this.position.y = this.position.y;
       lastPosX = this.position.x;
       lastPosY = this.position.y;
     } else {
       rect(lastPosX, lastPosY, this.ancho, this.alto);
     }
     //pelota.listenerCollisionPlayer(this);
  }
  
  @Override
  public void update(Observable o, Object val) {
     if(((Ball)val).fueraDelCampo && this.name.equals("B") && ((Ball)val).estadoTurno.equals("A")) {//Si era el turno de A pero fallo
         ((Ball)val).fueraDelCampo = false;             
         this.score += 1;//Se suma el punto a B
         //print("B gano un punto");
         juego.jugador_A_saca = false;
         juego.volver_a_sacar = true;
     } else if(((Ball)val).fueraDelCampo && this.name.equals("A") && ((Ball)val).estadoTurno.equals("B")) {//Si era el turno de B pero fallo  
           ((Ball)val).fueraDelCampo = false;                                     
           this.score += 1;//Se suma un punto a A
           //print("A gano un punto");
           juego.jugador_A_saca = true;
           juego.volver_a_sacar = true;
     }
  }
  
  public ObjectFiller getPlayerFiller() {
     return this.playerFiller; 
  }
}
