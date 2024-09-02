//+------------------------------------------------------------------+
//|                                                        Mahir.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
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


double buy_price;
double sell_price;

double start_order=false;

double Lot=0.01;
double tp_pip=300;
//double tp_pip=300;

int magic=333;


int distance=600;
double multiplier=3;

double last_buy_lot;
double last_sell_lot;

double buy_orders[50,4];
double sell_orders[50,4];


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  /*
  tp_pip=50;
  distance=100;*/
  
  
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

if ( crap_start == true && crap_order_type == OP_SELL && sell_total == 0 ) crap_start=false;
if ( crap_start == true && crap_order_type == OP_BUY && buy_total == 0 ) crap_start=false;


if ( crap_start == false ) return;

if ( buy_profit >= 1 ) {
CloseAllBuyOrders();
OrderCommetssTypeMulti(Symbol());
crap_start=false;
crap_ticket=-1;
return;
}

if ( sell_profit >= 1 ) {
CloseAllSellOrders();
OrderCommetssTypeMulti(Symbol());
crap_start=false;
crap_ticket=-1;
return;
}




if ( buy_total > 1 ) {

int b_ticket=buy_orders[buy_total,0];
double b_profit=buy_orders[buy_total,1];
double b_lot=buy_orders[buy_total,2];

int bb_ticket=buy_orders[1,0];
double bb_profit=buy_orders[1,1];
double bb_lot=buy_orders[1,2];

if ( b_profit + bb_profit > 0 ) {

OrderClose(b_ticket,b_lot,Bid,0,clrNONE);
OrderClose(bb_ticket,bb_lot,Bid,0,clrNONE);
OrderCommetssTypeMulti(Symbol());
}
}


if ( sell_total > 1 ) {

int s_ticket=sell_orders[sell_total,0];
double s_profit=sell_orders[sell_total,1];
double s_lot=sell_orders[sell_total,2];

int ss_ticket=sell_orders[1,0];
double ss_profit=sell_orders[1,1];
double ss_lot=sell_orders[1,2];

if ( s_profit + ss_profit > 0 ) {

Print(s_ticket,"/",s_profit,"/",s_lot);
Print(ss_ticket,"/",ss_profit,"/",ss_lot);

OrderClose(s_ticket,s_lot,Ask,0,clrNONE);
OrderClose(ss_ticket,ss_lot,Ask,0,clrNONE);
OrderCommetssTypeMulti(Symbol());
}
}


if ( buy_total == 1 ) {


int bb_ticket=buy_orders[1,0];
double bb_profit=buy_orders[1,1];
double bb_lot=buy_orders[1,2];
double bb_open_price=buy_orders[1,3];

buy_price=bb_open_price;

if ( (Bid-bb_open_price)/Point >= distance ) {
OrderClose(bb_ticket,bb_lot,Bid,0,clrNONE);
OrderCommetssTypeMulti(Symbol());
}

}


if ( sell_total == 1 ) {




int ss_ticket=sell_orders[1,0];
double ss_profit=sell_orders[1,1];
double ss_lot=sell_orders[1,2];
double ss_open_price=sell_orders[1,3];

sell_price=ss_open_price;


if ( (ss_open_price-Ask)/Point >= distance ) {
OrderClose(ss_ticket,ss_lot,Ask,0,clrNONE);
OrderCommetssTypeMulti(Symbol());
}

}



if ( buy_total > 1 ) {
/*
int b_ticket=buy_orders[buy_total,0];
double b_profit=buy_orders[buy_total,1];*/
double b_lot=buy_orders[1,2];
double b_open_price=buy_orders[1,3];

buy_price=b_open_price;
last_buy_lot=b_lot;

}

if ( sell_total > 1 ) {
/*
int s_ticket=sell_orders[sell_total,0];
double s_profit=sell_orders[sell_total,1];*/
double s_lot=sell_orders[1,2];
double s_open_price=sell_orders[1,3];

sell_price=s_open_price;
last_sell_lot=s_lot;

}




