//+------------------------------------------------------------------+
//|                                                   RsiLevelEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

input string MA_Indicator_Properties = "=======  Trend Moving Averages Properties ====="; //==================
extern bool Ma_Control=true; // Ma Control Order
input int MA_W=50;//Moving average period
input ENUM_MA_METHOD MaMethod=MODE_EMA;  // Ma Method
input ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
input ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT; // Ma Period
//////////////////////////////////////////////////////////////////
input string RSI_Indicator_Properties = "=======  RSI Properties ====="; //==================
extern bool Rsi_Control=true; // Rsi Control Order
extern int RSILength=12; // Rsi Lenght
extern int SellThreshold=20; // Over Sell
extern int BuyThreshold=80; // Over Buy
//////////////////////////////////////////////////////////////////
input string Martingale_Properties = "=======  Martingale ====="; //==================
extern bool martingale=true; // Martingale ( Kademe )
extern double multiplier=2; // Multiplier ( Lot Çarpan )
extern int distance_pip_manuel=500; // Distance Pip / 0 = Auto
extern int limit_order_total=2; // İkinci İşlem ile çift yönlü işlem açmaya başlar.
//////////////////////////////////////////////////////////////////
input string Prop_Properties = "=======  Prop Daily DD Limit ====="; //==================
extern double prop_stop_daily = -400; // Daily DD Limit USD
extern double today_target_daily_profit = 50; // Target Daily Profit
//////////////////////////////////////////////////////////////////
input string TP_Indicator_Properties = "=======  TakeProfit StopLoss ====="; //==================
extern int TP_Pips=450; // TakeProfit
//extern int SL_Pips=0; // StopLoss
extern double Lot=0.01; // Lot
extern double TP_Usd = 2; // Total Close
//extern double SL_Usd = 0;
//////////////////////////////////////////////////////////////////
input string Trailing_stop = "=======  Trailing stop ====="; //==================
extern double TS_Usd = 11; // Total Close ( First Order Close ) 
extern double TS_Level_Usd = 5; // Trailing Usd Distance
extern bool Trailing_Status = true; // Trailing On Off
////////////////////////////////////////////////////////////////////////////////////////////////////////
input string TimeFilter_Properties = "================ Time Filter Properties ================"; //====================
input bool   timefilter        = false;// Time Filter
input int    Start_Hour      = 8;
input int    Start_Minute     = 0;
input int     Finish_Hour     = 15;
input int     Finish_Minute     = 0;
//input int DayOf = -1; // Frider 5 or -1 Disabled
////////////////////////////////////////////////////////////////////////////////////////////////////////
input string Candle_Properties = "================ Candle Properties ================"; //====================
input bool bar_close=true; // Candle Close
datetime bar_time;




int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;
double buy_pen_lot=0;
double sell_pen_lot=0;

bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;

bool lock_order_buy_total=0;
bool lock_order_sell_total=0;

string last_select_object="";

double price=0;

double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


double last_buy_lot;
double last_sell_lot;

double buy_orders[50,4];
double sell_orders[50,4];



   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   int buy_ticket;
   int sell_ticket;   
   double buy_lots=1;
   double sell_lots=1;
   int magic=0;
   

   double high_price=-1;
   double low_price=-1;
   double sell_price;
   double buy_price;
   
   //double multiplier=2;
   
   double profit=5;
   int distance=250;
   
   datetime buy_time;
   datetime sell_time;

double buy_order_price=-1;
double sell_order_price=-1;

double buy_sl_price=-1;
double sell_sl_price=-1;

bool sl_clear=false;

bool auto_sl=false;
bool live=true; // Bar Live Close

bool ma_close=false;
bool profit_close=false;



int manuel_distance=0;
int manuel_sl_distance=0;

// Altın 15 5 1

int buy_timehour=-1;
int sell_timehour=-1;

bool time_filter_order_allow=true;

int robot_stop_day=-1;


datetime last_time;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  

double MA=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 

         string name="MA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,4);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   
         //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, ObjectTimeFrame);  
         
   ObjectMove(0,"MA",0,Time[1]+(PeriodSeconds()*3),MA);
   ObjectMove(0,"MA",1,Time[3]+(PeriodSeconds()*3),MA);  
   


     
  
