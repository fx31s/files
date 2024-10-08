//+------------------------------------------------------------------+
//|                                                   EngulfBand.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=1;

input string MA_Indicator_Properties = "=======  Trend Moving Averages Properties ====="; //==================
extern bool Ma_Control=true; // Ma Control Order
input int MA_W=50;//Moving average period
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
  
    /*
  if ( IsTesting() == False ) {
  if ( int(TimeMonth(TimeCurrent())) != 2 ) {
  ExpertRemove();
  }
  }*/
  
  
  
//--- create timer
   EventSetTimer(1);
   
   ObjectsDeleteAll();
   
   
   if ( Lot < MarketInfo(Symbol(),MODE_MINLOT) ) Lot=MarketInfo(Symbol(),MODE_MINLOT);
  
   
OnTimer();
   
   

         
  
         
   
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
  


for (int i=4;i>0;i--) {

//Print(i);
  
  shift=i;
  
         double iaos1=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift);
         double iaos2=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+1);
         double iaos3=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+2);

  
   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,shift);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,shift);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,shift);
   
   double MA=iMA(Symbol(), MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 
   
   double RSI=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift);
   double RSIS=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift+1);
   
  // if ( Band_High > MA && Band_Low < MA ) {} else {continue;}
   
   if ( MA > Band_High || MA < Band_Low ) continue;
   


if (// Low[i] < Band_Low && 

Close[i] <= Band_Main && Close[i] > Open[i] && Open[i+1] > Close[i+1]

&& High[i] > High[i+1]

&& Low[i] < Low[i+1]

&& iaos1 < 0 && iaos2 < 0 && iaos3 < 0 

&& ( RSI <= 30 || RSIS <=30 )

&& Close[i] <= Band_Main

) {


 bool findt=false;
 int shiftt=i;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findt == true ) continue;
 
double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);
 
 if ( Low[r] < Band_Lows ) {
 shiftt=r;
 findt=true;
 }
 
  }
  
  


 
 double price=Low[i];
 bool find=false;

 for(int r=i+1;r<i+11;r++) {
 
 if ( price > Low[r] ) find =true;
 
  }

 bool findb=false;
 int say=0;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findb == true ) continue;
 
 if ( Close[r] < Open[r] ) {
 say=say+1;
 } else {
 findb=true;
 }
 
  }
  
  bool findo=false;
  int shifto=i;
  
  
  
 for(int r=i-1;r>i-4;r--) {
 
 
 if ( findo == true ) continue;
 
 if ( r < 1 ) {
 if ( High[0] > High[i] && Low[0] > Low[i] ) {
 shifto=0;
 findo=true;
 }
 continue;
 }
 
 if ( High[r] > High[i] && Low[r] > Low[i] ) {
 shifto=r;
 findo=true;
 }
 
  }
  
  
  
  
  

