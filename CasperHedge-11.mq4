//+------------------------------------------------------------------+
//|                                                       Casper.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Lot=0.01;
double Lot2=0.01;
int magics=30;
int magic=30;

input string syms1="EURUSD";
input string syms2="GBPUSD";

double profit=0.70;

int min_pips=40;
int min_pip=40;
datetime last_time;


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

string sym1="";
string sym2="";
string sym3="";

  int limit=10;
  int shift=1;
  

bool auto_mode=true;
bool auto_order=false;

input int limit_lot=5; // En düşük lot 5 katı

double Lots;
double Lots2;
double Profits;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   
   if ( TimeYear(TimeCurrent()) != 2023 ) ExpertRemove();
   
   
   ObjectsDeleteAll(ChartID(),-1,-1);
   
sym1=syms1;
sym2=syms2;   

magic=magics;
min_pip=min_pips;


   

auto_mode=false;
int cevap=MessageBox("Auto Mode","Auto Mode Open",4); 
if ( cevap == 6 ) { 
auto_mode=true;
} 
   
   if ( auto_mode == true ) {
   
   if ( Symbol() == "EURUSD" ) {
   
   sym1=Symbol();
   sym2="GBPUSD";
   
   }
   
   if ( Symbol() == "GBPUSD" ) {
   
   sym1=Symbol();
   sym2="EURUSD";
   
   }
      
   
   
   if ( Symbol() == "XAUUSD" ) {
   
   sym1=Symbol();
   sym2="XAGUSD";
   
   }

   if ( Symbol() == "XAGUSD" ) {
   
   sym1=Symbol();
   sym2="XAUUSD";
   
   }



   if ( Symbol() == ".DE40Cash" ) {
   
   sym1=Symbol();
   sym2=".US30Cash";
   
   }
   
   if ( Symbol() == ".US30Cash" ) {
   
   sym1=Symbol();
   sym2=".DE40Cash";
   
   }
   
      
   
   if ( Symbol() == "BTCUSD" ) {
   
   sym1=Symbol();
   sym2="ETHUSD";
   
   }   
   
   if ( Symbol() == "ETHUSD" ) {
   
   sym1=Symbol();
   sym2="BTCUSD";
   
   }   
      
   
   
   }
   
      
   
      
   
   
   Lots=Lot;
   Lots2=Lot2;
   Profits=profit;
   
   
   string buttonID="ButtonBuySinyal"; // Support LeveL Show
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,130);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,60);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,80);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,"Set Lot");
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   
   buttonID="InputBox"; // Support LeveL Show
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,130);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,160);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,Lot);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   

   buttonID="InputBox2"; // Support LeveL Show
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,250);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,160);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,Lot);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   
   
      


   buttonID="InputBoxProfit"; // Support LeveL Show
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,130);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,190);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,profit);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");


   buttonID="InputBoxMagic"; // Support LeveL Show
   
   //Alert(ObjectFind(ChartID(),buttonID));
   
   if ( ObjectFind(ChartID(),buttonID) != -1 ) {
   magic=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);      
   } else {
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,130);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,220);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,magic);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");      
   }    
   


   buttonID="InputBoxPip"; // Support LeveL Show
   
   //Alert(ObjectFind(ChartID(),buttonID));
   
   if ( ObjectFind(ChartID(),buttonID) != -1 ) {
   min_pip=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);      
   } else {
                                    
   ObjectCreate(ChartID(),buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,130);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,250);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,min_pip);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"Min Pip");      
   }    
   
   
      
   
   
   OrderCommetssTypeMulti(sym1);
   
if ( buy_total == 0 && sell_total == 0 ) {
auto_order=false;
int cevap=MessageBox("Auto Order","Auto Order Open",4); 
if ( cevap == 6 ) { 
auto_order=true;
} 
}
   
   

CheckIfTradeIsAllowed(sym1,sym2);

   
      
      
   ChartRedraw();
   
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

input bool candle_gap_engine = false;
input bool real_price_engine=false;
input bool pip_distance_engine=true;
input int pip_distance=500;
input bool bollinger_band_engine=false;
input bool ma_breakout_engine=false;


