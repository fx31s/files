//+------------------------------------------------------------------+
//|                                                MumFormasyonu.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//extern int par_limit=10;
int par_limit=10;

ENUM_TIMEFRAMES PERIOD_M3=3;
//---
extern double Step    =0.02;   //Parabolic setting
extern double Maximum =0.2;    //Parabolic setting
extern double    Lots=1;
extern int       Slip=5;
extern int     flag1=0;
string sym=Symbol();

extern int sl_pip=150;
extern int tp_pip=300;
extern int magic=311;
extern double Lot=0.01;

double sell_time;
double buy_time;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int SarStep(int sbar) {

bool find=false;
int sar_shift=0;
bool sar_up=false;
bool sar_down=false;
int step=0;

//bool ma_updown=false;
double isar=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,sbar);
if ( Close[sbar] < isar ) sar_up=true; 
if ( Close[sbar] > isar ) sar_down=true;



for ( int ii=sbar;ii<sbar+50;ii++) {
//for ( int i=0;i<5;i++) {

double isar=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,ii);
//double isar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,ii+1);
//double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,ii+2);

//step=step+1;

//if ( ii < sbar ) {

if ( sar_up == true && Close[ii] < isar ) step=step+1; 
if ( sar_up == true && Close[ii] > isar ) return step; 


if ( sar_down == true && Close[ii] > isar ) step=step+1; 
if ( sar_down == true && Close[ii] < isar ) return step; 

//}


//if ( Close[ii+1] < isar1 && Close[ii+2] > isar2 && find == false ) {find=true;sar_shift=ii;sar_up=true;sar_down=false;return step;}

//if ( Close[ii+1] > isar1 && Close[ii+2] < isar2 && find == false ) {find=true;sar_shift=ii;sar_up=false;sar_down=true;return step;}

}

return step;

}




int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   
   EventSetTimer(1);

   ObjectsDeleteAll();
   
   
   ObjectCreate(ChartID(),"High",OBJ_TREND,0,0,0,0,0);
   ObjectCreate(ChartID(),"Low",OBJ_TREND,0,0,0,0,0);
   ObjectCreate(ChartID(),"Main",OBJ_TREND,0,0,0,0,0);
   ObjectCreate(ChartID(),"HtfMain",OBJ_TREND,0,0,0,0,0);
   ObjectCreate(ChartID(),"Ma50",OBJ_TREND,0,0,0,0,0);
   ObjectSetInteger(ChartID(),"Ma50",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"Ma50",OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"Ma20",OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),"Ma20",OBJPROP_WIDTH,2);   
   ObjectCreate(ChartID(),"Ma100",OBJ_TREND,0,0,0,0,0);
   ObjectSetInteger(ChartID(),"Ma100",OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"Ma100",OBJPROP_WIDTH,2);      

   
   
   
   return(INIT_SUCCEEDED);
   
   
   
   for (int i=1;i<Bars-500;i++) {
   
   //Print("Selam",i);
   
   //if ( Bars < i ) continue;
   

   if ( Close[i+5] > Open[i+5] && Close[i+4] > Open[i+4] && Close[i+3] > Open[i+3] && Open[i+2] > Close[i+2] && Close[i+1] > Open[i+1]
   
   && Close[i+5] < Close[i+4] && Close[i+4] < Close[i+3]
   
   && High[i+2] > High[i+3] && High[i+2] > High[i+4] && High[i+2] > High[i+1]
   
   && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+2) && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+3)
   
   && Close[i+2] > Close[i+5]

    ){
    
    int par=SarStep(i+2);
    

double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    


double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);