Comment("Buy Total:",buy_total,"\n Sell Total:",sell_total,"\n Buy Price:",buy_orders[1,3],"\n Sell Price:",sell_orders[1,3],"\n Account Free:",AccountFreeMargin(),"\n Account Balance:",AccountInfoDouble(ACCOUNT_BALANCE),"\n Tp Pip:",tp_pip,"\n Distance:",distance);




if ( start_order == false ) {

int buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,Ask+tp_pip*Point,"BUY",magic,0,clrNONE);
buy_price=Ask;

int sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,Bid-tp_pip*Point,"SELL",magic,0,clrNONE);
sell_price=Bid;

start_order=true;

}


else {
//if ( start_order == true ) {



if ( buy_total == 0 && crap_order_type == OP_BUY) {

int buy_ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,Ask+tp_pip*Point,"BUY",magic,0,clrNONE);
buy_price=Ask;
}


if ( sell_total == 0 && crap_order_type == OP_SELL ) {
int sell_ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,Bid-tp_pip*Point,"SELL",magic,0,clrNONE);
sell_price=Bid;
}

if ( buy_total > 0 && crap_order_type == OP_BUY) {

if ( (buy_price-Ask)/Point >= distance ) {

double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);

if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
//if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;



if ( buy_total <= 2 ) last_buy_lot=0.01; // 1-2-3
//if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total >=3 && buy_total < 6 ) last_buy_lot=0.03; //4-5-6
if ( buy_total >=6 && buy_total < 9 ) last_buy_lot=0.09; //7-8-9
if ( buy_total >= 9 ) last_buy_lot=0.12; //10 >
Lots=last_buy_lot;


// 6 işlemde toplam 12 açıyor
if ( buy_total <= 6 && buy_lot >= 0.12 ) {
double last_slot=sell_orders[buy_total,2];
if ( last_slot < 0.09 ) Lots=0.09;
}

if ( buy_total >= 9 && buy_lot >= 0.39 ) {
double last_slot=buy_orders[buy_total,2];
if ( last_slot < 0.12 ) Lots=0.12;
}






if ( multiplier == 0 ) Lots=Lot;
//Print("Buy",Lots,"xx");
int buy_ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,0,0,0,"BUY",magic,0,clrNONE);
buy_price=Ask;


}

}


if ( sell_total > 0 && crap_order_type == OP_SELL ) {

if ( (Bid-sell_price)/Point >= distance ) {
double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;

if ( sell_total <=2 ) last_sell_lot=0.01;
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total >=3 && sell_total < 6 ) last_sell_lot=0.03;
if ( sell_total >=6 && sell_total < 9 ) last_sell_lot=0.09;
if ( sell_total >= 9 ) last_sell_lot=0.12;
Lots=last_sell_lot;



// 6 işlemde toplam 12 açıyor
if ( sell_total <= 6 && sell_lot >= 0.12 ) {
double last_slot=sell_orders[sell_total,2];
if ( last_slot < 0.09 ) Lots=0.09;
}

if ( sell_total >= 9 && sell_lot >= 0.39 ) {
double last_slot=sell_orders[sell_total,2];
if ( last_slot < 0.12 ) Lots=0.12;
}


if ( multiplier == 0 ) Lots=Lot;
//Print("Sell",Lots,"xx");
int sell_ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,0,0,0,"SELL",magic,0,clrNONE);
sell_price=Bid;

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

Print(sparam);

if ( sparam == 45 ) {

magic=0;
crap_order_type=-1;
crap_order_lot=-1;
crap_order=false;
crap_ticket=-1;
crap_start=false;
crap_takeprofit_calculate=false;
ObjectsDeleteAll(ChartID(),-1,-1);
CloseAllOrders();





}

if ( sparam == 31 ) {

Print("Sell");

crap_order=true;
crap_ticket=0;
crap_order_type=OP_SELL;
crap_takeprofit_calculate=true;
magic=0;


OrderCommetssTypeMulti(Symbol());

}

if ( sparam == 48 ) {

Print("Buy2");

crap_order=true;
crap_ticket=0;
crap_order_type=OP_BUY;
crap_takeprofit_calculate=true;
magic=0;


OrderCommetssTypeMulti(Symbol());

   
   
   
}


