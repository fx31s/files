//+------------------------------------------------------------------+
//|                                                    FakeTrend.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alpc - Mehmet Ozhan Hastaoglu"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property icon "trendmyfriend.ico"
#ifdef __MQL5__ 
#define Ask    SymbolInfoDouble(_Symbol,SYMBOL_ASK)
#define Bid    SymbolInfoDouble(_Symbol,SYMBOL_BID)
#endif 
//--- redefine the order types from MQL5 to MQL4 for versatility of the code
#ifdef __MQL4__ 
#define ORDER_TYPE_BUY        OP_BUY
#define ORDER_TYPE_SELL       OP_SELL
#define ORDER_TYPE_BUY_LIMIT  OP_BUYLIMIT
#define ORDER_TYPE_SELL_LIMIT OP_SELLLIMIT
#define ORDER_TYPE_BUY_STOP   OP_BUYSTOP
#define ORDER_TYPE_SELL_STOP  OP_SELLSTOP
#endif 

#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//--- SYMBOL_TRADE_STOPS_LEVEL and SYMBOL_TRADE_FREEZE_LEVEL levels
int freeze_level,stops_level;
//--- spread
double spread;


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


//double buy_price;
//double sell_price;

double start_order=false;

double Lot=0.01;
input double tp_pip=300;
//double tp_pip=300;

int magic=333;


//int distance=600;
double multiplier=3;

double last_buy_lot;
double last_sell_lot;

double buy_orders[50,4];
double sell_orders[50,4];


double buy_price=-1;
double sell_price=-1;

//double Lot=0.01;
//int magic=1;

input int distance=250;
input double distance_profit=1.75;

//input int distance=500;
//input double distance_profit=3.5;


input double lot_level_1=0.01;
input double lot_level_2=0.03;
input double lot_level_3=0.09;
input double lot_level_4=0.12;


double last_close_profit=0;
double total_close_profit=0;
double max_dd=0;


int OnInit()
  {
  
   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrBlack);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrLimeGreen);    
   
   
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrRed);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrLimeGreen);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrRed);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrRed);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrLightGray);
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);
   
   ChartSetInteger(ChartID(),CHART_COLOR_GRID,clrNONE);
   ChartSetInteger(ChartID(),CHART_MODE,1);    
   
   
   
 int k=19;

 for(int i=0;i<k;i++)
        {
        
        Print(i);
        
         //PrintFormat("result[%d]=%s",i,results[i]);
         
         
         
     long sinyal_charid=ChartID();
     string LabelChartu = "Bilgi"+i;
     ObjectDelete(sinyal_charid,LabelChartu);
     ObjectCreate(sinyal_charid,LabelChartu, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,"");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_CORNER, 1);
     ObjectSetString(sinyal_charid,LabelChartu, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_XDISTANCE, 200);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_YDISTANCE, i*20); 
 
        }
           
           
int x=-1;
  


    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Trend My Frend");  
  
             
     
  
  buy_price=Ask;
  sell_price=Bid;
  
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


OrderCommetssTypeMulti(Symbol());


//if ( (sell_profit+buy_profit >= 3.5 && distance == 500 ) || (sell_profit+buy_profit >= 1.75 && distance == 250 ) ) { // 1.42
//if ( (sell_profit+buy_profit >= distance_profit && distance == 500 ) || (sell_profit+buy_profit >= distance_profit && distance == 250 ) ) { // 1.42
if ( sell_profit+buy_profit >= distance_profit ) { // 1.42

last_close_profit=sell_profit+buy_profit;
total_close_profit=total_close_profit+last_close_profit;

CloseAllOrdersMix();
OrderCommetssTypeMulti(Symbol());
  buy_price=Ask;
  sell_price=Bid;
  
  
  
      string OrderLine="OrderClose"+Time[0];
      datetime OrderTime=Time[0];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,Ask);// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,10); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);  

      OrderLine="OrderProfit"+Time[0];
      OrderTime=Time[0];
      ObjectCreate(ChartID(),OrderLine,OBJ_TEXT,0,0,0,0,0);          // Create an arrow
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,Ask);// Set price
      //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,20); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrYellow);    
      ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,DoubleToString(last_close_profit,2)+"$");  
  
  
}


