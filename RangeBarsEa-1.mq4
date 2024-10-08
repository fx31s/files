//+------------------------------------------------------------------+
//|                                                  RangeBarsEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//---
ENUM_TIMEFRAMES PERIOD_M3=3;
//---
extern double Step    =0.02;   //Parabolic setting
extern double Maximum =0.2;    //Parabolic setting
extern double    Lots=1;
extern int       Slip=5;
extern int     flag1=0;
string sym=Symbol();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   
   ObjectsDeleteAll(ChartID(),-1,OBJ_VLINE);
   ChartRedraw();
  
/*
RefreshRates();

double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);


Print(ma,"/",mal);
 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);

   */
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
/*
Print("Deneme");
RefreshRates();
double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);

 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);
*/
  
 
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
RefreshRates();
double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);
double mah=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_HIGH, 1);
double mao=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_OPEN, 1);




 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);
 Print("High:",iHigh(sym,PERIOD_CURRENT,1),"/",mah);
 Print("Open:",iOpen(sym,PERIOD_CURRENT,1),"/",mao);
  


double isar=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,1);


for ( int i=0;i<150;i++) {
double isar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+1);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);
double isar5=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+5);


//if ( isar5 < Close[i+5] && isar4 > Close[i+4] && isar3 > Close[i+3] && isar2 > Close[i+2] && isar1 > Close[i+1] ) {


if ( isar5 < Close[i+4] && isar1 > Close[i+1] && isar2 > Close[i+2] && isar3 > Close[i+3] && isar4 > Close[i+4] ) {
ObjectDelete(ChartID(),"VLINE"+i);
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i+1],isar1);
}


if ( isar5 > Close[i+4] && isar1 < Close[i+1] && isar2 < Close[i+2] && isar3 < Close[i+3] && isar4 < Close[i+4] ) {
ObjectDelete(ChartID(),"VLINE"+i);
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i+1],isar1);
}





}

   
double iao=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),1);
                               

ObjectDelete(ChartID(),"LAST");
ObjectCreate(ChartID(),"LAST",OBJ_TREND,0,Time[1],Close[1],Time[1]+50*PeriodSeconds(),Close[1]);
ObjectSetInteger(ChartID(),"LAST",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"LAST",OBJPROP_WIDTH,3);

ObjectDelete(ChartID(),"LASTO");
ObjectCreate(ChartID(),"LASTO",OBJ_TREND,0,Time[1],Open[1],Time[1]+50*PeriodSeconds(),Open[1]);
ObjectSetInteger(ChartID(),"LASTO",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),"LASTO",OBJPROP_WIDTH,3);



ObjectDelete(ChartID(),"LASTI");
ObjectCreate(ChartID(),"LASTI",OBJ_TREND,0,Time[1],isar,Time[1]+50*PeriodSeconds(),isar);
ObjectSetInteger(ChartID(),"LASTI",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"LASTI",OBJPROP_WIDTH,3);


ChartRedraw();
Print(isar,"/",iao);

//OnInit();


/*
    if ((iSAR(NULL, 0,Step,Maximum, 0)<iClose(NULL,0,0))&&(iSAR(NULL, 0,Step,Maximum, 1)>iOpen(NULL,0,1)))  //Signal Buy
 {

   int opensell=OrderSend(Symbol(),OP_SELL,Lots,Bid,Slip,NormalizeDouble(Bid+25*Point,Digits),NormalizeDouble(Bid-25*Point,Digits),"MY trader sell order",0,0,Green);
   flag1=1; 
 }
 
 if ((iSAR(NULL, 0,Step,Maximum, 0)>iClose(NULL,0,0))&&(iSAR(NULL, 0,Step,Maximum, 1)<iOpen(NULL,0,1)))  //Signal Sell
 {
 
   int openbuy=OrderSend(Symbol(),OP_BUY,Lots,Ask,Slip,NormalizeDouble(Ask-25*Point,Digits),NormalizeDouble(Ask+25*Point,Digits),"MY trader buy order",0,0,Blue);
   flag1=1;
 }
 
 */


   
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