if ( sparam == 46 ) {

Print("Control");


   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == 0 && OrderTakeProfit() != 0 )
         {
double p=(OrderOpenPrice()-OrderTakeProfit())/Point;


tp_pip=p;
distance=p*2;

Print("Sell",OrderTicket(),"/",OrderTakeProfit(),"/",p,"/",tp_pip,"/",distance);
Comment("Buy Total:",buy_total,"\n Sell Total:",sell_total,"\n Buy Price:",buy_orders[1,3],"\n Sell Price:",sell_orders[1,3],"\n Account Free:",AccountFreeMargin(),"\n Account Balance:",AccountInfoDouble(ACCOUNT_BALANCE),"\n Tp Pip:",tp_pip,"\n Distance:",distance);


ObjectDelete(ChartID(),"TPS");
ObjectCreate(ChartID(),"TPS",OBJ_HLINE,0,Time[0],OrderOpenPrice()+p*Point);
ObjectSetInteger(ChartID(),"TPS",OBJPROP_COLOR,clrLimeGreen);

ObjectDelete(ChartID(),"DISS");
ObjectCreate(ChartID(),"DISS",OBJ_HLINE,0,Time[0],OrderOpenPrice()+(p*2)*Point);
ObjectSetInteger(ChartID(),"DISS",OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),"DISS",OBJPROP_WIDTH,2);


         }
      }
   }
   
   

   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == 0 && OrderTakeProfit() != 0 )
         {
double p=(OrderTakeProfit()-OrderOpenPrice())/Point;


tp_pip=p;
distance=p*2;

Print("Buy",OrderTicket(),"/",OrderTakeProfit(),"/",p,"/",tp_pip,"/",distance);
Comment("Buy Total:",buy_total,"\n Sell Total:",sell_total,"\n Buy Price:",buy_orders[1,3],"\n Sell Price:",sell_orders[1,3],"\n Account Free:",AccountFreeMargin(),"\n Account Balance:",AccountInfoDouble(ACCOUNT_BALANCE),"\n Tp Pip:",tp_pip,"\n Distance:",distance);


ObjectDelete(ChartID(),"TPB");
ObjectCreate(ChartID(),"TPB",OBJ_HLINE,0,Time[0],OrderOpenPrice()-p*Point);
ObjectSetInteger(ChartID(),"TPB",OBJPROP_COLOR,clrLimeGreen);

ObjectDelete(ChartID(),"DISB");
ObjectCreate(ChartID(),"DISB",OBJ_HLINE,0,Time[0],OrderOpenPrice()-(p*2)*Point);
ObjectSetInteger(ChartID(),"DISB",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"DISS",OBJPROP_WIDTH,2);


         }
      }
   }
   

}

   
  }
//+------------------------------------------------------------------+

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
/////////////////////////////////////////////////////////////////////////////////////////////////////////

int crap_order_type=-1;
double crap_order_lot=-1;
bool crap_order=false;
int crap_ticket=-1;
bool crap_start=false;
bool crap_takeprofit_calculate=false;