//--- create timer
   //EventSetTimer(60);
/*   
if ( IsTesting() == false ) {
ExpertRemove();
}*/

/*
if ( AccountNumber() != 2102537711 ) {
ExpertRemove();
}*/
   
   
   //bar_time=Time[1];
   
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

bool robot_stop=false;

double buy_close_price=0;
double sell_close_price=0;
double last_buy_profit=0;
double last_sell_profit=0;

void OnTick()
  {
//---

/*
if ( bar_close == true ) {

if ( bar_time!=Time[1]) {
bar_time=Time[1];
return;
}
}
*/

/*
if ( IsTesting() == false ) {
ExpertRemove();
}
*/
/*
if ( AccountNumber() != 2102537711 ) {
ExpertRemove();
}*/


   if ( robot_stop == true ) {
   if ( robot_stop_day!=int(TimeDay(TimeCurrent())) ) {
   robot_stop=false;
   }
   
   }
   

if ( robot_stop == true ) return;






if ( timefilter == true ) {

   string start_times=TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+Start_Hour+":"+Start_Minute+":00";
   datetime Start_Time = StringToTime(start_times);

   string finish_times=TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+Finish_Hour+":"+Finish_Minute+":00";
   datetime Finish_Time = StringToTime(finish_times);



time_filter_order_allow=true;

//if ( int(TimeHour(TimeCurrent())) < Start_Time ) {
if ( TimeCurrent() < Start_Time ) {
time_filter_order_allow=false;
//return;
}
//if ( int(TimeHour(TimeCurrent())) > Finish_Time ) {
if ( TimeCurrent() > Finish_Time ) {
time_filter_order_allow=false;
//return;
}

}

   if ( timefilter == false ) {
   time_filter_order_allow=true;
   }
   
   
///////////////////////////////////////////////////////////////   
   double today_profit=OrderHistoryTotalProfits();
   
   if ( today_profit >= today_target_daily_profit ) {
   time_filter_order_allow=false;
   }
///////////////////////////////////////////////////////////////
   


double MA=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 

   //ObjectMove(0,"MA",0,Time[1],MA);
   //ObjectMove(0,"MA",1,Time[3]+(PeriodSeconds()*3),MA);
   
   ObjectSetDouble(ChartID(),"MA",OBJPROP_PRICE,MA);
   





string rsi_durum=RSI_WAY();

//Comment("Rsi:",rsi_durum);

if ( rsi_durum == "BUY" ) {

  if ( last_time == Time[1] ) {
  //return;
  } else {
  last_time=Time[1];
  
ObjectCreate(ChartID(),"VLINE"+Time[0],OBJ_VLINE,0,Time[0],Ask);
ObjectSetInteger(ChartID(),"VLINE"+Time[0],OBJPROP_COLOR,clrBlue);


   if ( buy_total == 0 && sell_total == 0 && time_filter_order_allow == true ) {   
   magic=magic+1;
   buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"BUY",magic,0,clrNONE);   
   buy_price=Ask;   
   }
   }

}

if ( rsi_durum == "SELL" ) {

  if ( last_time == Time[1] ) {
  //return;
  } else {
  last_time=Time[1];
  
ObjectCreate(ChartID(),"VLINE"+Time[0],OBJ_VLINE,0,Time[0],Ask);
ObjectSetInteger(ChartID(),"VLINE"+Time[0],OBJPROP_COLOR,clrRed);

   if ( sell_total == 0 && buy_total == 0 && time_filter_order_allow == true) {   
   magic=magic+1;
   sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"SELL",magic,0,clrNONE);   
   sell_price=Bid;   
   }
}

}


   OrderCommetssTypeMulti(Symbol());
   Comment("Today Profit:",today_profit,"\nMagic:",magic,"\nRsi:",rsi_durum,"\nBuyProfit:",buy_profit,"\nSell Profit:",sell_profit);


///////////////////////////////////////////////////   
  /* if ( buy_profit+sell_profit < prop_stop_daily ) {
   CloseAllOrders();
   robot_stop=true;
   return;
   } */
   

   
   if ( OrderHistoryTotalProfits()+AccountProfit() <= prop_stop_daily ) {
   CloseAllOrders();
   robot_stop=true;
   robot_stop_day=int(TimeDay(TimeCurrent()));
   return;
   } 
   