void OnTick()
  {
  
  OrderCommetssTypeMulti(sym1);
  
//---

//////////////////////////////////////////////////////////////////////////////////////////
// CORELASYON AUTO ORDER
//////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
// Bollinger Band Engine
/////////////////////////////////////////////////////////////////////////////

if ( bollinger_band_engine == true ) {


}

/////////////////////////////////////////////////////////////////////////////
// Ma Breakout Engine
/////////////////////////////////////////////////////////////////////////////

if ( ma_breakout_engine == true ) {


}





/////////////////////////////////////////////////////////////////////////////
// Pip Distance Engine
/////////////////////////////////////////////////////////////////////////////

if ( pip_distance_engine == true ) {

if ( buy_total == 0 && sell_total == 0 && auto_order == true ) {




  string   yenitarihs= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 00:00"; 
  //string   yenitarihs= TimeYear(TimeCurrent())+".05.02 03:03"; 
  datetime some_times = StringToTime(yenitarihs); 
  
  some_times = some_times - PeriodSeconds()*1440;
  
  
     
     int shift=iBarShift(Symbol(),PERIOD_M1,some_times);
     
     //Print(some_times,"/",shift);
   
   /*
   string sym1="EURUSD";
   string sym2="GBPUSD";


if ( Symbol() == ".USTECHCash" ) {
   sym1=".USTECHCash";
   sym2=".US500Cash";  
}    

if ( Symbol() == "NAS100" ) {
   sym1="NAS100";
   sym2="SP500";  
}   


if ( Symbol() == "XAUUSD" ) {
   sym1="XAUUSD";
   sym2="XAGUSD";  
}
   
if ( Symbol() == "EURJPY" ) {   
   sym1="EURJPY";
   sym2="USDJPY";  
}*/
     
   
   
   ENUM_TIMEFRAMES per=PERIOD_M1;
   
   bool find=false;
   
   for (int i=1;i<shift;i++) {
   
   if ( find==true)continue;
   
   int shift_1=iBarShift(sym1,PERIOD_M1,Time[i]);
   int shift_2=iBarShift(sym2,PERIOD_M1,Time[i]);
   
   int shifts_1=iBarShift(sym1,PERIOD_M1,Time[1]);
   int shifts_2=iBarShift(sym2,PERIOD_M1,Time[1]);

    
   
   //int shift_2=iBarShift(sym2,PERIOD_M1,iTime(sym2,PERIOD_M1,i));
   
   double sym1_op=iOpen(sym1,per,shift_1);
   double sym1_cp=iClose(sym1,per,shifts_1);
   
   double sym2_op=iOpen(sym2,per,shift_2);
   double sym2_cp=iClose(sym2,per,shifts_2);
      
 double farks=(sym1_cp-sym1_op);
  int pips=farks/MarketInfo(sym1,MODE_POINT);      

  double fark=(sym2_cp-sym2_op);
  int pip=fark/MarketInfo(sym2,MODE_POINT);
  
  //Print(i,"/",pips,"/",pip,"/",pips-pip);
  

if ( MathAbs(pips-pip) >= pip_distance ) {



if ( pips < 0 && pip < 0 ) {

if ( pips > pip ) {

//Alert(Symbol(),"EUR SELL","USD BUY");

   int ticket_buy=OrderSend(sym2,OP_BUY,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
     


}

if ( pips < pip ) {

//Alert(Symbol(),"EUR BUY","USD SELL");


   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,cmt,magic,0,clrNONE);
   
   
}


}



if ( pips > 0 && pip > 0 ) {

if ( pips > pip ) {

//Alert(Symbol(),"EUR BUY","USD SELL");

   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,cmt,magic,0,clrNONE);
   

}

if ( pips < pip ) {

//Alert(Symbol(),"EUR SELL","USD BUY");

   int ticket_buy=OrderSend(sym2,OP_BUY,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
     


}


}





/*
if ( sym1_cp > sym1_op && pips > pip ) {

//"EURSELL","USDBUY"

   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot,MarketInfo(sym2,MODE_ASK),0,0,0,cmt,magic,0,clrNONE);
   

}

if ( sym2_cp > sym2_op && pip > pips ) {

//"EURBUY","USDSELL"

   int ticket_buy=OrderSend(sym2,OP_BUY,Lot,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
     

}*/


/*
if ( sym1_cp > sym2_cp && pips > pip ) {

//"EURSELL","USDBUY"

   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot,MarketInfo(sym2,MODE_ASK),0,0,0,cmt,magic,0,clrNONE);
   

}

if ( sym2_cp > sym1_cp && pip > pips ) {

//"EURBUY","USDSELL"

   int ticket_buy=OrderSend(sym2,OP_BUY,Lot,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
     

}
*/


//if ( pips >= 600 ) {

//ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);

ObjectsDeleteAll(ChartID(),"TLINE"+i);
ObjectCreate(ChartID(),"TLINE"+i,OBJ_TREND,0,Time[1],Ask,Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_STYLE,STYLE_DOT);

if ( pip > 0 ) {
ObjectCreate(ChartID(),"TLINES"+i,OBJ_TREND,0,Time[1],Ask-(pip*Point),Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_STYLE,STYLE_DOT);
}

if ( pip < 0 ) {
ObjectCreate(ChartID(),"TLINESS"+i,OBJ_TREND,0,Time[1],Ask+(pip*Point),Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_STYLE,STYLE_DOT);
}

find=true;

}
   
   
   
   }
   
   
   
   

}

}
/////////////////////////////////////////////////////////////////////////////
// Real Price Engine
/////////////////////////////////////////////////////////////////////////////
if ( real_price_engine == true ) {
  
/*
120 gbpusd
eurusd 70

120 gbpusd gbp çıkmış sell
eurusd 70  eur inmiş buy



*/  
  
  /*string sym1="EURUSD";
  string sym2="GBPUSD";
  string sym3="EURGBP";*/
  
//////////////////////////////////////////////////////////////////////////////////////////  
  //string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 01:17"; 
  //datetime some_time = StringToTime(yenitarih); 
  
  //some_time=Time[1];
  
   datetime some_time=iTime(Symbol(),PERIOD_M1,1);
  
  
  if ( Symbol () == "EURGBP" && sym1=="EURUSD" && sym2=="GBPUSD" ) {
  sym3="EURGBP";
  limit=10;
  }
  
  if ( Symbol () == "EURUSD" && sym1=="EURJPY" && sym2=="USDJPY" ) {
  sym1="EURJPY";
  sym2="USDJPY";  
  sym3="EURUSD";
  limit=100;
  }

  double sym1prc=iClose(sym1,PERIOD_M1,shift);
  double sym2prc=iClose(sym2,PERIOD_M1,shift);
  double sym3prc=iClose(sym3,PERIOD_M1,shift);

if ( buy_total == 0 && sell_total == 0 && auto_order == true ) {

double sym4prc=DivZero(sym1prc,sym2prc);

  Comment(sym4prc/Point);
  
  if ( sym4prc > sym3prc ) {
  
  double fark=(sym4prc-sym3prc);
  int pip=fark/Point;
  //Comment("EUR BUY,GBP SELL:",pip); 
  Comment(sym1," BUY,",sym2," SELL:",pip);
  
  if ( pip >= limit ) ObjectCreate(ChartID(),"CTIME"+some_time,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"CTIME"+some_time,OBJPROP_COLOR,clrLimeGreen);

   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,cmt,magic,0,clrNONE);
     
  
  }
  
  if ( sym4prc < sym3prc ) {
  
  double fark=(sym3prc-sym4prc);
  int pip=fark/Point;  
  Comment(sym1," SELL,",sym2," BUY:",pip);  
  
  if ( pip >= limit )  ObjectCreate(ChartID(),"CTIME"+some_time,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"CTIME"+some_time,OBJPROP_COLOR,clrCrimson);
  
   int ticket_buy=OrderSend(sym2,OP_BUY,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
     
  
  }
    
    

}

}
/////////////////////////////////////////////////////////////////////////







/////////////////////////////////////////////////////////////////////////////
// Candle Gap Engine
/////////////////////////////////////////////////////////////////////////////

if ( candle_gap_engine == true ) {


if ( buy_total == 0 && sell_total == 0 && auto_order == true ) {

int sym1_point=DivZero(MathAbs(iClose(sym1,Period(),1) - iOpen(sym1,Period(),1)),Point);
int sym2_point=DivZero(MathAbs(iClose(sym2,Period(),1) - iOpen(sym2,Period(),1)),Point);

if ( DivZero(sym1_point,sym1_point) >=2 && sym1_point >= min_pip && last_time!=Time[1] ) {

   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot2,MarketInfo(sym2,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
   
   last_time=Time[1];

   /*if ( sparam == 48 ) {
   
   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   
   }*/
   
/*
   if ( sparam == 31 ) {
   
   int ticket_buy=OrderSend(sym2,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   
   }*/

}

if ( DivZero(sym2_point,sym1_point) >=2 && sym2_point >= min_pip && last_time!=Time[1] ) {

   int ticket_buy=OrderSend(sym2,OP_BUY,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
   
   last_time=Time[1];

}

}

}





//Comment(buy_profit,"/",sell_profit);
double sym1_buy_profit=buy_profit;
double sym1_sell_profit=sell_profit;

OrderCommetssTypeMulti(sym2);

//Comment(buy_profit,"/",sell_profit);
double sym2_buy_profit=buy_profit;
double sym2_sell_profit=sell_profit;

double total_profit=(sym1_buy_profit+sym1_sell_profit)+(sym2_buy_profit+sym2_sell_profit);


Comment(sym1,"\n Buy Profit:",sym1_buy_profit,"/ Sell Profit:",sym1_sell_profit,"= Total Profit:",sym1_buy_profit+sym1_sell_profit,"\n",sym2,"\n Buy Profit:",sym2_buy_profit,"/ Sell Profit:",sym2_sell_profit,"= Total Profit:",sym2_buy_profit+sym2_sell_profit,"\n Total Profit:",total_profit,"\nLot:",Lot,"\nProfit:",profit,"\n Magic:",magic,"\n Min Pip:",min_pip,"\n MinLot ",sym1,":",SymbolInfoDouble(sym1,SYMBOL_VOLUME_MIN),"\n MinLot ",sym2,":",SymbolInfoDouble(sym2,SYMBOL_VOLUME_MIN)
,"\n Lot ",sym1,":",Lot,"\n Lot2 ",sym2,":",Lot2);

if ( total_profit > profit ) {
//OrderCloseHedge();
OrderCloseHedgeAll();

}



string buttonID="ButtonBuySinyal"; // Support LeveL Show
                                    
   if ( total_profit >= 0 ) ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   if ( total_profit < 0 ) ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,DoubleToString(total_profit,2));
   
   
   
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

Print("Sparam",sparam);

if ( sparam == "ButtonBuySinyal" ) {


Lot=Lots;
Lot2=Lots2;
profit=Profits;
magic=magics;
min_pip=min_pips;


Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);

Print("Profits:",profit);

}


if ( sparam == "InputBox" ) {

Lots=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
Comment("Lots:",Lots);

}

if ( sparam == "InputBox2" ) {

Lots2=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
Comment("Lots2:",Lots2);

}




if ( sparam == "InputBoxProfit" ) {

Profits=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
Comment("Profits:",Profits);

}


if ( sparam == "InputBoxMagic" ) {
magics=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
Comment("Magics:",magics);
}

if ( sparam == "InputBoxPip" ) {
min_pips=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
Comment("Magics:",min_pips);
}




   if ( sparam == 48 ) {
   
   double sym1_min_lot=SymbolInfoDouble(sym1,SYMBOL_VOLUME_MIN);
   double sym2_min_lot=SymbolInfoDouble(sym2,SYMBOL_VOLUME_MIN);
   
   //double sym1_min_lot=MarketInfo(sym1,MODE_MINLOT);
   //double sym2_min_lot=MarketInfo(sym2,MODE_MINLOT);
   
   int ticket_buymin;
   int ticket_buy;
   
   
   if ( Lot >= MarketInfo(sym1,MODE_MINLOT)*limit_lot ) {

   ticket_buymin=OrderSend(sym1,OP_BUY,sym1_min_lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   double Lotw=Lot-sym1_min_lot;   
   int ticket_buy=OrderSend(sym1,OP_BUY,Lotw,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);

   } else {
   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,MarketInfo(sym1,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   }
   

   if ( Lot2 >= MarketInfo(sym2,MODE_MINLOT)*limit_lot ) {
   string cmt="CasperSell"+ticket_buy;
   string cmt_min="CasperSell"+ticket_buymin;
   int ticket_sellmin=OrderSend(sym2,OP_SELL,sym2_min_lot,MarketInfo(sym2,MODE_BID),0,0,0,cmt_min,magic,0,clrNONE);
   double Lotw=Lot2-sym2_min_lot;   
   int ticket_sell=OrderSend(sym2,OP_SELL,Lotw,MarketInfo(sym2,MODE_BID),0,0,0,cmt,magic,0,clrNONE);
   } else {
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot2,MarketInfo(sym2,MODE_BID),0,0,0,cmt,magic,0,clrNONE);   
   }
   
   
   
   /*} else {
   
   
   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   }*/
   
   
   
   }
   

   if ( sparam == 31 ) {
   
   
   double sym1_min_lot=SymbolInfoDouble(sym1,SYMBOL_VOLUME_MIN);
   double sym2_min_lot=SymbolInfoDouble(sym2,SYMBOL_VOLUME_MIN);      
   
   
   int ticket_buymin;
   int ticket_buy;
   
    if ( Lot2 >= MarketInfo(sym2,MODE_MINLOT)*limit_lot ) {

   ticket_buymin=OrderSend(sym2,OP_BUY,sym2_min_lot,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   double Lotw=Lot2-sym2_min_lot;  
   int ticket_buy=OrderSend(sym2,OP_BUY,Lotw,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   
   } else {
   int ticket_buy=OrderSend(sym2,OP_BUY,Lot2,MarketInfo(sym2,MODE_ASK),0,0,0,"CasperBuy",magic,0,clrNONE);
   }
   
   
   
   if ( Lot >= MarketInfo(sym1,MODE_MINLOT)*limit_lot ) {
   string cmt="CasperSell"+ticket_buy;
   string cmt_min="CasperSell"+ticket_buymin;
   int ticket_sellmin=OrderSend(sym1,OP_SELL,sym1_min_lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt_min,magic,0,clrNONE);   
   double Lotw=Lot-sym1_min_lot;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lotw,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);   
   } else {
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,MarketInfo(sym1,MODE_BID),0,0,0,cmt,magic,0,clrNONE);   
   }
   
 
 
   
   /*} else {
   
   int ticket_buy=OrderSend(sym2,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   }*/
   
   
   }

/*
   if ( sparam == 48 ) {
   
   int ticket_buy=OrderSend(sym1,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym2,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   
   }
   

   if ( sparam == 31 ) {
   
   int ticket_buy=OrderSend(sym2,OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(sym1,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   
   }*/
   
   
   

if ( sparam == 45 ) {

OrderCloseHedgeAll();

/*
Print("Kapat");

string cmt="CasperSell";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1  &&   OrderType() == OP_SELL && //OrderSymbol() == Symbol() && 
         OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         int replace=StringReplace(ordcmt,cmt,"");
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    

int ordticket=StringToInteger(ordcmt);    
    
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderTicket() == ordticket &&  OrderType() == OP_BUY && //OrderSymbol() == Symbol() && 
         OrderMagicNumber() == magic
         )
         {
         //string ordcmt=OrderComment();
         //int replace=StringReplace(ordcmt,cmt,"");
         
         
         Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    
        */
    
    
    
    
    
    
    


}   
   
   
  }
//+------------------------------------------------------------------+



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
buy_lot=buy_lot+OrderLots();


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
sell_lot=sell_lot+OrderLots();



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



void OrderCloseHedgeAll() {


string cmt="Casper";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
      
      Print(OrderTicket(),"/",OrderMagicNumber());
      
         if( StringFind(OrderComment(),cmt,0) != -1  &&   (OrderSymbol() == sym1 || OrderSymbol() == sym2) &&
         OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         
         
         int replace=StringReplace(ordcmt,cmt,"");
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    
    
    }
    
    

void OrderCloseHedge() {


string cmt="CasperSell";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1  &&   OrderType() == OP_SELL && //OrderSymbol() == Symbol() && 
         OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         int replace=StringReplace(ordcmt,cmt,"");
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    

int ordticket=StringToInteger(ordcmt);    
    
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderTicket() == ordticket &&  OrderType() == OP_BUY && //OrderSymbol() == Symbol() && 
         OrderMagicNumber() == magic
         )
         {
         //string ordcmt=OrderComment();
         //int replace=StringReplace(ordcmt,cmt,"");
         
         
         Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    
        
    
    }
    
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 


bool CheckIfTradeIsAllowed(string s1, string s2)
{
   if (SymbolInfoInteger(s1, SYMBOL_TRADE_MODE) != SYMBOL_TRADE_MODE_FULL)
   {
      Alert("Trade for symbol " + s1 + " is not allowed");
      return false;
   }
   if (SymbolInfoInteger(s2, SYMBOL_TRADE_MODE) != SYMBOL_TRADE_MODE_FULL)
   {
      Alert("Trade for symbol " + s2 + " is not allowed");
      return false;
   }
   return true;
}    