bool OrderCommetssTypeMulti(string sym){

//Print("Sym:",sym);


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

//Print(sym,"/",crap_order);

//if ( sym != OrderSymbol() ) continue;





///////////////////////////////////////////////////////////////////////////////////
if ( OrderSymbol() == sym && OrderMagicNumber() == 0 && OrderType() > 1 && crap_ticket != OrderTicket() ) {

//Print(OrderExpiration());

datetime expire=OrderExpiration();
int expire_year=TimeYear(expire);
int expire_hour=TimeHour(expire);
int expire_minute=TimeMinute(expire);

int expire_pip=0;


if ( expire_year == TimeYear(TimeCurrent()) ) {

if ( expire_hour != 0 || expire_minute != 0 ) {

expire_pip=(expire_hour*100)+(expire_minute);

}

int expire_type=-1;
string expire_types="";

if ( OrderType() == OP_BUYSTOP || OrderType() == OP_BUYLIMIT ) {
expire_type=OP_BUY;
expire_types="LONG";
}

if ( OrderType() == OP_SELLSTOP || OrderType() == OP_SELLLIMIT ) {
expire_type=OP_SELL;
expire_types="SHORT";

}

magic=0;
tp_pip=expire_pip;
distance=expire_pip*2;
crap_order_type=expire_type;
crap_order_lot=OrderLots();
//Lot=crap_order_lot;
crap_ticket=OrderTicket();
crap_order=true;

Print(expire_year,"/",expire_hour,"/",expire_minute,"/",expire_pip,"/",expire_types,"/",crap_order_lot);
}

}
////////////////////////////////////////////////////////////////////////////////////////

if ( crap_order == true ) {

/////////////////////////////////////////////////////////////////////////////////////////////////
// BUY
/////////////////////////////////////////////////////////////////////////////////////////////////
if ( OrderType() == OP_BUY && crap_order_type == OrderType() && crap_ticket != -1 && OrderSymbol() == sym) {
buy_price=OrderOpenPrice();
if ( crap_ticket != 0 ) OrderDelete(crap_ticket,clrNONE);
crap_ticket=-1;
crap_order=false;
crap_start=true;
start_order=true;
last_buy_lot=OrderLots();
crap_order_type=OP_BUY;
/////////////////////////////////////////////////////////////////////////
// Live Order TakeProfit Mode
////////////////////////////////////////////////////////////////////////
if ( OrderTakeProfit() != 0 && crap_takeprofit_calculate == true ) {
double crap_pip_fark=(OrderTakeProfit()-OrderOpenPrice());
tp_pip=crap_pip_fark/Point;
distance=tp_pip*2;

// Eğer işlem terse gittiyse o zaman zarar alığı tersde gitme miktarı kadar hesaplanıyor.
if ( (OrderOpenPrice()-OrderClosePrice())/Point > distance ) {
tp_pip=(OrderOpenPrice()-OrderClosePrice())/Point;
distance=tp_pip*2;
}
Alert("BUY");
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),0,0,clrNONE);
}
////////////////////////////////////////////////////////////////////


if ( OrderProfit() < 0 ) {
double crap_pip_fark=OrderOpenPrice()-OrderClosePrice();
if ( distance < crap_pip_fark/Point ) {
tp_pip=crap_pip_fark/Point;
distance=tp_pip*2;
}
}


}
/////////////////////////////////////////////////////////////////////////////////////////////////
// SELL
/////////////////////////////////////////////////////////////////////////////////////////////////
if ( OrderType() == OP_SELL && crap_order_type == OrderType() && crap_ticket != -1 && OrderSymbol() == sym ) {

Print("Sell İşlemei Control");


sell_price=OrderOpenPrice();
if ( crap_ticket != 0 ) OrderDelete(crap_ticket,clrNONE);
crap_ticket=-1;
crap_order=false;
crap_start=true;
start_order=true;
last_sell_lot=OrderLots();
crap_order_type=OP_SELL;
/////////////////////////////////////////////////////////////////////////
// Live Order TakeProfit Mode
////////////////////////////////////////////////////////////////////////
if ( OrderTakeProfit() != 0 && crap_takeprofit_calculate == true ) {

double crap_pip_fark=(OrderOpenPrice()-OrderTakeProfit());
Print("0Sell İşlemei Control",tp_pip,"/",distance,"/ crap_pip_fark=",crap_pip_fark,"/",OrderOpenPrice()-OrderTakeProfit());

tp_pip=(crap_pip_fark/Point);
distance=tp_pip*2;
Print("1Sell İşlemei Control",tp_pip,"/",distance);

if ( (OrderClosePrice()-OrderOpenPrice())/Point > distance ) {
tp_pip=(OrderClosePrice()-OrderOpenPrice())/Point;
distance=tp_pip*2;
}
Alert("SELL");
Print("2Sell İşlemei Control",tp_pip,"/",distance);
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),0,0,clrNONE);
}


if ( OrderProfit() < 0 ) {
double crap_pip_fark=OrderClosePrice()-OrderOpenPrice();
if ( distance < crap_pip_fark/Point ) {
tp_pip=crap_pip_fark/Point;
distance=tp_pip*2;
Print("3Sell İşlemei Control",tp_pip,"/",distance,"/crap_pip_fark=",crap_pip_fark);
}
}


Print("4Sell İşlemei Control",tp_pip,"/",distance);


}



}






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
