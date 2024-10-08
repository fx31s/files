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
// BuySell Ea 08.09.2023 20:38 Tamamlandı.

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
  
  if ( IsTesting() ) {
int buy_ticket=OrderSend(Symbol(),OP_BUY,start_lot,Ask,0,0,0,"UB0",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,start_lot,Bid,0,0,0,"DS0",0,0,clrNONE);
start_price=Bid;
price_level=0;
//bs_buy_total=1;
//bs_sell_total=1;
up_price=Bid;
down_price=Bid;
}


  
  

  
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

bool up_buy_order[11];
bool down_sell_order[11];

bool down_buy_order[11];
bool up_sell_order[11];



void OnTick()
  {
//---

string profit_order_list="";
double profit_usd=5;

//if ( OrderTotal != OrdersTotal() ) {

long n_ordticket;
double n_ordprofit;

bool negative=false;
double negative_profit_usd_min=-0.50;
double last_negative_profit=0;


int bs_buy_total=0;
int bs_sell_total=0;
double bs_buy_profit=0;
double bs_sell_profit=0;


for ( int i=0;i<11;i++) {
up_buy_order[i]=false;
up_sell_order[i]=false;
down_buy_order[i]=false;
down_sell_order[i]=false;
}



   //for (int h=OrdersTotal();h>=0;h--)
   for (int h=0;h<=OrdersTotal()-1;h++)
   {
   
   

   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() ) {
   
   //Print(OrderTicket());

if ( start_price == -1 || OrderTotal != OrdersTotal() ) {   
   
   if ( StringFind(OrderComment(),"UB0",0) != -1 ){up_buy_order[0]=true;}
   if ( StringFind(OrderComment(),"DS0",0) != -1 ){down_sell_order[0]=true;
   start_price=OrderOpenPrice();
   }

   if ( StringFind(OrderComment(),"UB1",0) != -1 && StringFind(OrderComment(),"UB10",0) == -1  ){up_buy_order[1]=true;}
   if ( StringFind(OrderComment(),"US1",0) != -1 && StringFind(OrderComment(),"US10",0) == -1  ){up_sell_order[1]=true;}

   if ( StringFind(OrderComment(),"UB2",0) != -1 ){up_buy_order[2]=true;}
   if ( StringFind(OrderComment(),"US2",0) != -1 ){up_sell_order[2]=true;}
   
   if ( StringFind(OrderComment(),"UB3",0) != -1 ){up_buy_order[3]=true;}
   if ( StringFind(OrderComment(),"US3",0) != -1 ){up_sell_order[3]=true;}
   
   if ( StringFind(OrderComment(),"UB4",0) != -1 ){up_buy_order[4]=true;}
   if ( StringFind(OrderComment(),"US4",0) != -1 ){up_sell_order[4]=true;}
   
   if ( StringFind(OrderComment(),"UB5",0) != -1 ){up_buy_order[5]=true;}
   if ( StringFind(OrderComment(),"US5",0) != -1 ){up_sell_order[5]=true;}   
      
   if ( StringFind(OrderComment(),"UB6",0) != -1 ){up_buy_order[6]=true;}
   if ( StringFind(OrderComment(),"US6",0) != -1 ){up_sell_order[6]=true;}
   
   if ( StringFind(OrderComment(),"UB7",0) != -1 ){up_buy_order[7]=true;}
   if ( StringFind(OrderComment(),"US7",0) != -1 ){up_sell_order[7]=true;}
   
   if ( StringFind(OrderComment(),"UB8",0) != -1 ){up_buy_order[8]=true;}
   if ( StringFind(OrderComment(),"US8",0) != -1 ){up_sell_order[8]=true;}
   
   if ( StringFind(OrderComment(),"UB9",0) != -1 ){up_buy_order[9]=true;}
   if ( StringFind(OrderComment(),"US9",0) != -1 ){up_sell_order[9]=true;}
   
   if ( StringFind(OrderComment(),"UB10",0) != -1 ){up_buy_order[10]=true;}
   if ( StringFind(OrderComment(),"US10",0) != -1 ){up_sell_order[10]=true;}
            
   
   

   if ( StringFind(OrderComment(),"DB1",0) != -1 && StringFind(OrderComment(),"DB10",0) == -1  ){down_buy_order[1]=true;}
   if ( StringFind(OrderComment(),"DS1",0) != -1 && StringFind(OrderComment(),"DS10",0) == -1 ){down_sell_order[1]=true;}

   if ( StringFind(OrderComment(),"DB2",0) != -1 ){down_buy_order[2]=true;}
   if ( StringFind(OrderComment(),"DS2",0) != -1 ){down_sell_order[2]=true;}
   
   if ( StringFind(OrderComment(),"DB3",0) != -1 ){down_buy_order[3]=true;}
   if ( StringFind(OrderComment(),"DS3",0) != -1 ){down_sell_order[3]=true;}
     
   if ( StringFind(OrderComment(),"DB4",0) != -1 ){down_buy_order[4]=true;}
   if ( StringFind(OrderComment(),"DS4",0) != -1 ){down_sell_order[4]=true;}
   
   if ( StringFind(OrderComment(),"DB5",0) != -1 ){down_buy_order[5]=true;}
   if ( StringFind(OrderComment(),"DS5",0) != -1 ){down_sell_order[5]=true;}
   
   if ( StringFind(OrderComment(),"DB6",0) != -1 ){down_buy_order[6]=true;}
   if ( StringFind(OrderComment(),"DS6",0) != -1 ){down_sell_order[6]=true;}
   
   if ( StringFind(OrderComment(),"DB7",0) != -1 ){down_buy_order[7]=true;}
   if ( StringFind(OrderComment(),"DS7",0) != -1 ){down_sell_order[7]=true;}
   
   if ( StringFind(OrderComment(),"DB8",0) != -1 ){down_buy_order[8]=true;}
   if ( StringFind(OrderComment(),"DS8",0) != -1 ){down_sell_order[8]=true;}
   
   if ( StringFind(OrderComment(),"DB9",0) != -1 ){down_buy_order[9]=true;}
   if ( StringFind(OrderComment(),"DS9",0) != -1 ){down_sell_order[9]=true;}
   
   if ( StringFind(OrderComment(),"DB10",0) != -1 ){down_buy_order[10]=true;}
   if ( StringFind(OrderComment(),"DS10",0) != -1 ){down_sell_order[10]=true;}                     
   
}   
      
      
   
   if ( OrderType() == OP_BUY ) bs_buy_total=bs_buy_total+1;
   if ( OrderType() == OP_SELL ) bs_sell_total=bs_sell_total+1;
   
   if ( OrderType() == OP_BUY ) bs_buy_profit=bs_buy_profit+OrderProfit();
   if ( OrderType() == OP_SELL ) bs_sell_profit=bs_sell_profit+OrderProfit();
   
   
   if ( negative == false ) {
   if ( OrderProfit() <= negative_profit_usd_min ) {   
   
   ///if (  OrderProfit() < last_negative_profit ) {   
   ///last_negative_profit=OrderProfit();
   
   //Print(h,"/",OrderTicket(),"/",OrderProfit());
   //Comment("OrderTicket:",OrderTicket(),"/ OrderProfit:",OrderProfit());
   
   negative=true;      
   n_ordticket=OrderTicket();
   n_ordprofit=OrderProfit();     
   profit_order_list=","+OrderTicket();     
   
   ///}   
   }
   }
   }
   }

   //}
   

