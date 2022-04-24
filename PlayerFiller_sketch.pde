


public enum ColorName {
  ORANGE("orange"),
  BLUE("blue");
  
  private String colorName;
  
  ColorName(String colorName){
    this.colorName = colorName;
  }
  
  public String getColorNameValue() {
     return this.colorName; 
  }
  
}

public class PlayerFiller {
  private ColorName colorName;
  
  public PlayerFiller(ColorName colorName) {
     this.colorName = colorName; 
  }
  
  public void fillIt() {
      switch(colorName) {
         case ORANGE:
           fill(0,0,255);
           break;
         case BLUE:
           fill(254, 135, 66);
           break;
      }
  }
  
  public void setColorName(ColorName colorName) {
     this.colorName = colorName; 
  }
  
  public ColorName getColorName() {
      return this.colorName;
  }
   
}
