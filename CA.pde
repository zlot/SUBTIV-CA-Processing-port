class CA {
  
  private int pAmount;
  private int rNumber;
  private boolean behaviorRules[];
  private boolean behaviorPossible[];
  
  /***** CONSTRUCTOR *****/
  CA(int parameterAmount, int ruleNumber) {
    pAmount = parameterAmount;
    rNumber = ruleNumber;
    
    int am = round(pow(2.0, pAmount));
    // create two arrays of size 2^parameterAmount
    behaviorRules = new boolean[am];
    behaviorPossible = new boolean[am*3];
    generateCheckRules();
  }

  ////////////////////////////////////
  //      METHODS
  ////////////////////////////////////  
  
/*  
  boolean checkTheRules(boolean p1, boolean p2, int ruleNumber) {
    boolean params[] = {p1,p2};
    if(pAmount != 2) {
      pAmount = 2;
      generateCheckRules();
    }
    return checkTheRules(params, ruleNumber);
  }
  
  boolean checkTheRules(boolean p1, boolean p2, boolean p3, int ruleNumber) {
    if(pAmount != 3) {
      pAmount = 3;
      generateCheckRules();
    }
    boolean params[] = {p1,p2,p3};
    return checkTheRules(params, ruleNumber);
  }
  
  boolean checkTheRules(boolean p1, boolean p2, boolean p3, boolean p4, int ruleNumber) {
    if(pAmount != 4) {
      pAmount = 4;
      generateCheckRules();
    }
    boolean params[] = {p1,p2,p3,p4};
    return checkTheRules(params, ruleNumber);
  }
  boolean checkTheRules(boolean p1, boolean p2, boolean p3, boolean p4, boolean p5, int ruleNumber) {
    if(pAmount != 5) {
      pAmount = 5;
      generateCheckRules();
    }
    boolean params[] = {p1,p2,p3,p4,p5};
    return checkTheRules(params, ruleNumber);
  }
  boolean checkTheRules(boolean p1, boolean p2, boolean p3, boolean p4, boolean p5, boolean p6, int ruleNumber) {
    if(pAmount != 6) {
      pAmount = 6;
      generateCheckRules();
    }
    boolean params[] = {p1,p2,p3,p4,p5,p6};
    return checkTheRules(params, ruleNumber);
  }*/
  
  boolean checkTheRules(boolean[] params, int ruleNumber) { // dynamic rule checking system
    // checks to see if it needs to generate new rules.
    if(ruleNumber != -1 && ruleNumber != rNumber) {
      rNumber = ruleNumber;
      generateRules();
    }
    boolean checkers[] = new boolean[pAmount]; // messy and not very functional, other solution? (breaking)
    
    int ii = round(pow(2.0, pAmount));
    for(int i=0; i<ii; i++) {
      for(int j=0; j<pAmount; j++) {
        checkers[j] = false;
      }
      
      for(int j=0; j<pAmount; j++) {
        if(params[j] == behaviorPossible[j%pAmount + pAmount*i]) {
          checkers[j] = true;
        } else {
          checkers[j] = false;
        }
      }
      
      /* this checkB + for-loop seems useless? */
      boolean checkB = true;
      for(int j=0; j<pAmount; j++) {
        if(checkers[j] == true && checkB == true) {
          checkB = true;
        } else {
          checkB = false;
        }
      }
      /* END this checkB + for-loop seems useless */
      if(checkB == true) {
        return behaviorRules[i];
      }
    }
    return false; // added to please compiler, Never gets here.
  }
  
  
  
  
  ////////////////////////////////////
  //      GETTERS N SETTERS
  ////////////////////////////////////   
/*  
  void setRuleNumber(int ruleNumber) {
    if(ruleNumber != rNumber) {
      rNumber = ruleNumber;
      generateRules();
    }
  }
*/ 
/*  
  void setRuleNumberAnalog(boolean[] params) {
    int amountofrules = round(pow(2.0,(pow(2.0,pAmount))));
    
    for(int i=0; i<amountofrules; i++) {
      int j = round(pow(2, (float) pAmount) -1);
      println("j: "+j);
      float number = pow(2, pow(2, (float) pAmount) - i - 1);
      
      while(j>=0) {
        println("j: "+j);
        behaviorRules[(int)map(j, pow(2,(float) pAmount)-1, 0, 0, pow(2,(float) pAmount) - 1)] = calc(round(number), j);
        if(behaviorRules == params) {
          rNumber = i;
          // goto brokenOut. brokenOut: int hammertime;
        }
        j--;
      }
    }
  }
*/  
/*  
  int getRuleNumber() {
    return rNumber;
  }
*/
/*
  void setParameterAmount(int parameterAmount) {
    if(parameterAmount != pAmount) {
      pAmount = parameterAmount;
      generateCheckRules();
      generateRules();
    }
  }
*/
/*
  int getParameterAmount() {
    return pAmount;
  }
*/  
  
  ////////////////////////////////////
  //      PRIVATE METHODS
  ////////////////////////////////////   

  void generateRules(){ // generate a new ruleset
      if((pAmount>0) && (pAmount<10)) {
        int j = round(pow(2,(float) pAmount)-1);
        float number = pow(2, pow(2, (float) pAmount)) - rNumber-1;
          
        while(j>=0) {
          behaviorRules[(int)map(j, pow(2,(float) pAmount)-1, 0, 0, pow(2,(float) pAmount)-1)] = calc(round(number), j);
           // behaviorRules[j]=calc(round(number), j); // cool but wrong :)
          j--;
        }
        
      } else { 
        println("Generate Rules: Impossible to generate rules for " + pAmount + " parameters");
      }    
  }


  void generateCheckRules(){ // generate all the possible rule combinations
      if ((pAmount>0) && (pAmount<10)) {
        int counter = 0;
        float number = pow(2, (float) pAmount);
        for (int i = 0; i < number; i++) {
          for (int j=pAmount - 1; j>=0; j--,counter++) {
            behaviorPossible[counter]=calc(i, j);
          }   
        }
      } else {
        println("Generate Check Rules: Impossible to generate rules for " + pAmount + " parameters");
      }
  }
  
  
  boolean calc(int i, int _n){ // a simple utility for generating rulesets
      int n = round(pow(2.0, _n));
      switch (abs((1+i/n) % 2)) {
        case 0: return false;
        case 1: return true;
        default: return true;
      }    
  }
   
}