////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////////////   
   
   
   
   
   
   if ( Trailing_Status == true ) {
   
if ( buy_total == 1 && buy_profit >= TS_Level_Usd && sell_total == 0 &&  last_buy_profit == 0 ) {  

   buy_close_price=Bid;
   last_buy_profit=buy_profit;
   ObjectDelete(ChartID(),"BUYCLOSEPRICE");
   ObjectCreate(ChartID(),"BUYCLOSEPRICE",OBJ_HLINE,0,Time[0],buy_close_price);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_COLOR,clrBlue);
}
   
   
if ( buy_total == 1 && buy_profit >= last_buy_profit+TS_Level_Usd && sell_total == 0 &&  last_buy_profit > 0 ) {  
   
   double close_pip=PipPrice(Symbol(),TS_Level_Usd,0,Lot);
   buy_close_price=Bid-close_pip*Point;
   last_buy_profit=buy_profit;
   ObjectDelete(ChartID(),"BUYCLOSEPRICE");
   ObjectCreate(ChartID(),"BUYCLOSEPRICE",OBJ_HLINE,0,Time[0],buy_close_price);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_COLOR,clrBlue);
}
   
   
    if ( buy_total == 1 && buy_profit >= TS_Usd
     && sell_total == 0 && Bid <= buy_close_price ) {
    CloseAllBuyOrders();
    last_buy_profit=0;
    buy_close_price=0;
    ObjectDelete(ChartID(),"BUYCLOSEPRICE");
    }

    }
    
/////////////////////////////////////////////////////////////////////////////
if ( Trailing_Status == false ) {

   if ( buy_total == 1 && buy_profit >= TS_Usd && sell_total == 0 ) {
   CloseAllBuyOrders();
   }

}      
////////////////////////////////////////////////////////////////////////////   
   
   
   /*if ( buy_total == 1 && buy_profit >= 11 && sell_total == 0 && ( buy_close_price == 0 || ((Ask-buy_close_price)/Point >= PipPrice(Symbol(),5,0,Lot)) )) {
   //CloseAllBuyOrders();
   
   double close_pip=PipPrice(Symbol(),5,0,Lot);
   buy_close_price=Ask-((int(close_pip))*Point);
   Print(buy_close_price,"/",close_pip);
   ObjectDelete(ChartID(),"BUYCLOSEPRICE");
   ObjectCreate(ChartID(),"BUYCLOSEPRICE",OBJ_HLINE,0,Time[0],buy_close_price);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"BUYCLOSEPRICE",OBJPROP_COLOR,clrBlue);
   }
   
  
    if ( buy_total == 1 && buy_profit >= 11
     && sell_total == 0 && Bid <= buy_close_price ) {
    CloseAllBuyOrders();
    }*/
 
 
 
 
 /*
   if ( buy_total == 1 && buy_profit >= 2 && sell_total == 0 ) {
   CloseAllBuyOrders();
   }
 */
 
 
   
   
   //PipPrice(string sym,double fiyat,int pips,double lots)
   
   
   

   if ( ( bar_time!=Time[1] || bar_close == false ) && 
   ( time_filter_order_allow == true || buy_total >= 1 ) && buy_total >= 1 && (buy_price-Ask)/Point >= distance_pip_manuel && buy_price != 0 ) {
   
double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);

if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 && Lot != 0.01 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;

if ( multiplier == 0 ) Lots=Lot;
   
   buy_ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,0,0,0,"BUY",magic,0,clrNONE);   
   buy_price=Ask;     
   if ( buy_total >= limit_order_total && sell_total == 0 ) sell_ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,0,0,Bid-TP_Pips*Point,"SELL",magic,0,clrNONE); 
   // if ( sell_total == 0 ) 

bar_time=Time[1];   
   
     
   }

  if ( buy_total > 1 ) {
  double history_sell_profit=OrderHistoryTotalProfits(OP_SELL);
  
  if ( (history_sell_profit+buy_profit+sell_profit) >= TP_Usd ) {
  CloseAllOrdersMix();
  }
  
  }
///////////////////////////////////////////////////////////////////////////////////////////  


