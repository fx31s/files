//+------------------------------------------------------------------+
//|                                                  Sessiongale.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "31.00"
#property strict

double Lot;

int magic=31;

string sym=Symbol();


double prices[17];
string pricen[17];


bool free_mode=false;



double Ortalama;
   //string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   string symi=Symbol();
   ENUM_TIMEFRAMES peri=Period();   
   

double Openi(int shifti) {
return iOpen(symi,peri,shifti);
}

double Closei(int shifti) {
return iClose(symi,peri,shifti);
}

double Highi(int shifti) {
return iHigh(symi,peri,shifti);
}

double Lowi(int shifti) {
return iLow(symi,peri,shifti);
}

double Timei(int shifti) {
return iTime(symi,peri,shifti);
}


datetime ty_start_time;
datetime ty_end_time;

datetime lnd_start_time;
datetime lnd_end_time;

bool london_start=false;
bool london_end=false;
bool tokyo_start=false;
bool tokyo_end=false;


bool ea_start=false;


double distance=0;


int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;

bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;


double margin=AccountMargin();


double bar_ortalama;



int active_magic_buy=magic;
int active_magic_sell=magic;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;


int start_day=-1;

int OrderTotal=OrdersTotal();

int OrderHisTotal=OrdersHistoryTotal();

// Güvenli Mod
//Sınır 414
//Saat Sınırı 14:00

bool safe_mode=true; // 414 - 886
datetime limit_time;

bool buy_risk_order=false;
bool sell_risk_order=false;
bool risk=false;

bool hedge_system=true;
bool lock_order=false;
bool lock_order_sell=false;
bool lock_order_buy=false;

bool lock_order_buy_total=0;
bool lock_order_sell_total=0;

double hedge_buy_profit=0;
double hedge_sell_profit=0;


int order_limit=200;
// margin_level
// haber durumu

int min_distance=100; // Gold
//int min_distance=50;

bool martingale=false; // Martingale ( Kademe )
double multiplier=2; // Multiplier ( Çarpan )
double last_buy_lot;
double last_sell_lot;

double max_loss_profit=0;

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  Lot=0.02;
  Lot=0.05;
  
london_start=false;
london_end=false;
tokyo_start=false;
tokyo_end=false;
ea_start=false;

  symi=Symbol();
  sym=Symbol();
  //Alert(sym);
  
  
  
//--- create timer
   //EventSetTimer(60);
   ObjectsDeleteAll();
   //SessionOrder("Tokyo","02:00","11:00"); // Limit 13:00 / 14
   //SessionOrder("Tokyo","09:00","15:25",0); // Limit 20:00 / 21 ( Lnd 19 kapanıyor = 18 ) 
   
   //bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
   
   
   

////////////////////////////////////////////////////////////////////////
// Range Alanı Genişlik Kontrolü
////////////////////////////////////////////////////////////////////////
/*
double bar_ortalama=BarOrtalama(1,300,Symbol(),Period());

double range=high_price-low_price;

double range_oran=DivZero(range,bar_ortalama);

//Alert("Range ORan:",range_oran,"/",bar_ortalama);



if ( range_oran >= 10  ) {
// Range Genişliği İyi
} else {
tokyo_end=true;
return;
}*/
/////////////////////////////////////////////////////////////////////////

   
   
   
   /*
   for(int i=0;i<=15;i++){
   
   if ( i == 15 ) {   
   if ( Bid > prices[i] ) {
   Print("Fiyat Üst Sınır Dışında");
   }
   }

   if ( i == 0 ) {   
   if ( Bid < prices[i] ) {
   Print("Fiyat Alt Sınır Dışında");
   }
   }
      
   if ( Bid <= prices[15] && Bid >= prices[0] ) {
   
   if ( Bid <= prices[1] && Bid >= prices[0] ) {
   Print("Fiyat End Dipte");
   }
   

   if ( Bid <= prices[15] && Bid >= prices[14] ) {
   Print("Fiyat End Üstte");
   }

   if ( Bid <= prices[14] && Bid >= prices[1] ) {
   
   
   if ( Bid <= prices[i] && Bid >= prices[i-1] ) {
   Print("Fiyat Aralıkta");
   Print(pricen[i]," ile ",pricen[i-1],"arasında");
   
   string cmt=pricen[i+1];
   int ticket=OrderSend(sym,OP_BUYSTOP,Lot,prices[i],0,0,prices[i+1],cmt,magic,0,clrNONE);

   cmt=pricen[i-1];
   ticket=OrderSend(sym,OP_SELLSTOP,Lot,prices[i-1],0,0,prices[i-2],cmt,magic,0,clrNONE);
   
      
   
   }
   
   
   }
   
         
   
   
   }
   
   
   //if ( MarketInfo(sym,MODE_BID) >=  
   //Print(pricen[i],"=",prices[i]);
   
   
   
   }
   */
   
   //Comment("Distance:",distance/Point);
   bool order_result=OrderCommetssTypeMulti(Symbol());
   
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

