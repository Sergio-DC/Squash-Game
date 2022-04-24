
public class GameState {
    private int PTS_MAX_TO_WIN = 4;
    private boolean finDelJuego;
    private boolean ganoJugadorA;
    private boolean volver_a_sacar;
    private boolean jugador_A_saca;
    private Player winner;
    private Field field;
    private Player player1, player2;
    private CRUD_File crud_file;
    private Dashboard dashboard;
    private Ball ball;
  
   public GameState() {
     this.finDelJuego = false;
     this.volver_a_sacar = false;
     this.jugador_A_saca = true;
     this.ganoJugadorA = false;
     crud_file = new CRUD_File();
     this.dashboard = new Dashboard();
     //Observers  
     PVector PLAYER1_POSITION = new PVector(width * .35,height/2 + 25);//Punto de Spawn del Player 1
     PVector PLAYER2_POSITION = new PVector(width * .60,height/2 + 25);//Punto de Spawn del Player 2
     player1 = new Player(PLAYER1_POSITION,"A", new ObjectFiller(ColorName.ORANGE), 0);
     player2 = new Player(PLAYER2_POSITION,"B",new ObjectFiller(ColorName.BLUE), 0);
   }
   
   public void configInitJuego() {
     leerArchivo();
     //Observable
     ball = new Ball(new PVector(width/2, height/2), 4, new ObjectFiller(ColorName.BLUE));
     
     //Colocamos los jugadores en la cancha
     field = new Field(player1, player2, ball);
     //Los jugadores se suscriben a los eventos emitidos por la pelota (Patron Observer)
     ball.addObserver(player1);
     ball.addObserver(player2);
     ball.estadoTurno = "A";//El primero en pegarle a la pelota será el jugador A
   }
   void correrJuego() {
       this.finDelJuego = false;
       field.dibujarCancha();
      if(volver_a_sacar) {//Respawn de la pelota
         delay(1000);
         ball.posicion.x = width/2;
         ball.posicion.y = height/2;
         ball.speedX = random(-1, 2) * 6;
         ball.speedY =  -6;
         volver_a_sacar = false;
         ball.estadoTurno = (jugador_A_saca) ?  "B" : "A";
      }
      println("score_1: " + player1.score + "   score_2: " + player2.score);
      if(this.player1.score > PTS_MAX_TO_WIN) {        
          this.finDelJuego = true;
          this.winner = player1;
          this.winner.partidasGanadas += 1;//Se incremena el numero de partidas ganadas de A
      }
      
      if(this.player2.score > PTS_MAX_TO_WIN) {
         this.finDelJuego = true;
         this.winner = player2;
         this.winner.partidasGanadas += 1;//Se incremena el numero de partidas ganadas de A
      }
        
   }
   
   public void dibujarMenu() {
      background(0);
      fill(14, 247, 191 );
      textSize(40);
      textAlign(CENTER);
      text("Juego de Squash",width/2,50);
      textSize(20);
      text("Jugador 1 se mueve con:",width/2,100);
      text("w: arriba",width/2,140);
      text("s: abajo",width/2,180);
      text("a: izquierda",width/2,220);
      text("d: derecha",width/2,260);
      text("Jugador 2 se mueve con:",width/2,300);
      text("i: arriba",width/2,340);
      text("k: abajo",width/2,380);
      text("j: izquierda",width/2,420);
      text("l: derecha",width/2,460);
      fill(255, 0, 0 );
      text("Presiona SPACE para iniciar",width/2, 500);
      text("Presiona 'p' para pausar",width/2,540);
      text("Presiona 'g' para ver partidas ganadas",width/2,580);
   }
   
   public void dibujarFinDeJuego() {
       background(0);
       fill(14, 247, 191 );
       textSize(30);
       textAlign(CENTER);
       text("El ganador es: " + this.winner.name,width/2,50);
       textAlign(CENTER);
       text("Presiona 'm' para volver al menu",width/2,100);
   }
   
   public void dibujarPausa() {
      background(#f5bf42);
      fill(0);
      textAlign(CENTER);
      textSize(40);
      text("Pausa", width/2, height/2 - 50);
      textSize(30);
      text("Presiona SPACE para continuar...", width/2, height/2);
      text("Presiona m para volver al menu...", width/2, height/2 + 50);
   }
   
   public void dibujarPartidasGanadas(){
     background(0);
     textSize(32);
     this.dashboard.pieChart(300, new Player[] {player1, player2});
     player1.getPlayerFiller().fillIt();
     ellipse(width/2 - 25, height - 150, 10, 10);

     text("A: " + this.player1.partidasGanadas, width/2 + 5, height - 145);
     player2.getPlayerFiller().fillIt();
     ellipse(width/2 - 25, height - 100, 10, 10);
      //textAlign(CENTER, TOP);
     text("B: " + this.player2.partidasGanadas, width/2 + 5, height - 95);
     fill(255);
     text("Presiona 'm' para volver", width/2, height - 50);
  }
  
  public void actualizarArchivo() {
      //println("player1.partidasGanadas: " + player1.partidasGanadas);
      //println("player2.partidasGanadas: " + player2.partidasGanadas);
     crud_file.updateFile(player1, player2); 
  }
  
  public void leerArchivo() {
     //La primera pos del array tiene el num de partidas ganadas del jugador B
     int [] partidas_ganadas = crud_file.readFile();
     player1.partidasGanadas = partidas_ganadas[1];
     player2.partidasGanadas = partidas_ganadas[0]; 
  }
   
   public void terminarJuego() {
      ball = null;
      player1.score = 0;
      player2.score = 0;
      field = null;
      this.finDelJuego = true;
   }
   
   public void guardarEstadisiticas() {
       crud_file.updateFile(this.player1, this.player2);
   }
}
  