if ( find == false && say <= 3 ) {

 ObjectCreate(ChartID(),"HT"+Time[i],OBJ_VLINE,0,Time[shiftt],Ask);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HT"+Time[i],OBJPROP_TOOLTIP,"BandTocuh");
 

 ObjectCreate(ChartID(),"LB"+Time[i],OBJ_VLINE,0,Time[i],Ask);
 ObjectSetInteger(ChartID(),"LB"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LB"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LB"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"LB"+Time[i],OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);

 ObjectCreate(ChartID(),"LBL"+Time[i],OBJ_TREND,0,Time[i],Low[i],Time[i+11],Low[i]);
 ObjectSetInteger(ChartID(),"LBL"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LBL"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LBL"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBL"+Time[i],OBJPROP_RAY,False);
 
 //ObjectCreate(ChartID(),"LBR"+Time[i],OBJ_TREND,0,Time[i],High[i],Time[i-5],High[i]);
 ObjectCreate(ChartID(),"LBR"+Time[i],OBJ_TREND,0,Time[i],High[i],Time[i]+5*PeriodSeconds(),High[i]);
 ObjectSetInteger(ChartID(),"LBR"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LBR"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LBR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBR"+Time[i],OBJPROP_RAY,False);
 
 
 if ( findo == true ) {
 ObjectCreate(ChartID(),"HO"+Time[i],OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HO"+Time[i],OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
 
 
   

 
 
 if ( buy_price != High[i] ) {
 
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
 
 
 
 
 
 //if ( buy_total == 0 ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Low[i],High[i]+((High[i]-Low[i])*tp_oran),"BUY",magic,0,clrNONE);
 if ( buy_total == 0 ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Low[i],Ask+pip_mesafe*Point,"BUY",magic,0,clrNONE);
 buy_price=High[i];
 }
 
 
 }
 
 
 
 
}



}
   
  
  
//continue;
  


   
if ( //High[i] > Band_High && 


Close[i] >= Band_Main && Open[i] > Close[i] && Close[i+1] > Open[i+1]

&& High[i] > High[i+1]

&& Low[i] < Low[i+1]

&& iaos1 > 0 && iaos2 > 0 && iaos3 > 0 

&& ( RSI >= 70 || RSIS >=70 )

&& Close[i] >= Band_Main

) {


 bool findt=false;
 int shiftt=i;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findt == true ) continue;
 
double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r);
 
 
 if ( High[r] > Band_Highs ) {
 shiftt=r;
 findt=true;
 }
 
  }
  
  
  



 
 double price=High[i];
 bool find=false;

 for(int r=i+1;r<i+11;r++) {
 
 if ( price < High[r] ) find =true;
 
  }

 bool findb=false;
 int say=0;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findb == true ) continue;
 
 if ( Close[r] > Open[r] ) {
 say=say+1;
 } else {
 findb=true;
 }
 
  }
  
  
  
  bool findo=false;
  int shifto=i;
  
  
 for(int r=i-1;r>i-4;r--) {
 
 if ( r < 1 ) {
 if ( Low[0] < Low[i] && High[0] < High[i]) {
 shifto=0;
 findo=true;
 }
 continue;
 }
 
 if ( findo == true ) continue;
 
 if ( Low[r] < Low[i] && High[r] < High[i]) {
 shifto=r;
 findo=true;
 }
 
  }
  
  
  
  
  

if ( find == false && say <= 3 ) {

 ObjectCreate(ChartID(),"HT"+Time[i],OBJ_VLINE,0,Time[shiftt],Ask);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HT"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HT"+Time[i],OBJPROP_TOOLTIP,"BandTocuh");
 

 ObjectCreate(ChartID(),"HB"+Time[i],OBJ_VLINE,0,Time[i],Ask);
 ObjectSetInteger(ChartID(),"HB"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HB"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HB"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HB"+Time[i],OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);

 ObjectCreate(ChartID(),"HBL"+Time[i],OBJ_TREND,0,Time[i],High[i],Time[i+11],High[i]);
 ObjectSetInteger(ChartID(),"HBL"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HBL"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HBL"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBL"+Time[i],OBJPROP_RAY,False);
 
 ObjectCreate(ChartID(),"HBR"+Time[i],OBJ_TREND,0,Time[i],Low[i],Time[i]+5*PeriodSeconds(),Low[i]);
 ObjectSetInteger(ChartID(),"HBR"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HBR"+Time[i],OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HBR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBR"+Time[i],OBJPROP_RAY,False);
 
 if ( findo == true ) {
 Print(shifto);
 ObjectCreate(ChartID(),"HO"+Time[i],OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+Time[i],OBJPROP_STYLE,STYLE_DOT);
 //ObjectSetString(ChartID(),"HO"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
 
 
 
 
 if ( sell_price != Low[i] ) {
 
 

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
 
 
 
 //if ( sell_total == 0 ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,High[i],Low[i]-((High[i]-Low[i])*tp_oran),"SELL",magic,0,clrNONE);
 if ( sell_total == 0 ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,High[i],Bid-pip_mesafe*Point,"SELL",magic,0,clrNONE);
 sell_price=Low[i];
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
