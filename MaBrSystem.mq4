//+------------------------------------------------------------------+
//|                                                   MaBrSystem.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "MaBrSystem"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



//int magic=16;

string sym=Symbol();


double prices[16];
string pricen[16];


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

double bar_ortalama;

double distance=0;
int distance_pip=0;

int start_day=-1;


int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;

int OrderTotal=OrdersTotal();

double buy_price;
double sell_price;

int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

input string MA_Indicator_Properties = "=======  Trend Moving Averages Properties ====="; //==================
input int MA_W=50;//Moving average period
input ENUM_MA_METHOD MaMethod=MODE_EMA;  // Ma Method
input ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
input ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT; // Ma Period
//////////////////////////////////////////////////////////////////
input string MA_Breakout_Properties = "=======  Breakout Properties ====="; //==================
extern int ma__min__pip=10; // Ma Breakout Minumum Pip ( Kırılma Mumunun Ma en az ne kadar olacağı )
extern int ma__max__pip=300; // Ma Breakout Maximum Pip ( Kırılma Mumunun Kapanışının MA'ya uzaklığı en fazla ne kadar olacağı )
extern int ma__bar__total=1; // Ma Breakout Bar Close Total // Kırılma mumundan sonra kaç mum üstünde kapatacağı ( kaç mum sonra işleme gireceği )
extern bool ma__on__bar=false; // Ma Breakout Close Bar for On Bar - Ma Kırıldıktan sonra Barların Altına geçmeme kuralı
extern bool ma__line_show = true; // Ma History Line Show
extern int ma__bar__left=20; // Ma Bar Left Control ( Total Bar ) - Breakout Mumunun solundaki mumların aşağıda olma kuralı
extern int ma__order__pips=200; // Ma -> Order Open Distance Max Pips - İşleme girilen yer ile  MA arasındaki mesafe
/////////////////////////////////////////////////////////////////////
input string TP_Indicator_Properties = "=======  TakeProfit StopLoss ====="; //==================
extern int TP_Pips=300; // TakeProfit
extern int SL_Pips=500; // StopLoss
extern double Lot=0.01; // Lot
extern double TP_Usd = 0;
extern double SL_Usd = 0;
extern bool ma_sl_system = false; // MA SL System
//////////////////////////////////////////////////////////////////
input string Order_Level_Properties = "=======  Order Level ====="; //==================
extern int Order_Level=7; // Entry Open Order
extern int Order_Limit=100; // Max Open Order
//////////////////////////////////////////////////////////////////
input string Martingale_Properties = "=======  Martingale ====="; //==================
extern bool martingale=false; // Martingale ( Kademe )
extern double multiplier=2; // Multiplier ( Çarpan )
extern int distance_pip_manuel=300; // Distance Pip / 0 = Auto
//////////////////////////////////////////////////////////////////
input string Other_Properties = "=======  Other Properties ====="; //==================
//extern string rst_time="02:00"; // System Reset Time
extern int magic=16; // Ea MAgic Group Number
extern bool spread_filter=false;//Spread Filter
extern int max_spead = 0;//MaxSpread (zero or negative value means no limit)
double spread;
bool spread_onay = true;



double last_buy_lot;
double last_sell_lot;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  /*
  if ( IsTesting() == False ) {
  if ( int(TimeMonth(TimeCurrent())) != 2 ) {
  ExpertRemove();
  }
  }*/
  
  
  
  distance_pip=distance_pip_manuel;
  
  //macheck(ma__min__pip,ma__max__pip,ma__bar__total,ma__on__bar);
  
  
  /*
  if ( IsTesting() == True ) {} else {
  if ( IsDemo() ) {} else {
  ExpertRemove();
  }
  }
  if ( StringFind(Symbol(),"EURUSD",0) == -1 ) {ExpertRemove();}
  */
  
  
  symi=Symbol();
  sym=Symbol();  
  
  
  //mg_buy_lot=Lot;
  //mg_sell_lot=Lot;
  

  bool order_result=OrderCommetssTypeMulti(Symbol());
  
  