////////////////////////////////////////////////////////////////////////////////////////////   
  /* if ( sell_total == 1 && sell_profit >= 2 && buy_total == 0 ) {
   CloseAllSellOrders();
   }*/



if ( Trailing_Status == true ) {

if ( sell_total == 1 && sell_profit >= TS_Level_Usd && buy_total == 0 &&  last_sell_profit == 0 ) {  

   sell_close_price=Bid;
   last_sell_profit=sell_profit;
   ObjectDelete(ChartID(),"SELLCLOSEPRICE");
   ObjectCreate(ChartID(),"SELLCLOSEPRICE",OBJ_HLINE,0,Time[0],sell_close_price);
   ObjectSetInteger(ChartID(),"SELLCLOSEPRICE",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"SELLCLOSEPRICE",OBJPROP_COLOR,clrRed);
}
   
   
if ( sell_total == 1 && sell_profit >= last_sell_profit+TS_Level_Usd && buy_total == 0 &&  last_sell_profit > 0 ) {  
   
   double close_pip=PipPrice(Symbol(),TS_Level_Usd,0,Lot);
   sell_close_price=Bid+close_pip*Point;
   last_sell_profit=sell_profit;
   ObjectDelete(ChartID(),"SELLCLOSEPRICE");
   ObjectCreate(ChartID(),"SELLCLOSEPRICE",OBJ_HLINE,0,Time[0],sell_close_price);
   ObjectSetInteger(ChartID(),"SELLCLOSEPRICE",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"SELLCLOSEPRICE",OBJPROP_COLOR,clrRed);
}
   
   
    if ( sell_total == 1 && sell_profit >= TS_Usd
     && buy_total == 0 && Bid >= sell_close_price ) {
    CloseAllSellOrders();
    last_sell_profit=0;
    sell_close_price=0;
    ObjectDelete(ChartID(),"SELLCLOSEPRICE");
    }
    
}    
/////////////////////////////////////////////////////////////////      
if ( Trailing_Status == false ) {      

if ( sell_total == 1 && sell_profit >= TS_Usd && buy_total == 0 ) {
   CloseAllSellOrders();
   }      
      
}      
////////////////////////////////////////////////////////////////////      


   if ( ( bar_time!=Time[1] || bar_close == false ) &&
    ( time_filter_order_allow == true || sell_total >= 1 ) && sell_total >= 1 && (Bid-sell_price)/Point >= distance_pip_manuel && sell_price != 0 ) {
   

double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 && Lot != 0.01 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;


if ( multiplier == 0 ) Lots=Lot;   

   sell_ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,0,0,0,"SELL",magic,0,clrNONE);   
   sell_price=Bid;  
   //if ( buy_total == 0 )    
   if ( sell_total >= limit_order_total && buy_total == 0 ) buy_ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,0,0,Ask+TP_Pips*Point,"BUY",magic,0,clrNONE);
   

bar_time=Time[1];   
      
   }

  if ( sell_total > 1 ) {
  double history_buy_profit=OrderHistoryTotalProfits(OP_BUY);
  
  if ( (history_buy_profit+buy_profit+sell_profit) >= TP_Usd ) {
  CloseAllOrdersMix();
  }
  
  }
///////////////////////////////////////////////////////////////////////////////////////////  



if ( bar_close == true ) {
if ( buy_total == 0 && sell_total == 0 ) {
last_time = Time[1];
}
}
else {
last_time = -1;
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


string RSI_WAY() {

double RSI = 0.0;

        int iShift = iBarShift(Symbol(), PERIOD_CURRENT, Time[0], false);

        RSI = iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, iShift);

string rsi_yonu="";

if ( RSI <= SellThreshold ) {
rsi_yonu = "BUY";
};

if ( RSI >= BuyThreshold ) {
rsi_yonu = "SELL";
};


return rsi_yonu;


} 

void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);
         }
      }
    }
}


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


/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
/////////////////////////////////////////////////////////////////////////////////////////////////////////
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;

eq_live_order=0;
eq_pen_order=0;


lock_order_buy_total=0;
lock_order_sell_total=0;

sell_total_profit_loss=0;
buy_total_profit_loss=0;

sell_total_profit=0;
buy_total_profit=0;