double buy_price;
double sell_price;

void OnTick()
  {
//---



/////////////////////////////////////////////////////////////////////////
if ( start_day != int(TimeDay(TimeCurrent())) ) {
ObjectsDeleteAll();
london_start=false;
london_end=false;
tokyo_start=false;
tokyo_end=false;
ea_start=false;

   bar_ortalama=BarOrtalama(1,300,Symbol(),Period());   
start_day=int(TimeDay(TimeCurrent()));

}

//10 da başlar
//14 de biter
// range genişlemeye 12 kadar devam eder.

// SessionOrder    Range Start    Range End Order Finish Order Start
   // Tokyo
   SessionOrder("Tokyo","02:00","11:00","13:00","09:00",0); // Limit 14:00 
   //SessionOrder("Tokyo","02:00","11:00","13:00","11:00",0); // Limit 14:00 

   // NewYork
  // SessionOrder("Tokyo","09:00","15:25","20:00","14:00",0); // Limit 20:00 / 21 ( Lnd 19 kapanıyor = 18 )    
   

   // Exness Tokyo
   //SessionOrder("Tokyo","00:00","9:00","11:00","07:00",0); // Limit 14:00  // Exness     
   // Exness Newyork
   // SessionOrder("Tokyo","07:00","13:25","18:00","12:00",0); // Limit 20:00 / 21 ( Lnd 19 kapanıyor = 18 )    


/////////////////////////////////////////////////////////////////////////
bool order_result=OrderCommetssTypeMulti(Symbol());

if ( OrdersTotal() != OrderTotal ) {
OrderTotal=OrdersTotal();
AvarageSystem(magic);
}

/*
if ( AccountMargin() != margin ) {
margin=AccountMargin();
AvarageSystem(magic);
}*/


int distance_pip=(distance/2)/Point;   

if ( distance_pip < (bar_ortalama/Point)*2 ) {
distance_pip=(bar_ortalama/Point)*2;
}


int askbid=(MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID))/Point;

if ( distance_pip < askbid*3 ) {
distance_pip=askbid*3;
}

///////////////////////////////////////
if ( distance_pip < min_distance ) {
distance_pip=min_distance;
}
//////////////////////////////////////


Comment("SesEA \n buy profit:",buy_profit,"\n sell profit:",sell_profit,"\n Total:",buy_profit+sell_profit,"\nSym:",sym,"\nPer:",per,"\nLot:",Lot
,"\n Buy Total:",buy_total,"\n Sell Total:",sell_total,"\n Distance:",distance/Point
,"\n Distance%50:",(distance/2)/Point
,"\n Distance Pip:",distance_pip
,"\n bar_ortalama",bar_ortalama
,"\n last_buy_avarage:",last_avarage_buy
,"\n last_sell_avarage:",last_avarage_sell
,"\n askbid:",(MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID))/Point
,"\n Profit:",AccountProfit()
,"\n buy_profit+sell_profit",buy_profit+sell_profit

);   


      
      
// 886
double limit_high=prices[15];
double limit_low=prices[0];  

// 414
if ( safe_mode == true ) {
limit_high=prices[13];
limit_low=prices[2]; 
}
    

//distance=distance/2;


/*
  string limit_time="21:00"; 
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent()))+" "+limit_time;
  datetime some_time = StringToTime(yenitarih);*/
  