double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+5);

   
   if ( isar2 < Close[i+2] && isar3 < Close[i+3] && par <= par_limit
   
   && ( (Open[i+5] < ma205 && Close[i+5] > ma205) || (Open[i+4] < ma204 && Close[i+4] > ma204) || (Open[i+3] < ma203 && Close[i+3] > ma203) )
   
   && Close[i+1] > ma201
   
   && iaos < 0 
   
   ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   }
   
   
   }


   if ( Close[i+6] > Open[i+6] && Close[i+5] > Open[i+5] && Close[i+4] > Open[i+4] && Open[i+3] > Close[i+3] && Open[i+2] > Close[i+2] && Close[i+1] > Open[i+1]
   
   && Close[i+6] < Close[i+5] && Close[i+5] < Close[i+4]
   
   && ((High[i+3] > High[i+4] && High[i+3] > High[i+5] && High[i+3] > High[i+2]) || (High[i+2] > High[i+3] && High[i+2] > High[i+4] && High[i+2] > High[i+1]))
        
   && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+2) && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+3)
   
   && Close[i+3] > Close[i+6] && Close[i+2] > Close[i+6]

    ){
   
    int par=SarStep(i+3);
    
double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);           
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);   

double ma206=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+6);
double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
 
double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+6); 
   
   //if ( isar2 < Close[i+2] && isar3 < Close[i+3] && par <= par_limit
   if ( isar4 < Close[i+4] && isar3 < Close[i+3] && par <= par_limit
   
   && ( (Open[i+6] < ma206 && Close[i+6] > ma206) || (Open[i+5] < ma205 && Close[i+5] > ma205) || (Open[i+4] < ma204 && Close[i+4] > ma204) )
   
   && Close[i+1] > ma201   
   
   && iaos < 0
   
   ) {    
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,3);  
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   }
   
   }
      
      

   if ( Close[i+5] < Open[i+5] && Close[i+4] < Open[i+4] && Close[i+3] < Open[i+3] && Open[i+2] < Close[i+2] && Close[i+1] < Open[i+1]
   
   && Close[i+5] > Close[i+4] && Close[i+4] > Close[i+3]
   
   && Low[i+2] < Low[i+3] && Low[i+2] < Low[i+4] && Low[i+2] < Low[i+1]
   
   && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+2) && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+3)
   
   && Close[i+2] < Close[i+5]

    ){
   
    int par=SarStep(i+2);
    
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);  


double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);  

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+5);


   
   if ( isar2 > Close[i+2] && isar3 > Close[i+3] && par <= par_limit
   

   && ( (Open[i+5] > ma205 && Close[i+5] < ma205) || (Open[i+4] > ma204 && Close[i+4] < ma204) || (Open[i+3] > ma203 && Close[i+3] < ma203) )
   
   && Close[i+1] < ma201  
   
   && iaos > 0 
   
   
   ) {    
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   }
   
   }


   if ( Close[i+6] < Open[i+6] && Close[i+5] < Open[i+5] && Close[i+4] < Open[i+4] && Open[i+3] < Close[i+3] && Open[i+2] < Close[i+2] && Close[i+1] < Open[i+1]
   
   && Close[i+6] > Close[i+5] && Close[i+5] > Close[i+4]
   
   && ((Low[i+3] < Low[i+4] && Low[i+3] < Low[i+5] && Low[i+3] < Low[i+2]) || (Low[i+2] < Low[i+3] && Low[i+2] < Low[i+4] && Low[i+2] < Low[i+1]))
        
   && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+2) && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+3)
   
   && Close[i+3] < Close[i+6] && Close[i+2] < Close[i+6]

    ){
   
    int par=SarStep(i+3);
   

double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);       
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    

double ma206=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+6);
double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+6);
   
   //if ( isar2 > Close[i+2] && isar3 > Close[i+3] && par <= par_limit
   if ( isar4 > Close[i+4] && isar3 > Close[i+3] && par <= par_limit
   
   && ( (Open[i+6] > ma206 && Close[i+6] < ma206) || (Open[i+5] > ma205 && Close[i+5] < ma205) || (Open[i+4] > ma204 && Close[i+4] < ma204) )
   
   && Close[i+1] < ma201   
   
   && iaos > 0
   
   ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   
   }
    
   }
          
   
   
   
   continue;
   
   
   
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