sell_pen_total_profit_loss=0;
buy_pen_total_profit_loss=0;

sell_pen_total_profit=0;
buy_pen_total_profit=0;

buy_pen_lot=0;
sell_pen_lot=0;



//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){




if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

if ( OrderMagicNumber() != magic ) continue;

//Print(OrderTicket());


//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}
/*
////////////////////////////////////////////////////
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_buy_profit=OrderProfit();
lock_order_buy_total=lock_order_buy_total+1;
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_sell_profit=OrderProfit();
lock_order_sell_total=lock_order_sell_total+1;
}
////////////////////////////
*/



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
//if ( OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_profit=buy_profit+OrderCommission();
buy_profit=buy_profit+OrderSwap();
buy_lot=buy_lot+OrderLots();


buy_orders[buy_total,0]=OrderTicket();
buy_orders[buy_total,1]=OrderProfit()+OrderCommission()+OrderSwap();
buy_orders[buy_total,2]=OrderLots();
buy_orders[buy_total,3]=OrderOpenPrice();



if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit_loss=buy_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit=buy_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}





if ( OrderSymbol() == sym && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP )  //&& OrderMagicNumber() == magic 
) {/*
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
*/
buy_pen_lot=buy_pen_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit_loss=buy_pen_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit=buy_pen_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
//if ( OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
 ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_profit=sell_profit+OrderCommission();
sell_profit=sell_profit+OrderSwap();
sell_lot=sell_lot+OrderLots();


sell_orders[sell_total,0]=OrderTicket();
sell_orders[sell_total,1]=OrderProfit()+OrderCommission()+OrderSwap();
sell_orders[sell_total,2]=OrderLots();
sell_orders[sell_total,3]=OrderOpenPrice();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit_loss=sell_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit=sell_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}



if ( OrderSymbol() == sym && (OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP )//&& OrderMagicNumber() == magic 
 ) {
 

//sell_total=sell_total+1;
//sell_profit=sell_profit+OrderProfit();
sell_pen_lot=sell_pen_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit_loss=sell_pen_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit=sell_pen_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}

}

sonuc=true;

/*
if ( lock_order_buy_total == 0 ) lock_order_buy = false;
if ( lock_order_sell_total == 0 ) lock_order_sell = false;
*/
return sonuc;
};
////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}

double OrderHistoryTotalProfits(int ordtyp){

//secilen comments tipinin ne kadar kazandigida ogrenilebilir

           double profitx = 0;
   for(int cnt=0; cnt<OrdersHistoryTotal(); cnt++)
   {
         OrderSelect(cnt,SELECT_BY_POS, MODE_HISTORY);
         
         
         if ( OrderMagicNumber() == magic && OrderType() == ordtyp ) { 
         
         if ( OrderSymbol() == Symbol()  ) profitx = profitx + OrderProfit()+OrderCommission()+OrderSwap();
         
            //if ( OrderSymbol() == Symbol() && OrderProfit() > 0  ) profitx = profitx + OrderProfit();
            //if ( OrderSymbol() == Symbol() && OrderProfit() < 0  ) profitx = profitx - OrderProfit();         
         
         } 
         

         
   }
  
   
  
return profitx;
};


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// TOPLAM KAZANc BUGuN AcILAN isLEMLER - OrderHistoryTotalProfits
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double OrderHistoryTotalProfits(){

//secilen comments tipinin ne kadar kazandigida ogrenilebilir

           double profitx = 0;
   for(int cnt=0; cnt<OrdersHistoryTotal(); cnt++)
   {
         OrderSelect(cnt,SELECT_BY_POS, MODE_HISTORY);
         
         
         if ( Symbol() == OrderSymbol() && int(TimeDay(OrderCloseTime())) == int(TimeDay(TimeCurrent())) && (StringFind(OrderComment(),"BUY",0) != -1 || StringFind(OrderComment(),"SELL",0) != -1) ) {
         


            if ( OrderSymbol() == Symbol()  ) profitx = profitx + OrderProfit()+OrderCommission()+OrderSwap();
            //if ( OrderProfit() > 0  ) profitx = profitx + OrderProfit();
            //if ( OrderProfit() < 0  ) profitx = profitx - OrderProfit();            
    
            
         };
   };
  
return profitx;
};