////////////////////////////////////////////////////////////////////////////////////////////  
// First Order
////////////////////////////////////////////////////////////////////////////////////////////
if ( TimeCurrent() >= ea_start_time && ea_start == true ) {

if ( Bid < limit_high  && Bid > limit_low && TimeCurrent() < limit_time  ) {

//Print("Distance:",distance);

/////////////////////////////////////////////////////////////////////////////////////
//if ( buy_total == 0 && Ask < prices[5] && lock_order_buy == false) {
if ( buy_total == 0 && Ask < prices[6] && lock_order_buy == false) {
string cmt="BUY-0";
int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,Ask+distance_pip*Point,cmt,magic,0,clrNONE);
//int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE);
buy_price=Ask;
buy_risk_order=false;

}      
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
//if (sell_total == 0 && Bid > prices[10] && lock_order_sell == false) {
if (sell_total == 0 && Bid > prices[9] && lock_order_sell == false) {
string cmt="SELL-0";
int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,Bid-distance_pip*Point,cmt,magic,0,clrNONE);
//int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
sell_price=Bid;
sell_risk_order=false;
}      
/////////////////////////////////////////////////////////////////////////////////////

}
}
///////////////////////////////////////////////////////////////////////////////////////////


/*
/////////////////////////////////////////////////////////////////////////////////////
// Matingale
/////////////////////////////////////////////////////////////////////////////////////
if ( buy_total > 0 && (buy_price-Ask) >= distance_pip*Point ) {
string cmt="BUY-"+(buy_total+1);
if ( buy_total <= 2 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
if ( buy_total > 2 && buy_total <= 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( buy_total > 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*3,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
buy_price=Ask;
}


if ( sell_total > 0 && (Bid-sell_price) >= distance_pip*Point ) {
string cmt="SELL-"+(sell_total+1);
if ( sell_total <= 2 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
if ( sell_total > 2 && sell_total <= 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( sell_total > 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*3,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
sell_price=Bid;
}
//////////////////////////////////////////////////////////////////////////////////////
*/



/*
///////////////////////////////////////////////////////////////////////////////////////////
if ( buy_total == 0 && sell_total > 1 ) {
string cmt="BUY-0";
int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,Ask+distance_pip*Point,cmt,magic,0,clrNONE);
buy_price=Ask;
buy_risk_order=false;

}  

if (sell_total == 0 && buy_total > 1 ) {
string cmt="SELL-0";
int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,Bid-distance_pip*Point,cmt,magic,0,clrNONE);
sell_price=Bid;
sell_risk_order=false;
}   
/////////////////////////////////////////////////////////////////////////////////////////
*/




