//+------------------------------------------------------------------+
//|                                                    SkyperSfp.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

datetime mnt;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
     /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
     
   
   ObjectsDeleteAll();
   
   for ( int i=Bars-100;i>1;i--) {
   
   int shift=i;
   bool find=false;
   double price=Low[i];
   int say=0;
   
   for(int r=i+1;r<i+50;r++) {
   
   if ( Low[i] < Low[r] && find==false) {
   say=say+1;
   //shift=r;
   } else {
   find=true;
   }
   
   
   }
   



   if ( say >= 20 && ((Open[i] < Close[i] && Close[i+1] < Open[i+1] && Close[i+2] < Open[i+2]) // 
   
   || (Close[i] < Open[i] && Close[i+1] < Open[i+1] && Open[i-1] < Close[i-1])  )) { // 
   
   
   


   if ( ( (Close[i] < Open[i] && Close[i+1] < Open[i+1] && Open[i-1] < Close[i-1]) && Low[shift] < Low[shift-1] && Low[shift] < Low[shift+1] )) { // Blue
   
   
   int shift=i;
   bool find=false;
   double price=Low[i];
   int say=0;
   int shifts=i;
   
   for(int r=i-1;r>0;r--) {
   
   if ( Low[i] < Low[r] && find==false) {
   say=say+1;
   shifts=r-1;
   //shift=r;
   } else {
   find=true;
   }
   
   }   
   
   if ( say >= 10 && find == true ) {
   /*
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[shift],Ask);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlack);   
   
   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),High[shift]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);  
   
   ObjectCreate(ChartID(),"HU"+i,OBJ_VLINE,0,Time[shifts],Ask);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_COLOR,clrBlack);

   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Low[shift]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);
   
   */
   //continue;

   //int shift=i;
   bool find=false;
   double price=Low[i];
   int say=0;
   //int shifts=i;
   int shiftc=shifts;
   
   for(int r=shifts-1;r>0;r--) {
   
   if ( High[i-1] > Close[r] && find==false) {
   say=say+1;
   shiftc=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   

//if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   

if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   
   
   int shiftu=i;
   double price=Low[i];
   for(int u=i;u>shiftc;u--) {
   
   if ( Low[u] < price ) {
   price=Low[u];
   shiftu=u;
   }
   
   
   }
   
   
   
   
 
   
   if ( i-shiftc < 100 ) {
   
   
   int pip=(Low[shiftu]-Low[shift])/Point;
   
   ObjectCreate(ChartID(),"LL"+i,OBJ_TREND,0,Time[shiftu],Low[shiftu],Time[shiftu]+1*0*PeriodSeconds(),Low[shiftu]);
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_COLOR,clrBlue);  
   ObjectSetString(ChartID(),"LL"+i,OBJPROP_TOOLTIP,pip); 
   
   
   ObjectCreate(ChartID(),"LL1"+i,OBJ_TREND,0,Time[i],Low[i],Time[shiftu],Low[shiftu]);
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_COLOR,clrBlue);  
 
   ObjectCreate(ChartID(),"LL2"+i,OBJ_TREND,0,Time[shiftu],Low[shiftu],Time[shiftc],High[shiftc]);
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_COLOR,clrYellow);  
      

   ObjectCreate(ChartID(),"LL3"+i,OBJ_TREND,0,Time[i-1],High[i-1],Time[shiftc],High[shiftc]);
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_COLOR,clrYellow);  
   
   
   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[i-1],High[i-1],Time[i-1]+100*PeriodSeconds(),High[i-1]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"LEQ"+i,OBJ_TREND,0,Time[i],Low[i-1]+DivZero((Close[i-1]-Low[i-1]),2),Time[i]+100*PeriodSeconds(),Low[i-1]+DivZero((Close[i-1]-Low[i-1]),2));
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_STYLE,STYLE_DOT);     
      
   
   } 
    

}   
   
       