double MA=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 

         string name="MA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   
         //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, ObjectTimeFrame);  
         
   ObjectMove(0,"MA",0,Time[1]+(PeriodSeconds()*3),MA);
   ObjectMove(0,"MA",1,Time[3]+(PeriodSeconds()*3),MA);         
  

    
  
  
   
  
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
  
 
datetime macheck_time=-1;

bool macheck(int ma_min_pip,int ma_max_pip,int ma_bar_total,bool ma_on_bar,int ma_bar_left) {

if ( macheck_time == Time[1] ) {
return false;
}


bool sonuc=false;
int oks=0;
bool upbr=false;
bool downbr=false;

//int ma_bar_left=20;
bool ma_left_check=false;



for(int i=ma_bar_total;i>=1;i--) {

//Print(i);

double Maa=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, i); 

if ( upbr == true ) {

if ( (Close[i] > Maa && ma_on_bar == false)  || ( Open[i] > Maa && Close[i] > Maa && ma_on_bar == true )  ) {
oks=oks+1;
}


}

if ( i == ma_bar_total ) {
if ( Open[i] < Maa && Close[i] > Maa && DivZero((Close[i] - Maa),Point) >= ma_min_pip && DivZero((Close[i] - Maa),Point) <= ma_max_pip ) {
oks=oks+1;
upbr=true;

/////////////////////////////////////////////////////////////////
int left=0;
if ( ma_bar_left > 0 ) {
for(int ii=ma_bar_total+1;ii<=ma_bar_total+ma_bar_left;ii++) {

double Maaa=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, ii); 

if ( Open[ii] < Maaa && Close[ii] < Maaa ) {
left=left+1;
}
}

if ( ma_bar_left == left ) {
upbr=true;
} else {
upbr=false;
}
}
////////////////////////////////////////////////


} 

}

////////////////////////////////////////////////////////////
if ( downbr == true ) {
if ( (Close[i] < Maa && ma_on_bar == false) || ( Open[i] < Maa && Close[i] < Maa && ma_on_bar == true ) ) {
oks=oks+1;
}
}


if ( i == ma_bar_total ) {
if ( Open[i] > Maa && Close[i] < Maa && DivZero((Maa - Close[i]),Point) >= ma_min_pip && DivZero((Maa - Close[i]),Point) <= ma_max_pip ) {
oks=oks+1;
downbr=true;

/////////////////////////////////////////////////////////////////
int left=0;
if ( ma_bar_left > 0 ) {
for(int ii=ma_bar_total+1;ii<=ma_bar_total+ma_bar_left;ii++) {

double Maaa=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, ii); 

if ( Open[ii] > Maaa && Close[ii] > Maaa ) {
left=left+1;
}
}

if ( ma_bar_left == left ) {
downbr=true;
} else {
downbr=false;
}
}
////////////////////////////////////////////////





} 



}





}

if ( oks == ma_bar_total ) sonuc=true;

macheck_time=Time[1];

return sonuc;



}
  
  
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+