if ( IsTesting() ) OnTimer();
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---


/////////////////////////////////////////////////////////////////////////////////////////////////////
int sell_total=0;
int buy_total=0;

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         sell_total=sell_total+1;
         }
         
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         buy_total=buy_total+1;
         }
                  
         
      }
   }
////////////////////////////////////////////////////////////////////////////////////////////////////   
   


RefreshRates();


int i=0;

   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,i+1);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,i+1);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,i+1);
    
   //double Band_HtfLow = iBands(Symbol(), ChartPeriod(ChartID()),50,2,0,PRICE_CLOSE, MODE_LOWER,i+1);
   //double Band_HtfHigh = iBands(Symbol(), ChartPeriod(ChartID()),50,2,0,PRICE_CLOSE, MODE_UPPER,i+1);
   double Band_HtfMain = iBands(Symbol(), ChartPeriod(ChartID()),50,2,0,PRICE_CLOSE, MODE_MAIN,i+1);
    
   double ma501=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, i+1); 
   double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_CLOSE, i+1);  
   double ma1001=iMA(Symbol(), ChartPeriod(ChartID()), 100, 0, MODE_SMA, PRICE_CLOSE, i+1); 
   
double iaaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+1);
double iaaos2=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+2);
double iaaos3=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+3);
double iaaos4=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+4);
double iaaos5=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+5);
double iaaos6=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+6);

double isaar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+1);
double isaar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    

int paaar=SarStep(i+1);

   ObjectMove(ChartID(),"High",0,Time[1],Band_High);
   ObjectMove(ChartID(),"High",1,Time[1]+100*PeriodSeconds(),Band_High);
 
   ObjectMove(ChartID(),"Low",0,Time[1],Band_Low);
   ObjectMove(ChartID(),"Low",1,Time[1]+100*PeriodSeconds(),Band_Low);
        
   ObjectMove(ChartID(),"Main",0,Time[1],Band_Main);
   ObjectMove(ChartID(),"Main",1,Time[1]+100*PeriodSeconds(),Band_Main);
    
   ObjectMove(ChartID(),"HtfMain",0,Time[1],Band_HtfMain);
   ObjectMove(ChartID(),"HtfMain",1,Time[1]+100*PeriodSeconds(),Band_HtfMain);
    
   ObjectMove(ChartID(),"Ma50",0,Time[1],ma501);
   ObjectMove(ChartID(),"Ma50",1,Time[1]+100*PeriodSeconds(),ma501);
           
   ObjectMove(ChartID(),"Ma20",0,Time[1],ma201);
   ObjectMove(ChartID(),"Ma20",1,Time[1]+100*PeriodSeconds(),ma201);
   
   ObjectMove(ChartID(),"Ma100",0,Time[1],ma1001);
   ObjectMove(ChartID(),"Ma100",1,Time[1]+100*PeriodSeconds(),ma1001);
   
   
   
   
   
   
   
   if ( Open[i+2] > Close[i+2] && Open[i+1] > Close[i+1] && 
   
   Open[i+1] >= ma201 && Close[i+1] < ma201 
   
   && ma501 <= Band_High && ma501 >= Band_Low
   
   && iaaos > 0
   
   && iaaos2 > 0
   
   && iaaos3 > 0
   
   && paaar >= 1 && paaar <= 2
   
   && isaar1 > Close[i+1]
   
   //&& isaar2 > Close[i+2]
   
   && Close[i+1] < Close[i+2]
   
   
   ) {
   
   //ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
   
   //return;
   

bool find=false;
bool low_find=false;
int low_shift=0;

for (int r=2;r<50;r++) {   

double ma20s=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_CLOSE, r); 
double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);

if ( Close[r] < ma20s ) find=true;