//}   
      
   
   }
    
   
   
   }
   
   
   //continue;  
   
   

   if ( ((Open[i] < Close[i] && Close[i+1] < Open[i+1] && Close[i+2] < Open[i+2]) && Low[shift] < Low[shift-1] && Low[shift] < Low[shift+1]  )) { // Red
   
   

   int shift=i;
   bool find=false;
   double price=Low[i];
   int say=0;
   int shifts=i;
   
   for(int r=i-1;r>0;r--) {
   
   if ( Low[i] < Low[r] && find==false) {
   say=say+1;
   shifts=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   
   
   if ( say >= 10 && find == true ) {
   
   

/*
   ObjectCreate(ChartID(),"HU"+i,OBJ_VLINE,0,Time[shifts],Ask);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_COLOR,clrBlack);
   
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[shift+1],Ask);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlack);
   

   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),High[shift]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);
   
   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Low[shift]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);*/
   
   
   //int shift=i;
   bool find=false;
   double price=Low[i];
   int say=0;
   //int shifts=i;
   int shiftc=shifts;
   
   for(int r=shifts-1;r>0;r--) {
   
   if ( High[shift] > Close[r] && find==false) {
   say=say+1;
   shiftc=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   
   

if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   
   
   int shiftu=i;
   double price=Low[i];
   for(int u=i;u>shiftc;u--) {
   
   if ( Low[u] < price ) {
   price=Low[u];
   shiftu=u;
   }
   
   
   }
   
   int pip=(Low[shiftu]-Low[shift])/Point;
   

   
   
   if ( i-shiftc < 100 ) {
   
   /*
   ObjectCreate(ChartID(),"HH"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftu]+100*PeriodSeconds(),High[shiftu]);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_COLOR,clrBlue);  
   ObjectSetString(ChartID(),"HH"+i,OBJPROP_TOOLTIP,pip);     

   ObjectCreate(ChartID(),"HH1"+i,OBJ_TREND,0,Time[i],High[i],Time[shiftu],High[shiftu]);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_COLOR,clrBlue);  
 
   ObjectCreate(ChartID(),"HH2"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_COLOR,clrYellow);  
      

   ObjectCreate(ChartID(),"HH3"+i,OBJ_TREND,0,Time[i],Low[i],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_COLOR,clrYellow);  
   
   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[i],Low[i],Time[i]+100*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"LEQ"+i,OBJ_TREND,0,Time[i],Low[i]+DivZero((Close[i]-Low[i]),2),Time[i]+100*PeriodSeconds(),Low[i]+DivZero((Close[i]-Low[i]),2));
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_STYLE,STYLE_DOT); */  
   
   

   ObjectCreate(ChartID(),"LL"+i,OBJ_TREND,0,Time[shiftu],Low[shiftu],Time[shiftu]+1*0*PeriodSeconds(),Low[shiftu]);
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL"+i,OBJPROP_COLOR,clrBlue);  
   ObjectSetString(ChartID(),"LL"+i,OBJPROP_TOOLTIP,pip); 
   
   
   ObjectCreate(ChartID(),"LL1"+i,OBJ_TREND,0,Time[i],Low[i],Time[shiftu],Low[shiftu]);
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL1"+i,OBJPROP_COLOR,clrBlue);  
 
   ObjectCreate(ChartID(),"LL2"+i,OBJ_TREND,0,Time[shiftu],Low[shiftu],Time[shiftc],High[shiftc]);
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL2"+i,OBJPROP_COLOR,clrYellow);  
      

   ObjectCreate(ChartID(),"LL3"+i,OBJ_TREND,0,Time[i],High[i],Time[shiftc],High[shiftc]);
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"LL3"+i,OBJPROP_COLOR,clrYellow);  
   
   
   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[i],High[i],Time[i]+100*PeriodSeconds(),High[i]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"LEQ"+i,OBJ_TREND,0,Time[i],Low[i]+DivZero((Close[i]-Low[i]),2),Time[i]+100*PeriodSeconds(),Low[i]+DivZero((Close[i]-Low[i]),2));
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_STYLE,STYLE_DOT);       
   
   }
       

}   
   
   
      
   
   }
   
   }
      
   
   }
   
   
   
   //continue;
   

   

   shift=i;
   find=false;
   price=High[i];
   say=0;
   
   for(int r=i+1;r<i+50;r++) {
   
   if ( High[i] > High[r] && find==false) {
   say=say+1;
   //shift=r;
   } else {
   find=true;
   }
   
   
   }   
   
   if ( say >= 20 && ((Open[i] > Close[i] && Close[i+1] > Open[i+1] && Close[i+2] > Open[i+2]) || (Close[i] > Open[i] && Close[i+1] > Open[i+1] && Open[i-1] > Close[i-1])  )) {
   

   if ( ((Open[i] > Close[i] && Close[i+1] > Open[i+1] && Close[i+2] > Open[i+2]) && High[shift] > High[shift-1] && High[shift] > High[shift+1]  )) { // Red
   
   

   int shift=i;
   bool find=false;
   double price=High[i];
   int say=0;
   int shifts=i;
   
   for(int r=i-1;r>0;r--) {
   
   if ( High[i] > High[r] && find==false) {
   say=say+1;
   shifts=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   
   
   if ( say >= 10 && find == true ) {
   
   

/*
   ObjectCreate(ChartID(),"HU"+i,OBJ_VLINE,0,Time[shifts],Ask);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_COLOR,clrBlack);
   
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[shift+1],Ask);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlack);
   

   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),High[shift]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);
   
   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Low[shift]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);*/
   
   

   //int shift=i;
   bool find=false;
   double price=High[i];
   int say=0;
   //int shifts=i;
   int shiftc=shifts;
   
   for(int r=shifts-1;r>0;r--) {
   
   if ( Low[shift] < Close[r] && find==false) {
   say=say+1;
   shiftc=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   

if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   
   
   int shiftu=i;
   double price=High[i];
   for(int u=i;u>shiftc;u--) {
   
   if ( High[u] > price ) {
   price=High[u];
   shiftu=u;
   }
   
   
   }
   
   int pip=(High[shiftu]-High[shift])/Point;
   

   
   
   if ( i-shiftc < 100 ) {
   
   
   ObjectCreate(ChartID(),"HH"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftu]+100*PeriodSeconds(),High[shiftu]);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_COLOR,clrBlue);  
   ObjectSetString(ChartID(),"HH"+i,OBJPROP_TOOLTIP,pip);     

   ObjectCreate(ChartID(),"HH1"+i,OBJ_TREND,0,Time[i],High[i],Time[shiftu],High[shiftu]);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_COLOR,clrBlue);  
 
   ObjectCreate(ChartID(),"HH2"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_COLOR,clrYellow);  
      

   ObjectCreate(ChartID(),"HH3"+i,OBJ_TREND,0,Time[i],Low[i],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_COLOR,clrYellow);  
   
   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[i],Low[i],Time[i]+100*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"LEQ"+i,OBJ_TREND,0,Time[i],Low[i]+DivZero((Close[i]-Low[i]),2),Time[i]+100*PeriodSeconds(),Low[i]+DivZero((Close[i]-Low[i]),2));
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_STYLE,STYLE_DOT);   
   
   }
       

}   
   
   
   
   
   
   
      
      
      
   }
   
   
   }
   
   if ( ( (Close[i] > Open[i] && Close[i+1] > Open[i+1] && Open[i-1] > Close[i-1]) && High[shift] > High[shift-1] && High[shift] > High[shift+1] )) { // Blue
   
   
   int shift=i;
   bool find=false;
   double price=High[i];
   int say=0;
   int shifts=i;
   
   for(int r=i-1;r>0;r--) {
   
   if ( High[i] > High[r] && find==false) {
   say=say+1;
   shifts=r-1;
   //shift=r;
   } else {
   find=true;
   }
   
   }   
   
   if ( say >= 10 && find == true ) {
   /*
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[shift],Ask);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlack);   
   
   ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[shift],High[shift],Time[shift]+100*PeriodSeconds(),High[shift]);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);  
   
   ObjectCreate(ChartID(),"HU"+i,OBJ_VLINE,0,Time[shifts],Ask);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HU"+i,OBJPROP_COLOR,clrBlack);

   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[shift],Low[shift],Time[shift]+100*PeriodSeconds(),Low[shift]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);*/
   
   

   //int shift=i;
   bool find=false;
   double price=High[i];
   int say=0;
   //int shifts=i;
   int shiftc=shifts;
   
   for(int r=shifts-1;r>0;r--) {
   
   if ( Low[i-1] < Close[r] && find==false) {
   say=say+1;
   shiftc=r-1;
   //shift=r;
   } else {
   find=true;
   
   }
   
   }
   

//if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   

if ( find == true ) {
/*
   ObjectCreate(ChartID(),"HC"+i,OBJ_VLINE,0,Time[shiftc],Ask);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"HC"+i,OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"HCL"+i,OBJ_TREND,0,Time[shiftc],Close[shiftc],Time[shiftc]+100*PeriodSeconds(),Close[shiftc]);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HCL"+i,OBJPROP_RAY,False);  */
   
   
   int shiftu=i;
   double price=High[i];
   for(int u=i;u>shiftc;u--) {
   
   if ( High[u] > price ) {
   price=High[u];
   shiftu=u;
   }
   
   
   }
   
   
   
   
 
   
   if ( i-shiftc < 100 ) {
   
   
   int pip=(High[shiftu]-High[shift])/Point;
   
   ObjectCreate(ChartID(),"HH"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftu]+1*0*PeriodSeconds(),High[shiftu]);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH"+i,OBJPROP_COLOR,clrBlue);  
   ObjectSetString(ChartID(),"HH"+i,OBJPROP_TOOLTIP,pip); 
   
   
   ObjectCreate(ChartID(),"HH1"+i,OBJ_TREND,0,Time[i],High[i],Time[shiftu],High[shiftu]);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH1"+i,OBJPROP_COLOR,clrBlue);  
 
   ObjectCreate(ChartID(),"HH2"+i,OBJ_TREND,0,Time[shiftu],High[shiftu],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH2"+i,OBJPROP_COLOR,clrYellow);  
      

   ObjectCreate(ChartID(),"HH3"+i,OBJ_TREND,0,Time[i-1],Low[i-1],Time[shiftc],Low[shiftc]);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_RAY,False);  
   ObjectSetInteger(ChartID(),"HH3"+i,OBJPROP_COLOR,clrYellow);  
   
   
   ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[i-1],Low[i-1],Time[i-1]+100*PeriodSeconds(),Low[i-1]);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"LEQ"+i,OBJ_TREND,0,Time[i],Low[i-1]+DivZero((Close[i-1]-Low[i-1]),2),Time[i]+100*PeriodSeconds(),Low[i-1]+DivZero((Close[i-1]-Low[i-1]),2));
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_RAY,False);   
   ObjectSetInteger(ChartID(),"LEQ"+i,OBJPROP_STYLE,STYLE_DOT);     
      
   
   } 
    

}   
   
       

//}   
      
   
   }
    
   
   
   }
   
         
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[shift],Ask);
   //ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,True);
   
   
   }
   
   
      
   
   
   
   
   }
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   


if ( sparam == 17 ) {

if ( wick == true ) {wick=false;}else{wick=true;}

Comment("Wick:",wick);

//CreateSinyalButton();



}

   if(id==CHARTEVENT_CLICK && wick==true)
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


string last_select_object=sparam;



          datetime obj_time1 = dt;//ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         

          
          
          if ( Open[shift1] >= Close[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          

datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);



          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          

datetime levels=dt;//0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;//1;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);          
         
          }

         
         
         
         
         
         
        }
        
        }
           
  }
//+------------------------------------------------------------------+
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 


        
bool wick=false;        