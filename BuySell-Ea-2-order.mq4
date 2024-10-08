//+------------------------------------------------------------------+
//|                                                   BuySell-Ea.mq4 |
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
   int magic=0;
   

   double high_price=-1;
   double low_price=-1;
   double sell_price=-1;
   double buy_price=-1;
   
   double multiplier=2;
   /*
   double profit=5;
   int distance=250;*/
   
   double profit=5;
   int distance=1;
   
      
   input int distance_multiplier=3; 
   input int pump_bar=3;
   
   datetime buy_time;
   datetime sell_time;


int OrderTotal=0;





int OnInit()
  {
  
  OrderTotal=OrdersTotal();
  
  
  ObjectsDeleteAll();
  
  
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

bool fiyat_list=false;

void OnTick()
  {
//---

string profit_order_list="";


if ( OrderTotal != OrdersTotal() ) {
OrderTotal = OrdersTotal();
//ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
fiyat_list=false;


             int obj_total=ObjectsTotal(ChartID(),-1,-1)-1;
    for(int i=obj_total;i>=0;i--)
        {
        string last_select_object = ObjectName(ChartID(),i);
        if ( StringFind(last_select_object,"ROrder",0) != -1 && ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE) == OBJ_RECTANGLE ) {
        ObjectDelete(ChartID(),last_select_object);
        }
        }
}




long n_ordticket;
double n_ordprofit;
double n_orderopenprice;
double n_ordertotal=0;
double n_orderlot=0.01;

bool negative=false;
double negative_profit_usd_min=-0.50;
double last_negative_profit=0;


   //for (int h=OrdersTotal();h>=0;h--)
   for (int h=0;h<=OrdersTotal()-1;h++)
   {

   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() ) {
   
   if ( fiyat_list == false ) {

   if ( OrderType() == OP_BUY ) ObjectCreate(ChartID(),"ROrder"+OrderTicket(),OBJ_RECTANGLE,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+10*PeriodSeconds(),OrderOpenPrice()+10*Point);
   if ( OrderType() == OP_SELL ) ObjectCreate(ChartID(),"ROrder"+OrderTicket(),OBJ_RECTANGLE,0,Time[WindowFirstVisibleBar()]+10*PeriodSeconds(),OrderOpenPrice(),Time[WindowFirstVisibleBar()]+20*PeriodSeconds(),OrderOpenPrice()+10*Point);
   if ( OrderType() == OP_BUY ) ObjectSetInteger(ChartID(),"ROrder"+OrderTicket(),OBJPROP_COLOR,clrBlue);
   if ( OrderType() == OP_SELL ) ObjectSetInteger(ChartID(),"ROrder"+OrderTicket(),OBJPROP_COLOR,clrRed);
   
   
   
   }
   
   
   
   
   
   
   
   
   n_ordertotal=n_ordertotal+1;
   n_orderopenprice=OrderOpenPrice();
   n_orderlot=OrderLots();
   
   
   if ( negative == false ) {
   if ( OrderProfit() <= negative_profit_usd_min ) {   
   
   if (  OrderProfit() < last_negative_profit ) {   
   last_negative_profit=OrderProfit();
   }
   
   //Print(h,"/",OrderTicket(),"/",OrderProfit());
   //Comment("OrderTicket:",OrderTicket(),"/ OrderProfit:",OrderProfit());
   negative=true;   
   n_ordticket=OrderTicket();
   n_ordprofit=OrderProfit();     
   profit_order_list=","+OrderTicket();   
   
   if ( ObjectFind(ChartID(),"NORDER") == -1 ) {
   ObjectCreate(ChartID(),"NORDER",OBJ_HLINE,0,Time[0],OrderOpenPrice());
   ObjectSetInteger(ChartID(),"NORDER",OBJPROP_COLOR,clrOrange);
   ObjectSetInteger(ChartID(),"NORDER",OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"NORDER",OBJPROP_BACK,true);
   ObjectSetString(ChartID(),"NORDER",OBJPROP_TOOLTIP,OrderTicket());
   } else {
   string nticket=ObjectGetString(ChartID(),"NORDER",OBJPROP_TOOLTIP);
   if ( nticket != IntegerToString(n_ordticket) ) {
   ObjectDelete(ChartID(),"NORDER");
   }
   
   }
   


     
   }
   }
   }
   }
   
   
   fiyat_list=true;
   
   
   
   
   //}
   

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// AutoOrder
////////////////////////////////////////////////////////////////////////////////////////////////////////   
   if ( n_ordertotal == 1 ) {
   
   if ( MathAbs(n_orderopenprice-Bid)/Point >= 250 && StringFind(Symbol(),"XAU",0) == -1  ) {
   
int buy_ticket=OrderSend(Symbol(),OP_BUY,n_orderlot,Ask,0,0,0,"BUY",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,n_orderlot,Bid,0,0,0,"SELL",0,0,clrNONE);
   
   }   
   
   }

   if ( n_ordertotal == 1 ) {
   
   if ( MathAbs(n_orderopenprice-Bid)/Point >= 2500 && StringFind(Symbol(),"XAU",0) != -1  ) {
   
int buy_ticket=OrderSend(Symbol(),OP_BUY,n_orderlot,Ask,0,0,0,"BUY",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,n_orderlot,Bid,0,0,0,"SELL",0,0,clrNONE);
   
   }   
   
   }
