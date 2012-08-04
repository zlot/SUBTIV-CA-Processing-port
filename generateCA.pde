void generateCA() {
  ////////////////////////////////////
  //      SETUP
  ////////////////////////////////////    
  final int AMOUNT_OF_PIXELS = width*height;
  int possibleRules[] = {30,90,182,73,77,41,47,45,165,78,85};
  int rule = possibleRules[round(random(possibleRules.length-1))];
  int widthCA = (width/2)+1;
  int heightCA = (height/2)+1;

  int spacer = 1;
  int pixelGrid[] = new int[AMOUNT_OF_PIXELS];
  
  int generation = -1;
  
  for(int i=0; i < AMOUNT_OF_PIXELS; i++) {
    pixelGrid[i] = 0;  
  }  
  pixelGrid[widthCA] = 1;
  
  CA simpleBehavior = new CA(3, round(random(255)));  
  
  ////////////////////////////////////
  //      UPDATE
  ////////////////////////////////////   
  
  while(generation <= heightCA-1) {
    generation++;
      for(int x=0; x<widthCA; x++) {
          PVector params = new PVector();
          if(generation == 0) {
            for(int i=0; i<AMOUNT_OF_PIXELS; i++) {
              pixelGrid[i] = 0;
            }
            int amountOfStarters = round(random(1,5));
            for(int i=0; i < amountOfStarters; i++) {
              pixelGrid[widthCA/amountOfStarters*i] = 1;
            }
          } else { // begin generations
            if(x == 0) {
              params.x = pixelGrid[(generation-1)*widthCA + x + widthCA - 1];
              params.y = pixelGrid[(generation-1)*widthCA + x];
              params.z = pixelGrid[(generation-1)*widthCA + x + 1];
            } else if(x == widthCA - 1) {
              params.x = pixelGrid[(generation-1)*widthCA + x - 1];
              params.y = pixelGrid[(generation-1)*widthCA + x];
              params.z = pixelGrid[(generation-1)*widthCA];
            } else {
              params.x = pixelGrid[(generation-1)*widthCA + x - 1];
              params.y = pixelGrid[(generation-1)*widthCA + x];
              params.z = pixelGrid[(generation-1)*widthCA + x + 1];
            }
            
          }
          boolean paramsToBool[] = new boolean[3];
          
          if (params.x == 0) {paramsToBool[0] = false;} else {paramsToBool[0] = true;}
          if (params.y == 0) {paramsToBool[1] = false;} else {paramsToBool[1] = true;}
          if (params.z == 0) {paramsToBool[2] = false;} else {paramsToBool[2] = true;}
          // returns 1 or 0 depending on the rules. These 0s and 1s get converted to black/white pixels onscreen.          
          pixelGrid[generation*widthCA+x] = simpleBehavior.checkTheRules(paramsToBool, rule) == true ? 1 : 0;
       // }
      }
    
  }
  
  
  ////////////////////////////////////
  //      DRAW
  ////////////////////////////////////   
  
  for(short y=0; y<heightCA; y++) {
    for(short x=0; x<widthCA; x++) {
      PVector v1 = new PVector(x*spacer,y*spacer);
      PVector v2 = new PVector(width/4,height/4);
//      vertices.add(v1.sub(v2));
//      vertices.add(v1);
      if(pixelGrid[y*widthCA + x] == 1) {
        fill(235);
      } else {
        fill(0);
      }
      rect(v1.x,v1.y,1,1);
      noFill();
    }
  }
  // get image of CA to manipulate
  PImage caRender = new PImage();
  caRender = get(0, 0, heightCA, widthCA+heightCA);
  
  pushMatrix();
  set(width/2,0,caRender);
  popMatrix();
  
  pushMatrix();
  set(0,height/2,caRender);
  popMatrix();
  
  pushMatrix();
  set(width/2,height/2,caRender);
  popMatrix();
  
//  pushMatrix();
//  translate(width/2, height);
//  rotate(PI);
//  //set(width/2,height/2,caRender);
//  image(caRender,0,0);
//  popMatrix();
//  
//  pushMatrix();
//  translate(width/4, height/4);
//  rotateX(180);
//  popMatrix();
//  
//  pushMatrix();
//  translate(width*0.75, height/4);
//  rotateX(180);
//  rotateY(180);
//  popMatrix();  
  
}
