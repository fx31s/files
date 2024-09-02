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

extern int sl_pip=20;
extern int tp_pip=30;
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

RefreshRates();


int i=0;

double maa203=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+3);
double maa202=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+2);
double maa201=iMA(Symbol(), ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i+1);

double iaaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),i+1);

double isaar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+1);
double isaar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);    

double adx=iADX(Symbol(),ChartPeriod(ChartID()),14,PRICE_CLOSE,MODE_MAIN,i+1);


 int paar=SarStep(i+1);


if ( Open[i+3] > Close[i+3] && Close[i+2] > Open[i+2] && Close[i+1] > Open[i+1] 

     && Open[i+3] < maa203 && Close[i+3] < maa203
     
     && Close[i+1] > Close[i+2]
     
     && Close[i+1] > maa201
     
     && ((Open[i+2] < maa202 && Close[i+2] > maa202 )||(Open[i+1] < maa201 && Close[i+1] > maa201))
     
     && iaaos < 0
     
     && adx < 22
     
     && paar <= par_limit
     
     && isaar1 < Close[i+1]
     
     //&& isaar2 < Close[i+2]
     
     
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

     && Open[i+3] > maa203 && Close[i+3] > maa203
     
     && Close[i+1] < Close[i+2]
     
     && Close[i+1] < maa201
     
     && ((Open[i+2] > maa202 && Close[i+2] < maa202 )||(Open[i+1] > maa201 && Close[i+1] < maa201))
     
     && iaaos > 0
     
     && adx < 22
     
     && paar <= par_limit
     
     && isaar1 > Close[i+1]
     
     //&& isaar2 > Close[i+2]
     
     
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
