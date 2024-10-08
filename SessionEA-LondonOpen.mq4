//+------------------------------------------------------------------+
//|                                                    SessionEA.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "666.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

//Robotu manuel başlatıp kar alabilirsin martingale ve %50 tp

//Coin harvester veya Martingale robotu.

//Saat 12 veya 16 civarı fiyat seviyesi yüksek olan paritelerde martingale başlat veya Session göre hesaplayarak gir.

//%50 coinharvester yakınsa tp martingale.


bool time_line=false;
color event_color = clrLightSlateGray;

int tsp=145;




   string sym=Symbol();
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




double london_eq;
double tokyo_eq;



double Lot=0.03;
int magic=31;


double min_profit=1;


int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;

int ticket_ty;
int ticket_lnd;

bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;


double tokyo_high;  
double tokyo_low;

double london_high;  
double london_low;

double newyork_high;  
double newyork_low;

bool hedge_order = false;

bool live_order_system = false;


double buy_sl;
double sell_sl;

bool buy_flag=false;
bool sell_flag=false;
double buy_flag_price=-1;
double sell_flag_price=-1;




double Ortalama;

int OnInit()
  {
  
/*  
1.886
1.618

-0.618
-0.886
*/  
  
  bool order_result=OrderCommetssTypeMulti(Symbol());
  
   sym=Symbol();
   per=Period();  
  
  
  //if ( Symbol() == "XAUUSD" ) Lot=0.01;
  if ( Symbol() == "XAUUSD" || Symbol() == "GOLDm#" || StringFind(Symbol(),"GOLD",0) != -1  ) Lot=0.01;
  
  if ( MarketInfo(Symbol(),MODE_MINLOT) == 0.10 ) Lot=Lot*10;
  
  
  Comment("Sym:",sym,"/ Per:",per," / Lot:",Lot);
  
  
//--- create timer
   //EventSetTimer(5);
   
   ObjectsDeleteAll();
   
   
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
   
   if ( IsTesting() ) OnTimer();
   OnTimer();
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+

datetime ty_start_time;
datetime ty_end_time;

datetime lnd_start_time;
datetime lnd_end_time;

bool london_start=false;
bool london_end=false;
bool tokyo_start=false;
bool tokyo_end=false;



void OnTimer()
  {
//---

/////////////////////////////////////////////////////////////////////////////////////////////
// Time Late Tokyo
/////////////////////////////////////////////////////////////////////////////////////////////
if ( int(TimeHour(Timei(1))) > 2  && tokyo_start == false && tokyo_end == false ) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_time = StringToTime(yenitarih);

  int ty_start_shift=iBarShift(sym,per,some_time);
  
  //Alert("TyStartShift:",ty_start_shift);
  
 
  
int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);


   string name="TOKYO-START-"+Timei(ty_start_shift);  
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_start_shift),Highi(ty_start_shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);


  
   
   ty_start_time=some_time;
   tokyo_start=true;
   tokyo_end=false;
   london_start=false;
   london_end=false;

   eq_order=false;
   
   
   buy_flag=false;
   sell_flag=false;
   buy_flag_price=-1;
   sell_flag_price=-1;
   

   
   if ( buy_total == 0 && sell_total == 0 ) {
   CloseAllPenOrders(OP_BUYLIMIT);
   CloseAllPenOrders(OP_SELLLIMIT);
   CloseAllPenOrders(OP_BUYSTOP);
   CloseAllPenOrders(OP_SELLSTOP);
   //Alert(sym+"=t3");
   if ( eq_system == true ) {
   OrderDelete(ticket_ty,clrNONE);
   OrderDelete(ticket_lnd,clrNONE);
   }
   
   }
   
   

}
/////////////////////////////////////////////////////////////////////////////////////////////



   
if ( int(TimeHour(Timei(1))) == 2  && int(TimeMinute(Timei(1))) == 0 ) {

int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);


   string name="TOKYO-START-"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   
   ty_start_time=Timei(1);
   tokyo_start=true;
   tokyo_end=false;
   london_start=false;
   london_end=false;
   
   eq_order=false;
   
   if ( buy_total == 0 && sell_total == 0 ) {
   CloseAllPenOrders(OP_BUYLIMIT);
   CloseAllPenOrders(OP_SELLLIMIT);
   CloseAllPenOrders(OP_BUYSTOP);
   CloseAllPenOrders(OP_SELLSTOP);
   //Alert(sym+"=t2");
   if ( eq_system == true ) {
   OrderDelete(ticket_ty,clrNONE);
   OrderDelete(ticket_lnd,clrNONE);   
   }
   }
   
}

   
 /*  
if ( (int(TimeHour(Timei(1))) > 11  &&  tokyo_end == false) ) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);

  int ty_end_shift=iBarShift(sym,per,some_time);

}*/
   
   
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   //Print("tokyo_end:",tokyo_end,"/",int(TimeHour(Timei(1))));
   
   
//if ( (int(TimeHour(Timei(1))) == 11  && int(TimeMinute(Timei(1))) == 0 && tokyo_end == false) || ( int(TimeHour(Timei(1))) >= 11  && int(TimeHour(Timei(1))) <= 15 &&  tokyo_end == false)  ) {
if ( (int(TimeHour(Timei(1))) == 10  && int(TimeMinute(Timei(1))) == 10 && tokyo_end == false) || ( int(TimeHour(Timei(1))) >= 11  && int(TimeHour(Timei(1))) <= 15 &&  tokyo_end == false)  ) {




int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);

  int ty_end_shift=iBarShift(sym,per,some_time);


   ty_end_time=Timei(ty_end_shift);
   //ty_end_time=Timei(1);

   string name="TOKYO-END-"+Timei(ty_end_shift);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_end_shift),Highi(ty_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);

   
   tokyo_end=true;


 int shift=iBarShift(sym,per,ty_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   

 int end_shift=0;
 if ( (int(TimeHour(Timei(1)))) >= 11 ) end_shift=ty_end_shift;

for(int s=shift;s>=end_shift;s--) {   

   //for(int s=shift;s>0;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }



tokyo_high=high_price;
tokyo_low=low_price;


   name="TokyoSession"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price,ty_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   
////////////////////////////////////////////////////////////////////////
// Range Alanı Genişlik Kontrolü
////////////////////////////////////////////////////////////////////////
double bar_ortalama=BarOrtalama(1,300,Symbol(),Period());

double range=high_price-low_price;

double range_oran=DivZero(range,bar_ortalama);

//Alert("Range ORan:",range_oran,"/",bar_ortalama);



if ( range_oran >= 10  ) {
// Range Genişliği İyi
} else {
tokyo_end=true;
return;
}
/////////////////////////////////////////////////////////////////////////

   
/*   
if ( MarketInfo(sym,MODE_ASK) <= high_price && MarketInfo(sym,MODE_BID) >= low_price ) {
//Alanın İçi 
} else {
//Alanın Dışı
tokyo_end=true;
return;
}
*/   
   
   
   

   double yuzde = DivZero(high_price-low_price, 100);
   
/*
///////////////////////////////////////////////////////////////////////////   
// Yakın Bölgede Live İşlem Açar
///////////////////////////////////////////////////////////////////////////
   double h_level=DivZero(high_price-Bid,yuzde);
   double l_level=DivZero(Bid-low_price,yuzde);
  
if ( h_level < 10 && h_level >= 0 ) int ticketl=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,"Live-H",magic,0,clrNONE);   
if ( l_level < 10 && l_level >= 0) int ticketl=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,"Live-L",magic,0,clrNONE);   
   
///////////////////////////////////////////////////////////////////////////   
*/
/*
   if ( high_price > Bid ) h_level=DivZero(high_price-Bid,yuzde);
   if ( Bid > low_price ) l_level=DivZero(Bid-low_price,yuzde);

   if ( Bid > high_price ) h_level=DivZero(Bid-high_price,yuzde);
   if ( low_price > Bid ) l_level=DivZero(low_price-Bid,yuzde);*/    
   
   
   double eq=low_price+yuzde*50; // 50
   
   tokyo_eq=eq;
   
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
   
////////////////////////////////////////////   
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50 
   double level2000=yuzde*127.2; // 50 
////////////////////////////////////////////  



/*
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 10:10";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  some_time = StringToTime(yenitarih);*/
  
  //if ( TimeCurrent() >= yenitarih ) {
  
  if ( Bid > eq && buy_total == 0) {
  
  //int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,high_price+level414,"LONDONTREND",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,high_price-level414,high_price+level272,"LONDONTREND",magic,0,clrNONE);
  
  } 
  
  if ( Bid < eq && sell_total == 0 ) {
  
  //int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,low_price-level414,"LONDONTREND",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,low_price+level414,low_price-level272,"LONDONTREND",magic,0,clrNONE);
  
  }
    
  //}
  
  
 

  name="TokyoLevel"+Timei(1);
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
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         


  int ticket;
  double price;
  

  level=0;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
    

  level=level168;
  levels="u168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  /*   
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
   
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
  if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  double price272=price; 
  
  sell_flag_price=price;
  
  
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 10 )  ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  double price414=price;



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  //sell_sl=high_price+level;

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  //sell_sl=high_price+level;
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  level=level2000;
  levels="u2000";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  //price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  //if ( sell_total == 10 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);

  sell_sl=high_price+level;

///////////////////////////////////////////////////////////////////////////////////////////////////////     


  double pips=(price414-price272)*2;

   if ( sell_total == 0 ) {
   for(int i=1;i<4;i++) {
   double prices=price+(pips*i);
   //if ( i <= 2 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   //if ( i >= 3 && int(TimeHour(Timei(1))) == 11 && int(TimeMinute(Timei(1))) == 0 && hedge_order == true ) ticket=OrderSend(sym,OP_BUYSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
   }
////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////   
// Yakın Bölgede ise Live İşlem Açar
///////////////////////////////////////////////////////////////////////////
if ( live_order_system == true ) {
 double h_level=DivZero(high_price-Bid,yuzde);

if ( h_level < 10 && h_level >= 0 && sell_total == 0 ) int ticketl=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,"Live-H",magic,0,clrNONE);   
}
///////////////////////////////////////////////////////////////////////////   


  level=0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  

  level=level168;
  levels="d168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  /*  
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

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
  
  buy_flag_price=price;
  
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price272=price; 
    
  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);     

  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  price414=price;


