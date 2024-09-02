//+------------------------------------------------------------------+
//|                                                   LondonOpen.mq4 |
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
   ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
   ChartSetInteger(ChartID(),CHART_SCALE,4);
   
   
   
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
double buy_price=0;
double sell_price=0;

int buy_ticket=0;
int sell_ticket=0;

bool buy_sl=false;
bool sell_sl=false;

double Lot=0.01;
int mgc=34;

int start_day=-1;

void OnTick()
  {
//---
if ( int(TimeHour(TimeCurrent())) == 8 && start_day != int(TimeDay(TimeCurrent())) && buy_ticket==0 && sell_ticket == 0
//if ( int(TimeHour(TimeCurrent())) == 9 && start_day != int(TimeDay(TimeCurrent())) && buy_ticket==0 && sell_ticket == 0
//if ( int(TimeHour(TimeCurrent())) == 10 && start_day != int(TimeDay(TimeCurrent())) && buy_ticket==0 && sell_ticket == 0
//if ( int(TimeHour(TimeCurrent())) == 18 && start_day != int(TimeDay(TimeCurrent())) && buy_ticket==0 && sell_ticket == 0 // Gbp Pariteleri
) {

double high_price=WindowPriceMax();
double low_price=WindowPriceMin();

double yuzde=(high_price-low_price)/100;

double level=(Bid-low_price)/yuzde;


ObjectCreate(ChartID(),"VLINE"+Time[0],OBJ_VLINE,0,Time[0],Ask);

if ( buy_ticket == 0 && level >= 70 ) {buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Bid-600*Point,Ask+600*Point,"BUY",mgc,0,clrNONE);
buy_price=Ask;
}
if ( sell_ticket == 0 && level <= 30) {sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Ask+600*Point,Bid-600*Point,"SELL",mgc,0,clrNONE);
sell_price=Bid;
}

start_day=int(TimeDay(TimeCurrent()));


}


Comment("Sell Ticket:",sell_ticket,"/ Buy Ticket:",buy_ticket);




if ( buy_ticket != 0 ) {
Print(buy_ticket,"/",buy_price,"/",(Bid-buy_price)/Point);
if ( (Bid-buy_price)/Point >= 600 && buy_sl == false ) {
Print("OrderModify");
OrderModify(buy_ticket,buy_price,buy_price+10*Point,0,0,clrNONE);
buy_sl=true;
//OrderClose(sell_ticket,Lot,Ask,0,clrNONE);
}
}

if ( sell_ticket != 0 ) {
Print(sell_ticket,"/",sell_price,"/",(sell_price-Ask)/Point);
if ( (sell_price-Ask)/Point >= 600 && sell_sl == false ) {
Print("OrderModify");
OrderModify(sell_ticket,sell_price,sell_price-10*Point,0,0,clrNONE);
sell_sl=true;
//OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
}
}
/*
if ( buy_ticket != 0 ) {
if ( (buy_price-Ask)/Point >= 600 ) {
OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
buy_ticket=0;
//sell_ticket=0;
buy_price=0;
//sell_price=0;
buy_sl=false;
//sell_sl=false;
}
}

if ( sell_ticket != 0 ) {
if ( (Bid-sell_price)/Point >= 600 ) {
OrderClose(sell_ticket,Lot,Bid,0,clrNONE);
//buy_ticket=0;
sell_ticket=0;
//buy_price=0;
sell_price=0;
//buy_sl=false;
sell_sl=false;
}
}
*/

//if ( int(TimeHour(TimeCurrent())) == 23 && start_day == int(TimeDay(TimeCurrent()))) { // Gbp
//if ( int(TimeHour(TimeCurrent())) == 15 && start_day == int(TimeDay(TimeCurrent()))) {
//if ( int(TimeHour(TimeCurrent())) == 17 && start_day == int(TimeDay(TimeCurrent()))) {
//if ( int(TimeHour(TimeCurrent())) == 13 && start_day == int(TimeDay(TimeCurrent()))) {
if ( int(TimeHour(TimeCurrent())) == 18 && start_day == int(TimeDay(TimeCurrent()))) {

if ( buy_ticket != 0 || sell_ticket != 0 ) {
ObjectCreate(ChartID(),"VLINE"+Time[0],OBJ_VLINE,0,Time[0],Ask);
ObjectSetInteger(ChartID(),"VLINE"+Time[0],OBJPROP_COLOR,clrYellow);
}

if ( buy_ticket != 0 ) {
//if ( (buy_price-Ask)/Point >= 600 ) {
OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
buy_ticket=0;
//sell_ticket=0;
buy_price=0;
//sell_price=0;
buy_sl=false;
//sell_sl=false;
//}
}

if ( sell_ticket != 0 ) {
//if ( (Bid-sell_price)/Point >= 600 ) {
OrderClose(sell_ticket,Lot,Ask,0,clrNONE);
//buy_ticket=0;
sell_ticket=0;
//buy_price=0;
sell_price=0;
//buy_sl=false;
sell_sl=false;
//}
}


}

/*
if ( buy_sl == true ) {
if ( (Bid-buy_price)/Point >= 300*2 ) {
OrderClose(buy_ticket,Lot,Bid,0,clrNONE);
buy_ticket=0;
sell_ticket=0;
buy_price=0;
sell_price=0;
buy_sl=false;
sell_sl=false;
}
}

if ( sell_sl == true ) {
if ( (sell_price-Ask)/Point >= 300*2 ) {
OrderClose(sell_ticket,Lot,Ask,0,clrNONE);
buy_ticket=0;
sell_ticket=0;
buy_price=0;
sell_price=0;
buy_sl=false;
sell_sl=false;
}
}
*/



   
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