if ( sell_profit+buy_profit < max_dd ) {
max_dd=sell_profit+buy_profit;
}



//distance=250;

if ( (Ask-buy_price)/Point >=distance ) {

OrderCommetssTypeMulti(Symbol());

double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);

if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
//if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;



if ( buy_total <= 2 ) last_buy_lot=lot_level_1; // 1-2-3
//if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total >=3 && buy_total < 6 ) last_buy_lot=lot_level_2; //4-5-6
if ( buy_total >=6 && buy_total < 9 ) last_buy_lot=lot_level_3; //7-8-9
if ( buy_total >= 9 ) last_buy_lot=lot_level_4; //10 >
Lots=last_buy_lot;


spread=Ask-Bid;

         //--- get the opening price and knowingly set invalid TP/SL
         double price=Ask;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP,Lots);
         Print("  -----------------");         
//int ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,0,0,0,"FUCK",magic,0,clrNONE);

buy_price=Ask;
}

if ( (sell_price-Bid)/Point >=distance ) {

OrderCommetssTypeMulti(Symbol());

double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;

if ( sell_total <=2 ) last_sell_lot=lot_level_1;
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total >=3 && sell_total < 6 ) last_sell_lot=lot_level_2;
if ( sell_total >=6 && sell_total < 9 ) last_sell_lot=lot_level_3;
if ( sell_total >= 9 ) last_sell_lot=lot_level_4;
Lots=last_sell_lot;


spread=Ask-Bid;

         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Sell(price,SL,TP,Lots);
         Print("  -----------------");   

//int ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,0,0,0,"FUCK",magic,0,clrNONE);

sell_price=Bid;
}


//Comment("AccountProfit:",AccountProfit());

//Comment("SymbolProfit:",sell_profit+buy_profit,"\n Sell Profit:",sell_profit,"\n Buy Profit:",buy_profit);


int x=-1;
  


    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Trend My Friend");  
  ObjectSetInteger(0,"Bilgi"+x,OBJPROP_COLOR,clrYellow);      
  ObjectSetInteger(0,"Bilgi"+x,OBJPROP_FONTSIZE,13);      


    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Balance:"+NormalizeDouble(AccountBalance(),2)+"$");  

    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Equity:"+NormalizeDouble(AccountEquity(),2)+"$");  

  

    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"SymbolProfit:"+NormalizeDouble(sell_profit+buy_profit,2)+"$");  


    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Buy Profit:"+NormalizeDouble(buy_profit,2)+"$");  
  
    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Sell Profit:"+NormalizeDouble(sell_profit,2)+"$");  
    
    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Buy Lot:"+NormalizeDouble(buy_lot,2)+"");  
  
    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Sell Lot:"+NormalizeDouble(sell_lot,2)+"");  
    
    
        
    
    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Last Profit:"+NormalizeDouble(last_close_profit ,2)+"$");  
  ObjectSetInteger(0,"Bilgi"+x,OBJPROP_COLOR,clrGreen);      
    
    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Total Profit:"+NormalizeDouble(total_close_profit ,2)+"$");  
  ObjectSetInteger(0,"Bilgi"+x,OBJPROP_COLOR,clrLimeGreen);      


    x=x+1;   
  ObjectSetString(0,"Bilgi"+x,OBJPROP_TEXT,"Max DD:"+NormalizeDouble(max_dd ,2)+"$");  
  ObjectSetInteger(0,"Bilgi"+x,OBJPROP_COLOR,clrRed);      
      
    

/*
if ( AccountProfit() >= 3.5 ) {

CloseAllOrdersMix();

  buy_price=Ask;
  sell_price=Bid;
  
}*/



   
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


if ( sparam == 45 ) { // 1.42
CloseAllOrdersMix();
OrderCommetssTypeMulti(Symbol());
  buy_price=Ask;
  sell_price=Bid;
}


   
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




//+------------------------------------------------------------------+
//| Check the distance from opening price to activation price        |
//+------------------------------------------------------------------+
bool CheckOrderForFREEZE_LEVEL(int ticket)
  {
//--- get the SYMBOL_TRADE_FREEZE_LEVEL level
   int freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: Cannot modify order"+
                  "  nearer than %d points from the activation price",freeze_level,freeze_level);
     }
