//+------------------------------------------------------------------+
//|                                                 GizliTepeDip.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   
   ObjectsDeleteAll();
   
   
   for ( int i=3000;i>5;i--) {
   
   


  //if ( High[i] < High[i-2] && Low[i-1] <= Low[i] && Low[i-1] <= Low[i-2] ){
   
   if ( Low[i] > Low[i-2] && //Low[i-1] <= Low[i] && 
   High[i-1] >= High[i-2] //&& MathAbs(Close[i]-Open[i])/Point >= 150 && MathAbs(Close[i-2]-Open[i-2])/Point >= 150 
      
      
   && Low[i] <= Low[i-1] && Low[i-2] <= Low[i-1]   
   
   ){

      
      double h_price=High[i-1];
      
      bool find=false;
      
      
      for (int t=i-3;t>i-10;t--) {
      
      if ( t < 1 ) continue;
      
      
      if ( Close[t] > h_price && find == false ) {
      
      
      ObjectCreate(ChartID(),"RDOWN"+i,OBJ_TREND,0,Time[i],Low[i],Time[i-2],Low[i-2]);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_COLOR,clrBlack);   
      ObjectSetInteger(ChartID(),"RDOWN"+i,OBJPROP_RAY,false);        
      
      
      ObjectCreate(ChartID(),"RDOWNH"+i,OBJ_TREND,0,Time[i],High[i-1],Time[i-1]+10*PeriodSeconds(),High[i-1]);  
      ObjectSetInteger(ChartID(),"RDOWNH"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RDOWNH"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RDOWNH"+i,OBJPROP_COLOR,clrBlack);   
      ObjectSetInteger(ChartID(),"RDOWNH"+i,OBJPROP_RAY,false);        
      
      ObjectCreate(ChartID(),t+"RDOWNH"+i,OBJ_TREND,0,Time[i-1],Close[t],Time[t]+10*PeriodSeconds(),Close[t]);  
      ObjectSetInteger(ChartID(),t+"RDOWNH"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),t+"RDOWNH"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),t+"RDOWNH"+i,OBJPROP_COLOR,clrBlue);   
      ObjectSetInteger(ChartID(),t+"RDOWNH"+i,OBJPROP_RAY,false);        
      
      
      find=true;
      
      }
      
      
      }
      
            
   
   
   }
   
   
      //continue;
   
   
   //if ( High[i] < High[i-2] && Low[i-1] <= Low[i] && Low[i-1] <= Low[i-2] ){
   
   if ( High[i] < High[i-2] && //Low[i-1] <= Low[i] && 
   Low[i-1] <= Low[i-2] //&& MathAbs(Close[i]-Open[i])/Point >= 150 && MathAbs(Close[i-2]-Open[i-2])/Point >= 150 
   
   && High[i] >= High[i-1] && High[i-2] >= High[i-1]
   
   ){

      
      double l_price=Low[i-1];
      
      bool find=false;
      
      
      for (int t=i-3;t>i-10;t--) {
      
      if ( t < 1 ) continue;
      
      
      if ( Close[t] < l_price && find == false ) {
      
      
      ObjectCreate(ChartID(),"RUP"+i,OBJ_TREND,0,Time[i],High[i],Time[i-2],High[i-2]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrBlack);   
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_RAY,false);        
      
      
      ObjectCreate(ChartID(),"RUPL"+i,OBJ_TREND,0,Time[i],Low[i-1],Time[i-1]+10*PeriodSeconds(),Low[i-1]);  
      ObjectSetInteger(ChartID(),"RUPL"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUPL"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUPL"+i,OBJPROP_COLOR,clrBlack);   
      ObjectSetInteger(ChartID(),"RUPL"+i,OBJPROP_RAY,false);        
      
      ObjectCreate(ChartID(),t+"RUPC"+i,OBJ_TREND,0,Time[i-1],Close[t],Time[t]+10*PeriodSeconds(),Close[t]);  
      ObjectSetInteger(ChartID(),t+"RUPC"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),t+"RUPC"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),t+"RUPC"+i,OBJPROP_COLOR,clrRed);   
      ObjectSetInteger(ChartID(),t+"RUPC"+i,OBJPROP_RAY,false);        
      
      
      find=true;
      
      }
      
      
      }
      
            
   
   
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
   
  }
//+------------------------------------------------------------------+
