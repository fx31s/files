//+------------------------------------------------------------------+
//|                                                    SupDemRsi.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

 
      
input string RSI_Indicator_Properties = "=======  Trend Rsi Properties ====="; //==================
input int Rsi_W=50;//Rsi period
//input ENUM_MA_METHOD MaMethod=MODE_EMA;  // Rsi Method
input ENUM_APPLIED_PRICE RsiPrice=PRICE_CLOSE;// Rsi Price
input ENUM_TIMEFRAMES RsiTimeA = PERIOD_CURRENT; // Rsi Period
input bool Rsi_Control=True; // Rsi Control
input int Rsi_Up_Level = 70; // Rsi Up Level
input int Rsi_Down_Level = 30; // Rsi Down Level
//////////////////////////////////////////////////////////////////
input string TP_Indicator_Properties = "=======  TakeProfit StopLoss ====="; //==================
extern int TP_Pips=0; // TakeProfit
extern int SL_Pips=0; // StopLoss Minimum Pip ( Eğer bölge küçükse belirtilen minumum pip miktarı SL olarak belirlenir )
extern double Lot=0.01; // Lot
extern double TP_Usd = 10;
extern double SL_Usd = 0;
//////////////////////////////////////////////////////////////////
input string Order_Level_Properties = "=======  Order Level ====="; //==================
//extern int Order_Level=7; // Entry Open Order
extern int Order_Limit=100; // Max Open Order
//////////////////////////////////////////////////////////////////
input string Martingale_Properties = "=======  Martingale ====="; //==================
extern bool martingale=true; // Martingale ( Kademe )
extern double multiplier=2; // Multiplier ( Çarpan )
extern int distance_pip_manuel=0; // Distance Pip / 0 = Auto
//////////////////////////////////////////////////////////////////
input string Other_Properties = "=======  Other Properties ====="; //==================
extern string rst_time="02:00"; // System Reset Time
extern int supdem_length=100; // Minumum SupDem Lenght Time Period ( Min Bar Total )




double Ortalama;

double last_buy_lot;
double last_sell_lot;


//double Lot=0.01;
int magic=31;

bool order_buy=false;
bool order_sell=false;



int ObjTotal=ObjectsTotal();

datetime last_bar_time;

int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;

string last_buy_object="";
string last_sell_object="";

double buy_price;
double sell_price;

string sym=Symbol();


double bar_ortalama;

double distance=0;
int distance_pip=0;

int start_day=-1;

int OrderTotal=OrdersTotal();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
  /*
  if ( IsTesting() == True ) {} else {
  if ( IsDemo() ) {} else {
  ExpertRemove();
  }
  }
  if ( StringFind(Symbol(),"EURUSD",0) == -1 ) {ExpertRemove();}
     */
   
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

int time_left=0;

bool rsi_buy=false;
bool rsi_sell=false;