//--- select order for working
   if(!OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      //--- failed to select order
      return (false);
     }
//--- get the order data
   double price=OrderOpenPrice();
   double sl=OrderStopLoss();
   double tp=OrderTakeProfit();
   int type=OrderType();
//--- result of checking 
   bool check=false;
//--- check the order type
   switch(type)
     {
      //--- BuyLimit pending order
      case  OP_BUYLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((Ask-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYLIMIT #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-price)/_Point),freeze_level);
         return(check);
        }
      //--- BuyLimit pending order
      case  OP_SELLLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Bid)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLLIMIT #%d cannot be modified: Open-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Bid)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- BuyStop pending order
      case  OP_BUYSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Ask)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYSTOP #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Ask)/_Point),freeze_level);
         return(check);
        }
      //--- SellStop pending order
      case  OP_SELLSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((Bid-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLSTOP #%d cannot be modified: Bid-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-price)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- checking opened Buy order
      case  OP_BUY:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(tp-Bid>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((tp-Bid)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(Bid-sl>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-sl)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
      //--- checking opened Sell order
      case  OP_SELL:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(Ask-tp>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_SELL %d cannot be modified: Ask-TakeProfit=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-tp)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(sl-Ask>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((sl-Ask)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
     }
//--- order did not pass the check
   return (false);
  }
  
//+------------------------------------------------------------------+
//| Checking the new values of levels before order modification      |
//+------------------------------------------------------------------+
bool OrderModifyCheck(int ticket,double price,double sl,double tp)
  {
//--- select order by ticket
   if(OrderSelect(ticket,SELECT_BY_TICKET))
     {
      //--- point size and name of the symbol, for which a pending order was placed
      string symbol=OrderSymbol();
      double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
      //--- check if there are changes in the Open price
      bool PriceOpenChanged=true;
      int type=OrderType();
      if(!(type==OP_BUY || type==OP_SELL))
        {
         PriceOpenChanged=(MathAbs(OrderOpenPrice()-price)>point);
        }
      //--- check if there are changes in the StopLoss level
      bool StopLossChanged=(MathAbs(OrderStopLoss()-sl)>point);
      //--- check if there are changes in the Takeprofit level
      bool TakeProfitChanged=(MathAbs(OrderTakeProfit()-sl)>tp);
      //--- if there are any changes in levels
      if(PriceOpenChanged || StopLossChanged || TakeProfitChanged)
         return(true);  // order can be modified      
      //--- there are no changes in the Open, StopLoss and Takeprofit levels
      else
      //--- notify about the error
         PrintFormat("Order #%d already has levels of Open=%.5f SL=.5f TP=%.5f",
                     ticket,OrderOpenPrice(),OrderStopLoss(),OrderTakeProfit());
     }
//--- came to the end, no changes for the order
   return(false);       // no point in modifying 
  }  
  

bool CheckMoneyForTrade(string symb, double lots,int type)
  {
   double free_margin=AccountFreeMarginCheck(symb,type, lots);
   //-- if there is not enough money
   if(free_margin<0)
     {
      string oper=(type==OP_BUY)? "Buy":"Sell";
      Print("Not enough money for ", oper," ",lots, " ", symb, " Error code=",GetLastError());
      return(false);
     }
   //--- checking successful
   return(true);
  }
  
//+------------------------------------------------------------------+
//| Check the correctness of the order volume                        |
//+------------------------------------------------------------------+
/*
bool CheckVolumeValue(double volume,string &description)
  {
//--- minimal allowed volume for trade operations
   double min_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(volume<min_volume)
     {
      description=StringFormat("Volume is less than the minimal allowed SYMBOL_VOLUME_MIN=%.2f",min_volume);
      return(false);
     }

//--- maximal allowed volume of trade operations
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(volume>max_volume)
     {
      description=StringFormat("Volume is greater than the maximal allowed SYMBOL_VOLUME_MAX=%.2f",max_volume);
      return(false);
     }

//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);

   int ratio=(int)MathRound(volume/volume_step);
   if(MathAbs(ratio*volume_step-volume)>0.0000001)
     {
      description=StringFormat("Volume is not a multiple of the minimal step SYMBOL_VOLUME_STEP=%.2f, the closest correct volume is %.2f",
                               volume_step,ratio*volume_step);
      return(false);
     }
   description="Correct volume value";
   return(true);
  } */   
  
//+------------------------------------------------------------------+
//| Check if another order can be placed                             |
//+------------------------------------------------------------------+
/*
bool IsNewOrderAllowed()
  {
//--- get the number of pending orders allowed on the account
   int max_allowed_orders=(int)AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);

//--- if there is no limitation, return true; you can send an order
   if(max_allowed_orders==0) return(true);

//--- if we passed to this line, then there is a limitation; find out how many orders are already placed
   int orders=OrdersTotal();

//--- return the result of comparing
   return(orders<max_allowed_orders);
  }
  */
  
  /*
  double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);
if(max_volume==0) volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//+------------------------------------------------------------------+
//| Return the size of position on the specified symbol              |
//+------------------------------------------------------------------+
double PositionVolume(string symbol)
  {
//--- try to select position by a symbol
   bool selected=PositionSelect(symbol);
//--- there is a position
   if(selected)
      //--- return volume of the position
      return(PositionGetDouble(POSITION_VOLUME));
   else
     {
      //--- report a failure to select position
      Print(__FUNCTION__," Failed to perform PositionSelect() for symbol ",
            symbol," Error ",GetLastError());
      return(-1);
     }
  }*/
  
  
//+------------------------------------------------------------------+
//|  returns the volume of current pending order by a symbol         |
//+------------------------------------------------------------------+
/*
double   PendingsVolume(string symbol)
  {
   double volume_on_symbol=0;
   ulong ticket;
//---  get the number of all currently placed orders by all symbols
   int all_orders=OrdersTotal();

//--- get over all orders in the loop
   for(int i=0;i<all_orders;i++)
     {
      //--- get the ticket of an order by its position in the list
      if(ticket=OrderGetTicket(i))
        {
         //--- if our symbol is specified in the order, add the volume of this order
         if(symbol==OrderGetString(ORDER_SYMBOL))
            volume_on_symbol+=OrderGetDouble(ORDER_VOLUME_INITIAL);
        }
     }
//--- return the total volume of currently placed pending orders for a specified symbol
   return(volume_on_symbol);
  }*/
  
//+------------------------------------------------------------------+
//| Return the maximum allowed volume for an order on the symbol     |
//+------------------------------------------------------------------+
/*
double NewOrderAllowedVolume(string symbol)
  {
   double allowed_volume=0;
//--- get the limitation on the maximal volume of an order
   double symbol_max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//--- get the limitation on the volume by a symbol
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);

//--- get the volume of the open position by a symbol
   double opened_volume=PositionVolume(symbol);
   if(opened_volume>=0)
     {
      //--- if we have exhausted the volume
      if(max_volume-opened_volume<=0)
         return(0);

      //--- volume of the open position doesn't exceed max_volume
      double orders_volume_on_symbol=PendingsVolume(symbol);
      allowed_volume=max_volume-opened_volume-orders_volume_on_symbol;
      if(allowed_volume>symbol_max_volume) allowed_volume=symbol_max_volume;
     }
   return(allowed_volume);
  }       */
  
   
  //+------------------------------------------------------------------+
//| Perform a Buy                                                    |
//+------------------------------------------------------------------+
bool Buy(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_BUY) ) return false;
  
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUY,NormalizeDouble(lt,2),price,10,sl,tp,"",magic,0,clrNONE);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY;                        // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Perform a Sell                                                   |
//+------------------------------------------------------------------+
bool Sell(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_SELL) ) return false;
  
//--- sell in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELL,NormalizeDouble(lt,2),price,10,sl,tp,"",magic,0,clrNONE);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- sell in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL;                       // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool BuyLimit(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYLIMIT,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_LIMIT;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool BuyStop(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYSTOP,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_STOP;                   // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool SellLimit(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLLIMIT,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_LIMIT;                 // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool SellStop(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), 1,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLSTOP,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_STOP;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Check the correctness of StopLoss and TakeProfit                 |
//+------------------------------------------------------------------+
bool CheckStopLoss_Takeprofit(ENUM_ORDER_TYPE type,double price,double SL,double TP)
  {
//--- get the SYMBOL_TRADE_STOPS_LEVEL level
   int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
   if(stops_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_STOPS_LEVEL=%d: StopLoss and TakeProfit must"+
                  " not be nearer than %d points from the closing price",stops_level,stops_level);
     }
//---
   bool SL_check=false,TP_check=false;
//--- check the order type
   switch(type)
     {
      //--- Buy operation
      case  ORDER_TYPE_BUY:
        {
         //--- check the StopLoss
         SL_check=(Bid-SL>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Bid=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Bid-stops_level*_Point,Bid,stops_level);
         //--- check the TakeProfit
         TP_check=(TP-Bid>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (Bid=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Bid+stops_level*_Point,Bid,stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- Sell operation
      case  ORDER_TYPE_SELL:
        {
         //--- check the StopLoss
         SL_check=(SL-Ask>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (Ask=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Ask+stops_level*_Point,Ask,stops_level);
         //--- check the TakeProfit
         TP_check=(Ask-TP>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Ask=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Ask-stops_level*_Point,Ask,stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyLimit pending order
      case  ORDER_TYPE_BUY_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price+stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellLimit pending order
      case  ORDER_TYPE_SELL_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyStop pending order
      case  ORDER_TYPE_BUY_STOP:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellStop pending order
      case  ORDER_TYPE_SELL_STOP:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
     }

//---
   return false;
  }
  
//+------------------------------------------------------------------+
//| Return the total number of pending orders on the symbol          |
//+------------------------------------------------------------------+
int OrdersTotalPending(string sym)
  {
   int orders=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               orders++;
              }
           }
        }
     }
   return(orders);
  }
//+------------------------------------------------------------------+
//| Return the ticket of a pending order by number                   |
//+------------------------------------------------------------------+
int OrderPendingSelect(int ind,string sym)
  {
   int ticket=0,counter=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               if(counter==ind)
                 {
                  ticket=OrderTicket();
                  break;
                 }
               counter++;
              }
           }
        }
     }

   return(ticket);
  }
