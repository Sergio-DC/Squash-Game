/**
 * La siguiente clase representa una cancha de squash
 **/
public class Field {
  private float padding_x = 75;
  private float padding_y_top = 20;
  private float ancho = width - (padding_x * 2);
  private float largo = height - (padding_y_top * 2);
  private float muroIzquierdo = padding_x;
  private float muroTop = padding_y_top;
  private float limiteCampoY = muroTop + (largo * 15/16);
  private Player player1;
  private Player player2;
  private Ball ball;
  private ObjectFiller fieldFiller;
  
  public Field(Player player1, Player player2, Ball ball) {
    this.player1 = player1;
    this.player2 = player2;
    this.ball = ball;
    //Le indica a la pelota hasta donde puede rebotar
    this.ball.definirLimites(muroIzquierdo,muroIzquierdo + ancho, muroTop);
    this.fieldFiller = new ObjectFiller(ColorName.GREEN);
  }

  public void dibujarCancha(){
    background(200);
    fill(150);
    rect(muroIzquierdo, muroTop, ancho, largo);//Base para la cancha de SQUASH
    pushMatrix();
    this.fieldFiller.fillIt();
    translate(15,15);
    scale(0.95);
    rect(muroIzquierdo, muroTop, ancho, largo); //Cancha de Squashs    
    dibujarDelimitaciones();
    this.ball.dibujarPelota();
    //Debe ir dentro de push/pop matrix para que no se salgo del campo
    player1.movePlayer(muroIzquierdo, ancho, largo);
    player2.movePlayer(muroIzquierdo, ancho, largo);
    this.ball.listenerCollisionPlayer(player1);
    this.ball.listenerCollisionPlayer(player2);
    this.ball.listenerCollisionWall();
    this.ball.listenerOutOfField(limiteCampoY);
    popMatrix();
    scoreBoard(muroIzquierdo,muroTop, ancho);
  }
  
  void scoreBoard(float origenX, float origenY, float ancho){
     float desfaseX = 20;
     float desfaseY = 50;
      
     textSize(32);
     player1.getPlayerFiller().fillIt();
     textAlign(RIGHT);
     text(player1.score, origenX - desfaseX, origenY + desfaseY);
     text("A", origenX - desfaseX, origenY + (desfaseY*2));
     
     player2.getPlayerFiller().fillIt();
     textAlign(LEFT);
     text(player2.score, origenX + ancho + desfaseX, origenY + desfaseY);
     text("B", origenX + ancho + desfaseX, origenY + (desfaseY*2));
  }
  private void dibujarDelimitaciones() {
    float punto_medio_y = ( muroTop + (muroTop + largo) ) / 2;
    float punto_medio_x = (muroIzquierdo + (muroIzquierdo + ancho) ) / 2;
    strokeWeight(10);
    //Linea Horizontal
    PVector v1_horizontal , v2_horizontal;
    v1_horizontal = new PVector(muroIzquierdo, punto_medio_y);
    v2_horizontal = new PVector(muroIzquierdo + ancho, punto_medio_y);
    strokeWeight(3);
    stroke(255,0,0);
    line(v1_horizontal.x, v1_horizontal.y, v2_horizontal.x, v2_horizontal.y);
    //Linea Vertical
    PVector v1_vertical , v2_vertical;
    v1_vertical = new PVector(punto_medio_x, punto_medio_y);
    v2_vertical = new PVector(punto_medio_x, punto_medio_y + (largo/2));
    line(v1_vertical.x, v1_vertical.y, v2_vertical.x, v2_vertical.y);
    //Rectangulos pequeños
    stroke(255,0,0);
    beginShape();
      vertex(v1_horizontal.x + 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho/4), v1_horizontal.y + (largo/6));
      vertex(v1_horizontal.x + 1, v1_horizontal.y + (largo/6));
    endShape();
    beginShape();
      vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y);
      vertex(v1_horizontal.x + (ancho * 3/4) - 1, v1_horizontal.y + (largo/6));
      vertex(v1_horizontal.x + (ancho) - 1, v1_horizontal.y + (largo/6));
    endShape();
    genDottedLine(muroIzquierdo, limiteCampoY, ancho * 3/4);
  }
  
  
  private void genDottedLine(float x, float y, float ancho) {
      int aux_x = (int)x;
      for(int i = 0 ; i<(aux_x + ancho + 40); i+=10){
        ellipse (aux_x + i,y,1,1);  
      } 
  }
  
}