if ( find == false && low_find == false ) {
if ( High[r] > Band_High ) {low_find=true;
low_shift=r;
}
}

}

if ( low_find == true ) {
/*
ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);
*/
bool finds=false;

for (int t=low_shift+1;t<low_shift+50;t++) {   

double ma50s=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t); 
double ma51s=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t+1); 

if ( Close[t] < ma51s && Close[t] < Open[t] &&  Open[t] < ma50s && Close[t] > ma50s && finds == false) {


bool ma_upclose=false;

for(int x=t;x>low_shift;x--) {

if ( ma_upclose == false ) {
double ma50x=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, x);
if ( Close[x] < ma50x ) ma_upclose == true;
}

}

if ( ma_upclose == false && sell_time != Time[1] ) {

   double ma50t=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t);   
   double ma100t=iMA(Symbol(), ChartPeriod(ChartID()), 100, 0, MODE_SMA, PRICE_CLOSE, t);

if ( ma100t < ma50t ) {

ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VMa3"+Time[t],OBJ_VLINE,0,Time[t],Ask);
ObjectSetInteger(ChartID(),"VMa3"+Time[t],OBJPROP_COLOR,clrBlack);

double tp=Bid-(Open[i+2]-Close[i+1]);
double sl=High[i+2]+(sl_pip*Point);

if ( sell_total == 0 ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
sell_time=Time[1];
Alert("SELL ORDER");
}


}

}

finds=true;




}





if ( Close[t+1] < ma51s && Close[t] > ma50s && finds == false) {

bool ma_upclose=false;

for(int x=t;x>low_shift;x--) {

if ( ma_upclose == false ) {
double ma50x=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, x);
if ( Close[x] < ma50x ) ma_upclose == true;
}

}




if ( ma_upclose == false && sell_time != Time[1]) {


   double ma50t=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t);   
   double ma100t=iMA(Symbol(), ChartPeriod(ChartID()), 100, 0, MODE_SMA, PRICE_CLOSE, t);

if ( ma100t < ma50t ) {
ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VMa3"+Time[t],OBJ_VLINE,0,Time[t],Ask);
ObjectSetInteger(ChartID(),"VMa3"+Time[t],OBJPROP_COLOR,clrBlack);

double tp=Bid-(Open[i+2]-Close[i+1]);
double sl=High[i+2]+(sl_pip*Point);


if ( sell_total == 0 ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"SELL",magic,0,clrNONE);
sell_time=Time[1];
Alert("SELL ORDER");
}




}


}


finds=true;
}





}


}

   
   }   
   
   
   
   
   
   
   
   
   
   
   //return;
   
   
   if ( Close[i+2] > Open[i+2] && Close[i+1] > Open[i+1] && 
   
   Open[i+1] <= ma201 && Close[i+1] > ma201 
   
   && ma501 <= Band_High && ma501 >= Band_Low
   
   && iaaos < 0
   
   && iaaos2 < 0
   
   && iaaos3 < 0
   
   && paaar >= 1 && paaar <= 2
   
   && isaar1 < Close[i+1]
   
   //&& isaar2 < Close[i+2]
   
   && Close[i+1] > Close[i+2]
   
   
   ) {
   
   //ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);

bool find=false;
bool low_find=false;
int low_shift=0;

for (int r=2;r<50;r++) {   

double ma20s=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_CLOSE, r); 
double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);

if ( Close[r] > ma20s ) find=true;

if ( find == false && low_find == false ) {
if ( Low[r] < Band_Lows ) {low_find=true;
low_shift=r;
}
}

}

if ( low_find == true ) {
/*
ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);
*/
bool finds=false;

for (int t=low_shift+1;t<low_shift+50;t++) {   

double ma50s=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t); 
double ma51s=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t+1); 

