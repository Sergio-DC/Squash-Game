


public enum ColorName {
  ORANGE("orange"),
  GREEN("green"),
  BLUE("blue");
  
  private String colorName;
  
  ColorName(String colorName){
    this.colorName = colorName;
  }
  
  public String getColorNameValue() {
     return this.colorName; 
  }
  
}

public class ObjectFiller {
  private ColorName colorName;
  
  public ObjectFiller(ColorName colorName) {
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
         case GREEN:
           fill(0,255,0);
      }
  }
  
  public void setColorName(ColorName colorName) {
     this.colorName = colorName; 
  }
  
  public ColorName getColorName() {
      return this.colorName;
  }
   
}
