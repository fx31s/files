//+------------------------------------------------------------------+
//|                                                     BrBandEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=1;

input string MA_Indicator_Properties = "=======  Trend Moving Averages Properties ====="; //==================
extern bool Ma_Control=true; // Ma Control Order
input int MA_W=50;//Moving average period
input int MB_W=100;//Moving average period
input ENUM_MA_METHOD MaMethod=MODE_SMA;  // Ma Method
input ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
input ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT; // Ma Period
//////////////////////////////////////////////////////////////////
input string RSI_Indicator_Properties = "=======  RSI Properties ====="; //==================
extern bool Rsi_Control=true; // Rsi Control Order
extern int RSILength=7; // Rsi Lenght
extern int SellThreshold=30; // Over Sell
extern int BuyThreshold=70; // Over Buy
//////////////////////////////////////////////////////////////////
input string EA_Properties = "=======  EA Properties ====="; //==================
extern double Lot=0.01; // Lot
extern int magic=0; // Ea MAgic Group Number
//extern double tp_oran=1; // TakeProfit Risk Reward Risk 1/1
//////////////////////////////////////////////////////////////////
input string Other_Properties = "=======  Other Properties ====="; //==================
//extern string rst_time="02:00"; // System Reset Time
extern bool spread_filter=false;//Spread Filter
extern int max_spead = 0;//MaxSpread (zero or negative value means no limit)
double spread;
bool spread_onay = true;

double sell_price=-1;
double buy_price=-1;



  extern double tp_oran=100; // TP Oran Yüzde
     extern double profits=25;
     double profit=25;
     extern double Lots=0.01;
     
     
     
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
   profit=profits;
   Lot=Lots;
   
//--- create timer
   EventSetTimer(1);
   
   ObjectsDeleteAll();
   
   
   if ( Lot < MarketInfo(Symbol(),MODE_MINLOT) ) Lot=MarketInfo(Symbol(),MODE_MINLOT);
  
   
OnTimer();


    /*
  if ( IsTesting() == False ) {
  if ( int(TimeMonth(TimeCurrent())) != 2 ) {
  ExpertRemove();
  }
  }*/
  
  
   
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

   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
bool order_result=OrderCommetssTypeMulti(Symbol());


////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   //spread=ask-bid;
   spread=(ask-bid)/Point;
   spread_onay=true;
   if ( spread_filter == true ) {
   if ( spread > max_spead && max_spead > 0 ) {
   spread_onay=false;
   //return;
   }
   }
   
   
//////////////////////////////////////////////////////////////////////////
  
  
  if ( spread_filter == true && spread_onay == false ) return;
  
  


  //for (int i=Bars-100;i>5;i--) {
  for (int i=4;i>0;i--) {
  
  
  shift=i;
  
         double iaos1=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift);
         double iaos2=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+1);
         double iaos3=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+2);

  
   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,shift);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,shift);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,shift);
   
   double MA=iMA(Symbol(), MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 
   double MB=iMA(Symbol(), MaTimeA, MB_W, ma_shift, MaMethod, MaPrice, shift); 
   
   double RSI=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift);
   double RSIS=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift+1);
   
  // if ( Band_High > MA && Band_Low < MA ) {} else {continue;}
   
   if ( MA > Band_High || MA < Band_Low ) continue;
   


//////////////////////////////////////////