if ( Close[t] > ma51s && Close[t] > Open[t] &&  Open[t] > ma50s && Close[t] < ma50s && finds == false) {


bool ma_upclose=false;

for(int x=t;x>low_shift;x--) {

if ( ma_upclose == false ) {
double ma50x=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, x);
if ( Close[x] > ma50x ) ma_upclose == true;
}

}

if ( ma_upclose == false && buy_time != Time[1] ) {

   double ma50t=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t);   
   double ma100t=iMA(Symbol(), ChartPeriod(ChartID()), 100, 0, MODE_SMA, PRICE_CLOSE, t);

if ( ma100t > ma50t ) {

ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VMa3"+Time[t],OBJ_VLINE,0,Time[t],Ask);
ObjectSetInteger(ChartID(),"VMa3"+Time[t],OBJPROP_COLOR,clrBlack);

double tp=Ask+(Close[i+1]-Open[i+2]);
double sl=Low[i+2]-(sl_pip*Point);

if ( buy_total == 0 ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
buy_time=Time[1];
Alert("BUY ORDER");
}


}

}

finds=true;




}





if ( Close[t+1] > ma51s && Close[t] < ma50s && finds == false) {

bool ma_upclose=false;

for(int x=t;x>low_shift;x--) {

if ( ma_upclose == false ) {
double ma50x=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, x);
if ( Close[x] > ma50x ) ma_upclose == true;
}

}




if ( ma_upclose == false && buy_time != Time[1]) {


   double ma50t=iMA(Symbol(), ChartPeriod(ChartID()), 50, 0, MODE_SMA, PRICE_CLOSE, t);   
   double ma100t=iMA(Symbol(), ChartPeriod(ChartID()), 100, 0, MODE_SMA, PRICE_CLOSE, t);

if ( ma100t > ma50t ) {
ObjectCreate(ChartID(),"VMa1"+Time[i+1],OBJ_VLINE,0,Time[i+1],Ask);
ObjectCreate(ChartID(),"VMa2"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
ObjectSetInteger(ChartID(),"VMa2"+Time[low_shift],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VMa3"+Time[t],OBJ_VLINE,0,Time[t],Ask);
ObjectSetInteger(ChartID(),"VMa3"+Time[t],OBJPROP_COLOR,clrBlack);

double tp=Ask+(Close[i+1]-Open[i+2]);
double sl=Low[i+2]-(sl_pip*Point);

if ( buy_total == 0 ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"BUY",magic,0,clrNONE);
buy_time=Time[1];
Alert("BUY ORDER");
}




}


}


finds=true;
}





}


}

   
   }   
   
   
   
   
   
   
   
   
   
            
        
    
    return;



double maa206=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+6);
double maa205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double maa204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double maa203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double maa202=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+2);
double maa201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+1);





double adx=iADX(Symbol(),ChartPeriod(ChartID()),14,PRICE_CLOSE,MODE_MAIN,i+1);


 int paar=SarStep(i+1);