if ( OrderTotal != OrdersTotal() ) {
   
if ( start_price != -1 ) {

for ( int i=0;i<11;i++) {

if ( i >= 1 ) {

double order_price=start_price+((price_distance*i)*Point);

if ( up_buy_order[i]==false && Ask < order_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,start_lot,start_price+((price_distance*i)*Point),0,0,0,"UB"+i,0,0,clrNONE);
if ( up_buy_order[i]==false && Ask > order_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYLIMIT,start_lot,start_price+((price_distance*i)*Point),0,0,0,"UB"+i,0,0,clrNONE);


if ( up_sell_order[i]==false && Bid < order_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLLIMIT,start_lot,start_price+((price_distance*i)*Point),0,0,0,"US"+i,0,0,clrNONE);
if ( up_sell_order[i]==false && Bid > order_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLSTOP,start_lot,start_price+((price_distance*i)*Point),0,0,0,"US"+i,0,0,clrNONE);


order_price=start_price-((price_distance*i)*Point);

if ( down_buy_order[i]==false && Ask < order_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,start_lot,start_price-((price_distance*i)*Point),0,0,0,"DB"+i,0,0,clrNONE);
if ( down_buy_order[i]==false && Ask > order_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYLIMIT,start_lot,start_price-((price_distance*i)*Point),0,0,0,"DB"+i,0,0,clrNONE);

if ( down_sell_order[i]==false && Bid < order_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLLIMIT,start_lot,start_price-((price_distance*i)*Point),0,0,0,"DS"+i,0,0,clrNONE);
if ( down_sell_order[i]==false && Bid > order_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLSTOP,start_lot,start_price-((price_distance*i)*Point),0,0,0,"DS"+i,0,0,clrNONE);



}

if ( i == 0 ) {

if ( up_buy_order[i]==false && Ask < start_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,start_lot,start_price,0,0,0,"UB"+i,0,0,clrNONE);
if ( down_sell_order[i]==false && Bid < start_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLLIMIT,start_lot,start_price,0,0,0,"DS"+i,0,0,clrNONE);

if ( up_buy_order[i]==false && Bid > start_price ) int buy_ticket=OrderSend(Symbol(),OP_BUYLIMIT,start_lot,start_price,0,0,0,"UB"+i,0,0,clrNONE);
if ( down_sell_order[i]==false && Bid > start_price ) int sell_ticket=OrderSend(Symbol(),OP_SELLSTOP,start_lot,start_price,0,0,0,"DS"+i,0,0,clrNONE);

}

}





}


OrderTotal = OrdersTotal();

}

   
   
