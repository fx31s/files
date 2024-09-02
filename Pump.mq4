//+------------------------------------------------------------------+
//|                                                         Pump.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int min_pump=300;
datetime sell_time;
double sell_price=-1;

datetime buy_time;
double buy_price=-1;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);
   
   
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


if ( (High[2]-Low[2])/Point >= min_pump && Close[2] > Open[2] ) {

ObjectCreate(ChartID(),"V"+Time[2],OBJ_VLINE,0,Time[2],Ask);
ObjectCreate(ChartID(),"T"+Time[1],OBJ_TREND,0,Time[1],Low[1],Time[1]+50*PeriodSeconds(),Low[1]);
sell_time=Time[1];
sell_price=Low[1]-50*Point;
}
   

if ( sell_price!=-1 ) {

int sell_shift=iBarShift(Symbol(),Period(),sell_time);

if ( sell_shift <= 3 ) {

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);

if ( Ask < sell_price && OrdersTotal() == 0 && Close[1] < sell_price ) {

OrderSend(Symbol(),OP_SELL,0.01,Bid,0,Bid+200*Point,Bid-100*Point,"",0,0,clrNONE);
sell_price=-1;

}

}

}      
    
    

if ( (High[2]-Low[2])/Point >= min_pump && Close[2] < Open[2] ) {

ObjectCreate(ChartID(),"V"+Time[2],OBJ_VLINE,0,Time[2],Ask);
ObjectCreate(ChartID(),"T"+Time[1],OBJ_TREND,0,Time[1],High[1],Time[1]+50*PeriodSeconds(),High[1]);
buy_time=Time[1];
buy_price=High[1]+50*Point;
}
   

if ( buy_price!=-1 ) {

int buy_shift=iBarShift(Symbol(),Period(),buy_time);

if ( buy_shift <= 3 ) {

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);

if ( Bid > buy_price && OrdersTotal() == 0 && Close[1] > buy_price ) {

OrderSend(Symbol(),OP_BUY,0.01,Ask,0,Ask-200*Point,Ask+100*Point,"",0,0,clrNONE);
buy_price=-1;

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
