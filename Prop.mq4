//+------------------------------------------------------------------+
//|                                                         Prop.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int sl=150;
int distance=20;
double buy_price=-1;
double sl_price=-1;

int magic=333;
double Lot=0.60;

string cmt="";
int buy_ticket;
int sell_ticket;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
  // EventSetTimer(60);
   
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

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 15:00";
  datetime some_time = StringToTime(yenitarih);
 
  string yenitarihs= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 15:14";
  datetime some_times = StringToTime(yenitarih);
  
  

int shift=iBarShift(Symbol(),PERIOD_M1,some_time);
int shifts=iBarShift(Symbol(),PERIOD_M1,some_times);


  string yenitarih2= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 16:45";
  datetime some_time2 = StringToTime(yenitarih);
 
  string yenitarihs2= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 16:59";
  datetime some_times2 = StringToTime(yenitarih);
  
  

int shift2=iBarShift(Symbol(),PERIOD_M1,some_time2);
int shifts2=iBarShift(Symbol(),PERIOD_M1,some_times2);


  string yenitarih3= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 20:45";
  datetime some_time3 = StringToTime(yenitarih);
 
  string yenitarihs3= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 20:59";
  datetime some_times3 = StringToTime(yenitarih);
  
  

int shift3=iBarShift(Symbol(),PERIOD_M1,some_time3);
int shifts3=iBarShift(Symbol(),PERIOD_M1,some_times3);





if ( iOpen(Symbol(),PERIOD_M1,shift) >  iClose(Symbol(),PERIOD_M1,shifts) && (int(TimeHour(TimeCurrent())) == 15 && (int(TimeMinute(TimeCurrent())) >= 15 || int(TimeMinute(TimeCurrent())) <= 30) ) 



|| 
( iOpen(Symbol(),PERIOD_M1,shift2) <  iClose(Symbol(),PERIOD_M1,shifts2) &&  int(TimeHour(TimeCurrent())) == 17 && (int(TimeMinute(TimeCurrent())) == 0 || int(TimeMinute(TimeCurrent())) <= 30) )

|| 
(iOpen(Symbol(),PERIOD_M1,shift3) <  iClose(Symbol(),PERIOD_M1,shifts3) && int(TimeHour(TimeCurrent())) == 21 && (int(TimeMinute(TimeCurrent())) == 0 || int(TimeMinute(TimeCurrent())) <= 30))



 ) {

ObjectCreate(ChartID(),"V"+Time[0],OBJ_VLINE,0,Time[0],Ask);


if ( buy_price == -1 ) {
buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,Lot,Ask+distance*Point,0,Bid-sl*Point,0,cmt,magic,0,clrNONE);
buy_price=Ask+distance*Point;
sl_price=Bid-sl*Point;
}


if ( buy_price != -1 && Ask >= buy_price ) {
buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,Lot,Ask+distance*Point,0,sl_price,0,cmt,magic,0,clrNONE);
buy_price=Ask+distance*Point;
//Bid-sl*Point
}


}

if ( OrdersTotal() == 1 && AccountMargin() == 0 ) {
if ( Bid < sl_price ) {
OrderDelete(buy_ticket,clrNONE);
buy_price=-1;
}
}

if ( OrdersTotal() == 0 ) {
buy_price=-1;
}


if ( OrdersTotal() > 0 ) {

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic 
         
         //&& Bid >= buy_price+distance*Point 
         && Bid-OrderOpenPrice() >= (distance*Point)*2 && OrderStopLoss() < Bid-distance*Point
         
         && Bid-OrderStopLoss() >= (distance*2)*Point
         
         
         )
         {
         
         //OrderModify(OrderTicket(),OrderOpenPrice(),buy_price+distance*Point,0,-1,-1);
         OrderModify(OrderTicket(),OrderOpenPrice(),Bid-distance*Point,0,-1,-1);
         
         
            //RefreshRates();
            //bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
    
    
    
}

   
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