/////////////////////////////////////////////////////////////////////////////////////////////////////////   
  
  
     
   
   
   
   
   
   
   
   double profit_target_usd=0;
   
   if ( negative == true ) {

   bool profit_target=false;
   profit_target_usd=0;
   double profit_usd=1;
   //double profit_usd=0.50;
   //double profit_usd_min=0.20;
   double profit_usd_min=0.50;
   

   for (int h=OrdersTotal();h>=0;h--)
   //for (int h=0;h<=OrdersTotal()-1;h++)
   {
   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() ) {
   if ( profit_target == false ) {
   if ( OrderProfit() >= profit_usd_min ) {  
   profit_target_usd=profit_target_usd+OrderProfit(); 
   /*
   if ( profit_order_list == "" ) {profit_order_list=","+OrderTicket();} else {
   profit_order_list=profit_order_list+","+OrderTicket(); 
   }*/
   profit_order_list=profit_order_list+","+OrderTicket(); 
        
   if ( profit_target_usd-MathAbs(n_ordprofit) >= profit_usd ) { 
   profit_target=true;  
   }           
   
   }
   }
   }
   }
   
   
   if ( profit_target == true && profit_target_usd-MathAbs(n_ordprofit) >= profit_usd ) {

   for (int h=OrdersTotal();h>=0;h--)
   //for (int h=0;h<=OrdersTotal()-1;h++)
   {
   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() ) {
//if ( OrderProfit() >= profit_usd_min ) { 
if ( StringFind(profit_order_list,","+OrderTicket(),0) != -1 ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
}          
   }
   
   //}
  
   }
   profit_order_list="";
   }
   
   
   //}   
   
   
   
   }
   
   
   
   

double profit_result=profit_target_usd-MathAbs(n_ordprofit);   
   /*
   OrderCommetssTypeMulti(Symbol());
   Comment("BuyProfit:",DoubleToString(buy_profit,2),"$ / Sell Profit:",DoubleToString(sell_profit,2)+"$\n OrderTicket:",n_ordticket,"\ Order Profit:",n_ordprofit,"\nProfit Target Usd:",profit_target_usd,"\n Profit:",profit_result);
*/

   
   Comment("OrderTicket:",n_ordticket,"\ Order Profit:",n_ordprofit,"\nProfit Target Usd:",profit_target_usd,"\n Profit:",profit_result,"\n List:",profit_order_list);
   

   
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


if ( sparam == 45 ) {

int buy_ticket=OrderSend(Symbol(),OP_BUY,0.01,Ask,0,0,0,"BUY",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,0.01,Bid,0,0,0,"SELL",0,0,clrNONE);

}
   
  }
//+------------------------------------------------------------------+




void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() //&& OrderMagicNumber() == magic
          )
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
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magic
          )
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
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magic
          )
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

//if ( OrderMagicNumber() != magic ) continue;

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