if ( MB < MA //|| MB < MA

&& iaos1 > 0 && iaos2 > 0 && iaos3 > 0 

 ) {

bool find=false;
double price=High[i];
int shift=i;
for (int r=i+1;r<i+6;r++) {

if ( price < High[r] ) {
shift=r;
find=true;
}

}




if ( find == false && High[i] > High[i-1] && High[i] > High[i+1] && Open[i] > Band_Main
 ) {

 ObjectCreate(ChartID(),"H"+Time[i],OBJ_TREND,0,Time[i],High[i],Time[i+6],High[i]);
 ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_RAY,False);
 
bool find=false;
double price=High[i];
int shift=i;
int say=0;

if ( Open[i] < Close[i] ) say=1;

for (int r=i+1;r<i+6;r++) {

if ( find==true ) continue;

if ( Open[r] < Close[r] ) {
say=say+1;
shift=r;
} else {
find=true;
}
}



if ( say < 4 && find == true ) {

 ObjectCreate(ChartID(),"HR"+Time[i],OBJ_TREND,0,Time[shift],Low[shift],Time[i],High[i]);
 ObjectSetInteger(ChartID(),"HR"+Time[i],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HR"+Time[i],OBJPROP_COLOR,clrOrange);
 ObjectSetInteger(ChartID(),"HR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HR"+Time[i],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HR"+Time[i],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HR"+Time[i],OBJPROP_WIDTH,2);
 
 
bool find=false;
double price=High[i];
int shift=i;
int say=0;


for (int r=i+1;r<i+6;r++) {

double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r);
double Band_Highss = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r-1);

if ( find==true ) continue;

if ( High[r] > Band_Highs && High[r-1] < Band_Highss) {
say=say+1;
shift=r;
find=true;
}
}
 
 if ( find == true ) {



 double price=Low[shift];
 int shiftt=shift;
 bool findtt=false;
 for(int r=shift;r>=i;r--) {
 
 if ( Low[r] < price && Low[r] < Low[r+1] && Low[r] < Low[r-1] ) {price=Low[r];
 shiftt=r;
 findtt=true;
 }
 }
 
 if ( findtt == false ) continue;
 
 
  ObjectCreate(ChartID(),"HBT"+Time[shift],OBJ_TREND,0,Time[shift],High[shift],Time[i],High[i]);
 ObjectSetInteger(ChartID(),"HBT"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBT"+Time[shift],OBJPROP_COLOR,clrLimeGreen);
 ObjectSetInteger(ChartID(),"HBT"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBT"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBT"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBT"+Time[shift],OBJPROP_WIDTH,2);
 
 
 
 
 ObjectCreate(ChartID(),"HBL"+Time[shift],OBJ_TREND,0,Time[shiftt],Low[shiftt],Time[i],Low[shiftt]);
 ObjectSetInteger(ChartID(),"HBL"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBL"+Time[shift],OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HBL"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBL"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBL"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBL"+Time[shift],OBJPROP_WIDTH,2);
 
 ObjectCreate(ChartID(),"HBLO"+Time[shift],OBJ_TREND,0,Time[i],Low[shiftt],Time[i]+3*PeriodSeconds(),Low[shiftt]);
 ObjectSetInteger(ChartID(),"HBLO"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBLO"+Time[shift],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HBLO"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBLO"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBLO"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBLO"+Time[shift],OBJPROP_WIDTH,2);


  bool findo=false;
  int shifto=shiftt;
  
  
 for(int r=i-1;r>i-4;r--) {
 
 if ( r < 1 ) {
 if ( Low[0] < Low[shiftt] && High[0] < High[i]) {
 shifto=0;
 findo=true;
 }
 continue;
 }
 
 if ( findo == true ) continue;
 
 if ( Low[r] < Low[shiftt] && High[r] < High[i]) {
 shifto=r;
 findo=true;
 }
 
  }
   

 if ( findo == true ) {
 Print(shifto);
 ObjectCreate(ChartID(),"HO"+Time[i],OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 //ObjectSetString(ChartID(),"HO"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
 
 if ( sell_price != Low[shiftt] ) {
 
 

   double pip=PipPrice(Symbol(),profit,0,Lot);
   //Bid-1000*Point
   
   
   double pip_mesafe=(High[i]-Bid)/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;   
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level); 
 
 
 
 //if ( sell_total == 0 ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,High[i],Low[shiftt]-((High[i]-Low[shiftt])*tp_oran),"SELL",magic,0,clrNONE);
 if ( sell_total == 0 ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,High[i],Bid-pip_mesafe*Point,"SELL",magic,0,clrNONE);
 
 
 sell_price=Low[shiftt];
 }
 
 
 }
    
 
  
  
 
  
 }
 
 
 }
 


 
 

}




}




//continue;


//////////////////////////////////////////


if ( MB > MA //|| MB < MA

&& iaos1 < 0 && iaos2 < 0 && iaos3 < 0 

 ) {

bool find=false;
double price=Low[i];
int shift=i;
for (int r=i+1;r<i+6;r++) {

if ( price > Low[r] ) {
shift=r;
find=true;
}

}




if ( find == false && Low[i] < Low[i-1] && Low[i] < Low[i+1] && Open[i] < Band_Main
 ) {

 ObjectCreate(ChartID(),"L"+Time[i],OBJ_TREND,0,Time[i],Low[i],Time[i+6],Low[i]);
 ObjectSetInteger(ChartID(),"L"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"L"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"L"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"L"+Time[i],OBJPROP_RAY,False);
 
bool find=false;
double price=Low[i];
int shift=i;
int say=0;

if ( Open[i] > Close[i] ) say=1;

for (int r=i+1;r<i+6;r++) {

if ( find==true ) continue;

if ( Open[r] > Close[r] ) {
say=say+1;
shift=r;
} else {
find=true;
}
}



if ( say < 4 && find == true ) {

 ObjectCreate(ChartID(),"LR"+Time[i],OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
 ObjectSetInteger(ChartID(),"LR"+Time[i],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LR"+Time[i],OBJPROP_COLOR,clrOrange);
 ObjectSetInteger(ChartID(),"LR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LR"+Time[i],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LR"+Time[i],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LR"+Time[i],OBJPROP_WIDTH,2);
 
 
bool find=false;
double price=Low[i];
int shift=i;
int say=0;


for (int r=i+1;r<i+6;r++) {

double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);
double Band_Lowss = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r-1);

if ( find==true ) continue;

if ( Low[r] < Band_Lows && Low[r-1] > Band_Lowss) {
say=say+1;
shift=r;
find=true;
}
}
 
 if ( find == true ) {



 
 double price=High[shift];
 int shiftt=shift;
 bool findtt=false;
 
 for(int r=shift;r>=i;r--) {
 
 if ( High[r] > price && High[r] > High[r+1] && High[r] > High[r-1] ) {price=High[r];
 shiftt=r;
 findtt=true;
 }
 }
 
 if ( findtt == false ) continue;
 
 
 ObjectCreate(ChartID(),"LBT"+Time[shift],OBJ_TREND,0,Time[shift],Low[shift],Time[i],Low[i]);
 ObjectSetInteger(ChartID(),"LBT"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBT"+Time[shift],OBJPROP_COLOR,clrLimeGreen);
 ObjectSetInteger(ChartID(),"LBT"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBT"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBT"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBT"+Time[shift],OBJPROP_WIDTH,2); 
 
 
 
 ObjectCreate(ChartID(),"LBH"+Time[shift],OBJ_TREND,0,Time[shiftt],High[shiftt],Time[i],High[shiftt]);
 ObjectSetInteger(ChartID(),"LBH"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBH"+Time[shift],OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"LBH"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBH"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBH"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBH"+Time[shift],OBJPROP_WIDTH,2);
 
 ObjectCreate(ChartID(),"LBHO"+Time[shift],OBJ_TREND,0,Time[i],High[shiftt],Time[i]+3*PeriodSeconds(),High[shiftt]);
 ObjectSetInteger(ChartID(),"LBHO"+Time[shift],OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBHO"+Time[shift],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"LBHO"+Time[shift],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBHO"+Time[shift],OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBHO"+Time[shift],OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBHO"+Time[shift],OBJPROP_WIDTH,2);

 

  bool findo=false;
  int shifto=i;
  
  
  
 for(int r=i-1;r>i-4;r--) {
 
 
 if ( findo == true ) continue;
 
 if ( r < 1 ) {
 if ( High[0] > High[shiftt] && Low[0] > Low[i] ) {
 shifto=0;
 findo=true;
 }
 continue;
 }
 
 if ( High[r] > High[shiftt] && Low[r] > Low[i] ) {
 shifto=r;
 findo=true;
 }
 
  }
  
  
  
 if ( findo == true ) {
 ObjectCreate(ChartID(),"HO"+Time[i],OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HO"+Time[i],OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
 
 if ( buy_price != High[shiftt] ) {

 double pip_mesafe=(Ask-Low[i])/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;
   
   Print("Lot:",Lot);
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level); 
 
 
 //if ( buy_total == 0 ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Low[i],High[shiftt]+((High[shiftt]-Low[i])*tp_oran),"BUY",magic,0,clrNONE);
 if ( buy_total == 0 ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Low[i],Ask+pip_mesafe*Point,"BUY",magic,0,clrNONE);
 
 buy_price=High[shiftt];
 }
 
 
 }
 
 
  

 
 
  
 }
 
 
 }
 


 
 

}




}



  
  
  

}  
  
  
     
   
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
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
/////////////////////////////////////////////////////////////////////////////////////////////////////////

int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;

int OrderTotal=OrdersTotal();

bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;

/*eq_live_order=0;
eq_pen_order=0;
*/

//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

/*
if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}
*/


if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

/*
if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}
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

return sonuc;
};



////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandırır ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {


string OrderSymbols = sym;
double sonuc = 0;

//Print("Spread:",MarketInfo(OrderSymbols,MODE_SPREAD));


//if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;//DivZero((SymbolInfoDouble(Symbol(),SYMBOL_ASK)-SymbolInfoDouble(Symbol(),SYMBOL_BID)),Point);
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
        //if ( lots==0 ) lots=0.01;
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
    /*
    if ( lots != 0 ) {
    lots=DivZero(Order_Profit,pips);    
    DoubleToString(lots,2);
    fiyat=0;
    pips=0;
    sonuc=lots;
    
    Print(lots);
    }*/
    
    //if ( BS_spread_one == 0 ) {Alert("BS_spread_one Hatası:",OrderSymbols);return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = DivZero(fiyat,BS_spread_one);   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kaç piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kaç $ kazandırır ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}

return sonuc;


}
