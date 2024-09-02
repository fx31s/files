//+------------------------------------------------------------------+
//|                                                       Casino.mq4 |
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
   balance=AccountBalance();
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


if ( AccountBalance() > balance && OrdersTotal() == 0 ) {
last_lot=-1;
balance=AccountBalance();
}



if ( OrdersTotal() == 0 ) {

if ( last_lot == -1 ) {
//OrderSend(Symbol(),OP_BUY,last_lot,Ask,0,Bid-50*Point,Ask+50*Point,"NULL",0,0,clrNONE);
//OrderSend(Symbol(),OP_SELL,last_lot,Bid,0,Ask+250*Point,Bid-250*Point,"NULL",0,0,clrNONE);
OrderSend(Symbol(),OP_SELL,last_lot,Bid,0,Ask+1000*Point,Bid-1000*Point,"NULL",0,0,clrNONE);
//OrderSend(Symbol(),OP_BUY,last_lot,Ask,0,Bid-1000*Point,Ask+1000*Point,"NULL",0,0,clrNONE);
last_lot=0.01;
level=level+1;
} else {
last_lot=last_lot*2;
//OrderSend(Symbol(),OP_SELL,last_lot,Bid,0,Ask+250*Point,Bid-250*Point,"NULL",0,0,clrNONE);
OrderSend(Symbol(),OP_SELL,last_lot,Bid,0,Ask+1000*Point,Bid-1000*Point,"NULL",0,0,clrNONE);
//OrderSend(Symbol(),OP_BUY,last_lot,Ask,0,Bid-1000*Point,Ask+1000*Point,"NULL",0,0,clrNONE);
level=level+1;
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

double last_lot=-1;
double balance;
int level=0;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


   
  }
//+------------------------------------------------------------------+