/////////////////////////////////////////////////////////////////////////////////////
// Matingale
/////////////////////////////////////////////////////////////////////////////////////
if ( buy_total > 0 && (buy_price-Ask) >= distance_pip*Point && buy_total < order_limit && Bid > prices[0] && lock_order_buy == false ) {


if ( risk == false ) {
string cmt="BUY-"+(buy_total+1);
if ( martingale == false ) {
if ( buy_total <= 2 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
if ( buy_total > 2 && buy_total <= 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( buy_total > 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*3,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
} else {
double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(buy_total*multiplier),2);

if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
//if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;

if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_BUY,Lots,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
}


buy_price=Ask;

} else { 
//////////////////////////////////////////////////////////////////////////////////////////
  string risk_time = "16:30";
  //string risk_time = "14:30";// exness
  int day_left=0;
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_time;
  datetime reserval_time = StringToTime(yenitarih);


  string risk_end_time = "18:30";
  //string risk_end_time = "16:30";// exness
  //int day_left=0;
  yenitarih = TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_end_time;
  datetime reserval_end_time = StringToTime(yenitarih);
  


  string risk_time_am = "11:00";
  //string risk_time_am = "09:00";// exness
  //day_left=0;
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_time_am;
  datetime reserval_time_am = StringToTime(yenitarih);


  string risk_end_time_am = "13:00";
  //string risk_end_time_am = "11:00";// exness
  //int day_left=0;
  yenitarih = TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_end_time_am;
  datetime reserval_end_time_am = StringToTime(yenitarih);
  
  
    
///////////////////////////////////////////////////////////////////////////////////
// Clean All Buy Order ToDay
///////////////////////////////////////////////////////////////////////////////////
//if ( Ask <= prices[2] && TimeCurrent() >= reserval_time && buy_risk_order == false  ) { // 414
//if ( Ask <= prices[1] && TimeCurrent() >= reserval_time && TimeCurrent() <= reserval_end_time && buy_risk_order == false  && buy_total > 5) { // 618
if ( Ask <= prices[1] && ((TimeCurrent() >= reserval_time && TimeCurrent() <= reserval_end_time) || (TimeCurrent() >= reserval_time_am && TimeCurrent() <= reserval_end_time_am) ) && buy_risk_order == false  && buy_total > 5) { // 618
//if ( Ask <= prices[0] && TimeCurrent() >= reserval_time && buy_risk_order == false  ) { // 886
//string cmt="BUYRISK-"+buy_lot*2;
string cmt="RISK";
buy_risk_order=true;
int ticket=OrderSend(sym,OP_BUY,buy_lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
} else {
//////////////////////////////////////////////////////////////////////////////////////////

string cmt="BUY-"+(buy_total+1);
if ( buy_total <= 2 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
if ( buy_total > 2 && buy_total <= 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( buy_total > 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*3,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
buy_price=Ask;

}
}
}


if ( sell_total > 0 && (Bid-sell_price) >= distance_pip*Point  && sell_total < order_limit && Ask < prices[15] && lock_order_sell == false ) {

if ( risk == false ) {
string cmt="SELL-"+(sell_total+1);
if ( martingale == false ) {
if ( sell_total <= 2 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
if ( sell_total > 2 && sell_total <= 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( sell_total > 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*3,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
} else {
double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;

if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_SELL,Lots,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
}


sell_price=Bid; 


} else {

///////////////////////////////////////////////////////////////////////////////////
// Clean All Sell Order ToDay
///////////////////////////////////////////////////////////////////////////////////
  string risk_time = "16:30";
  //string risk_time = "14:30";// exness
  int day_left=0;
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_time;
  datetime reserval_time = StringToTime(yenitarih);


  string risk_end_time = "18:30";
  //string risk_end_time = "16:30";// exness
  //int day_left=0;
  yenitarih = TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_end_time;
  datetime reserval_end_time = StringToTime(yenitarih);
  

  string risk_time_am = "11:00";
  //string risk_time_am = "09:00";// exness
  //day_left=0;
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_time_am;
  datetime reserval_time_am = StringToTime(yenitarih);


  string risk_end_time_am = "13:00";
  //string risk_end_time_am = "11:00";// exness
  //int day_left=0;
  yenitarih = TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+risk_end_time_am;
  datetime reserval_end_time_am = StringToTime(yenitarih);
      

//if ( Bid >= prices[13] && TimeCurrent() >= reserval_time && sell_risk_order == false ) { // 414
//if ( Bid >= prices[14] && TimeCurrent() >= reserval_time && TimeCurrent() <= reserval_end_time  && sell_risk_order == false && sell_total > 5 ) { // 618
if ( Bid >= prices[14] && ((TimeCurrent() >= reserval_time && TimeCurrent() <= reserval_end_time) || (TimeCurrent() >= reserval_time_am && TimeCurrent() <= reserval_end_time_am) )  && sell_risk_order == false && sell_total > 5 ) { // 618
//if ( Bid >= prices[15] && TimeCurrent() >= reserval_time && sell_risk_order == false ) { // 886
//string cmt="SELLRISK-"+sell_lot*2;
string cmt="RISK";
sell_risk_order=true;
int ticket=OrderSend(sym,OP_SELL,sell_lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
} else {
/////////////////////////////////////////////////////////////////////////////////

string cmt="SELL-"+(sell_total+1);
if ( sell_total <= 2 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
if ( sell_total > 2 && sell_total <= 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 4-6
if ( sell_total > 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*3,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
sell_price=Bid;

}

}

}
//////////////////////////////////////////////////////////////////////////////////////


//buy_profit+sell_profit
if ( max_loss_profit > AccountProfit() ) {
max_loss_profit=AccountProfit();
Print(max_loss_profit);
}


//////////////////////////////////////////////////////////////////////////////////
int hedge_carpan=3; // lot 2 %20 dd
// 3 433 310dd
// 2 390 281dd

//0.033 lot , 103 dd 1000$ - %10
//0.017 lot ,  51 dd 1000$ - %5
//0.008 lot ,  25 dd 1000$ - %2.5
//0.004 lot ,12,5 dd 1000$ - %1.25

//0.004 ile 0.008 arası max 1000$
//0.04 ile 0.08 arası max 10.000$
//0.20 ile 0.40 arası max 50.000$

// 50k hesapla 0.05 lot 1500$ dd ile günde 30$ kazanç tatil günleri dahil.






if ( hedge_system == true && lock_order_buy == false ) {
if ( buy_total > 1 && (prices[0]-Ask)/Point > min_distance*hedge_carpan  ) {
///lock_order=true;
///lock_order_buy=true;

//int ticket=OrderSend(Symbol(),OP_SELL,buy_lot*2,Bid,0,Ask+((min_distance*2)*Point),0,"HEDGE-SELL",magic,0,clrNONE);
//int ticket=OrderSend(Symbol(),OP_SELL,buy_lot*2,Bid,0,prices[15],0,"HEDGE-SELL",magic,0,clrNONE);

///int ticket=OrderSend(Symbol(),OP_SELL,buy_lot*2,Bid,0,0,0,"HEDGE-SELL",magic,0,clrNONE);

CloseAllBuyOrders();

}
}

if ( hedge_system == true && lock_order_sell == false ) {
if ( sell_total > 1 && (Bid-prices[15])/Point > min_distance*hedge_carpan  ) {
///lock_order=true;
///lock_order_sell=true;
//int ticket=OrderSend(Symbol(),OP_BUY,sell_lot*2,Ask,0,Bid-((min_distance*2)*Point),0,"HEDGE-BUY",magic,0,clrNONE);
//int ticket=OrderSend(Symbol(),OP_BUY,sell_lot*2,Ask,0,prices[0],0,"HEDGE-BUY",magic,0,clrNONE);

///int ticket=OrderSend(Symbol(),OP_BUY,sell_lot*2,Ask,0,0,0,"HEDGE-BUY",magic,0,clrNONE);
CloseAllSellOrders();

}
}

if ( hedge_system == true ) {
if ( lock_order == true ) {
if ( buy_profit+sell_profit > 0 ) {
CloseAllBuyOrders();
CloseAllSellOrders();
lock_order=false;
lock_order_buy=false;
lock_order_sell=false;
}
}
}



//////////////////////////////////////////////////////////////////////////////////




//////////////////////////////////////////////////////////////////////////////////
// İşlem Kapama
//////////////////////////////////////////////////////////////////////////////////
if ( buy_total > 1 && Bid-last_avarage_buy >= distance_pip*Point ) {
CloseAllBuyOrders();
buy_risk_order=false;
}

if ( sell_total > 1 && last_avarage_sell-Ask >= distance_pip*Point ) {
CloseAllSellOrders();
sell_risk_order=false;
}
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////
// EQ Close
//////////////////////////////////////////////////////////////
/*
if ( buy_total > 1 && buy_profit > 0 ) {
if ( Bid >= prices[16] ) {
CloseAllBuyOrders();
}
}


if ( sell_total > 1 && sell_profit > 0  ) {
if ( Bid <= prices[16] ) {
CloseAllSellOrders();
}
}
*/
//////////////////////////////////////////////////////////////





   
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
//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
int OrderCommetssType(string cmt,string sym,int typ){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == typ && OrderMagicNumber() == magic ) {
com++;
}
}

return com;
};



//////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderCommetlive(string cmt,string sym,int typ,int mgc){

int coms = 0;


if ( free_mode == true ) cmt="";



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 && OrderMagicNumber() != 0 )  ) {
   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};


datetime ea_start_time;
   double low_price=1000000;
   double high_price=-1;

void SessionOrder(string sname,string start_time,string end_time,string finish_time,string ea_time,int day_left) {

if ( sname=="Tokyo" ) {


  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+start_time;
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;


  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+end_time;
  some_time = StringToTime(yenitarih);
  
  ty_end_time=some_time;
  

  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+finish_time;
  some_time = StringToTime(yenitarih);
  
  limit_time=some_time;

  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+ea_time;
  some_time = StringToTime(yenitarih);
  
  ea_start_time=some_time;

  if ( TimeCurrent() > end_time && ea_start == true ) return; // Range Genişlemesi Biter

  if ( TimeCurrent() < ea_start_time ) return; // Eq Başlama Zamanı
  
  if ( ea_start == true ) {
  /*
  if ( Bid > high_price || Bid < low_price ) {} else {
  return;
  }*/
  
  if ( Bid < high_price && Bid > low_price ) return;
  
  }



  int ticket;
  double price;

//if ( (int(TimeHour(Timei(1))) == 11  && int(TimeMinute(Timei(1))) == 0 && tokyo_end == false) || (int(TimeHour(Timei(1))) > 11  &&  tokyo_end == false)  ) {

//Alert("Tokyo2");

/*
int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);

int buy_limit_total=OrderCommetlive("d886",sym,OP_BUYLIMIT,magic);
int sell_limit_total=OrderCommetlive("u886",sym,OP_BUYLIMIT,magic);

buy_total=buy_total+buy_limit_total;
sell_total=sell_total+sell_limit_total;*/




  
  
    
  
  if ( Time[0] < ty_end_time ) ty_end_time=Time[0];
  

  int ty_end_shift=iBarShift(sym,per,ty_end_time);


   ty_end_time=Timei(ty_end_shift);
   //ty_end_time=Timei(1);

   string name="TOKYO-END";//-"+Timei(ty_end_shift);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_end_shift),Highi(ty_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);

   
   tokyo_end=true;


 int shift=iBarShift(sym,per,ty_start_time);
   
   low_price=1000000;
   high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   //for(int s=shift;s>0;s--) {
   for(int s=shift;s>=ty_end_shift;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }






   name="TokyoSession";//+Timei(1);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price,ty_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   
   //Alert("Tokyo");
   
   /*
if ( MarketInfo(sym,MODE_ASK) <= high_price && MarketInfo(sym,MODE_BID) >= low_price ) {
//Alanın İçi 
} else {
//Alanın Dışı
tokyo_end=true;
return;
}*/
   
   


   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   prices[16]=eq;
   pricen[16]="Eq";
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 
     
/////////////////////////////////////////////////////////     
   //bool sell_order=false;
   //bool buy_order=false;
   /*if ( high_price - Bid < Bid- low_price ) {
   sell_order=true;
   buy_order=false;
   } else {
   buy_order=true;
   sell_order=false;   
   }
////////////////////////////////////////////////////   
   */
   

  name="TokyoLevel";//+Timei(1);
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
   

  level=level45;
  levels="45";
  price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  prices[7]=price; 
  pricen[7]=levels;         
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";  
  price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  prices[8]=price;
  pricen[8]=levels;        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";   
  price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  prices[9]=price; 
  pricen[9]=levels;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";  
  //price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  //prices[9]=price;      
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";
  price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  prices[6]=price; 
  pricen[6]=levels;         
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";   
//  price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
//  prices[6]=price;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         






  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[10]=price;
  pricen[10]=levels;  
  //if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  

  level=level168;
  levels="u168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[11]=price;
  pricen[11]=levels;  
  //if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
   /*
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  //if ( (high_price-MarketInfo(sym,MODE_ASK))/MarketInfo(sym,MODE_POINT) > 5 )
  if ( (high_price-MarketInfo(sym,MODE_ASK)) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) )  price=NormalizeDouble(high_price,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/


  level=level272;
  levels="u272";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[12]=price;
  pricen[12]=levels;  
  //if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  double price272=price;  
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[13]=price;
  pricen[13]=levels;  
  //if ( sell_total == 0 && sell_order == true )  ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  double price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[14]=price;
  pricen[14]=levels;  
  //if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  prices[15]=price;
  pricen[15]=levels;  
  //if ( sell_total == 0 && sell_order == true ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////  





  double pips=(price414-price272)*2;
  distance=(price414-price272);
  
  
  /*
if ( sell_total == 0 && sell_order == true ) {

   if ( sell_total == 0 ) {
   for(int i=1;i<4;i++) {
   double prices=price+(pips*i);
   ///if ( i <= 2 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_BUYSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
   }
   
}   */





/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level0;
  levels="d00";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
*/  
  


  level=level0;
  levels="d000";     
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[5]=price;     
  pricen[5]=levels;      
  
  //if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  

  level=level168;
  levels="d168";         
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[4]=price; 
  pricen[4]=levels;  
  //if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
/*
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  //if ( (MarketInfo(sym,MODE_BID)-low_price)/MarketInfo(sym,MODE_POINT) > 5 ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
  if ( (MarketInfo(sym,MODE_BID)-low_price) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
    
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[3]=price;
  pricen[3]=levels;   
  ///if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price272=price; 
    
  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);     

  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[2]=price;   
  pricen[2]=levels;
  ///if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);  
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[1]=price;   
  pricen[1]=levels;
  ///if ( buy_total == 0 && buy_order == true ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow); 
   
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  prices[0]=price;   
  pricen[0]=levels;
  ///if ( buy_total == 0 && buy_order == true) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
///////////////////////////////////////////////////////////////////////////////////////////////////////////   





  pips=(price272-price414)*2;

/*
if ( buy_total == 0 && buy_order == true )  {
   for(int i=1;i<4;i++) {
   double prices=price-(pips*i);
   ///if ( i <= 2 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   ///if ( i >= 3 ) ticket=OrderSend(sym,OP_SELLSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
}  */ 
   
   
   



   
//}



}



ea_start=true;



}


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


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){


if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
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
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic ) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_lot=buy_lot+OrderLots();
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_lot=sell_lot+OrderLots();
}





}

sonuc=true;

/*
if ( lock_order_buy_total == 0 ) lock_order_buy = false;
if ( lock_order_sell_total == 0 ) lock_order_sell = false;
*/
return sonuc;
};



  int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}
  
  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void AvarageSystem(int mgc) {

///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
if ( OrdersTotal() > 0 ) {

double margin_buylot=0;
double margin_selllot=0;
double margin_buyprofit=0;
double margin_sellprofit=0;
double avarage = 0;
double avarage_total = 0;
double islem_sayisi = 0;
double islem_sayisi_buy = 0;
double islem_sayisi_sell = 0;


double avarage_total_buy = 0;
double avarage_total_sell = 0;

double avarage_buy = 0;
double avarage_sell = 0;


       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol() && OrderMagicNumber() == mgc ) {
           
           //Alert("OrderTicket:",OrderTicket());
           
           //Print(OrderTicket(),"/",OrderMagicNumber());
           
           
           
           
        //if ( OrderType() == OP_BUY || OrderType() == OP_BUYSTOP ) {
        if ( OrderType() == OP_BUY  ) {
        
           margin_buylot = margin_buylot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));           
           
           islem_sayisi_buy=islem_sayisi_buy+(OrderLots()*100);
           avarage_total_buy=avarage_total_buy+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        //if ( OrderType() == OP_SELL || OrderType() == OP_SELLSTOP ) {
        if ( OrderType() == OP_SELL  ) {
        
           margin_selllot = margin_selllot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));
           
           islem_sayisi_sell=islem_sayisi_sell+(OrderLots()*100);
           avarage_total_sell=avarage_total_sell+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        
       if ( OrderType() == OP_BUY && OrderProfit() < 0 ) {
        
        margin_buyprofit = margin_buyprofit +  OrderProfit(); 
        
        } 
        
       if ( OrderType() == OP_SELL && OrderProfit() < 0 ) {
        
        margin_sellprofit = margin_sellprofit +  OrderProfit(); 
        
        } 
        
        



}
}
}

if ( avarage_total == 0 ) return;


//////////////////////////////////////////////////////////////////////////////////////////////
// AVARAGE SİSTEMİ
//////////////////////////////////////////////////////////////////////////////////////////////        
        avarage=DivZero(avarage_total,islem_sayisi);
        
        avarage_buy=DivZero(avarage_total_buy,islem_sayisi_buy);
        avarage_sell=DivZero(avarage_total_sell,islem_sayisi_sell);
        
        //Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
        double avarage_fark=avarage_buy-avarage_sell;
        

double avarage_buy_profit_price=avarage_buy+avarage_fark;
double avarage_sell_profit_price=avarage_sell-avarage_fark;

        
if ( last_avarage_buy_profit_price != avarage_buy_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageBuyp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuyp",OBJ_HLINE,0,0,avarage_buy_profit_price);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuyp",OBJPROP_PRICE,avarage_buy_profit_price);
last_avarage_buy_profit_price=avarage_buy_profit_price;
}  
}

if ( last_avarage_sell_profit_price != avarage_sell_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageSellp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSellp",OBJ_HLINE,0,0,avarage_sell_profit_price);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSellp",OBJPROP_PRICE,avarage_sell_profit_price);
last_avarage_sell_profit_price=avarage_sell_profit_price;
}  
}



        
        
        
        ///Print("avarage",avarage,"/",islem_sayisi,"/",avarage_total);

if ( mgc == active_magic_buy ) {

if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}


if ( last_avarage_sell != avarage_sell ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}








}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
if ( mgc == active_magic_sell ) {

if ( last_avarage_sell != avarage ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}


if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}







}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
  
  
    
  
  
  
  
  
  
}



}  



void CloseAllPenOrders(string sym)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() > 1 && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}


void CloseAllPenOrdersTyp(string sym,int ord_typ)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == ord_typ && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
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

void CloseOrders(string cmt,int ord_type)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( (( cmt !="" && StringFind(OrderComment(),cmt,0) != -1 ) || cmt == "" ) &&   OrderType() == ord_type && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}