////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  //buy_sl=low_price-level;
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  //buy_sl=low_price-level;
  
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
///////////////////////////////////////////////////////////////////////////////////////////////////////////   
  
  level=level2000;
  levels="d2000";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  buy_sl=low_price-level;
  
  //price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  //if ( buy_total == 10 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);


///////////////////////////////////////////////////////////////////
  pips=(price272-price414)*2;

if ( buy_total == 0 )  {
   for(int i=1;i<4;i++) {
   double prices=price-(pips*i);
   //if ( i <= 2 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   //if ( i >= 3 && int(TimeHour(Timei(1))) == 11 && int(TimeMinute(Timei(1))) == 0 && hedge_order == true ) ticket=OrderSend(sym,OP_SELLSTOP,Lot*12,prices,0,0,0,"Mrt"+i,magic,0,clrNONE);
   }
}   
//////////////////////////////////////////////////////////////////////   
   
   
///////////////////////////////////////////////////////////////////////////   
// Yakın Bölgede ise Live İşlem Açar
///////////////////////////////////////////////////////////////////////////
if ( live_order_system == true ) {   
   double l_level=DivZero(Bid-low_price,yuzde);
 
 if ( l_level < 10 && l_level >= 0 && buy_total == 0) int ticketl=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,"Live-L",magic,0,clrNONE);   
}   
///////////////////////////////////////////////////////////////////////////   



   
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Time Late London
/////////////////////////////////////////////////////////////////////////////////////////////
if ( int(TimeHour(Timei(1))) > 9  && london_start == false ) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  datetime some_time = StringToTime(yenitarih);

  int lnd_start_shift=iBarShift(sym,per,some_time);
  
  //Alert("LndStartShift:",lnd_start_shift);
  
 
   string name="LONDON-START-"+Timei(lnd_start_shift);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(lnd_start_shift),Highi(lnd_start_shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   
   lnd_start_time=Timei(lnd_start_shift);
   london_start=true;  
  

}
/////////////////////////////////////////////////////////////////////////////////////////////

