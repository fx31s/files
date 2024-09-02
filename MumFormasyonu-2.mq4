//+------------------------------------------------------------------+
//|                                                MumFormasyonu.mq4 |
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
   
   
   for (int i=1;i<Bars-500;i++) {
   
   //Print("Selam",i);
   
   //if ( Bars < i ) continue;
   

   
   
   
   /*
    if ( Open[i+1] > Close[i+1] &&  Low[i+1] < Low[i+2] && Low[i+1] < Low[i+3] && Close[i] > Close[i+1]
    ) {
   
   ObjectCreate(ChartID(),"RECUPsss"+i,OBJ_RECTANGLE,0,Time[i],Low[i+1],Time[i+2],Open[i]);
   ObjectSetInteger(ChartID(),"RECUPsss"+i,OBJPROP_COLOR,clrDarkRed);
   }
   */
   
/*
   if ( Open[i+1] < Close[i+1] &&  High[i+1] > High[i+2] && High[i+1] > High[i+3] && Close[i] < Close[i+1]
    ) {
   
   ObjectCreate(ChartID(),"RECUPssss"+i,OBJ_RECTANGLE,0,Time[i],High[i+1],Time[i+2],Open[i]);
   ObjectSetInteger(ChartID(),"RECUPssss"+i,OBJPROP_COLOR,clrDarkGreen);
   }
   */
   

   if ( Open[i+1] <= Close[i+1] &&  Low[i+1] <= Low[i+2] && Low[i+1] <= Low[i+3] //&& Close[i] < Close[i+1]
    ) {
   
   ObjectCreate(ChartID(),"RECUPssss"+i,OBJ_RECTANGLE,0,Time[i+1],Open[i+1],Time[i+3],Low[i+1]);
   ObjectSetInteger(ChartID(),"RECUPssss"+i,OBJPROP_COLOR,clrDarkGreen);
   }
   

   if ( Open[i+1] >= Close[i+1] &&  High[i+1] >= High[i+2] && High[i+1] >= High[i+3] //&& Close[i] < Close[i+1]
    ) {
   
   ObjectCreate(ChartID(),"RECUPsss"+i,OBJ_RECTANGLE,0,Time[i+1],Open[i+1],Time[i+3],High[i+1]);
   ObjectSetInteger(ChartID(),"RECUPsss"+i,OBJPROP_COLOR,clrDarkRed);
   }
   
   
      

   
   
   
   if ( Open[i+1] > Close[i+1] 
   && Close[i+2] > Open[i+2] && Close[i+3] > Open[i+3] && Close[i+4] > Open[i+4]  
   && High[i+1] > High[i+2] && High[i+1] > High[i+3] && Close[i] < Open[i+1] ) {
   
   ObjectCreate(ChartID(),"RECUP"+i,OBJ_RECTANGLE,0,Time[i+1],High[i+1],Time[i+7],Open[i+1]);
   ObjectSetInteger(ChartID(),"RECUP"+i,OBJPROP_COLOR,clrChartreuse);
   
   }
   


   if ( Close[i+1] > Open[i+1] 
   && Close[i+2] < Open[i+2] && Close[i+3] < Open[i+3] && Close[i+4] < Open[i+4] 
   &&  Low[i+1] < Low[i+2] && Low[i+1] < Low[i+3] && Close[i] > Open[i+1] 
   
   ) {
   
   ObjectCreate(ChartID(),"RECUPs"+i,OBJ_RECTANGLE,0,Time[i+1],Low[i+1],Time[i+7],Open[i+1]);
   ObjectSetInteger(ChartID(),"RECUPs"+i,OBJPROP_COLOR,clrCrimson);
   }   
      
      





   
         
      
    //continue;  
    
    

   if ( Close[i+2] < Open[i+2] && Low[i+3] <= Close[i+2] && Low[i+1] <= Close[i+2] &&
   Low[i+2] < Low[i+3] && Low[i+2] < Low[i+1] && Close[i+1] > Low[i+2] && Close[i+3] > Low[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl"+i,OBJ_RECTANGLE,0,Time[i+1],Close[i+2],Time[i+3],Low[i+2]);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrLightSlateGray);
   }


   if ( Close[i+2] > Open[i+2] && Low[i+3] <= Open[i+2] && Low[i+1] <= Open[i+2] &&
   Low[i+2] < Low[i+3] && Low[i+2] < Low[i+1] && Close[i+1] > Low[i+2] && Close[i+3] > Low[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl2"+i,OBJ_RECTANGLE,0,Time[i+1],Open[i+2],Time[i+3],Low[i+2]);
   ObjectSetInteger(ChartID(),"RECUPsl2"+i,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"RECUPsl2"+i,OBJPROP_COLOR,clrLightSlateGray);
   }
      


   if ( Close[i+2] > Open[i+2] &&  High[i+3] >= Close[i+2] && High[i+1] >= Close[i+2] &&
   High[i+2] > High[i+3] && High[i+2] > High[i+1] && Close[i+1] < High[i+2] && Close[i+3] < High[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl"+i,OBJ_RECTANGLE,0,Time[i+1],High[i+2],Time[i+3],Close[i+2]);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrPink);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrLightSlateGray);
   }

   if ( Close[i+2] < Open[i+2] &&  High[i+3] >= Open[i+2] && High[i+1] >= Open[i+2] &&
   High[i+2] > High[i+3] && High[i+2] > High[i+1] && Close[i+1] < High[i+2] && Close[i+3] < High[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl2"+i,OBJ_RECTANGLE,0,Time[i+1],Open[i+2],Time[i+3],High[i+2]);
   ObjectSetInteger(ChartID(),"RECUPsl2"+i,OBJPROP_COLOR,clrPink);
   ObjectSetInteger(ChartID(),"RECUPsl2"+i,OBJPROP_COLOR,clrLightSlateGray);
   }
          
   
   
       
   
/*
   if ( //Close[i+1] > Open[i+1] &&  
   Low[i+2] < Low[i+3] && Low[i+2] < Low[i+1] && Close[i+1] > Low[i+2] && Close[i+3] > Low[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl"+i,OBJ_RECTANGLE,0,Time[i+1],Low[i+2],Time[i+3],Low[i+3]);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrLimeGreen);
   }
   

   if ( //Close[i+1] > Open[i+1] &&  
   High[i+2] > High[i+3] && High[i+2] > High[i+1] && Close[i+1] < High[i+2] && Close[i+3] < High[i+2] ) {
   
   ObjectCreate(ChartID(),"RECUPsl"+i,OBJ_RECTANGLE,0,Time[i+1],High[i+2],Time[i+3],High[i+3]);
   ObjectSetInteger(ChartID(),"RECUPsl"+i,OBJPROP_COLOR,clrPink);
   }
  */
   
   


     
      
   
   
   }
   
   
   
   ChartRedraw();
   
   
   
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