//+------------------------------------------------------------------+
//| Return the order type as a string                                |
//+------------------------------------------------------------------+
string GetOrderTypeString(int type)
  {
   switch(type)
     {
      case  OP_BUY:
         return("OP_BUY");       break;
      case  OP_SELL:
         return("OP_SELL");      break;
      case  OP_BUYLIMIT:
         return("OP_BUYLIMIT");  break;
      case  OP_SELLLIMIT:
         return("OP_SELLLIMIT"); break;
      case  OP_BUYSTOP:
         return("OP_BUYSTOP");   break;
      case  OP_SELLSTOP:
         return("OP_SELLSTOP");  break;
     }
//--- unknown order type     
   return("Unknown order type");
  }
//+------------------------------------------------------------------+
  
//+------------------------------------------------------------------+
//| Return the current order activation price                        |
//+------------------------------------------------------------------+
double GetActivationPrice(int ticket)
  {
//---
   double activation_price=0;
//---
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      int type=OrderType();
      //--- orders are activated by the Ask price
      if(type==OP_BUYLIMIT || type==OP_BUYSTOP)
        {
         activation_price=Ask;
        }
      else
      //--- orders are activated by the Bid price
      if(type==OP_SELLLIMIT || type==OP_SELLSTOP)
        {
         activation_price=Bid;
        }
     }
//--- price is not determined for the other orders
   return activation_price;
  }
//+------------------------------------------------------------------+
//| Calculate the nearest opening price for the current moment       |
//+------------------------------------------------------------------+
double GetNearestPrice(int type,int distance)
  {
   double price=0;
//--- iterate over the order types
   switch(type)
     {
      case  OP_SELLSTOP:
         price=Bid-distance*_Point;
         break;
      case  OP_BUYLIMIT:
         price=Ask-distance*_Point;
         break;
      case  OP_SELLLIMIT:
         price=Bid+distance*_Point;
         break;
      case  OP_BUYSTOP:
         price=Ask+distance*_Point;
         break;
      default:
         break;
     }
//--- return the received result
   return(NormalizeDouble(price,_Digits));
  }  