if ( int(TimeHour(Timei(1))) == 9  && int(TimeMinute(Timei(1))) == 0 ) {

   string name="LONDON-START-"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   
   lnd_start_time=Timei(1);
   london_start=true;
}
   
   
   
   
   
if ( tokyo_end == true && ((int(TimeHour(Timei(1))) == 17  && int(TimeMinute(Timei(1))) == 56) || ( london_start == true && london_end==false )) ) {


  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 17:55";
  datetime some_time = StringToTime(yenitarih);
    
  lnd_end_time=some_time;

  int lnd_end_shift=iBarShift(sym,per,some_time);


  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  some_time = StringToTime(yenitarih);
  int lnd_start_shift=iBarShift(sym,per,some_time);
    
  //int lnd_start_shift=iBarShift(sym,per,lnd_start_time);
  
  //int lnd_fark_shift=(lnd_start_shift-lnd_end_shift);
  ///int lnd_fark_shift=DivZero((lnd_end_time-lnd_start_time),PeriodSeconds(per));

   string name="LONDON-END-"+lnd_start_time;
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,lnd_end_time,MarketInfo(sym,MODE_ASK));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(lnd_start_time)+lnd_fark_shift*PeriodSeconds(per),Highi(lnd_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(lnd_end_shift),Highi(lnd_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);

   //lnd_end_time=Timei(1);
   //lnd_end_time=Timei(lnd_end_shift);
   //london_end=true;
   



 int shift=iBarShift(sym,per,lnd_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shift;s>0;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }


   if ( ( (int(TimeHour(Timei(1))) == 18  && int(TimeMinute(Timei(1))) == 00) || int(TimeHour(Timei(1))) >= 18 ) && london_end == false ) {
   name="LondSession"+lnd_start_time;
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,lnd_start_time,high_price,lnd_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"LONDON");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   london_end=true;


int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);


   if ( buy_total == 0 && sell_total == 0 ) {
   CloseAllPenOrders(OP_BUYLIMIT);
   CloseAllPenOrders(OP_SELLLIMIT);
   CloseAllPenOrders(OP_BUYSTOP);
   CloseAllPenOrders(OP_SELLSTOP);
   //Alert(sym+"=t1");
   }
   
   }
   

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
      
  name="LondonLevel"+lnd_start_time;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,lnd_start_time,eq,lnd_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,lnd_start_time,eq,lnd_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
  
  london_eq=eq;
        


   
   }
     
     
   