if ( Open[i+3] > Close[i+3] && Close[i+2] > Open[i+2] && Close[i+1] > Open[i+1] 

     && High[i+1] > High[i+2] && High[i+1] > High[i+3]
     
     && Low[i+2] < Low[i+3] && Low[i+2] < Low[i+4]

///////////////////////////////////////////////////////////             

     ///&& Open[i+3] < maa203 && Close[i+3] < maa203
     
     ///&& Close[i+1] > Close[i+2]
     
     && Close[i+1] > maa201
     
     && ((Open[i+2] < maa202 && Close[i+2] > maa202 )||(Open[i+1] < maa201 && Close[i+1] > maa201))
     
////////////////////////////////////////////////////////////     
     
     && ( paar >= 3 && paar <= 6 ) 
     
///////////////////////////////////////////////////////////     
     
     && iaaos < 0
     
     && iaaos2 < 0 && iaaos3 < 0 && iaaos4 < 0 && iaaos5 < 0 && iaaos6 < 0
     
     
     && adx < 23
     
     ///&& paar <= par_limit
     
     && isaar1 < Close[i+1]
     
     //&& isaar2 < Close[i+2]
     
     ////////////////////////////////////////////////////////////////////
     
     && ( Close[i+6] > maa206 || Close[i+5] > maa205 || Close[i+4] > maa204 
     
     || ( Close[i+6] > Open[i+6] && Close[i+6] < maa206 && Open[i+6] < maa206 && High[i+6] >= maa206)
     
     || ( Close[i+5] > Open[i+5] && Close[i+5] < maa205 && Open[i+5] < maa205 && High[i+5] >= maa205)
     
     || ( Close[i+4] > Open[i+4] && Close[i+4] < maa204 && Open[i+4] < maa204 && High[i+4] >= maa204)
     
     || ( Close[i+6] < Open[i+6] && Close[i+6] < maa206 && Open[i+6] < maa206 && High[i+6] >= maa206)
     
     || ( Close[i+5] < Open[i+5] && Close[i+5] < maa205 && Open[i+5] < maa205 && High[i+5] >= maa205)
     
     || ( Close[i+4] < Open[i+4] && Close[i+4] < maa204 && Open[i+4] < maa204 && High[i+4] >= maa204)
     
     
     )
     
     ) {
     
   ObjectCreate(ChartID(),"V"+Time[1],OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+Time[1],OBJPROP_TOOLTIP,paar);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_BACK,true);
   

 //double sl=Low[1]-(sl_pip*Point);
 double sl=Ask-(sl_pip*Point);
 //double tp=Close[1]+(tp_pip*Point);
 double tp=Ask+(tp_pip*Point);
 if ( OrdersTotal() == 0 && buy_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);
 buy_time=Time[1];
 Alert("BUY ORDER");
 }
     
     
     }
     
     
     
if ( Open[i+3] < Close[i+3] && Close[i+2] < Open[i+2] && Close[i+1] < Open[i+1]

     && Low[i+1] < Low[i+2] && Low[i+1] < Low[i+3]
     
     && High[i+2] > High[i+3] && High[i+2] > High[i+4]
     
/////////////////////////////////////////////////////////     
 
     ///&& Open[i+3] > maa203 && Close[i+3] > maa203
     
     ///&& Close[i+1] < Close[i+2]
     
     && Close[i+1] < maa201
     
     && ((Open[i+2] > maa202 && Close[i+2] < maa202 )||(Open[i+1] > maa201 && Close[i+1] < maa201))
     
//////////////////////////////////////////////////////////////////////////////////////////////////////

      && ( paar >= 3 && paar <= 6 ) 

//////////////////////////////////////////////////////////////////////////////////////////////////////
     
     && iaaos > 0
     
     && iaaos2 > 0 && iaaos3 > 0 && iaaos4 > 0 && iaaos5 > 0 && iaaos6 > 0
        
     && adx < 23
     
     ///&& paar <= par_limit
     
     && isaar1 > Close[i+1]
     
     //&& isaar2 > Close[i+2]

     ////////////////////////////////////////////////////////////////////
     
     && ( Close[i+6] < maa206 || Close[i+5] < maa205 || Close[i+4] < maa204 
     
     || ( Close[i+6] < Open[i+6] && Close[i+6] > maa206 && Open[i+6] > maa206 && Low[i+6] <= maa206)
     
     || ( Close[i+5] < Open[i+5] && Close[i+5] > maa205 && Open[i+5] > maa205 && Low[i+5] <= maa205)
     
     || ( Close[i+4] < Open[i+4] && Close[i+4] > maa204 && Open[i+4] > maa204 && Low[i+4] <= maa204)
     
     || ( Close[i+6] > Open[i+6] && Close[i+6] > maa206 && Open[i+6] > maa206 && Low[i+6] <= maa206)
     
     || ( Close[i+5] > Open[i+5] && Close[i+5] > maa205 && Open[i+5] > maa205 && Low[i+5] <= maa205)
     
     || ( Close[i+4] > Open[i+4] && Close[i+4] > maa204 && Open[i+4] > maa204 && Low[i+4] <= maa204)
     
     )
          
     
     ) {
     
     
   ObjectCreate(ChartID(),"V"+Time[1],OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+Time[1],OBJPROP_TOOLTIP,paar);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_BACK,true);
   
  //double sl=High[1]+(sl_pip*Point);
  double sl=Bid+(sl_pip*Point);
 //double tp=Close[1]-(tp_pip*Point);
 double tp=Bid-(tp_pip*Point);
 
 if ( OrdersTotal() == 0 && sell_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"",magic,0,clrNONE);
 sell_time=Time[1];
 Alert("SELL ORDER");
 }
 
 
     
     
     }     
     