void OnTick()
  {
//---

 /* 
  if ( IsTesting() == True ) {} else {
  if ( IsDemo() ) {} else {
  ExpertRemove();
  }
  }
  if ( StringFind(Symbol(),"EURUSD",0) == -1 ) {ExpertRemove();}
  */
  

/////////////////////////////////////////////////////////////////////////
// Rsi Configration and Control
////////////////////////////////////////////////////////////////////////
        double RSI = iRSI(sym, RsiTimeA, Rsi_W, RsiPrice, 1);
        
        
        Comment("Rsi Level:",int(RSI),"\n Distance Pip:",distance_pip);
        
        
        
if ( Rsi_Control == true ) {

if ( RSI >= Rsi_Up_Level ) rsi_sell = true;
if ( RSI <= Rsi_Down_Level ) rsi_buy = true;

} else {

rsi_buy=true;
rsi_sell=true;

}
//////////////////////////////////////////////////////////////////////////      
      

bool order_result=OrderCommetssTypeMulti(Symbol());


if ( buy_total == 0 ) {
order_buy=false;
last_buy_lot=Lot;
}

if ( sell_total == 0 ) {
order_sell=false;
last_sell_lot=Lot;
}


 /* if ( ObjTotal != ObjectsTotal() ) {
  ObjTotal=ObjectsTotal();
  AlertObject();
  }*/
  
  
  //AlertObject();
  
  if ( last_bar_time != Time[1] ) {  
  time_left=time_left+1;
  if ( time_left > 50 ) AlertObject();
  last_bar_time=Time[1];
  }

/*
if ( OrdersTotal() != OrderTotal ) {
bool order_result=OrderCommetssTypeMulti(Symbol());
OrderTotal=OrdersTotal();
//AvarageSystem(magic);

if ( buy_total == 0 ) {last_buy_lot=Lot;}
if ( sell_total == 0 ) {last_sell_lot=Lot;}

}*/

  
  

/////////////////////////////////////////////////////////////////////////////////////
// Matingale
/////////////////////////////////////////////////////////////////////////////////////
if ( martingale == true ) {
if ( buy_total > 0 && (buy_price-Ask) >= distance_pip*Point && buy_total < Order_Limit ) {
string cmt="BUY-"+(buy_total+1);
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
//if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
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
}
////////////////////////////////////////////////////////////////////////////////////////

  
/////////////////////////////////////////////////////////////////////////
// RESETLEME SİSTEMİ
/////////////////////////////////////////////////////////////////////////
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



void AlertObject() {


    int obj_total=ObjectsTotal();
  string name;
  //for(int i=obj_total-1;i<obj_total;i++)
  for(int i=0;i<obj_total+1;i++)
  //for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     
     //Print(ObjectName(ObjectsTotal()-1),"/",ObjectName(int(ObjectsTotal()+1)),"/",ObjectName(int(ObjectsTotal())));
     
     int indexarrow_up=StringFind(name, "UPAR");
     int indexarrow_down=StringFind(name, "DNAR");
     
     int indexfill_up=StringFind(name, "UPFILL");
     int indexfill_down=StringFind(name, "DNFILL");
     

string last_select_object=name;
          
          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME1);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME2);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME3);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE1);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE3);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);     
          
          int obj_shift1=iBarShift(Symbol(),Period(),obj_time1);
          int obj_shift2=iBarShift(Symbol(),Period(),obj_time2);
     
     //if(ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_ARROW && last_name != name && indexarrow == -1 ) {
     
     if(ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_RECTANGLE  ) {
     
     if ( indexfill_up != -1 ) {
     
     
     if ( High[1] >= obj_prc2 && order_sell==false && name != last_sell_object ) {
     
     //if ( (obj_time1-obj_time2)/PeriodSeconds() > 200 ) {
     
     if ( obj_shift1 >= supdem_length && sell_total == 0 //&& obj_shift1 < 500
      ) {
     
     int time_lenght=(obj_time2-obj_time1)/PeriodSeconds();
     
     Print(i," Up object - ",name,"/",ObjectsTotal(),"/",time_lenght,"/",obj_shift1,"/",obj_shift2);
     
     double TP=0;
     if ( TP_Pips > 0 ) TP=Bid-TP_Pips*Point;
     
     double SL=obj_prc2;
     
     if ( SL_Pips > 0 && (obj_prc2-Bid)/Point < SL_Pips ) SL=Bid+SL_Pips*Point;

     int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,TP,SL,magic,0,clrNONE);
     
     /*if ( SL_Pips != 0 ) {
     
     if ( martingale == false && TP_Pips != 0 ) {
     int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,Bid-TP_Pips*Point,obj_prc1,magic,0,clrNONE);
     }*/

     

     
          
     
     
     order_sell=true;
     last_sell_object=name;
     sell_price=Bid;
     }
     }
     
     
     }
     
     if ( indexfill_down != -1 ) {
     //Print(i," Down object - ",name,"/",ObjectsTotal());
     
     
     
     if ( Low[1] <= obj_prc1 && order_buy==false && name != last_buy_object ) {
     
     //if ( (obj_time1-obj_time2)/PeriodSeconds() > 200 ) {
     
     if ( obj_shift1 >= supdem_length && buy_total == 0 //&& obj_shift1 < 500
      ) {
     
     int time_lenght=(obj_time2-obj_time1)/PeriodSeconds();
     
     Print(i," Down object - ",name,"/",ObjectsTotal(),"/",time_lenght,"/",obj_shift1,"/",obj_shift2);
     
     double TP=0;
     if ( TP_Pips > 0 ) TP=Ask+TP_Pips*Point;    
     
     double SL=obj_prc2;
     
     if ( SL_Pips > 0 && (Ask-obj_prc2)/Point < SL_Pips ) SL=Ask-SL_Pips*Point;
      
     
     int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,TP,SL,magic,0,clrNONE);
     order_buy=true;
     buy_price=Ask;
     last_buy_object=name;
     }
     }     
     
     
     
     
     
     
     
     
     
     }
          
     
     }
     
     if(ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_ARROW  ) {
     
     if ( indexarrow_up != -1 ) {
     
     }
     
     if ( indexarrow_down != -1 ) {
     
     }
     
     
          
     
     //Print(i," object - ",name,"/",ObjectsTotal());
     
     }
     
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

//Print(OrderComment());

double sl=StringToDouble(OrderComment());

if ( Close[1] <= sl && (TimeCurrent()-OrderOpenTime())/PeriodSeconds() > 0 ) {

if ( martingale == false ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
} else {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_lot=buy_lot+OrderLots();
}



} else {

buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_lot=buy_lot+OrderLots();

}


}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {

//Print(OrderComment());

double sl=StringToDouble(OrderComment());

if ( Close[1] >= sl && (TimeCurrent()-OrderOpenTime())/PeriodSeconds() > 0  ) {

if ( martingale == false ) {
OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
} else {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_lot=sell_lot+OrderLots();
}


} else {

sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_lot=sell_lot+OrderLots();

}

}





}

sonuc=true;

return sonuc;
};


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
 
 
 }     