///////////////////////////////////////////////////////////////////////////////////////////////////////////////   
// Smart Brain Human Order System
//////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
//Comment("london_eq:",london_eq,"\n tokyo_eq:",tokyo_eq);   


/*
int buy_total=OrderCommetssType("",sym,OP_BUY);
int sell_total=OrderCommetssType("",sym,OP_SELL);
double buy_profit=OrderTotalProfit(OP_BUY);
double sell_profit=OrderTotalProfit(OP_SELL);*/

bool order_result=OrderCommetssTypeMulti(Symbol());



Comment("SesEA london_eq:",london_eq,"\n buy profit:",buy_profit,"\n sell profit:",sell_profit,"\n Total:",buy_profit+sell_profit,"\nSym:",sym,"\nPer:",per,"\nLot:",Lot,"\nBuy Lot:",buy_total,"\nSell Lot:",sell_total,"\nBuy Flag Price:",buy_flag_price,"-",buy_flag,"\n Sell Flag Price:",sell_flag_price,"-",sell_flag);   
      

if (  buy_total > 0  && sell_total == 0 ) {
CloseAllPenOrders(OP_SELLLIMIT);
CloseAllPenOrders(OP_BUYSTOP);
//Alert(sym+"=3");
//////// Tokyo Eq Ters İşlem Otomatik
if ( eq_order == false && eq_live_order == 0 && eq_pen_order == 0 && eq_system == true ) {
if ( tokyo_eq-Bid > 0 )  ticket_ty=OrderSend(Symbol(),OP_SELLLIMIT,Lot*eq_lot_carpan,NormalizeDouble(tokyo_eq,Digits),0,0,NormalizeDouble(tokyo_low,Digits),"Teq",magic+1,0,clrNONE);
//if ( tokyo_eq-Bid > london_eq-Bid ) ticket_ty=OrderSend(Symbol(),OP_SELLLIMIT,Lot,NormalizeDouble(tokyo_eq,Digits),0,0,0,"Teq",magic+1,0,clrNONE);
//if ( london_eq-Bid > tokyo_eq-Bid ) ticket_lnd=OrderSend(Symbol(),OP_SELLLIMIT,Lot,NormalizeDouble(london_eq,Digits),0,0,0,"Leq",magic+1,0,clrNONE);
eq_order=true;
}
}