return;

if ( Close[i+5] > Open[i+5] && Close[i+4] > Open[i+4] && Close[i+3] > Open[i+3] && Open[i+2] > Close[i+2] && Close[i+1] > Open[i+1]
   
   && Close[i+5] < Close[i+4] && Close[i+4] < Close[i+3]
   
   && High[i+2] > High[i+3] && High[i+2] > High[i+4] && High[i+2] > High[i+1]
   
   && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+2) && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+3)
   
   && Close[i+2] > Close[i+5]

    ){
    
    int par=SarStep(i+2);
    

double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    


double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);


double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+5);

   
   if ( isar2 < Close[i+2] && isar3 < Close[i+3] && par <= par_limit
   
   && ( (Open[i+5] < ma205 && Close[i+5] > ma205) || (Open[i+4] < ma204 && Close[i+4] > ma204) || (Open[i+3] < ma203 && Close[i+3] > ma203) )
   
   && Close[i+1] > ma201
   
   && iaos < 0 
   
   ) {
   
   ObjectCreate(ChartID(),"V"+Time[1],OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+Time[1],OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+Time[1],OBJPROP_BACK,true);
   

 //double sl=Low[1]-(sl_pip*Point);
 double sl=Ask-(sl_pip*Point);
 //double tp=Close[1]+(tp_pip*Point);
 double tp=Ask+(tp_pip*Point);
 if ( OrdersTotal() == 0 && buy_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);
 buy_time=Time[1];
 Alert("BUY ORDER");
 }
    
   }
   
   
   }


   if ( Close[i+6] > Open[i+6] && Close[i+5] > Open[i+5] && Close[i+4] > Open[i+4] && Open[i+3] > Close[i+3] && Open[i+2] > Close[i+2] && Close[i+1] > Open[i+1]
   
   && Close[i+6] < Close[i+5] && Close[i+5] < Close[i+4]
   
   && ((High[i+3] > High[i+4] && High[i+3] > High[i+5] && High[i+3] > High[i+2]) || (High[i+2] > High[i+3] && High[i+2] > High[i+4] && High[i+2] > High[i+1]))
        
   && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+2) && iLow(Symbol(),Period(),i+1) < iLow(Symbol(),Period(),i+3)
   
   && Close[i+3] > Close[i+6] && Close[i+2] > Close[i+6]

    ){
   
    int par=SarStep(i+3);
    
double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);           
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);   

double ma206=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+6);
double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
 