void OnTick()
  {
  /*
  if ( IsTesting() == True ) {} else {
  if ( IsDemo() ) {} else {
  ExpertRemove();
  }
  }
  if ( StringFind(Symbol(),"EURUSD",0) == -1 ) {ExpertRemove();}
  */
  


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
  
  
  
bool order_result=OrderCommetssTypeMulti(Symbol());


double MA=iMA(NULL, MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 

   //ObjectMove(0,"MA",0,Time[1],MA);
   //ObjectMove(0,"MA",1,Time[3]+(PeriodSeconds()*3),MA);
   
   ObjectSetDouble(ChartID(),"MA",OBJPROP_PRICE,MA);
   
   
   if ( ma__line_show == true ) {
         string name="MA"+Time[1];
         //ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_TREND,0,Time[1],MA,Time[1]+PeriodSeconds(),MA);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,1);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA");
         ObjectSetInteger(0,name,OBJPROP_RAY,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   
          ObjectSetInteger(0,name,OBJPROP_BACK,True);   
         //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, ObjectTimeFrame); 
         }
         
   

if ( OrdersTotal() != OrderTotal ) {
bool order_result=OrderCommetssTypeMulti(Symbol());
OrderTotal=OrdersTotal();
//AvarageSystem(magic);

if ( buy_total == 0 ) {last_buy_lot=Lot;}
if ( sell_total == 0 ) {last_sell_lot=Lot;}

}





/////////////////////////////////////////////////////////////////////////////////////
if ( buy_total == 0 && (Ask-MA)/Point <= ma__order__pips && spread_onay == true ) {
if ( Close[ma__bar__total] > Open[ma__bar__total] ) {
bool mac=macheck(ma__min__pip,ma__max__pip,ma__bar__total,ma__on__bar,ma__bar__left);
//if ( buy_total == 0 && DivZero((MA-Ask),(distance_pip*Point)) >= Order_Level ) {
if ( mac == true ) {

ObjectCreate(ChartID(),"V"+Time[ma__bar__total],OBJ_VLINE,0,Time[ma__bar__total],Ask);
ObjectSetInteger(ChartID(),"V"+Time[ma__bar__total],OBJPROP_BACK,True);

ObjectCreate(ChartID(),"T"+Time[ma__bar__total],OBJ_TREND,0,Time[ma__bar__total+ma__bar__left],Open[ma__bar__total],Time[ma__bar__total],Open[ma__bar__total]);
ObjectSetInteger(ChartID(),"T"+Time[ma__bar__total],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"T"+Time[ma__bar__total],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"O"+Time[ma__bar__total],OBJ_TREND,0,Time[ma__bar__total],Open[ma__bar__total],Time[1],Close[1]);
ObjectSetInteger(ChartID(),"O"+Time[ma__bar__total],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"O"+Time[ma__bar__total],OBJPROP_COLOR,clrWhite);




string cmt="BUY-0";
if ( martingale == true ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips > 0 && SL_Pips > 0 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,Ask-SL_Pips,Ask+TP_Pips*Point,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips == 0 && SL_Pips == 0 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips > 0 && SL_Pips == 0 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,Ask+TP_Pips*Point,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips == 0 && SL_Pips > 0 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,Ask-SL_Pips,0,cmt,magic,0,clrNONE);
buy_price=Ask;
}      
}
}
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

//if (sell_total == 0 && DivZero((Bid-MA),(distance_pip*Point)) >= Order_Level ) {
if (sell_total == 0  && (MA-Bid)/Point <= ma__order__pips && spread_onay == true ) {
if ( Open[ma__bar__total] > Close[ma__bar__total] ) {
bool mac=macheck(ma__min__pip,ma__max__pip,ma__bar__total,ma__on__bar,ma__bar__left);
if ( mac == true ) {

ObjectCreate(ChartID(),"V"+Time[ma__bar__total],OBJ_VLINE,0,Time[ma__bar__total],Ask);
ObjectSetInteger(ChartID(),"V"+Time[ma__bar__total],OBJPROP_BACK,True);

ObjectCreate(ChartID(),"T"+Time[ma__bar__total],OBJ_TREND,0,Time[ma__bar__total+ma__bar__left],Open[ma__bar__total],Time[ma__bar__total],Open[ma__bar__total]);
ObjectSetInteger(ChartID(),"T"+Time[ma__bar__total],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"T"+Time[ma__bar__total],OBJPROP_COLOR,clrBlue);

//ObjectCreate(ChartID(),"O"+Time[ma__bar__total],OBJ_TREND,0,Time[ma__bar__total],Open[ma__bar__total],Time[1],Open[ma__bar__total]);
ObjectCreate(ChartID(),"O"+Time[ma__bar__total],OBJ_TREND,0,Time[ma__bar__total],Open[ma__bar__total],Time[1],Close[1]);
ObjectSetInteger(ChartID(),"O"+Time[ma__bar__total],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"O"+Time[ma__bar__total],OBJPROP_COLOR,clrWhite);



string cmt="SELL-0";
if ( martingale == true )  int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
//if ( martingale == false ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,Bid+distance_pip*Point,Bid-distance_pip*Point,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips > 0 && SL_Pips > 0 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,Bid+SL_Pips*Point,Bid-TP_Pips*Point,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips == 0 && SL_Pips == 0) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips > 0 && SL_Pips == 0 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,Bid-TP_Pips*Point,cmt,magic,0,clrNONE);
if ( martingale == false && TP_Pips == 0 && SL_Pips > 0 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,Bid+SL_Pips*Point,0,cmt,magic,0,clrNONE);
sell_price=Bid;
}
}    
}
  
/////////////////////////////////////////////////////////////////////////////////////





/////////////////////////////////////////////////////////////////////////////////////
// Matingale
/////////////////////////////////////////////////////////////////////////////////////
if ( martingale == true && spread_onay == true ) {
if ( buy_total > 0 && (buy_price-Ask) >= distance_pip*Point && buy_total < Order_Limit ) {
string cmt="BUY-"+(buy_total+1);
double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(buy_total*multiplier),2);

if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
//if ( buy_total == 2 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;

if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_BUY,Lots,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
//if ( buy_total <= 2 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
//if ( buy_total > 2 && buy_total <= 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 4-6
//if ( buy_total > 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*3,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
buy_price=Ask;
}


if ( sell_total > 0 && (Bid-sell_price) >= distance_pip*Point && sell_total < Order_Limit) {
string cmt="SELL-"+(sell_total+1);
double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
//if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;


if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_SELL,Lots,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
//if ( sell_total <= 2 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
//if ( sell_total > 2 && sell_total <= 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 4-6
//if ( sell_total > 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*3,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
sell_price=Bid;
}



//////////////////////////////////////////////////////////////////////////////////
// İşlem Kapama
//////////////////////////////////////////////////////////////////////////////////
if ( buy_total >= 1 && buy_profit >= TP_Usd ) {
CloseAllBuyOrders();
}

if ( sell_total >= 1 && sell_profit >= TP_Usd ) {
CloseAllSellOrders();
}

if ( SL_Usd > 0 ) {
if ( buy_total >= 1 && buy_profit <= (SL_Usd*-1) ) {
CloseAllBuyOrders();
}

if ( sell_total >= 1 && sell_profit <= (SL_Usd*-1) ) {
CloseAllSellOrders();
}
}


//////////////////////////////////////////////////////////////////////////////////
}






//////////////////////////////////////////////////////////////////////////////////////
// DOLAR BAZLI KAPAMA
/////////////////////////////////////////////////////////////////////////////////////
if ( martingale == false ) {

if ( TP_Pips == 0 && TP_Usd > 0 ) {
if ( buy_total == 1 && buy_profit >= TP_Usd ) {
CloseAllBuyOrders();
}

if ( sell_total == 1 && sell_profit >= TP_Usd ) {
CloseAllSellOrders();
}

}

if ( SL_Pips == 0 && SL_Usd > 0 ) {
if ( buy_total == 1 && buy_profit <= (SL_Usd*-1) ) {
CloseAllBuyOrders();
}

if ( sell_total == 1 && sell_profit <= (SL_Usd*-1) ) {
CloseAllSellOrders();
}

}

////////////////////////////////////////////////////////
if ( ma_sl_system == true ) {
if ( buy_total == 1 && Close[1] < MA ) {
CloseAllBuyOrders();
}


if ( sell_total == 1 && Close[1] > MA ) {
CloseAllSellOrders();
}
}
////////////////////////////////////////////////////////





}
////////////////////////////////////////////////////////////////////////////////////////




  
  
//---
/////////////////////////////////////////////////////////////////////////
// RESETLEME SİSTEMİ
/////////////////////////////////////////////////////////////////////////
/*
if ( start_day != int(TimeDay(TimeCurrent())) && buy_total == 0 && sell_total == 0 ) {


  string reset_time = "02:00";
  reset_time=rst_time;
  //string risk_time = "14:30";// exness
  int day_left=0;
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+(TimeDay(TimeCurrent())-day_left)+" "+reset_time;
  datetime restart_time = StringToTime(yenitarih);
  
if ( restart_time >= TimeCurrent() ) {
  
ObjectsDeleteAll();
   //bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
     GridReset();
start_day=int(TimeDay(TimeCurrent()));

}


}
*/





   
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

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 

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
  
  
  
void GridReset() {



         
  

  bar_ortalama=BarOrtalama(1,300,Symbol(),Period());   

//int distance_pip=(distance/2)/Point;   



if ( distance_pip < (bar_ortalama/Point)*2 ) {
distance_pip=(bar_ortalama/Point)*2;
}


int askbid=(MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID))/Point;

if ( distance_pip < askbid*3 ) {
distance_pip=askbid*3;
}
  
///////////////////////////////////////  
if ( distance_pip_manuel != 0 ) {
distance_pip=distance_pip_manuel;
}  
//////////////////////////////////////
  
int wdf=WindowFirstVisibleBar();
int wdc=WindowBarsPerChart();
//int wc=(wdf-wdc)/2;
int wc=(wdc)/2;



double high_price=WindowPriceMax();
double low_price=WindowPriceMin();

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
  
  Comment("bar_ortalama:",bar_ortalama,"\n distance pip:",distance_pip,"\n eq:",eq,"\n wc:",wc,"\n wdf:",wdf,"\n wdc:",wdc);
  
  
  datetime start_time=Time[0];
  

  string name="ScreenLevel";//+Timei(1);
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  //ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,start_time,eq,end_time,eq);
  ObjectCreate(ChartID(),name+"Eq",OBJ_HLINE,0,Time[0],eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"Window EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_SELECTABLE,false);  
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_SELECTED,false);  
    

for(int i=1;i<100;i++) {


  double level=eq+((distance_pip*i)*Point);
  string levels="UP-"+i;
  //price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  //prices[7]=price; 
  //pricen[7]=levels;         
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_HLINE,0,Time[0],level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_BACK,True);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTABLE,false);  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTED,false);  

  level=eq-((distance_pip*i)*Point);
  levels="DOWN-"+i;
  //price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  //prices[7]=price; 
  //pricen[7]=levels;         
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_HLINE,0,Time[0],level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_BACK,True);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTABLE,false);  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTED,false);    
    


  //double level=eq+((distance_pip*i)*Point);
  levels="LEFT-"+i;
  //price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  //prices[7]=price; 
  //pricen[7]=levels;   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_VLINE,0,Time[wc]+((i*4)*PeriodSeconds()),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_BACK,True);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTABLE,false);  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTED,false);  


  levels="RIGHT-"+i;
  //price=NormalizeDouble(level,MarketInfo(sym,MODE_DIGITS));
  //prices[7]=price; 
  //pricen[7]=levels;   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_VLINE,0,Time[wc]-((i*4)*PeriodSeconds()),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_BACK,True);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTABLE,false);  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_SELECTED,false);    
  
    

      

}  
  

         name="MA";
         ObjectDelete(0,name);
         ObjectCreate(0,name,OBJ_HLINE,0,Time[1],Ask,Time[5],Bid);
         ObjectSetInteger(0,name,OBJPROP_COLOR,clrRed); 
         ObjectSetInteger(0,name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
         ObjectSetInteger(0,name,OBJPROP_WIDTH,4);
         ObjectSetString(0,name,OBJPROP_TEXT,"MA");
         ObjectSetInteger(0,name,OBJPROP_RAY_RIGHT,0); 
         ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);   
         //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, ObjectTimeFrame);  
         
  
} 

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
   