if ( sell_total > 0 &&  buy_total == 0 ) {
CloseAllPenOrders(OP_BUYLIMIT);
CloseAllPenOrders(OP_SELLSTOP);
//////// Tokyo Eq Ters İşlem Otomatik
if ( eq_order == false && eq_live_order == 0 && eq_pen_order == 0 && eq_system == true ) {
if ( Bid-tokyo_eq > 0 )  ticket_ty=OrderSend(Symbol(),OP_BUYLIMIT,Lot*eq_lot_carpan,NormalizeDouble(tokyo_eq,Digits),0,0,NormalizeDouble(tokyo_high,Digits),"Teq",magic+1,0,clrNONE);
//if ( Bid-tokyo_eq > Bid-london_eq )ticket_ty=OrderSend(Symbol(),OP_BUYLIMIT,Lot,NormalizeDouble(tokyo_eq,Digits),0,0,0,"Teq",magic+1,0,clrNONE);
//if ( Bid-london_eq > Bid-tokyo_eq )ticket_lnd=OrderSend(Symbol(),OP_BUYLIMIT,Lot,NormalizeDouble(london_eq,Digits),0,0,0,"Leq",magic+1,0,clrNONE);
eq_order=true;
}

}



///////////////////////////////////////////////////////////////////////////////////////
// Guard Engine
//////////////////////////////////////////////////////////////////////////////////////
/*if (  buy_total == 6 && sell_total == 1 && buy_profit+sell_profit > min_profit  ) {
CloseAllBuyOrders();
CloseAllSellOrders();
}

   
if ( sell_total == 6 &&  buy_total == 1 && sell_profit+buy_profit > min_profit ) {
CloseAllSellOrders();
CloseAllBuyOrders();
}*/
//////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////
// Recovery Engine
//////////////////////////////////////////////////////////////////////////////////////
/*if (  buy_total > 4 &&  buy_total <= 6 && buy_profit > min_profit  ) {
CloseAllBuyOrders();
CloseAllPenOrders(OP_BUYLIMIT);
CloseAllPenOrders(OP_SELLSTOP);
}

   
if ( sell_total > 4 && sell_total <= 6 && sell_profit> min_profit ) {
CloseAllSellOrders();
CloseAllPenOrders(OP_SELLLIMIT);
CloseAllPenOrders(OP_BUYSTOP);
//Alert(sym+"=2");
}*/
//////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////////////////////////////////
// Standart Engine  
/////////////////////////////////////////////////////////////////////////////////////
/*if ( sell_total == 0 &&  buy_total > 0 && buy_total  <= 4 && MarketInfo(sym,MODE_BID) >= london_eq && buy_profit > min_profit  ) {
CloseAllBuyOrders();
CloseAllPenOrders(OP_BUYLIMIT);
CloseAllPenOrders(OP_SELLSTOP);
}

   
if (   buy_total == 0 && sell_total > 0 && sell_total <= 4  && MarketInfo(sym,MODE_ASK) <= london_eq && sell_profit > min_profit  ) {
CloseAllSellOrders();
CloseAllPenOrders(OP_SELLLIMIT);
CloseAllPenOrders(OP_BUYSTOP);
//Alert(sym+"=1");
}*/
////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////////////
// Standart Engine  
/////////////////////////////////////////////////////////////////////////////////////
/*if ( sell_total == 0 &&  buy_total > 0 && buy_total  <= 8 && MarketInfo(sym,MODE_BID) >= london_eq && buy_profit > min_profit  ) {
CloseAllBuyOrders();
CloseAllPenOrders(OP_BUYLIMIT);
CloseAllPenOrders(OP_SELLSTOP);
}

   
if (   buy_total == 0 && sell_total > 0 && sell_total <= 8  && MarketInfo(sym,MODE_ASK) <= london_eq && sell_profit > min_profit  ) {
CloseAllSellOrders();
CloseAllPenOrders(OP_SELLLIMIT);
CloseAllPenOrders(OP_BUYSTOP);
//Alert(sym+"=1");
}*/
////////////////////////////////////////////////////////////////////////////////////