double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+6); 
   
   //if ( isar2 < Close[i+2] && isar3 < Close[i+3] && par <= par_limit
   if ( isar4 < Close[i+4] && isar3 < Close[i+3] && par <= par_limit
   
   && ( (Open[i+6] < ma206 && Close[i+6] > ma206) || (Open[i+5] < ma205 && Close[i+5] > ma205) || (Open[i+4] < ma204 && Close[i+4] > ma204) )
   
   && Close[i+1] > ma201   
   
   && iaos < 0
   
   ) {    
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,3);  
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   
 //double sl=Low[1]-(sl_pip*Point);
 double sl=Ask-(sl_pip*Point);
 //double tp=Close[1]+(tp_pip*Point);
 double tp=Ask+(tp_pip*Point);
 if ( OrdersTotal() == 0 && buy_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);
 buy_time=Time[1];
 Alert("BUY ORDER");
 }
   
   }
   
   }
      
      

   if ( Close[i+5] < Open[i+5] && Close[i+4] < Open[i+4] && Close[i+3] < Open[i+3] && Open[i+2] < Close[i+2] && Close[i+1] < Open[i+1]
   
   && Close[i+5] > Close[i+4] && Close[i+4] > Close[i+3]
   
   && Low[i+2] < Low[i+3] && Low[i+2] < Low[i+4] && Low[i+2] < Low[i+1]
   
   && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+2) && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+3)
   
   && Close[i+2] < Close[i+5]

    ){
   
    int par=SarStep(i+2);
    
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);  


double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);  

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+5);


   
   if ( isar2 > Close[i+2] && isar3 > Close[i+3] && par <= par_limit
   

   && ( (Open[i+5] > ma205 && Close[i+5] < ma205) || (Open[i+4] > ma204 && Close[i+4] < ma204) || (Open[i+3] > ma203 && Close[i+3] < ma203) )
   
   && Close[i+1] < ma201  
   
   && iaos > 0 
   
   
   ) {    
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   
  //double sl=High[1]+(sl_pip*Point);
  double sl=Bid+(sl_pip*Point);
 //double tp=Close[1]-(tp_pip*Point);
 double tp=Bid-(tp_pip*Point);
 
 if ( OrdersTotal() == 0 && sell_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"",magic,0,clrNONE);
 sell_time=Time[1];
 Alert("SELL ORDER");
 }
 
    
   }
   
   }


   if ( Close[i+6] < Open[i+6] && Close[i+5] < Open[i+5] && Close[i+4] < Open[i+4] && Open[i+3] < Close[i+3] && Open[i+2] < Close[i+2] && Close[i+1] < Open[i+1]
   
   && Close[i+6] > Close[i+5] && Close[i+5] > Close[i+4]
   
   && ((Low[i+3] < Low[i+4] && Low[i+3] < Low[i+5] && Low[i+3] < Low[i+2]) || (Low[i+2] < Low[i+3] && Low[i+2] < Low[i+4] && Low[i+2] < Low[i+1]))
        
   && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+2) && iHigh(Symbol(),Period(),i+1) > iHigh(Symbol(),Period(),i+3)
   
   && Close[i+3] < Close[i+6] && Close[i+2] < Close[i+6]

    ){
   
    int par=SarStep(i+3);
   

double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);       
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    

double ma206=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+6);
double ma205=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+5);
double ma204=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+4);
double ma201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+6);
   
   //if ( isar2 > Close[i+2] && isar3 > Close[i+3] && par <= par_limit
   if ( isar4 > Close[i+4] && isar3 > Close[i+3] && par <= par_limit
   
   && ( (Open[i+6] > ma206 && Close[i+6] < ma206) || (Open[i+5] > ma205 && Close[i+5] < ma205) || (Open[i+4] > ma204 && Close[i+4] < ma204) )
   
   && Close[i+1] < ma201   
   
   && iaos > 0
   
   ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetString(ChartID(),"V"+i,OBJPROP_TOOLTIP,par);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_BACK,true);
   

  //double sl=High[1]+(sl_pip*Point);
  double sl=Bid+(sl_pip*Point);
 //double tp=Close[1]-(tp_pip*Point);
 double tp=Bid-(tp_pip*Point);
 
 if ( OrdersTotal() == 0 && sell_time!=Time[1] ) {int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"",magic,0,clrNONE);
 sell_time=Time[1];
 Alert("SELL ORDER");
 } 
   
   }
    
   }
          
   
   
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
