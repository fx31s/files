//+------------------------------------------------------------------+
//|                                                    salvation.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


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
   double Lot=0.01;
   double buy_lots=1;
   double sell_lots=1;
   int magic=666;
   

   double high_price=-1;
   double low_price=-1;
   double sell_price;
   double buy_price;
   
   double multiplier=2;
   
   input double profit=7;
   input int distance=250;
   
   datetime buy_time;
   datetime sell_time;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   Print("Symbol=",Symbol());
   Print("Low day price=",MarketInfo(Symbol(),MODE_LOW));
   Print("High day price=",MarketInfo(Symbol(),MODE_HIGH));
   Print("The last incoming tick time=",(MarketInfo(Symbol(),MODE_TIME)));
   Print("Last incoming bid price=",MarketInfo(Symbol(),MODE_BID));
   Print("Last incoming ask price=",MarketInfo(Symbol(),MODE_ASK));
   Print("Point size in the quote currency=",MarketInfo(Symbol(),MODE_POINT));
   Print("Digits after decimal point=",MarketInfo(Symbol(),MODE_DIGITS));
   Print("Spread value in points=",MarketInfo(Symbol(),MODE_SPREAD));
   Print("Stop level in points=",MarketInfo(Symbol(),MODE_STOPLEVEL));
   Print("Lot size in the base currency=",MarketInfo(Symbol(),MODE_LOTSIZE));
   Print("Tick value in the deposit currency=",MarketInfo(Symbol(),MODE_TICKVALUE));
   Print("Tick size in points=",MarketInfo(Symbol(),MODE_TICKSIZE)); 
   Print("Swap of the buy order=",MarketInfo(Symbol(),MODE_SWAPLONG));
   Print("Swap of the sell order=",MarketInfo(Symbol(),MODE_SWAPSHORT));
   Print("Market starting date (for futures)=",MarketInfo(Symbol(),MODE_STARTING));
   Print("Market expiration date (for futures)=",MarketInfo(Symbol(),MODE_EXPIRATION));
   Print("Trade is allowed for the symbol=",MarketInfo(Symbol(),MODE_TRADEALLOWED));
   Print("Minimum permitted amount of a lot=",MarketInfo(Symbol(),MODE_MINLOT));
   Print("Step for changing lots=",MarketInfo(Symbol(),MODE_LOTSTEP));
   Print("Maximum permitted amount of a lot=",MarketInfo(Symbol(),MODE_MAXLOT));
   Print("Swap calculation method=",MarketInfo(Symbol(),MODE_SWAPTYPE));
   Print("Profit calculation mode=",MarketInfo(Symbol(),MODE_PROFITCALCMODE));
   Print("Margin calculation mode=",MarketInfo(Symbol(),MODE_MARGINCALCMODE));
   Print("Initial margin requirements for 1 lot=",MarketInfo(Symbol(),MODE_MARGININIT));
   Print("Margin to maintain open orders calculated for 1 lot=",MarketInfo(Symbol(),MODE_MARGINMAINTENANCE));
   Print("Hedged margin calculated for 1 lot=",MarketInfo(Symbol(),MODE_MARGINHEDGED));
   Print("Free margin required to open 1 lot for buying=",MarketInfo(Symbol(),MODE_MARGINREQUIRED));
   Print("Order freeze level in points=",MarketInfo(Symbol(),MODE_FREEZELEVEL)); 
   

Print(AccountStopoutLevel());

 double level=AccountStopoutLevel();
  if(AccountStopoutMode()==0)
     Print("StopOut level = ", level, "%");
  else
     Print("StopOut level = ", level, " ", AccountCurrency());
     

      

   
   
   
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

   OrderCommetssTypeMulti(Symbol());
   Comment("BuyProfit:",buy_profit,"/ Sell Profit:",sell_profit);
   
   

if ( iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     (iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     
     sell_time!=iTime(sym,per,1)
     
     ) {
     
     ObjectCreate(ChartID(),"S"+Time[1],OBJ_TREND,0,Time[1],iClose(sym,per,1),Time[1]+10*PeriodSeconds(per),iClose(sym,per,1));
     ObjectSetInteger(ChartID(),"S"+Time[1],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"S"+Time[1],OBJPROP_COLOR,clrLimeGreen);

     ObjectCreate(ChartID(),"SH"+Time[1],OBJ_TREND,0,Time[2],iHigh(sym,per,2),Time[2]+10*PeriodSeconds(per),iHigh(sym,per,2));
     ObjectSetInteger(ChartID(),"SH"+Time[1],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"SH"+Time[1],OBJPROP_COLOR,clrBlue);
     

double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( sell_total == 0 ) last_sell_lot=0.01;
if ( sell_total == 1 ) last_sell_lot=0.02;
if ( sell_total == 2 ) last_sell_lot=0.04;
if ( sell_total == 3 ) last_sell_lot=0.08;
if ( sell_total > 3 ) last_sell_lot=0.16;
Lots=last_sell_lot;


     
     if ( high_price != -1 && (iHigh(sym,per,2)-high_price)/Point >= distance ) {
     Print("Lots",Lots);
     sell_ticket=OrderSend(sym,OP_SELL,Lots,Bid,0,0,0,"",magic,0,clrNONE);
     high_price=iHigh(sym,per,2);
     sell_price=Bid;
     sell_time=iTime(sym,per,1);
     }
     

     if ( high_price == -1  ) {
     Print("Lots",Lots);
     sell_ticket=OrderSend(sym,OP_SELL,Lots,Bid,0,0,0,"",magic,0,clrNONE);
     high_price=iHigh(sym,per,2);
     sell_price=Bid;
     sell_time=iTime(sym,per,1);
     }

     
     }
     
     
     
     


if ( iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     (iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     
     buy_time!=iTime(sym,per,1)
     
     ) {
     
     ObjectCreate(ChartID(),"S"+Time[1],OBJ_TREND,0,Time[1],iClose(sym,per,1),Time[1]+10*PeriodSeconds(per),iClose(sym,per,1));
     ObjectSetInteger(ChartID(),"S"+Time[1],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"S"+Time[1],OBJPROP_COLOR,clrLimeGreen);

     ObjectCreate(ChartID(),"SL"+Time[1],OBJ_TREND,0,Time[2],iLow(sym,per,2),Time[2]+10*PeriodSeconds(per),iLow(sym,per,2));
     ObjectSetInteger(ChartID(),"SL"+Time[1],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"SL"+Time[1],OBJPROP_COLOR,clrBlue);
     

double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( buy_total == 0 ) last_buy_lot=0.01;
if ( buy_total == 1 ) last_buy_lot=0.02;
if ( buy_total == 2 ) last_buy_lot=0.04;
if ( buy_total == 3 ) last_buy_lot=0.08;
if ( buy_total > 3 ) last_buy_lot=0.16;
Lots=last_buy_lot;


     
     if ( low_price != -1 && (low_price-iLow(sym,per,2))/Point >= distance ) {
     Print("Lots",Lots);
     buy_ticket=OrderSend(sym,OP_BUY,Lots,Ask,0,0,0,"",magic,0,clrNONE);
     low_price=iLow(sym,per,2);
     buy_price=Ask;
     buy_time=iTime(sym,per,1);
     }
     

     if ( low_price == -1  ) {
     Print("Lots",Lots);
     buy_ticket=OrderSend(sym,OP_BUY,Lots,Ask,0,0,0,"",magic,0,clrNONE);
     low_price=iLow(sym,per,2);
     buy_price=Ask;
     buy_time=iTime(sym,per,1);
     }
     
     
     /*
     if ( high_price == -1 || high_price < iHigh(sym,per,1) ) {
     sell_ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
     high_price=iHigh(sym,per,1);
     sell_price=Bid;
     }*/
    
     
     
     }
     
          
     
     

   if ( buy_profit >= profit ) {
    CloseAllBuyOrders();
    low_price=-1;
   }
   
   if ( sell_profit >= profit ) {
    CloseAllSellOrders();
    high_price=-1;
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
buy_lot=buy_lot+OrderLots();


buy_orders[buy_total,0]=OrderTicket();
buy_orders[buy_total,1]=OrderProfit()+OrderCommission();
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
sell_lot=sell_lot+OrderLots();


sell_orders[sell_total,0]=OrderTicket();
sell_orders[sell_total,1]=OrderProfit()+OrderCommission();
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