/*
if ( buy_total > 0 && MarketInfo(sym,MODE_BID) < buy_sl ) {
CloseAllBuyOrders();
sell_flag=false;
sell_flag_price=-1;
buy_flag_price=-1;
buy_flag=false;
}


if ( sell_total > 0 && MarketInfo(sym,MODE_ASK) > sell_sl ) {
CloseAllSellOrders();
sell_flag=false;
sell_flag_price=-1;
buy_flag_price=-1;
buy_flag=false;
}


//////////////////////////////////////////////////////////
if ( int(TimeHour(TimeCurrent())) >= 11 ) {
if ( MarketInfo(sym,MODE_BID) < buy_flag_price && buy_flag == false && buy_flag_price != -1 ) {
buy_flag=true;
ObjectDelete(ChartID(),"BFP");
ObjectCreate(ChartID(),"BFP",OBJ_VLINE,0,Time[0],Ask);
}

if ( MarketInfo(sym,MODE_ASK) > sell_flag_price && sell_flag == false && sell_flag_price != -1 ) {
sell_flag=true;
ObjectDelete(ChartID(),"SFP");
ObjectCreate(ChartID(),"SFP",OBJ_VLINE,0,Time[0],Ask);
}
}
/////////////////////////////////////////////////////////

if ( buy_total == 0 && MarketInfo(sym,MODE_ASK) >= london_eq && buy_flag == true  ) {
CloseAllPenOrders(OP_BUYLIMIT);
CloseAllPenOrders(OP_SELLLIMIT);
buy_flag=false;
buy_flag_price=-1;
sell_flag_price=-1;
sell_flag=false;
}

if ( sell_total == 0 && MarketInfo(sym,MODE_BID) <= london_eq && sell_flag == true ) {
CloseAllPenOrders(OP_SELLLIMIT);
CloseAllPenOrders(OP_BUYLIMIT);
sell_flag=false;
sell_flag_price=-1;
buy_flag_price=-1;
buy_flag=false;
}
*/







// Fiyat hafızası o gün açılan işlemleri Eq seviyesi profit seviyesinde ise tp ye eşitleyebilir.
// fiyat 414 yukarısına marginale yapabilir
// coint harvester olabilir. buystop lu yukarı sell stoplu aşağı   
   
   
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////   
 
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



bool event_icon = false;

string TimeOH[11];
string TimeOM[11];

/*

int TimeConvert(int saat,int dakika,bool topla,bool cikar,int fark) {

int sonuc=-1;

return sonuc;

}*/





/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


ChartRedraw(ChartID());

}


//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;

eq_live_order=0;
eq_pen_order=0;


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



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic ) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
}





}

sonuc=true;

return sonuc;
};



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


//+------------------------------------------------------------------+
// CloseAllBuyOrders()
// closes all open buy orders
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

void CloseAllPenOrders(int ord_typ)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == ord_typ && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success = OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}




//+------------------------------------------------------------------+
// CloseAllSellOrders()
// closes all open sell orders
//+------------------------------------------------------------------+
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


//+------------------------------------------------------------------+
// CloseAllOrders()
// closes all orders
//+------------------------------------------------------------------+
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
         if( (( cmt !="" && StringFind(OrderComment(),cmt,0) != -1 ) || cmt == "" ) &&   OrderType() == ord_type && OrderSymbol() == Symbol() //&& OrderMagicNumber() == magicbuy
         )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

/*
void CloseAllOrdersMix()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}*/

///////////////////////////////////////////////////////////////////////  
// PROFIT  
/////////////////////////////////////////////////////////////////////// 
double OrderTotalProfit(int typ)
{

double profits=0;

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {


    if ( OrderType() == typ && OrderSymbol() == Symbol() && OrderMagicNumber() == magic ) {      
    profits=profits+OrderProfit();
    }

  
              
   }
   
}

return profits;

}



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
  