/*   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( buy_profit >= profit_usd && bs_buy_total == 1 && bs_sell_total == 0 ) {
CloseAllBuyOrders();
bs_buy_total=0;
}


if ( sell_profit >= profit_usd && bs_buy_total == 0 && bs_sell_total == 1 ) {
CloseAllSellOrders();
bs_sell_total=0;
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( bs_buy_total == 0 && bs_sell_total == 0 ) {
start_price=-1;
start_lot=0.01;
price_level=0;
price_distance=250;
down_price=-1;
up_price=-1;
}
/////////////////////////////////////////////////////////////////////////////////////////////
*/



   
   
   if ( profit_order_list != "" ) negative=true;
   
   
   double profit_target_usd=0;
   
   if ( negative == true ) {

   bool profit_target=false;
   profit_target_usd=0;
   //double profit_usd=1;
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

   
   Comment("OrderTicket:",n_ordticket,"\ Order Profit:",n_ordprofit,"\nProfit Target Usd:",profit_target_usd,"\n Profit:",profit_result,"\n List:",profit_order_list,"\n Start Price:",start_price);
   

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/*
if ( start_price == -1 ) {
int buy_ticket=OrderSend(Symbol(),OP_BUY,start_lot,Ask,0,0,0,"BUY",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,start_lot,Bid,0,0,0,"SELL",0,0,clrNONE);
start_price=Bid;
price_level=0;
bs_buy_total=1;
bs_sell_total=1;
up_price=Bid;
down_price=Bid;
}

if ( start_price != -1 && (down_price-Bid)/Point >= price_distance ) {

start_price=Bid;
down_price=Bid;
price_level=price_level+1;
if ( price_level < 3 ) start_lot=0.01;
if ( price_level >= 3 && price_level < 6 ) start_lot=0.02;
if ( price_level >= 6 ) start_lot=0.03;
/*
if ( price_level >= 2 ) price_distance=500;
if ( price_level >= 5 ) price_distance=1000;
*/
/*
int buy_ticket=OrderSend(Symbol(),OP_BUY,start_lot,Ask,0,0,0,"BUY",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,start_lot,Bid,0,0,0,"SELL",0,0,clrNONE);

}

if ( start_price != -1 && (Bid-up_price)/Point >= price_distance ) {
start_price=Bid;
up_price=Bid;
price_level=price_level+1;
if ( price_level < 3 ) start_lot=0.01;
if ( price_level >= 3 && price_level < 6 ) start_lot=0.02;
if ( price_level >= 6 ) start_lot=0.03;
/*
if ( price_level >= 2 ) price_distance=500;
if ( price_level >= 5 ) price_distance=1000;
*/
//int buy_ticket=OrderSend(Symbol(),OP_BUY,start_lot,Ask,0,0,0,"BUY",0,0,clrNONE);
//int sell_ticket=OrderSend(Symbol(),OP_SELL,start_lot,Bid,0,0,0,"SELL",0,0,clrNONE);
//}










   
  }
  
  
double start_price=-1;
//double start_price=1922.30;
double start_lot=0.30;
double price_level=0;
int price_distance=500;
double down_price=-1;
double up_price=-1;
  
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

start_price=-1;

int buy_ticket=OrderSend(Symbol(),OP_BUY,start_lot,Ask,0,0,0,"UB0",0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELL,start_lot,Bid,0,0,0,"DS0",0,0,clrNONE);
start_price=Bid;
price_level=0;
//bs_buy_total=1;
//bs_sell_total=1;
up_price=Bid;
down_price=Bid;


for ( int i=1;i<3;i++) {

up_buy_order[i]=true;
up_sell_order[i]=true;

int buy_ticket=OrderSend(Symbol(),OP_BUYSTOP,start_lot,Bid+((price_distance*i)*Point),0,0,0,"UB"+i,0,0,clrNONE);
int sell_ticket=OrderSend(Symbol(),OP_SELLLIMIT,start_lot,Bid+((price_distance*i)*Point),0,0,0,"US"+i,0,0,clrNONE);

down_buy_order[i]=true;
down_sell_order[i]=true;

int buys_ticket=OrderSend(Symbol(),OP_BUYLIMIT,start_lot,Bid-((price_distance*i)*Point),0,0,0,"DB"+i,0,0,clrNONE);
int sells_ticket=OrderSend(Symbol(),OP_SELLSTOP,start_lot,Bid-((price_distance*i)*Point),0,0,0,"DS"+i,0,0,clrNONE);

}





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
