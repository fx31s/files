//+------------------------------------------------------------------+
//|                                                  SkyperOrder.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int min_candle_body = 10;
//int min_distance=8000;
int min_bar_range=100;
int min_distance=200;
int min_bar=2;
//int min_bar=4;


int last_sell_shift=-1;
double last_sell_price=-1;
double last_buy_price=-1;
int last_buy_shift=-1;


extern double Lot=0.01; // Lot
extern int magic=0; // Ea Group Number

extern bool spread_filter=true;//Spread Filter
extern int max_spead = 30;//MaxSpread (zero or negative value means no limit)
double spread;
bool spread_onay = true;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
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

////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   spread=(ask-bid)/Point;
   //Print("spread",spread,"/",max_spead);
   spread_onay=true;
   if ( spread_filter == true ) {
   if ( spread > max_spead && max_spead > 0 ) {
   spread_onay=false;
   //return;
   }
   }
//////////////////////////////////////////////////////////////////////////
  
    
    Comment("AccountProfit:",AccountProfit());
    
    
    if ( AccountProfit() > 1 ) {
    
    
CloseAllOrders();
    
    last_buy_price=-1;
    last_sell_price=-1;
    
    
    }
    
    

  if ( Open[1] > Close[1] && (Open[1] - Close[1])/Point >= min_candle_body && Close[2] > Open[2] ) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Close[i] > Open[i] || MathAbs(Close[i]-Open[i])/Point < min_candle_body ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
if ( spread_onay == true && say >= min_bar && find == true && (High[2]-Low[shift])/Point >= min_bar_range && last_sell_shift != shift && ((Bid > last_sell_price && (Bid-last_sell_price)/Point >= min_distance) || last_sell_price == -1 )  ) {
ObjectDelete(ChartID(),"SELL"+Time[2]);
ObjectCreate(ChartID(),"SELL"+Time[2],OBJ_TREND,0,Time[2],High[2],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_RAY,False);

last_sell_shift=shift;
last_sell_price=Bid;

int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);

}

  
  
  
  }
  
  
  
/*
 
  if ( Close[1] > Open[1] && (Close[2]-Open[1])/Point >= min_candle_body && Open[2] > Close[2]  ) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Open[i] > Close[i] || MathAbs(Open[i]-Close[i])/Point < min_candle_body ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
if ( spread_onay == true && say >= min_bar && find == true && (High[shift]-Low[2])/Point >= min_bar_range && last_sell_shift != shift && ((Ask < last_buy_price && (last_buy_price-Ask)/Point >= min_distance) || last_buy_price==-1) ) {
ObjectDelete(ChartID(),"BUY"+Time[2]);
ObjectCreate(ChartID(),"BUY"+Time[2],OBJ_TREND,0,Time[shift],High[shift],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_RAY,False);

last_buy_shift=shift;
last_buy_price=Ask;

int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

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


void CloseAllBuyOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
         }
      }
   }
}

void CloseAllOrders()
{
   CloseAllBuyOrders();
   CloseAllSellOrders();
}
