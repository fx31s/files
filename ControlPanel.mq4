//+------------------------------------------------------------------+
//|                                                    AvaregeEa.mq4 |
//|                        Copyright 2024, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Mehmet Ozhan Hastaoglu "
#property link      "https://www.mql5.com"
#property version   "1.02"
#property icon "controlpanel.ico"
#ifdef __MQL5__ 
#define Ask    SymbolInfoDouble(_Symbol,SYMBOL_ASK)
#define Bid    SymbolInfoDouble(_Symbol,SYMBOL_BID)
#endif 
//--- redefine the order types from MQL5 to MQL4 for versatility of the code
#ifdef __MQL4__ 
#define ORDER_TYPE_BUY        OP_BUY
#define ORDER_TYPE_SELL       OP_SELL
#define ORDER_TYPE_BUY_LIMIT  OP_BUYLIMIT
#define ORDER_TYPE_SELL_LIMIT OP_SELLLIMIT
#define ORDER_TYPE_BUY_STOP   OP_BUYSTOP
#define ORDER_TYPE_SELL_STOP  OP_SELLSTOP
#endif 
#property strict

//--- SYMBOL_TRADE_STOPS_LEVEL and SYMBOL_TRADE_FREEZE_LEVEL levels
int freeze_level,stops_level;
//--- spread
double spread;


// Avarag TP
// Martingale Grid
// Firs Last Close
// Group Mum Sistemi



int active_magic_buy=0;
int active_magic_sell=0;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

int historytotal;



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
double today_buy_profit=0;
double today_sell_profit=0;
double today_buy_lot=0;
double today_sell_lot=0;
int today_buy_total=0;
int today_sell_total=0;


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
//////////////////////////////////////////////////////////////////
input string Order_Level_Properties = "=======  Order Level ====="; //==================
extern int Order_Level=7; // Entry Open Order
extern int Order_Limit=100; // Max Open Order
//////////////////////////////////////////////////////////////////
input string Martingale_Properties = "=======  Martingale ====="; //==================
extern bool martingales=false; // Martingale ( Kademe )
extern double multiplier=2; // Multiplier ( Çarpan )
extern int distance_pip_manuel=300; // Distance Pip / 0 = Auto
//////////////////////////////////////////////////////////////////
input string Other_Properties = "=======  Other Properties ====="; //==================
//extern string rst_time="02:00"; // System Reset Time
extern int magic=0; // Ea MAgic Group Number
extern bool spread_filter=false;//Spread Filter
extern int max_spead = 0;//MaxSpread (zero or negative value means no limit)
//double spread;
bool spread_onay = true;

extern int ObjeOran=100; // Object Screen Size Percent %


double last_buy_lot;
double last_sell_lot;



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
  if ( IsTesting() == True ) {
  
  order_mode=true;
  order_mode_buy=true;
  order_mode_sell=false;
  order_mode_trend=true;
  Lot=0.20;
  martingaleprofit=10;
  any=true;
  run=true;
  usdprofit=true;
  
  }
  
  
  if ( Lot < MarketInfo(Symbol(),MODE_MINLOT) ) Lot = MarketInfo(Symbol(),MODE_MINLOT);
  
  
      /*
  if ( IsTesting() == False ) {
  if ( int(TimeMonth(TimeCurrent())) != 3 ) {
  ExpertRemove();
  }
  }
  */
  
//--- create timer
   EventSetTimer(1);
   
   //historytotal=OrdersHistoryTotal();
   
   bool order_result=OrderCommetssTypeMulti(Symbol());
   
   
   ObjectsDeleteAll();
   
   
   string buttonID="ControlPanel";
   
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,297);   
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,215);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,300);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="ControlPanelBack";
   ObjectDelete(0,buttonID);   
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrSeaGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,295);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,59);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,289);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,257);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrMidnightBlue);
   
   
   buttonID="ControlPanelText";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,35);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Order Block Trend EA");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);      
   
   buttonID="ControlPanelTexts";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrLimeGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,70);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,37);
   //ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,155);
   //ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,33);   
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"FX Market");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   

   buttonID="ControlPanelTextSpread";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrYellow);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrYellow);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,107);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,37);
   //ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,155);
   //ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,33);   
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"2200");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,9);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   
   
      
   
   buttonID="OnlyBuy";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Only Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="Any";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"ANY");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && any == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 
   
      
   buttonID="OnlySell";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Only Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
      

   buttonID="CloseAllBuy";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Run";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Bold");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Run");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && run == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 
   

   buttonID="Pause";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,148);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Pause");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
         

   buttonID="CloseAllSell";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Bold");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   


  

   buttonID="CloseProfitBuy";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close Profit Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
   buttonID="BuyZone";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"UP      ");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,3);
   
    
    
   buttonID="BuyZoneLabel";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,175);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"zone");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
      

   buttonID="BuyZoneAutoLabel";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,174);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,152);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"auto");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
   
   
      
      

   buttonID="SellZone";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,148);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"  DOWN   ");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      


   buttonID="SellZoneLabel";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,127);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"zone");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
      

   buttonID="SellZoneAutoLabel";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,127);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,152);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"auto");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
   
   
      

   buttonID="CloseProfitSell";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close Profit Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
     
         
   
   


   buttonID="Buy";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"BUY 0");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Sell";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SELL 0");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="Up";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"+");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 



   buttonID="Edit";
   //Alert(ObjectFind(ChartID(),buttonID));
   if ( ObjectFind(ChartID(),buttonID) <= 0 ) {
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);   
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,Lot);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   Lot=MarketInfo(Symbol(),MODE_MINLOT);
   } else {
   Lot=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);   
   }
   
      ChartRedraw();
      

   buttonID="Down";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"-");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);    
   
   
   
   
   
         

   buttonID="CloseAllBuyPen";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Buy Pen");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="CloseAllSellPen";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Sell Pen");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="UpPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLimeGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"+");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 


string sym_path=SymbolInfoString(Symbol(),SYMBOL_PATH);

   buttonID="EditPoint";
   if ( ObjectFind(ChartID(),buttonID) <= 0 ) {
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,offset_point);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   if ( StringFind(sym_path,"Crypto",0) != -1 || StringFind(Symbol(),"BTC",0) != -1 ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   } else {
   offset_point=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);   
   }
   
      

   buttonID="DownPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrange);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"-");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="ClearTP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"CTP");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="MartinGale";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,260);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"MartinGale");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Downer";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,55);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,45);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Downer");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 


   buttonID="SetTP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Set TP");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
   

   buttonID="UsdProfit";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLimeGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"$");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && usdprofit == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 


   buttonID="MartinGaleProfit";
   if ( ObjectFind(ChartID(),buttonID) <= 0 ) {
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,martingaleprofit);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   } else {
   martingaleprofit=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);   
   }
   
      

   buttonID="PipsProfit";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrange);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"P");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);    




   buttonID="GroupSystem";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SK");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && order_mode == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 
   

   buttonID="GroupTrend";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,260);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"TRD");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && order_mode_trend == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 
 
   buttonID="GroupReserval";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,225);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"RES");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="GroupBar";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGold);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,45);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,15);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"2");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   


   buttonID="GroupTurbo";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBisque);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,15);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"T");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="GroupUp";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrTurquoise);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"UP");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && order_mode_sell == true  ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 

   buttonID="GroupDown";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,75);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"DW");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   if ( IsTesting() == True && order_mode_buy == true ) ObjectSetInteger(0,buttonID,OBJPROP_STATE,True); 
     
   


   buttonID="GroupUpPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLimeGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"+");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 



   buttonID="GroupEditPoint";
   if ( ObjectFind(ChartID(),buttonID) <= 0 ) {
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,range_point);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   } else {
   range_point=ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT);   
   min_bar_range=range_point;
   }
   
      

   buttonID="GroupDownPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrange);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,275);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"-");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
         
      


   buttonID="ControlPanelP";
   
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNavy);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,330);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,297);   
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,215);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="ControlPanelBackP";
   ObjectDelete(0,buttonID);   
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrSeaGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,295);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,359);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,289);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrMidnightBlue);
   

  
   buttonID="ControlPanelTextP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,333);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Result Table");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   



   
   buttonID="ControlPanelTextTime";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,337);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Time");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
   
   buttonID="ControlPanelTextsP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrLimeGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,120);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,337);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"PROFIT & LOT");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   
      
   

   buttonID="BuyLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BuyLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"ANY");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BuyProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrChartreuse);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      



   buttonID="SellLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="SellLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="SellProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   





   buttonID="BsLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Result");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BsLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BsProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightSlateGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   





   buttonID="TodayLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Today");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="TodayLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="TodayProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightSlateGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
               
   
   /*
   buyzone=true;
   sellzone=true;
   buyzoneprc=WindowPriceMin();
   sellzoneprc=WindowPriceMax();
   run=true;

ObjectCreate(ChartID(),"BUYZONEAUTO",OBJ_HLINE,0,Time[0],buyzoneprc);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_BACK,True);   
       
ObjectCreate(ChartID(),"SELLZONEAUTO",OBJ_HLINE,0,Time[0],sellzoneprc);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_BACK,True);


ObjectSetInteger(ChartID(),"BuyZone",OBJPROP_STATE,True);
ObjectSetInteger(ChartID(),"SellZone",OBJPROP_STATE,True);
*/

if ( IsTesting() == False ) {
ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,True);
ChartSetInteger(ChartID(),CHART_EVENT_MOUSE_MOVE,true);
}

   
   
   if ( ObjeOran != 100 ) Resize(ObjeOran);
   
   
bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
min_candle_body=bar_ortalama;
   
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

/////////////////////////////////////////////////////////////////////////////////////////


   int ticket;
//--- the current opening and SL/TP levels
/*
   ... get the ticket 
*/
//--- compare the distance to the current activation price with the SYMBOL_TRADE_FREEZE_LEVEL level
   if(CheckOrderForFREEZE_LEVEL(ticket))
     {
      // check succeeded, modify the order
     }


//--- distance from the activation price, within which it is not allowed to modify orders and positions
   freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: order or position modification is not allowed,"+
                  " if there are %d points to the activation price",freeze_level,freeze_level);
     }

//--- price levels for orders and positions
   double priceopen,stoploss,takeprofit;
//--- ticket of the current order 
   int orderticket;
/*
   ... get the order ticket and new StopLoss/Takeprofit/PriceOpen levels
*/
//--- check the levels before modifying the order   
   if(OrderModifyCheck(orderticket,priceopen,stoploss,takeprofit))
     {
      //--- checking successful
      OrderModify(orderticket,priceopen,stoploss,takeprofit,OrderExpiration());
     }
     

/////////////////////////////////////////////////////////////////////////
   if ( IsTesting() == False ) {
   if((MarketInfo(Symbol(),MODE_TRADEALLOWED))>0)
     {
      Print(" Market is Open and Trade is Allowed on This Symbol.");
     }
   else
     {
      Print ("Trade is not Allowed on This Symbol RightNow.");
      return;
     }
//////////////////////////////////////////////////////////////////
          }
          
//if ( OrdersTotal() > AccountInfoInteger(ACCOUNT_LIMIT_ORDERS)) return;












///////////////////////////////////////////////////////////////////////////////////////
   
  if ( IsTesting() == true ) OnTimer();
  
  
  
  if ( order_mode == true ) {
  
  if ( ObjectGetInteger(ChartID(),"GroupSystem",OBJPROP_BGCOLOR) == clrDarkRed ) 
  {ObjectSetInteger(ChartID(),"GroupSystem",OBJPROP_BGCOLOR,clrRed);}
  else {ObjectSetInteger(ChartID(),"GroupSystem",OBJPROP_BGCOLOR,clrDarkRed);
  }
  
  
  } else {
  ObjectSetInteger(ChartID(),"GroupSystem",OBJPROP_BGCOLOR,clrLightGray);
  }
   
   
   string buttonID="ControlPanelTextSpread";
   /*
	int min, sec;
	
   min = iTime(Symbol(),Period(),0) + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
     */
     //ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,min+":"+sec);

     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,DoubleToString(((Ask-Bid)/Point),0));

  if ( ObjectGetInteger(ChartID(),buttonID,OBJPROP_COLOR) == clrYellow ) 
  {ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrYellowGreen);}
  else {ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrYellow);
  }
  

   
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+

void OnChartEventObject(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


oda_type=-1;

//return;

//if ( buyzone == true || sellzone == true ) oda_type=-1;




             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
if ( ((buyzone == true || sellzone == true) && ObjectType(name) == OBJ_HLINE ) || ObjectType(name) == OBJ_EDIT || ObjectType(name) == OBJ_BUTTON ) {         
        
        
        if ( ObjectType(name) == OBJ_BUTTON ) {
        
        OnChartEventTest(name);
        
        }
        

        if ( ObjectType(name) == OBJ_EDIT ) {
        
        OnChartEventTest(name);
        
        
        
        }
                
        
        oda_wilcard="ZONEAUTO";
        
 int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  
  OnChartEventTest(name);
  
 /* Sleep(100);
  ObjectDelete(ChartID(),name);*/
  
  
   }  
   
   
   
   
   
  }
  
  
}
  
  
  
  }
  


void OnTimer()
  {
//---
	int min, sec;
	
   min = iTime(Symbol(),Period(),0) + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
     
     ObjectSetString(ChartID(),"ControlPanelTextTime",OBJPROP_TEXT,min+":"+sec);
     

if ( IsTesting() == True ) {
string sparam="";
OnChartEventObject(ChartID(),"",-1,OBJ_BUTTON);
}



if ( order_mode == true ) SkyperOrder();

//Print("Last_buy_price:",last_buy_price,"/ Sell_price:",last_sell_price);


////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
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
   

   string buttonID="Sell";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SELL "+sell_total);

   buttonID="Buy";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"BUY "+buy_total);      
   
   
   AvarageSystem(0);
   if ( spread_onay == true ) CoinHarvester();


   buttonID="BuyLotTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(buy_lot,2),2));    

   buttonID="BuyProfitTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(buy_profit,2),2));     
      
   buttonID="SellLotTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(sell_lot,2),2));    

   buttonID="SellProfitTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(sell_profit,2),2));     
      
   buttonID="BsLotTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(sell_lot+buy_lot,2),2));    

   buttonID="BsProfitTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(sell_profit+buy_profit,2),2));     
      
   buttonID="TodayLotTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(today_sell_lot+today_buy_lot,2),2));    

   buttonID="TodayProfitTotal";
   ObjectSetString(0,buttonID,OBJPROP_TEXT,""+DoubleToString(NormalizeDouble(today_sell_profit+today_buy_profit,2),2));     
      
////////////////////////////////////////////////////////////////////////////////////////////////////////                  
// Otomatik Kapama
////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( martingale == false ) {

if ( onlybuy == true && run == true && usdprofit == true && buy_profit >= martingaleprofit && martingaleprofit > 0) {
CloseAllBuyOrders();
}

if ( onlysell == true && run == true && usdprofit == true && sell_profit >= martingaleprofit && martingaleprofit > 0) {
CloseAllSellOrders();
}


if ( any == true && pause == true && usdprofit == true && sell_profit+buy_profit >= martingaleprofit && martingaleprofit > 0) {
CloseAllOrders();
}

//////////////////////////////////////////////////////////////////////
if ( any == true && run == true && usdprofit == true && martingaleprofit > 0 ) {

if (usdprofit == true && buy_profit >= martingaleprofit ) {
CloseAllBuyOrders();
}

if ( usdprofit == true && sell_profit >= martingaleprofit ) {
CloseAllSellOrders();
}
/////////////////////////////////////////////////////////////////////


}

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////


//Print("martingaleprofit",martingaleprofit);












//spread_onay
/////////////////////////////////////////////////////////////////////////////////////
// Matingale
/////////////////////////////////////////////////////////////////////////////////////
if ( martingale == true ) {




distance_pip=offset_point;
//if ( buy_price == -1 && buy_total > 0 ) buy_price=last_avarage_buy_profit_price;
//if ( sell_price == -1 && sell_total > 0) sell_price=last_avarage_buy_profit_price;

if ( buy_price == -1 && buy_total > 0 ) buy_price=last_avarage_buy;
if ( sell_price == -1 && sell_total > 0) sell_price=last_avarage_sell;


if ( buy_total == 0  && ( (onlybuy == true && onlysell == false)  || (onlybuy == false && onlysell == false) ) //&& run == true && pause == false && any == false 
 ) {
string cmt="BUY-0";
int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE);
buy_price=Ask;
}


if (sell_total == 0  && ( (onlybuy == false && onlysell == true)  || (onlybuy == false && onlysell == false) ) //&& run == true && pause == false && any == false
  ) {
string cmt="SELL-0";
if ( martingale == true )  int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
sell_price=Bid;
}



if ( buy_total > 0 && (buy_price-Ask) >= distance_pip*Point && buy_total < Order_Limit 

&& ( (onlybuy == true && onlysell == false)  || (onlybuy == false && onlysell == false) ) //&& run == true && pause == false && any == false

) {
string cmt="BUY-"+(buy_total+1);
//double Lots=NormalizeDouble((buy_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(buy_total*multiplier),2);
/*
if ( buy_total == 1 ) last_buy_lot=Lot*multiplier;
if ( buy_total == 2 ) last_buy_lot=Lot*multiplier;
//if ( buy_total == 2 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total == 3 ) last_buy_lot=last_buy_lot*multiplier;
if ( buy_total > 3 ) last_buy_lot=last_buy_lot*multiplier;
Lots=last_buy_lot;
*/
double Lots=NormalizeDouble(buy_lot*multiplier,2);


if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_BUY,Lots,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
//if ( buy_total <= 2 ) int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,0,0,cmt,magic,0,clrNONE); //1-3
//if ( buy_total > 2 && buy_total <= 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*2,Ask,0,0,0,cmt,magic,0,clrNONE); // 4-6
//if ( buy_total > 5 ) int ticket=OrderSend(sym,OP_BUY,Lot*3,Ask,0,0,0,cmt,magic,0,clrNONE); // 7--
buy_price=Ask;
}


if ( sell_total > 0 && (Bid-sell_price) >= distance_pip*Point && sell_total < Order_Limit

&& ( (onlybuy == false && onlysell == true)  || (onlybuy == false && onlysell == false) )// && run == true && pause == false && any == false

) {
string cmt="SELL-"+(sell_total+1);
/*
double Lots=NormalizeDouble((sell_total*Lot)*multiplier,2);
//double Lots=NormalizeDouble(Lot*(sell_total*multiplier),2);

if ( sell_total == 1 ) last_sell_lot=Lot*multiplier;
if ( sell_total == 2 ) last_sell_lot=Lot*multiplier;
//if ( sell_total == 2 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total == 3 ) last_sell_lot=last_sell_lot*multiplier;
if ( sell_total > 3 ) last_sell_lot=last_sell_lot*multiplier;
Lots=last_sell_lot;
*/

double Lots=NormalizeDouble(sell_lot*multiplier,2);


if ( multiplier == 0 ) Lots=Lot;
int ticket=OrderSend(sym,OP_SELL,Lots,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
//if ( sell_total <= 2 ) int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE); // 1-3
//if ( sell_total > 2 && sell_total <= 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*2,Bid,0,0,0,cmt,magic,0,clrNONE); // 4-6
//if ( sell_total > 5 ) int ticket=OrderSend(sym,OP_SELL,Lot*3,Bid,0,0,0,cmt,magic,0,clrNONE); // 7--
sell_price=Bid;
}


///////////////////////////////////////////////////////////////
if ( usdprofit == true && buy_profit >= martingaleprofit ) {
CloseAllBuyOrders();
}

if ( usdprofit == true && sell_profit >= martingaleprofit ) {
CloseAllSellOrders();
}

//if ( pipsprofit == true && Ask-last_avarage_buy_profit_price >= martingaleprofit ) {
if ( buy_total > 0 ) {
if ( pipsprofit == true && (Ask-last_avarage_buy)/Point >= martingaleprofit ) {
CloseAllBuyOrders();
}
}

//if ( pipsprofit == true && last_avarage_sell_profit_price-Bid >= martingaleprofit ) {
if ( sell_total > 0 ) {
if ( pipsprofit == true && (last_avarage_sell-Bid)/Point >= martingaleprofit ) {
CloseAllSellOrders();
}
}
///////////////////////////////////////////////////////////////






//////////////////////////////////////////////////////////////////////////////////
// İşlem Kapama
//////////////////////////////////////////////////////////////////////////////////
/*
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
*/

//////////////////////////////////////////////////////////////////////////////////





}
        
        
if ( downer == true && martingale == false ) {

if ( any == false && (onlybuy == true || (onlybuy==false && onlysell==false )) )DownerOrder(OP_BUY);
if ( any == false && (onlysell == true || (onlybuy==false && onlysell==false )) )DownerOrder(OP_SELL);
if ( any==true && onlybuy == false && onlysell == false ) DownerOrder(-1); // BuySell Mix

}

 
         
    
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+

bool onlybuy=false;
bool any=false;
bool onlysell=false;
bool run=false;
bool pause=false;
bool sellzone=false;
bool buyzone=false;
double buyzoneprc=-1;
double sellzoneprc=-1;


bool pipsprofit=true;
bool usdprofit=false;
bool martingale=false;
bool downer=false;
//double martingaleprofit=40000;
double martingaleprofit=100;
bool settp=false;
bool cleartp=false;



void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {


GroupChartEvent(sparam);


if ( sparam == "MartinGaleProfit" ) {


string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//martingaleprofit=StringToInteger(bilgi);
martingaleprofit=StringToDouble(bilgi);
martingaleprofit=NormalizeDouble(martingaleprofit,2);
//Comment("Bilgi:",bilgi,"/MartinGaleProfit:",martingaleprofit);


}


if ( sparam == "ClearTP" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {cleartp=true;} else {

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

cleartp=false;
}

Comment("ClearTP:",cleartp);


}


  


if ( sparam == "SetTP" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {settp=true;} else {

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

settp=false;
}

Comment("SetTP:",settp);


}



if ( sparam == "Downer" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {downer=true;} else{

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

downer=false;
}


Comment("Downer:",downer);


}


if ( sparam == "MartinGale" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {martingale=true;} else{

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

martingale=false;
}


Comment("MartinGale:",martingale);


}


if ( sparam == "UsdProfit" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {usdprofit=true;pipsprofit=false;

ObjectSetInteger(ChartID(),"PipsProfit",OBJPROP_STATE,False);
//ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{usdprofit=false;pipsprofit=false;}

Comment("UsdProfit:",usdprofit,"PipsProfit:",pipsprofit);


}

if ( sparam == "PipsProfit" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {usdprofit=false;pipsprofit=true;

ObjectSetInteger(ChartID(),"UsdProfit",OBJPROP_STATE,False);
//ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{usdprofit=false;pipsprofit=false;}

Comment("UsdProfit:",usdprofit,"PipsProfit:",pipsprofit);


}












      
        
  if ( id == CHARTEVENT_MOUSE_MOVE ) {

  
  int heightScreen=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
  int widthScreen=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
  

  int cyd=ObjectGetInteger(ChartID(),"ControlPanel",OBJPROP_YDISTANCE);
  int cys=ObjectGetInteger(ChartID(),"ControlPanel",OBJPROP_YSIZE);  
  int cxd=ObjectGetInteger(ChartID(),"ControlPanel",OBJPROP_XDISTANCE);
  int cxs=ObjectGetInteger(ChartID(),"ControlPanel",OBJPROP_XSIZE);
  int cpyd=ObjectGetInteger(ChartID(),"ControlPanelP",OBJPROP_YDISTANCE);
  int cpys=ObjectGetInteger(ChartID(),"ControlPanelP",OBJPROP_YSIZE);
  int cpxd=ObjectGetInteger(ChartID(),"ControlPanelP",OBJPROP_XDISTANCE);
  int cpxs=ObjectGetInteger(ChartID(),"ControlPanelP",OBJPROP_XSIZE);
    
  //Print(cxd+cxs,"/",cpyd+cpys);
  
  // X yatay
  // Y Dikey
  
  /*
   string buttonID="ControlPanelsss";
   
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNavy);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,cxd+20);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,cyd);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,cxs);   
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,215);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,(cpyd+cpys));
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
   
   ChartRedraw();
     */
  //(cpyd+cpys)-(cpyd-(cyd+cys))-(cpyd-(cyd+cys))
  
  
  //Print("POINT: "+(int)lparam,","+(int)dparam,","+(widthScreen-(int)lparam));
  
  //if ( (widthScreen-(int)lparam) <= 300 && (int)dparam < 327 ) {
  //if ( (widthScreen-(int)lparam) <= cyd+cys && (int)dparam < cpxd+cpxs ) {
  if ( (widthScreen-(int)lparam) <= cxd && (int)dparam < cpyd+cpys ) {
  ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);  
  } else {
  ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,True);  
  }
  

  
  }
  
//---
/*
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_BUTTON || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL) {

//ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False);
ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);


}

*/



if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}


if ( sparam == 32 ) {

if ( ChartGetInteger(ChartID(),CHART_DRAG_TRADE_LEVELS,0) == True ) {ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);} else {ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,True);}

Comment("DragLevel:",ChartGetInteger(ChartID(),CHART_DRAG_TRADE_LEVELS,0));

}






if ( sparam == "OnlyBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {onlybuy=true;onlysell=false;

ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{onlybuy=false;}

Comment("OnlyBuy:",onlybuy);


}





if ( sparam == "OnlySell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {onlysell=true;onlybuy=false;

ObjectSetInteger(ChartID(),"OnlyBuy",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{onlysell=false;}

Comment("OnlySell:",onlysell);


}





if ( sparam == "Any" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {any=true;onlysell=false;onlybuy=false;

ObjectSetInteger(ChartID(),"OnlyBuy",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

} else{any=false;}

Comment("Any:",any);

}


if ( sparam == "CloseAllBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
CloseAllBuyOrders();
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseAllBuy:");

}

if ( sparam == "CloseAllSell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllSellOrders();
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseAllSell:");

}


if ( sparam == "CloseProfitBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllProfitBuyOrders();
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseProfitBuy:");

}

if ( sparam == "CloseProfitSell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllProfitSellOrders();

Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseProfitSell:");

}






if ( sparam == "Run" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {run=true;pause=false;

ObjectSetInteger(ChartID(),"Pause",OBJPROP_STATE,False);

} else{run=false;}

Comment("Run:",run);


}

if ( sparam == "Pause" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {pause=true;run=false;

ObjectSetInteger(ChartID(),"Run",OBJPROP_STATE,False);

} else{pause=false;}

Comment("Pause:",pause);


}





if ( sparam == "BuyZone" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {buyzone=true;

ObjectCreate(ChartID(),"BUYZONEAUTO",OBJ_HLINE,0,Time[0],WindowPriceMin());
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_BACK,True);

buyzoneprc=WindowPriceMin();
buyzoneprc=NormalizeDouble(buyzoneprc,Digits);

//order_mode_buy=true;


} else{buyzone=false;
buyzoneprc=-1;
ObjectDelete(ChartID(),"BUYZONEAUTO");

//order_mode_buy=false;


}

Comment("BuyZone:",buyzone,"BuyZonePrc:",buyzoneprc,"order_mode_buy:",order_mode_buy);

}

if ( sparam == "BUYZONEAUTO" ) {

buyzoneprc=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE);
buyzoneprc=NormalizeDouble(buyzoneprc,Digits);

Comment("BuyZonePrc:",buyzoneprc);


}



if ( sparam == "SELLZONEAUTO" ) {

sellzoneprc=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE);
sellzoneprc=NormalizeDouble(sellzoneprc,Digits);

Comment("SellZonePrc:",sellzoneprc);


}


if ( sparam == "SellZone" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {sellzone=true;

ObjectCreate(ChartID(),"SELLZONEAUTO",OBJ_HLINE,0,Time[0],WindowPriceMax());
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_BACK,True);

sellzoneprc=WindowPriceMax();
sellzoneprc=NormalizeDouble(sellzoneprc,Digits);

//order_mode_sell=true;


} else{sellzone=false;

ObjectDelete(ChartID(),"SELLZONEAUTO");
sellzoneprc=-1;
//order_mode_sell=false;

}

Comment("SellZone:",sellzone,"SellZonePrc:",sellzoneprc,"order_mode_sell",order_mode_sell);



}







if ( sparam == "Buy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

Sleep(10);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);



} 

Comment("Buy:");


}

if ( sparam == "Sell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);

Sleep(10);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);


} 

Comment("Sell:");


}




if ( sparam == "Up" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"Edit",OBJPROP_TEXT);
double bilgid=StringToDouble(bilgi);
bilgid=bilgid+MarketInfo(Symbol(),MODE_MINLOT);
if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"Edit",OBJPROP_TEXT,DoubleToString(bilgid,2));
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
Lot=NormalizeDouble(bilgid,2);



} 

Comment("Up:",Lot);


}

if ( sparam == "Down" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"Edit",OBJPROP_TEXT);
double bilgid=StringToDouble(bilgi);
bilgid=bilgid-MarketInfo(Symbol(),MODE_MINLOT);
if ( bilgid < MarketInfo(Symbol(),MODE_MINLOT) ) bilgid=MarketInfo(Symbol(),MODE_MINLOT);
ObjectSetString(ChartID(),"Edit",OBJPROP_TEXT,DoubleToString(bilgid,2));
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
Lot=NormalizeDouble(bilgid,2);




} 

Comment("Down:",Lot);


}




if ( sparam == "Edit" ) {


string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

Lot=StringToDouble(bilgi);
Lot=NormalizeDouble(Lot,2);


Comment("Bilgi:",bilgi,"/Lot:",Lot);


}







if ( sparam == "UpPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"EditPoint",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;
//if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"EditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
offset_point=StringToInteger(bilgid);



} 

Comment("UpPoint:",offset_point);


}

if ( sparam == "DownPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"EditPoint",OBJPROP_TEXT);
int bilgid=StringToInteger(bilgi);
bilgid=bilgid-1;
if ( bilgid < 1 ) bilgid=1;
ObjectSetString(ChartID(),"EditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
offset_point=StringToInteger(bilgid);




} 

Comment("DownPoint:",offset_point);


}




if ( sparam == "EditPoint" ) {


string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

offset_point=StringToInteger(bilgi);

Comment("Bilgi:",bilgi,"/OffsetPoint:",offset_point);


}




if ( sparam == "CloseAllBuyPen" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
CloseAllPenOrdersTyp(Symbol(),OP_BUYLIMIT);
CloseAllPenOrdersTyp(Symbol(),OP_BUYSTOP);
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

buyzone=false;
buyzoneprc=-1;
ObjectDelete(ChartID(),"BUYZONEAUTO");

ObjectSetInteger(ChartID(),"BuyZone",OBJPROP_STATE,False);

} 
Comment("CloseAllBuyPen:");

}

if ( sparam == "CloseAllSellPen" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllPenOrdersTyp(Symbol(),OP_SELLLIMIT);
CloseAllPenOrdersTyp(Symbol(),OP_SELLSTOP);
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

sellzone=false;
sellzoneprc=-1;
ObjectDelete(ChartID(),"SELLZONEAUTO");

ObjectSetInteger(ChartID(),"SellZone",OBJPROP_STATE,False);

} 
Comment("CloseAllSellPen:");



}



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_BUTTON || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL) {

//ChartSetInteger(0,CHART_SHOW_ONE_CLICK,True);
//ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);
//ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);

}



/*
"OnlyBuy"
"Any"
"OnlySell"
"CloseAllBuy"
"Run"
"Pause"
"CloseAllSell"
"CloseProfitBuy"
"SellZone"
"BuyZone"
"CloseProfitSell"
"Buy"
"Sell"
"Up"
"Edit"
"Down"
*/



   
  }
//+------------------------------------------------------------------+


bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;


//Print(OrdersHistoryTotal());

if ( historytotal!=OrdersHistoryTotal() ) {

today_buy_lot=0;
today_sell_lot=0;
today_buy_profit=0;
today_sell_profit=0;
today_buy_total=0;
today_sell_total=0;

for(int cntf=OrdersHistoryTotal();cntf>=0;cntf--){

if(!OrderSelect(cntf, SELECT_BY_POS, MODE_HISTORY))continue;

if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && int(TimeDay(TimeCurrent())) == int(TimeDay(OrderCloseTime()))
 ) {
today_buy_total=today_buy_total+1;
today_buy_profit=today_buy_profit+OrderProfit()+OrderCommission()+OrderSwap();
today_buy_lot=today_buy_lot+OrderLots();
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && int(TimeDay(TimeCurrent())) == int(TimeDay(OrderCloseTime()))
 ) {
today_sell_total=today_sell_total+1;
today_sell_profit=today_sell_profit+OrderProfit()+OrderCommission()+OrderSwap();
today_sell_lot=today_sell_lot+OrderLots();
}




}

historytotal=OrdersHistoryTotal();

}



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
buy_profit=buy_profit+OrderProfit()+OrderCommission()+OrderSwap();
buy_lot=buy_lot+OrderLots();


if ( settp == true && onlybuy == true && pipsprofit == true ) {
Print(NormalizeDouble(last_avarage_buy_profit_price,Digits),"/",last_avarage_buy);
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),last_avarage_buy+(martingaleprofit)*Point,0,clrNONE);
}


if ( cleartp == true && onlybuy == true  ) {
Print(NormalizeDouble(last_avarage_buy_profit_price,Digits),"/",last_avarage_buy);
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),0,0,clrNONE);
}




}





if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit()+OrderCommission()+OrderSwap();
sell_lot=sell_lot+OrderLots();


if ( settp == true && onlysell == true && pipsprofit == true ) {
Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
Print(NormalizeDouble(last_avarage_sell_profit_price,Digits));
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),last_avarage_sell-(martingaleprofit)*Point,0,clrNONE);
}
/*
/////////////////////////////////////////////////////////////////////////
if ( settp == true && onlysell == true && usdprofit == true ) {
Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
Print(NormalizeDouble(last_avarage_sell_profit_price,Digits));

double pip_profit=PipPrice(Symbol(),martingaleprofit,0,OrderLots());
Print(pip_profit,"/$",martingaleprofit);
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-pip_profit*Point,0,clrNONE);
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
settp = false;



}*/
/////////////////////////////////////////////////////////////////
/*
/////////////////////////////////////////////////////////////////////////
if ( settp == true && onlysell == true && usdprofit == true ) {
Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
Print(NormalizeDouble(last_avarage_sell_profit_price,Digits),"/",sell_lot);

double pip_profit=PipPrice(Symbol(),martingaleprofit,0,sell_lot);
Print(pip_profit,"/$",martingaleprofit);
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),last_avarage_sell-pip_profit*Point,0,clrNONE);
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
settp = false;
}
/////////////////////////////////////////////////////////////////
*/





if ( cleartp == true && onlysell == true ) {
Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
Print(NormalizeDouble(last_avarage_sell_profit_price,Digits));
OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),0,0,clrNONE);
}







}





}

sonuc=true;




//onlysell=false;
//onlybuy=false;

/////////////////////////////////////////////////////////////////////////
// SetTP UsdProfit
////////////////////////////////////////////////////////////////////////
if ( settp == true && onlysell == true
 && pipsprofit == false && usdprofit == true  ) {


double pip_profit=PipPrice(Symbol(),martingaleprofit,0,sell_lot);

/////////////////////////////////////////////////////////////////////////
//Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
//Print(NormalizeDouble(last_avarage_sell_profit_price,Digits),"/",sell_lot);

//Print(pip_profit,"/$",martingaleprofit);

for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){
if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
if ( OrderType() == OP_SELL ) OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),last_avarage_sell-pip_profit*Point,0,clrNONE);
}
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
settp = false;
}
/////////////////////////////////////////////////////////////////

if ( settp == true && onlybuy == true
 && pipsprofit == false && usdprofit == true  ) {

double pip_profit=PipPrice(Symbol(),martingaleprofit,0,buy_lot);

/////////////////////////////////////////////////////////////////////////
//Print("Sell TP",last_avarage_sell_profit_price,"/",last_avarage_sell);
//Print(NormalizeDouble(last_avarage_sell_profit_price,Digits),"/",sell_lot);

Print(pip_profit,"/$",martingaleprofit);

for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){
if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
if ( OrderType() == OP_BUY ) OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),last_avarage_buy+pip_profit*Point,0,clrNONE);
}

ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
settp = false;
}
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////







/*
//////////////////////////////////////////////////
if ( settp == true //&& onlybuy == true
 && pipsprofit == false && usdprofit == true  ) {
if ( buy_profit >= martingaleprofit ) {
CloseAllBuyOrders();
settp=false;
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
}
}

if ( settp == true //&& onlybuy == true 
&& pipsprofit == false && usdprofit == true  ) {
if ( sell_profit >= martingaleprofit ) {
CloseAllSellOrders();
settp=false;
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
}
}
/////////////////////////////////////////////////////////
*/


if ( pipsprofit == true ) {
settp=false;
ObjectSetInteger(ChartID(),"SetTP",OBJPROP_STATE,False);
}


if ( cleartp == true ) {
cleartp=false;
ObjectSetInteger(ChartID(),"ClearTP",OBJPROP_STATE,False);
}



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


bool DistanceOrders(double ord_prc,int ord_typ)
{

bool sonuc=true;

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {


         if ( ord_typ == OP_BUY && OrderType() == OP_BUY ) {
         if ( Ask > OrderOpenPrice() && (Ask-OrderOpenPrice())/Point < offset_point ) sonuc=false;
         if ( Ask < OrderOpenPrice() && (OrderOpenPrice()-Ask)/Point < offset_point ) sonuc=false;         
         }

         if ( ord_typ == OP_SELL && OrderType() == OP_SELL ) {
         if ( Bid > OrderOpenPrice() && (Bid-OrderOpenPrice())/Point < offset_point ) sonuc=false;
         if ( Bid < OrderOpenPrice() && (OrderOpenPrice()-Bid)/Point < offset_point ) sonuc=false;         
         }
                  


         }
      }
    }
    
  return sonuc;
    
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
    
    last_sell_price=-1;
    last_sell_up_price=-1;
    last_sell_down_price=-1;
    last_sell_first_price=-1;
    
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
   
   last_buy_price=-1;
   last_buy_up_price=-1;
   last_buy_down_price=-1;
   last_buy_first_price=-1;
   
}



void CloseAllProfitBuyOrders()
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic  && OrderProfit() > 0 )
         {
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), Bid, 0, Blue);
         }
      }
    }
}

void CloseAllProfitSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderProfit() > 0  )
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void AvarageSystem(int mgc) {

//if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {


///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
//if ( OrdersTotal() > 0 ) {

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
        
        Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell,"\n LastAvarageBuy:",last_avarage_buy,"\n LastAvarageSell:",last_avarage_sell);
        
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
last_avarage_buy_profit_price=avarage_buy_profit_price;
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
last_avarage_sell_profit_price=avarage_sell_profit_price;
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
last_avarage_buy=avarage_buy;
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
last_avarage_sell=avarage_sell;
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
  
  
    
  
  
  
  
  
  
//}

//}


}

   
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
   

extern double sell_start_price=0;//1.167442;//23
extern double sell_finish_price=0;//1.11966;//21;
extern  bool sell_start_ea = false;
extern  bool sell_finish_ea = false;

extern double buy_start_price=0;//1.167442;//23
extern double buy_finish_price=0;//1.11966;//21;
extern  bool buy_start_ea = false;
extern  bool buy_finish_ea = false;
  
  
  
extern bool order_type_buy = false;  
extern bool order_type_sell = true;  

extern double offset_point = 1000;

int ticket_limit=-1;
int ticket_stop=-1;
int ticket_live=-1;

int order_typ;//=OP_BUY;

extern double lot=0.01;
//int MagicNumber=666;
int MagicNumber=0;

   

 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderDeletes(string cmt,string sym,int typ){

int coms = 0;



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt ) && OrderSymbol() == sym && type == typ ) {
   
   OrderDelete(OrderTicket(),clrNONE);
   

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};
 
 
 


 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderCommetlive(string cmt,string sym,int typ){

int coms = 0;



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt ) && OrderSymbol() == sym && type == typ ) {
   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};
 


void CoinHarvester()
  {
  
  
  buy_start_price=buyzoneprc;
  sell_start_price=sellzoneprc;

 lot=Lot;
 

order_type_buy=False;
order_type_sell=False;

order_typ=-1;



if ( onlysell == false && buyzone == true && run == true && buyzoneprc != -1.0 && any == false ) {
if ( Bid > buyzoneprc ) order_type_buy=true;
}

if ( order_type_buy == true ) {order_typ = OP_BUY;}
else {
order_typ = -1;
}



if ( order_typ == OP_BUY ) {

//////////////////////////////////////////////////////////////////////   
   if ( buy_start_ea == false &&  buy_finish_ea == false ) {
   
   //if ( Close[2] < start_price && Bid >= start_price ) {
  /* if ( Close[2] < start_price && Close[1] >= start_price ) {
   
   start_ea = true;
   
   }   */
   
   
   if ( Bid > buyzoneprc ) {
    buy_start_ea=true;
    buy_finish_ea=false;
    buy_start_price=buyzoneprc;
   //finish_price=sellzoneprc;
   }
   
   if ( Bid < buyzoneprc ) {
    buy_start_ea=false;
    buy_finish_ea=true;
   }
   
   
   }
//////////////////////////////////////////////////////////////////////   

if (  buy_start_ea == true &&  buy_finish_ea == false ) {

//if ( Bid >= start_price+(offset_point*2)*Point && Bid <= finish_price-(offset_point*2)*Point ) {

//if ( Bid >= start_price+(offset_point*2)*Point //&& Bid <= finish_price-(offset_point*2)*Point 

if ( Bid >=  buy_start_price //&& Bid <= finish_price-(offset_point*2)*Point 

) {

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// İşlem Aktif oldu ise diğerini iptal eder.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 1 &&

((OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT) == 1 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_BUYSTOP) == 0) ||

(OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_BUYSTOP) == 1)

)) {
//OrderDelete(ticket_stop,clrNONE);
//OrderDelete(ticket_limit,clrNONE);


 OrderDeletes("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT);
 OrderDeletes("CoinHarvester-Stop",Symbol(),OP_BUYSTOP);

}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 0 &&

((OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT) == 1 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_BUYSTOP) == 0) ||

(OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_BUYSTOP) == 1)

)) {
//OrderDelete(ticket_stop,clrNONE);
//OrderDelete(ticket_limit,clrNONE);


 OrderDeletes("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT);
 OrderDeletes("CoinHarvester-Stop",Symbol(),OP_BUYSTOP);

}



/// İşlem

// Canlıda İşlem Yoksa

if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 0 && OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_BUYLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_BUYSTOP) == 0 ) {//Ask+1*Point

//if (  ) 
ticket_limit=OrderSend(Symbol(),OP_BUYLIMIT,lot,Bid-offset_point*Point,0,0,Bid,"CoinHarvester-Limit",MagicNumber,0,clrNONE);

//if ( )  
ticket_stop=OrderSend(Symbol(),OP_BUYSTOP,lot,Ask+offset_point*Point,0,0,Ask+(offset_point*2)*Point,"CoinHarvester-Stop",MagicNumber,0,clrNONE);

}


//////////////////////////////////////////////////////////////////////////
// Canlıda İşleme Girdiyse Diğeri İptal
/////////////////////////////////////////////////////////////////////////
// Biri Diğerini İptal Eder
if ( OrderCommetlive("CoinHarvester-Limit",Symbol(),order_typ) == 1 ) {
//OrderDelete(ticket_stop,clrNONE);
OrderDeletes("CoinHarvester-Stop",Symbol(),OP_BUYSTOP);
}

// Biri Diğerini İptal Eder
if ( OrderCommetlive("CoinHarvester-Stop",Symbol(),order_typ) == 1 ) {
//OrderDelete(ticket_limit,clrNONE);
OrderDeletes("CoinHarvester-Limit",Symbol(),OP_BUYSTOP);
}




}

}




/*
if ( Bid >= finish_price ) {
finish_ea=true;
//start_ea=true;
}*/


/*
//////////////////////////////////////////////////////////////////////
// Finish - Target Price
//////////////////////////////////////////////////////////////////////
if ( start_ea == true && finish_ea == false ) {

if ( Bid <= finish_price && order_type_sell == true && order_type_buy == false && order_typ == OP_SELL) {
finish_ea=true;
//start_ea=true;
}

////////////////////
if ( Bid >= finish_price && order_type_sell == false && order_type_buy == true  && order_typ == OP_BUY) {
finish_ea=true;
//start_ea=true;
}




}
   */
   

}   


//start_ea=false;
//finish_ea=false;


if ( onlybuy == false && sellzone == true && run == true && sellzoneprc != -1.0 && any == false ) {
if ( Ask < sellzoneprc ) order_type_sell=true;
}


if ( order_type_sell == true ) {
order_typ = OP_SELL;
} else {
order_typ = -1;
}
  


////////////////////////////////////////////////////////////////////////
if ( order_typ == OP_SELL ) {




//////////////////////////////////////////////////////////////////////   
   if ( sell_start_ea == false && sell_finish_ea == false ) {
   
   //if ( Bid >= start_price ) {
  /* if ( Close[2] > start_price && Close[1] < start_price ) {
   
   start_ea = true;
   
   } */
   
   if ( Bid < sellzoneprc ) {
   sell_start_ea=true;
   sell_finish_ea=false;
   sell_start_price=sellzoneprc;
   
   
   
   //finish_price=sellzoneprc;
   }
   
   if ( Bid > sellzoneprc ) {
   sell_start_ea=false;
   sell_finish_ea=true;
   }
      
   
     
   
   }
   
   //Alert(sellzoneprc,"/",start_ea,"/",finish_ea,"/",start_price,"/",sellzoneprc);
   
//////////////////////////////////////////////////////////////////////   

if ( sell_start_ea == true && sell_finish_ea == false ) {

//if ( Bid <= start_price && Bid >= finish_price+(offset_point*2)*Point ) {


if ( Bid <= sell_start_price //&& Bid >= finish_price+(offset_point*2)*Point

 ) {




///////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 1 &&

((OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT) == 1 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_SELLSTOP) == 0) ||

(OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_SELLSTOP) == 1)

)) {
//OrderDelete(ticket_stop,clrNONE);
//OrderDelete(ticket_limit,clrNONE);


 OrderDeletes("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT);
 OrderDeletes("CoinHarvester-Stop",Symbol(),OP_SELLSTOP);

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////





////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////
if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 0 &&

((OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT) == 1 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_SELLSTOP) == 0) ||

(OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_SELLSTOP) == 1)

)) {
//OrderDelete(ticket_stop,clrNONE);
//OrderDelete(ticket_limit,clrNONE);


 OrderDeletes("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT);
 OrderDeletes("CoinHarvester-Stop",Symbol(),OP_SELLSTOP);

}
/////////////////////////////////////////////////////////////////////////////////////////////////////////



/// İşlem

// Canlıda İşlem Yoksa

if ( OrderCommetlive("CoinHarvester",Symbol(),order_typ) == 0 && OrderCommetlive("CoinHarvester-Limit",Symbol(),OP_SELLLIMIT) == 0 && OrderCommetlive("CoinHarvester-Stop",Symbol(),OP_SELLSTOP) == 0) {//Bid-1*Point

//if (  ) 

ticket_limit=OrderSend(Symbol(),OP_SELLLIMIT,lot,Ask+offset_point*Point,0,0,Ask,"CoinHarvester-Limit",MagicNumber,0,clrNONE);

//if (  )  

ticket_stop=OrderSend(Symbol(),OP_SELLSTOP,lot,Bid-offset_point*Point,0,0,Bid-(offset_point*2)*Point,"CoinHarvester-Stop",MagicNumber,0,clrNONE);

}


//////////////////////////////////////////////////////////////////////////
// Canlıda İşleme Girdiyse Diğeri İptal
/////////////////////////////////////////////////////////////////////////
// Biri Diğerini İptal Eder
if ( OrderCommetlive("CoinHarvester-Limit",Symbol(),order_typ) == 1 ) {
//OrderDelete(ticket_stop,clrNONE);
OrderDeletes("CoinHarvester-Stop",Symbol(),OP_SELLLIMIT);
}

// Biri Diğerini İptal Eder
if ( OrderCommetlive("CoinHarvester-Stop",Symbol(),order_typ) == 1 ) {
//OrderDelete(ticket_limit,clrNONE);
OrderDeletes("CoinHarvester-Limit",Symbol(),OP_SELLSTOP);
}



}

}



/*
if ( Bid >= finish_price ) {
finish_ea=true;
//start_ea=true;
}*/

/*
//////////////////////////////////////////////////////////////////////
// Finish - Target Price
//////////////////////////////////////////////////////////////////////
if ( start_ea == true && finish_ea == false ) {


if ( Bid <= finish_price && order_type_sell == true && order_type_buy == false && order_typ == OP_SELL) {
finish_ea=true;
//start_ea=true;
}

////////////////////
if ( Bid >= finish_price && order_type_sell == false && order_type_buy == true  && order_typ == OP_BUY) {
finish_ea=true;
//start_ea=true;
}




}
*/
   

}   
   
   
   ///Comment("Start EA:",start_ea,"/ Finish EA:",finish_ea);
   //Comment("\nStart EA:",start_ea,"\nFinish EA:",finish_ea,"\nStart Price",start_price,"\nFinish Price:",finish_price,"\nBuy:",order_type_buy,"\nSell:",order_type_sell,"\noffset_point",offset_point,"\nlot",lot);   
   
   
  }
   
   

void DownerOrder(int do_ord_typ) {


if ( do_ord_typ == OP_BUY ) Print("DownOrderBuy");
if ( do_ord_typ == OP_SELL ) Print("DownOrderSell");
if ( do_ord_typ == -1 ) Print("DownOrderBuySellMix");

//Print("DownerOrder");


string profit_order_list="";

//if ( OrderTotal != OrdersTotal() ) {

long n_ordticket;
double n_ordprofit;

bool negative=false;
double negative_profit_usd_min=-0.50;

   //for (int h=OrdersTotal();h>=0;h--)
   for (int h=0;h<=OrdersTotal()-1;h++)
   {

   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() && ( OrderType()==do_ord_typ || do_ord_typ == -1 )) {
   if ( negative == false ) {
   if ( OrderProfit() <= negative_profit_usd_min ) {   
   //Print(h,"/",OrderTicket(),"/",OrderProfit());
   //Comment("OrderTicket:",OrderTicket(),"/ OrderProfit:",OrderProfit());
   negative=true;   
   n_ordticket=OrderTicket();
   n_ordprofit=OrderProfit()+OrderCommission()+OrderSwap();  
   profit_order_list=","+OrderTicket();     
   }
   }
   }
   }
   
   //}
   
   
   double profit_target_usd=0;
   
   if ( negative == true ) {

   bool profit_target=false;
   profit_target_usd=0;
   double profit_usd=2;
   //double profit_usd=0.50;
   //double profit_usd_min=0.20;
   double profit_usd_min=0.50;
   
   if ( martingaleprofit < 100 ) profit_target_usd=martingaleprofit;
   
   

   for (int h=OrdersTotal();h>=0;h--)
   //for (int h=0;h<=OrdersTotal()-1;h++)
   {
   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() && ( OrderType()==do_ord_typ || do_ord_typ == -1 ) ) {
   if ( profit_target == false ) {
   if ( OrderProfit() >= profit_usd_min ) {  
   profit_target_usd=profit_target_usd+OrderProfit()+OrderCommission()+OrderSwap(); 
   if ( profit_target_usd-MathAbs(n_ordprofit) >= profit_usd ) { 
   profit_target=true;  
   if ( profit_order_list == "" ) {profit_order_list=","+OrderTicket();} else {
   profit_order_list=profit_order_list+","+OrderTicket();
   }
          
   }
   }
   }
   }
   }
   
   
   if ( profit_target == true && profit_target_usd-MathAbs(n_ordprofit) >= profit_usd ) {

   for (int h=OrdersTotal();h>=0;h--)
   //for (int h=0;h<=OrdersTotal()-1;h++)
   {
   if ( OrderSelect(h,SELECT_BY_POS) && OrderSymbol() == Symbol() && ( OrderType()==do_ord_typ || do_ord_typ == -1 )) {
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

  }
  
  

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
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
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

  
////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrices(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price/BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {Alert("BS_spread_one Hatasi:",OrderSymbols);return sonuc;}
         
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
  
  
/////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////



/*
void OnChartEventTest(int id,long lparam,double dparam,string sparam)
  {*/

void OnChartEventTest(string sparam)
  {



//Print("UsdProfit:",usdprofit);





if ( sparam == "MartinGaleProfit" ) {
                

string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//martingaleprofit=StringToInteger(bilgi);
martingaleprofit=StringToDouble(bilgi);
martingaleprofit=NormalizeDouble(martingaleprofit,2);


//Comment("Bilgi:",bilgi,"/MartinGaleProfit:",martingaleprofit);
//Print("Bilgi:",bilgi,"/MartinGaleProfit:",martingaleprofit);


}


if ( sparam == "ClearTP" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {cleartp=true;} else {

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

cleartp=false;
}

Comment("ClearTP:",cleartp);


}


  


if ( sparam == "SetTP" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {settp=true;} else {

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

settp=false;
}

Comment("SetTP:",settp);


}



if ( sparam == "Downer" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {downer=true;} else{

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

downer=false;
}


Comment("Downer:",downer);


}


if ( sparam == "MartinGale" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {martingale=true;} else{

//ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

//Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

martingale=false;
}


Comment("MartinGale:",martingale);


}


if ( sparam == "UsdProfit" && ObjectGetInteger(ChartID(),"PipsProfit",OBJPROP_STATE) == 0) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {usdprofit=true;pipsprofit=false;

ObjectSetInteger(ChartID(),"PipsProfit",OBJPROP_STATE,False);
//ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} /*else{usdprofit=false;pipsprofit=false;}*/

Comment("UsdProfit:",usdprofit,"PipsProfit:",pipsprofit);


}

if ( sparam == "PipsProfit" && ObjectGetInteger(ChartID(),"UsdProfit",OBJPROP_STATE) == 0 ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {usdprofit=false;pipsprofit=true;

ObjectSetInteger(ChartID(),"UsdProfit",OBJPROP_STATE,False);
//ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} 


/*else{usdprofit=false;pipsprofit=false;}*/

Comment("UsdProfit:",usdprofit,"PipsProfit:",pipsprofit);


}












      
        /*
  if ( id == CHARTEVENT_MOUSE_MOVE ) {
  
    int heightScreen=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
  int widthScreen=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
  
  //Print("POINT: "+(int)lparam,","+(int)dparam,","+(widthScreen-(int)lparam));
  
  if ( (widthScreen-(int)lparam) <= 300 && (int)dparam < 327 ) {
  ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);  
  } else {
  ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,True);  
  }
  

  
  }*/
  
//---
/*
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_BUTTON || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL) {

//ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False);
ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);


}

*/



if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}


if ( sparam == 32 ) {

if ( ChartGetInteger(ChartID(),CHART_DRAG_TRADE_LEVELS,0) == True ) {ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);} else {ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,True);}

Comment("DragLevel:",ChartGetInteger(ChartID(),CHART_DRAG_TRADE_LEVELS,0));

}






if ( sparam == "OnlyBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {onlybuy=true;onlysell=false;

ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{onlybuy=false;}

Comment("OnlyBuy:",onlybuy);


}





if ( sparam == "OnlySell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {onlysell=true;onlybuy=false;

ObjectSetInteger(ChartID(),"OnlyBuy",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"Any",OBJPROP_STATE,False);

} else{onlysell=false;}

Comment("OnlySell:",onlysell);


}





if ( sparam == "Any" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {any=true;onlysell=false;onlybuy=false;

ObjectSetInteger(ChartID(),"OnlyBuy",OBJPROP_STATE,False);
ObjectSetInteger(ChartID(),"OnlySell",OBJPROP_STATE,False);

} else{any=false;}

Comment("Any:",any);

}


if ( sparam == "CloseAllBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
CloseAllBuyOrders();
last_sell_price=-1;
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseAllBuy:");

}

if ( sparam == "CloseAllSell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllSellOrders();
last_buy_price=-1;
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseAllSell:");

}


if ( sparam == "CloseProfitBuy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllProfitBuyOrders();
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseProfitBuy:");

}

if ( sparam == "CloseProfitSell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllProfitSellOrders();

Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

} 
Comment("CloseProfitSell:");

}






if ( sparam == "Run" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {run=true;pause=false;

ObjectSetInteger(ChartID(),"Pause",OBJPROP_STATE,False);

} else{run=false;}

Comment("Run:",run);


}

if ( sparam == "Pause" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {pause=true;run=false;

ObjectSetInteger(ChartID(),"Run",OBJPROP_STATE,False);

} else{pause=false;}

Comment("Pause:",pause);


}





if ( sparam == "BuyZone" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {buyzone=true;

ObjectCreate(ChartID(),"BUYZONEAUTO",OBJ_HLINE,0,Time[0],WindowPriceMin());
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"BUYZONEAUTO",OBJPROP_BACK,True);


buyzoneprc=WindowPriceMin();
buyzoneprc=NormalizeDouble(buyzoneprc,Digits);

//order_mode_buy=true;

} else{buyzone=false;
buyzoneprc=-1;
ObjectDelete(ChartID(),"BUYZONEAUTO");

//order_mode_buy=false;


}

Comment("BuyZone:",buyzone,"BuyZonePrc:",buyzoneprc);


}

if ( sparam == "BUYZONEAUTO" ) {

buyzoneprc=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE);
buyzoneprc=NormalizeDouble(buyzoneprc,Digits);


if ( sellzoneprc < Ask ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrDarkGreen);
} else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrChartreuse);
}

Comment("BuyZonePrc:",buyzoneprc);


}



if ( sparam == "SELLZONEAUTO" ) {

sellzoneprc=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE);
sellzoneprc=NormalizeDouble(sellzoneprc,Digits);

if ( sellzoneprc < Ask ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrDarkRed);
} else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrOrangeRed);
}



Comment("SellZonePrc:",sellzoneprc);


}


if ( sparam == "SellZone" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {sellzone=true;

ObjectCreate(ChartID(),"SELLZONEAUTO",OBJ_HLINE,0,Time[0],WindowPriceMax());
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),"SELLZONEAUTO",OBJPROP_BACK,True);

sellzoneprc=WindowPriceMax();
sellzoneprc=NormalizeDouble(sellzoneprc,Digits);

//order_mode_sell=true;

} else{sellzone=false;

ObjectDelete(ChartID(),"SELLZONEAUTO");
sellzoneprc=-1;

//order_mode_sell=false;

}

Comment("SellZone:",sellzone,"SellZonePrc:",sellzoneprc);



}



if ( sparam == "Buy" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

Sleep(10);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);



} 

Comment("Buy:");


}

if ( sparam == "Sell" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);

Sleep(10);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);


} 

Comment("Sell:");


}




if ( sparam == "Up" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"Edit",OBJPROP_TEXT);
double bilgid=StringToDouble(bilgi);
bilgid=bilgid+MarketInfo(Symbol(),MODE_MINLOT);
if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"Edit",OBJPROP_TEXT,DoubleToString(bilgid,2));
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
Lot=NormalizeDouble(bilgid,2);



} 

Comment("Up:",Lot);


}

if ( sparam == "Down" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"Edit",OBJPROP_TEXT);
double bilgid=StringToDouble(bilgi);
bilgid=bilgid-MarketInfo(Symbol(),MODE_MINLOT);
if ( bilgid < MarketInfo(Symbol(),MODE_MINLOT) ) bilgid=MarketInfo(Symbol(),MODE_MINLOT);
ObjectSetString(ChartID(),"Edit",OBJPROP_TEXT,DoubleToString(bilgid,2));
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
Lot=NormalizeDouble(bilgid,2);




} 

Comment("Down:",Lot);


}




if ( sparam == "Edit" ) {


string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

Lot=StringToDouble(bilgi);
Lot=NormalizeDouble(Lot,2);


Comment("Bilgi:",bilgi,"/Lot:",Lot);


}



if ( sparam == "GroupEditPoint" ) {

string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

range_point=StringToInteger(bilgi);

min_bar_range=range_point;

Comment("Bilgi:",bilgi,"/RangePoint:",range_point);

}





if ( sparam == "UpPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"EditPoint",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;
//if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"EditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
offset_point=StringToInteger(bilgid);



} 

Comment("UpPoint:",offset_point);


}


if ( sparam == "GroupUpPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;
//if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
range_point=StringToInteger(bilgid);

min_bar_range=range_point;

} 

Comment("GroupUpPoint:",range_point);


}



if ( sparam == "DownPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"EditPoint",OBJPROP_TEXT);
int bilgid=StringToInteger(bilgi);
bilgid=bilgid-1;
if ( bilgid < 1 ) bilgid=1;
ObjectSetString(ChartID(),"EditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
offset_point=StringToInteger(bilgid);




} 

Comment("DownPoint:",offset_point);


}



if ( sparam == "GroupDownPoint" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT);
int bilgid=StringToInteger(bilgi);
bilgid=bilgid-1;
if ( bilgid < 1 ) bilgid=1;
ObjectSetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
range_point=StringToInteger(bilgid);

min_bar_range=range_point;


} 

Comment("GroupDownPoint:",range_point);


}



if ( sparam == "GroupBar" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
string bilgi=ObjectGetString(ChartID(),"GroupBar",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;


if ( bilgid > 5 ) bilgid=1;
min_bar=bilgid;
if ( bilgid < 2 ) bilgid=2;
min_bar=bilgid;

ObjectSetString(ChartID(),sparam,OBJPROP_TEXT,min_bar);
Sleep(40);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);
}

}



if ( sparam == "GroupTrend" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
//if ( order_mode_trend == true ) {
order_mode_trend=true;
//ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {
order_mode_trend=false;}

//Comment("OrderModeTrend:",order_mode_trend);


}


if ( sparam == "GroupReserval" ) {

//if ( order_mode_reserval == true ) {
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
order_mode_reserval=true;
//ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {order_mode_reserval=false;}

//Comment("OrderModeReserval:",order_mode_reserval);

}


if ( sparam == "GroupTurbo" ) {


//if ( order_mode_turbo == true ) {
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
order_mode_turbo=true;
//ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);
} else {order_mode_turbo=false;}

//Comment("OrderModeTurbo:",order_mode_turbo);

}



if ( sparam == "GroupSystem" ) {

//if ( order_mode == true ) {
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
order_mode=true;

//ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {

order_mode=false;

last_buy_price=-1;
last_sell_price=-1;
last_buy_time=-1;
last_sell_time=-1;

last_buy_up_price=-1;
last_buy_down_price=-1;

last_sell_up_price=-1;
last_sell_down_price=-1;

last_buy_first_price=-1;
last_sell_first_price=-1;


}

//bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
//min_candle_body=bar_ortalama;
//Alert(bar_ortalama,"/",min_candle_body);

//Comment("OrderMode:",order_mode,"/min_candle_body:",min_candle_body);

}


if ( sparam == "GroupUp" ) {
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {order_mode_sell=true;
} else{
order_mode_sell=false;
}

//Comment("Up:",order_mode_sell);

}


if ( sparam == "GroupDown" ) {
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {order_mode_buy=true;
} else{
order_mode_buy=false;
}

//Comment("Down:",order_mode_buy);

}








if ( sparam == "EditPoint" ) {


string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

offset_point=StringToInteger(bilgi);

Comment("Bilgi:",bilgi,"/OffsetPoint:",offset_point);


}




if ( sparam == "CloseAllBuyPen" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {
CloseAllPenOrdersTyp(Symbol(),OP_BUYLIMIT);
CloseAllPenOrdersTyp(Symbol(),OP_BUYSTOP);
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

buyzone=false;
buyzoneprc=-1;
ObjectDelete(ChartID(),"BUYZONEAUTO");

ObjectSetInteger(ChartID(),"BuyZone",OBJPROP_STATE,False);

} 
Comment("CloseAllBuyPen:");

}

if ( sparam == "CloseAllSellPen" ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) == 1 ) {

CloseAllPenOrdersTyp(Symbol(),OP_SELLLIMIT);
CloseAllPenOrdersTyp(Symbol(),OP_SELLSTOP);
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

sellzone=false;
sellzoneprc=-1;
ObjectDelete(ChartID(),"SELLZONEAUTO");

ObjectSetInteger(ChartID(),"SellZone",OBJPROP_STATE,False);

} 
Comment("CloseAllSellPen:");



}



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_BUTTON || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL) {

//ChartSetInteger(0,CHART_SHOW_ONE_CLICK,True);
//ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);
//ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,False);

}



/*
"OnlyBuy"
"Any"
"OnlySell"
"CloseAllBuy"
"Run"
"Pause"
"CloseAllSell"
"CloseProfitBuy"
"SellZone"
"BuyZone"
"CloseProfitSell"
"Buy"
"Sell"
"Up"
"Edit"
"Down"
*/



   
  }
//+------------------------------------------------------------------+



void Resize(int oranx) {


   long cid=ChartID();
   
   
   //return 0;
   
   
   
   /*
int heightScreen=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
int widthScreen=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);

Comment("Height:",heightScreen,"Width:",widthScreen);*/

string obje_listesi="Bilgisi";

       int obj_total=ObjectsTotal(cid);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(cid,i);
     
int indexof = StringFind(name,obje_listesi, 0);
if ( indexof != -1 ) continue;


//if(ObjectType(name)!=OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
if(ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_LABEL && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_BUTTON && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_RECTANGLE_LABEL && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_EDIT) continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_FIBO ) continue;

int ObjWidth = ObjectGetInteger(cid,name,OBJPROP_XSIZE,0);
int ObjHeight = ObjectGetInteger(cid,name,OBJPROP_YSIZE,0);
int ObjX = ObjectGetInteger(cid,name,OBJPROP_XDISTANCE,0);
int ObjY = ObjectGetInteger(cid,name,OBJPROP_YDISTANCE,0);
int ObjFont = ObjectGetInteger(cid,name,OBJPROP_FONTSIZE,0);
//Print(i," object - ",name,"Size:",ButtonWidth,"/",ButtonHeight,"Sinyal:",obje_listesi,"indexof",indexof);

//int oranx=150;

int ObjWidthOran = DivZero(ObjWidth,100)*oranx;
int ObjHeightOran = DivZero(ObjHeight,100)*oranx;
int ObjFontOran = DivZero(ObjFont,100)*oranx;
int ObjXOran = DivZero(ObjX,100)*oranx;
int ObjYOran = DivZero(ObjY,100)*oranx;


int ChartWidths=ObjWidthOran;
int ChartHeights=ObjHeightOran;
int ChartFonts=ObjFontOran;
int ChartXs=ObjXOran;
int ChartYs=ObjYOran;

 ObjectSetInteger(cid,name,OBJPROP_XSIZE,ChartWidths);
 ObjectSetInteger(cid,name,OBJPROP_YSIZE,ChartHeights);
 ObjectSetInteger(cid,name,OBJPROP_FONTSIZE,ChartFonts);
 ObjectSetInteger(cid,name,OBJPROP_XDISTANCE,ChartXs);
 ObjectSetInteger(cid,name,OBJPROP_YDISTANCE,ChartYs);
 //ObjectSetInteger(cid,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
 

}  


}


void GroupChartEvent(string sparams) {


if ( sparams == "GroupBar" ) {

string bilgi=ObjectGetString(ChartID(),"GroupBar",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;


if ( bilgid > 5 ) bilgid=1;
min_bar=bilgid;
if ( bilgid < 2 ) bilgid=2;
min_bar=bilgid;

ObjectSetString(ChartID(),sparams,OBJPROP_TEXT,min_bar);
Sleep(100);
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);


}


   
   
   


if ( sparams == "GroupTrend" ) {

if ( order_mode_trend == true ) {order_mode_trend=false;
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {order_mode_trend=true;}

Comment("OrderModeTrend:",order_mode_trend);


}

if ( sparams == "GroupReserval" ) {

if ( order_mode_reserval == true ) {order_mode_reserval=false;
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {order_mode_reserval=true;}

Comment("OrderModeReserval:",order_mode_reserval);




}


if ( sparams == "GroupTurbo" ) {


if ( order_mode_turbo == true ) {order_mode_turbo=false;
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {order_mode_turbo=true;}

Comment("OrderModeTurbo:",order_mode_turbo);

}



if ( sparams == "GroupSystem" ) {

if ( order_mode == true ) {order_mode=false;

last_buy_price=-1;
last_sell_price=-1;
last_buy_time=-1;
last_sell_time=-1;

last_buy_up_price=-1;
last_buy_down_price=-1;

last_sell_up_price=-1;
last_sell_down_price=-1;

last_buy_first_price=-1;
last_sell_first_price=-1;


ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);
} else {order_mode=true;}



bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
min_candle_body=bar_ortalama;
//Alert(bar_ortalama,"/",min_candle_body);

Comment("OrderMode:",order_mode,"/min_candle_body:",min_candle_body);

}








if ( sparams == "GroupUpPoint" ) {

if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT);
double bilgid=StringToInteger(bilgi);
bilgid=bilgid+1;
//if ( bilgid > MarketInfo(Symbol(),MODE_MAXLOT) ) bilgid=MarketInfo(Symbol(),MODE_MAXLOT);
ObjectSetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
range_point=StringToInteger(bilgid);

min_bar_range=range_point;

} 

Comment("GroupUpPoint:",range_point);


}

if ( sparams == "GroupDownPoint" ) {

if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_STATE) == 1 ) {

string bilgi=ObjectGetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT);
int bilgid=StringToInteger(bilgi);
bilgid=bilgid-1;
if ( bilgid < 1 ) bilgid=1;
ObjectSetString(ChartID(),"GroupEditPoint",OBJPROP_TEXT,bilgid);
Sleep(50);
ObjectSetInteger(ChartID(),sparams,OBJPROP_STATE,False);

//Lot=StringToDouble(bilgid);
range_point=StringToInteger(bilgid);

min_bar_range=range_point;


} 

Comment("GroupDownPoint:",range_point);


}




if ( sparams == "GroupEditPoint" ) {


string bilgi=ObjectGetString(ChartID(),sparams,OBJPROP_TEXT);

range_point=StringToInteger(bilgi);

min_bar_range=range_point;

Comment("Bilgi:",bilgi,"/RangePoint:",range_point);


}



if ( sparams == "GroupUp" ) {
if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_STATE) == 1 ) {order_mode_sell=true;
} else{
order_mode_sell=false;
}

Comment("Up:",order_mode_sell);

}


if ( sparams == "GroupDown" ) {
if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_STATE) == 1 ) {order_mode_buy=true;
} else{
order_mode_buy=false;
}

Comment("Down:",order_mode_buy);

}





}



/*
void GroupBarSystem() {
}*/


 int ortalama_last_bar= -1;

 
int BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

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
  
   
   bar_ortalama = DivZero(bar_pip,bar_toplam)/Point;
   
   return bar_ortalama;

}
  

////////////////////////////////////////////////////////////////////////
// Skyper Order 
////////////////////////////////////////////////////////////////////////

int min_candle_body = -1;
//int min_distance=8000;
int min_bar_range=10;
int min_distance=10;
int min_bar=2;
//int min_bar=4;


int last_sell_shift=-1;
double last_sell_price=-1;
double last_buy_price=-1;
int last_buy_shift=-1;
datetime last_buy_time;
datetime last_sell_time;


double last_sell_up_price=-1;
double last_sell_down_price=-1;

double last_buy_up_price=-1;
double last_buy_down_price=-1;


/*
extern bool spread_filter=false;//Spread Filter
extern int max_spead = 30;//MaxSpread (zero or negative value means no limit)
double spread;
bool spread_onay = true;
*/

bool order_mode_turbo=false;
bool order_mode_reserval=false;
bool order_mode_trend=false;
bool order_mode_buy=false;
bool order_mode_sell=false;
bool order_mode=false;
int range_point=0;

/*


*/
datetime last_buy_down_time=-1;
datetime last_sell_up_time=-1;

double last_sell_first_price=-1;
double last_buy_first_price=-1;

void SkyperOrder() {

if ( IsNewOrderAllowed() == False ) return;


  //Print(Symbol(),"buy:",last_buy_price,"/sell:",last_sell_price,"SkyperOrder Work / Down:",order_mode_buy,"/ Up:",order_mode_sell,"/",min_distance,"/",min_bar_range,"/",min_candle_body,"/",min_bar,"/",Lot);
  
  
/*
order_mode_trend=true;
order_mode_buy=true;
order_mode_sell=true;
order_mode=true;
*/

//if ( order_mode_standart == true ) {


//min_bar=2;
if ( min_candle_body == -1 ) min_candle_body = 10;
//int min_distance=8000;
//min_bar_range=100;
min_distance=10;

if ( offset_point > 0 ) min_distance=offset_point;
if ( range_point > 0 ) min_bar_range = range_point;



/*

 
if ( Period() == PERIOD_M1  ) {
min_candle_body = 10;
//int min_distance=8000;
min_bar_range=100;
min_distance=200;
}


if ( Period() == PERIOD_M5  ) {
min_candle_body = 20;
//int min_distance=8000;
min_bar_range=200;
min_distance=400;
}

if ( Period() == PERIOD_M15  ) {
min_candle_body = 30;
//int min_distance=8000;
min_bar_range=300;
min_distance=600;
}

}


if ( order_mode_defensive == true ) {
if ( Period() == PERIOD_M1  ) min_candle_body = 10;
if ( Period() == PERIOD_M5  ) min_candle_body = 20;
if ( Period() == PERIOD_M15  ) min_candle_body = 30;
min_bar_range=300;
min_distance=600;
min_bar=4;
}

if ( order_mode_aggressive == true ) {
if ( Period() == PERIOD_M1  ) min_candle_body = 10;
if ( Period() == PERIOD_M5  ) min_candle_body = 20;
if ( Period() == PERIOD_M15  ) min_candle_body = 30;
min_bar_range=100;
min_distance=200;
min_bar=2;
}

*/


if ( order_mode == false ) return;

if ( order_mode_buy == false && order_mode_sell == false ) return;

if ( Lot == 0 ) return;


////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   spread=(ask-bid)/Point;
   //Print("spread",spread,"/",max_spead);
   spread_onay=true;
   if ( spread_filter == true ) {
   if ( spread > max_spead && max_spead > 0 ) {
   spread_onay=false;
   //return;
   }
   }
//////////////////////////////////////////////////////////////////////////
  
  
  if ( spread_onay == false ) return;
  
  //Print(Symbol(),"SkyperOrder Work / Down:",order_mode_buy,"/ Up:",order_mode_sell,"/",min_distance,"/",min_bar_range,"/",min_candle_body,"/",min_bar,"/",Lot);
  
  




  if ( order_mode_sell == true && spread_onay == true ) {  

  if ( Open[1] > Close[1] //&& (Open[1]-Close[1])/Point >= min_candle_body 
   && Close[2] > Open[2] && Close[3] > Open[3] && last_sell_time != Time[1] ) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Close[i] > Open[i] && Close[i] > Close[i+1] //|| MathAbs(Close[i]-Open[i])/Point < min_candle_body 
  
  ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
  
  
  
if ( say >= min_bar && find == true && (High[2]-Low[shift])/Point >= min_bar_range //&& last_sell_shift != shift 
&& ((Bid > last_sell_up_price && (Bid-last_sell_up_price)/Point >= min_distance) || last_sell_up_price == -1 ) 
//&& ( (buy_total+sell_total == 0 && last_sell_first_price == -1) || (last_sell_first_price != -1 && (Bid-last_sell_first_price)/Point > offset_point) ) 
&& ( (last_sell_first_price == -1) || (last_sell_first_price != -1 && (Bid-last_sell_first_price)/Point > offset_point) ) 
 ) {
ObjectDelete(ChartID(),"SELL"+Time[2]);
ObjectCreate(ChartID(),"SELL"+Time[2],OBJ_TRENDBYANGLE,0,Time[2],High[2],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_RAY,False);

last_sell_shift=shift;
last_sell_up_price=Bid;
last_sell_up_time =Time[1];

//if ( buy_total == 0 && sell_total == 0  ) last_sell_first_price=Bid;


//if ( order_mode_reserval == true  )  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
//if ( order_mode_trend == true ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

if ( order_mode_reserval == true  )  {

if ( last_sell_first_price == -1 ) last_sell_first_price=Bid;

//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);

         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Sell(price,SL,TP,Lot);
         Print("  -----------------"); 


}
if ( order_mode_trend == true ) {

if ( last_sell_first_price == -1 ) last_sell_first_price=Bid;

//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

         double price=Ask;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP,Lot);
         Print("  -----------------");  

}










}



if ( order_mode_turbo == true ) {
if ( say >= min_bar && find == true && (High[2]-Low[shift])/Point >= min_bar_range //&& last_sell_shift != shift 
&& ( ( last_sell_first_price == -1) || (last_sell_first_price != -1 &&  (last_sell_first_price-Bid)/Point > offset_point) ) && ((Bid < last_sell_down_price && (last_sell_down_price-Bid)/Point >= min_distance) || last_sell_down_price == -1 )  ) {
ObjectDelete(ChartID(),"SELL"+Time[2]);
ObjectCreate(ChartID(),"SELL"+Time[2],OBJ_TRENDBYANGLE,0,Time[2],High[2],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_RAY,False);

last_sell_shift=shift;
last_sell_down_price=Bid;
last_sell_time =Time[1];




if ( order_mode_reserval == true ) {


if ( last_sell_first_price == -1 ) last_sell_first_price=Bid;


//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);


         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Sell(price,SL,TP,Lot);
         Print("  -----------------"); 
         

}
if ( order_mode_trend == true ) {

if ( last_sell_first_price == -1 ) last_sell_first_price=Bid;

//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

         double price=Ask;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP,Lot);
         Print("  -----------------");  


}

}



}

  
  
  
  }
  
  }
  
  
  
if ( order_mode_buy == true && spread_onay == true ) {  
 
  if ( Close[1] > Open[1] //&& (Close[1] -Open[1])/Point >= min_candle_body
   && Open[2] > Close[2]  && Open[3] > Close[3] && last_buy_time != Time[1] ) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Open[i] > Close[i] && Close[i] < Close[i+1] //|| MathAbs(Open[i]-Close[i])/Point < min_candle_body 
  
  ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
if ( spread_onay == true && say >= min_bar && find == true && (High[shift]-Low[2])/Point >= min_bar_range //&& last_sell_shift != shift 
&& ((Ask < last_buy_up_price && (last_buy_up_price-Ask)/Point >= min_distance) || last_buy_up_price==-1) 
&& ( (last_buy_first_price == -1) || (last_buy_first_price != -1 &&  (last_buy_first_price-Ask)/Point > offset_point) ) 
) {
ObjectDelete(ChartID(),"BUY"+Time[2]);
ObjectCreate(ChartID(),"BUY"+Time[2],OBJ_TRENDBYANGLE,0,Time[shift],High[shift],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_RAY,False);

last_buy_shift=shift;
last_buy_up_price=Ask;
last_buy_time=Time[1];

//if ( buy_total == 0 && sell_total == 0  ) last_buy_first_price=Ask;


if ( order_mode_reserval == true ) {

if ( last_buy_first_price == -1 ) last_buy_first_price=Ask;

//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

         double price=Ask;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP,Lot);
         Print("  -----------------");  


}
if ( order_mode_trend == true ) {


if ( last_buy_first_price == -1 ) last_buy_first_price=Ask;


//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);


         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Sell(price,SL,TP,Lot);
         Print("  -----------------"); 



}



}  



///////////////////
if ( order_mode_turbo == true ) {
if ( spread_onay == true && say >= min_bar && find == true && (High[shift]-Low[2])/Point >= min_bar_range //&& last_sell_shift != shift 
&& ((Ask > last_buy_down_price && (Ask-last_buy_down_price)/Point >= min_distance) || last_buy_down_price==-1) 
&& ( (last_buy_first_price == -1) || (last_buy_first_price != -1 &&  (Ask-last_buy_first_price)/Point > offset_point) ) 
) {
ObjectDelete(ChartID(),"BUY"+Time[2]);
ObjectCreate(ChartID(),"BUY"+Time[2],OBJ_TRENDBYANGLE,0,Time[shift],High[shift],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_RAY,False);

last_buy_shift=shift;
last_buy_down_price=Ask;
last_buy_time=Time[1];




if ( order_mode_reserval == true ) {

if ( last_buy_first_price == -1 ) last_buy_first_price=Ask;

//int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

         double price=Ask;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_BUY,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Buy(price,SL,TP,Lot);
         Print("  -----------------");  


}
if ( order_mode_trend == true ) {

if ( last_buy_first_price == -1 ) last_buy_first_price=Ask;

//int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);


         //--- get the opening price and knowingly set invalid TP/SL
         double price=Bid;
         double SL=0.0;
         double TP=0.0;
         //--- perform a check
         PrintFormat("Buy at %.5f   SL=%.5f   TP=%.5f  Bid=%.5f",price,SL,TP,Bid);
         if(!CheckStopLoss_Takeprofit(ORDER_TYPE_SELL,price,SL,TP))
            Print("The StopLoss or TakeProfit level is incorrect!");
         //--- try to buy anyway, in order to see the execution result
         Sell(price,SL,TP,Lot);
         Print("  -----------------"); 


}


}  
}
////////////////////////





  
  
  }
  
  
  }





} // İşlem Açma Sorunum olduğu için bu işi otomatik yapmaya karar verdim başka çarem kalmadı, senelerce aynı döngü dönüp duruyor. Haberlerde çok fazla tersde kalıp işlem açıyorum.
/////////////////////////////////////////////////////////////////////////////////////////


//+------------------------------------------------------------------+
//| Check the distance from opening price to activation price        |
//+------------------------------------------------------------------+
bool CheckOrderForFREEZE_LEVEL(int ticket)
  {
//--- get the SYMBOL_TRADE_FREEZE_LEVEL level
   int freeze_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_FREEZE_LEVEL);
   if(freeze_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_FREEZE_LEVEL=%d: Cannot modify order"+
                  "  nearer than %d points from the activation price",freeze_level,freeze_level);
     }
//--- select order for working
   if(!OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      //--- failed to select order
      return (false);
     }
//--- get the order data
   double price=OrderOpenPrice();
   double sl=OrderStopLoss();
   double tp=OrderTakeProfit();
   int type=OrderType();
//--- result of checking 
   bool check=false;
//--- check the order type
   switch(type)
     {
      //--- BuyLimit pending order
      case  OP_BUYLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((Ask-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYLIMIT #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-price)/_Point),freeze_level);
         return(check);
        }
      //--- BuyLimit pending order
      case  OP_SELLLIMIT:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Bid)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLLIMIT #%d cannot be modified: Open-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Bid)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- BuyStop pending order
      case  OP_BUYSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((price-Ask)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_BUYSTOP #%d cannot be modified: Ask-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((price-Ask)/_Point),freeze_level);
         return(check);
        }
      //--- SellStop pending order
      case  OP_SELLSTOP:
        {
         //--- check the distance from the opening price to the activation price
         check=((Bid-price)>freeze_level*_Point);
         if(!check)
            PrintFormat("Order OP_SELLSTOP #%d cannot be modified: Bid-Open=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-price)/_Point),freeze_level);
         return(check);
        }
      break;
      //--- checking opened Buy order
      case  OP_BUY:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(tp-Bid>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((tp-Bid)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(Bid-sl>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Bid-sl)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
      //--- checking opened Sell order
      case  OP_SELL:
        {
         //--- check TakeProfit distance to the activation price
         bool TP_check=(Ask-tp>freeze_level*_Point);
         if(!TP_check)
            PrintFormat("Order OP_SELL %d cannot be modified: Ask-TakeProfit=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((Ask-tp)/_Point),freeze_level);
         //--- check TakeProfit distance to the activation price
         bool SL_check=(sl-Ask>freeze_level*_Point);
         if(!SL_check)
            PrintFormat("Order OP_BUY %d cannot be modified: TakeProfit-Bid=%d points < SYMBOL_TRADE_FREEZE_LEVEL=%d points",
                        ticket,(int)((sl-Ask)/_Point),freeze_level);
         return(SL_check&&TP_check);
        }
      break;
     }
//--- order did not pass the check
   return (false);
  }
  
//+------------------------------------------------------------------+
//| Checking the new values of levels before order modification      |
//+------------------------------------------------------------------+
bool OrderModifyCheck(int ticket,double price,double sl,double tp)
  {
//--- select order by ticket
   if(OrderSelect(ticket,SELECT_BY_TICKET))
     {
      //--- point size and name of the symbol, for which a pending order was placed
      string symbol=OrderSymbol();
      double point=SymbolInfoDouble(symbol,SYMBOL_POINT);
      //--- check if there are changes in the Open price
      bool PriceOpenChanged=true;
      int type=OrderType();
      if(!(type==OP_BUY || type==OP_SELL))
        {
         PriceOpenChanged=(MathAbs(OrderOpenPrice()-price)>point);
        }
      //--- check if there are changes in the StopLoss level
      bool StopLossChanged=(MathAbs(OrderStopLoss()-sl)>point);
      //--- check if there are changes in the Takeprofit level
      bool TakeProfitChanged=(MathAbs(OrderTakeProfit()-sl)>tp);
      //--- if there are any changes in levels
      if(PriceOpenChanged || StopLossChanged || TakeProfitChanged)
         return(true);  // order can be modified      
      //--- there are no changes in the Open, StopLoss and Takeprofit levels
      else
      //--- notify about the error
         PrintFormat("Order #%d already has levels of Open=%.5f SL=.5f TP=%.5f",
                     ticket,OrderOpenPrice(),OrderStopLoss(),OrderTakeProfit());
     }
//--- came to the end, no changes for the order
   return(false);       // no point in modifying 
  }  
  

bool CheckMoneyForTrade(string symb, double lots,int type)
  {
   double free_margin=AccountFreeMarginCheck(symb,type, lots);
   //-- if there is not enough money
   if(free_margin<0)
     {
      string oper=(type==OP_BUY)? "Buy":"Sell";
      Print("Not enough money for ", oper," ",lots, " ", symb, " Error code=",GetLastError());
      return(false);
     }
   //--- checking successful
   return(true);
  }
  
//+------------------------------------------------------------------+
//| Check the correctness of the order volume                        |
//+------------------------------------------------------------------+

bool CheckVolumeValue(double volume,string &description)
  {
//--- minimal allowed volume for trade operations
   double min_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
   if(volume<min_volume)
     {
      description=StringFormat("Volume is less than the minimal allowed SYMBOL_VOLUME_MIN=%.2f",min_volume);
      return(false);
     }

//--- maximal allowed volume of trade operations
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
   if(volume>max_volume)
     {
      description=StringFormat("Volume is greater than the maximal allowed SYMBOL_VOLUME_MAX=%.2f",max_volume);
      return(false);
     }

//--- get minimal step of volume changing
   double volume_step=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);

   int ratio=(int)MathRound(volume/volume_step);
   if(MathAbs(ratio*volume_step-volume)>0.0000001)
     {
      description=StringFormat("Volume is not a multiple of the minimal step SYMBOL_VOLUME_STEP=%.2f, the closest correct volume is %.2f",
                               volume_step,ratio*volume_step);
      return(false);
     }
   description="Correct volume value";
   return(true);
  }    
  
//+------------------------------------------------------------------+
//| Check if another order can be placed                             |
//+------------------------------------------------------------------+

bool IsNewOrderAllowed()
  {
//--- get the number of pending orders allowed on the account
   int max_allowed_orders=(int)AccountInfoInteger(ACCOUNT_LIMIT_ORDERS);

//--- if there is no limitation, return true; you can send an order
   if(max_allowed_orders==0) return(true);

//--- if we passed to this line, then there is a limitation; find out how many orders are already placed
   int orders=OrdersTotal();

//--- return the result of comparing
   return(orders<max_allowed_orders);
  }
  
  
  /*
  double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);
if(max_volume==0) volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//+------------------------------------------------------------------+
//| Return the size of position on the specified symbol              |
//+------------------------------------------------------------------+
double PositionVolume(string symbol)
  {
//--- try to select position by a symbol
   bool selected=PositionSelect(symbol);
//--- there is a position
   if(selected)
      //--- return volume of the position
      return(PositionGetDouble(POSITION_VOLUME));
   else
     {
      //--- report a failure to select position
      Print(__FUNCTION__," Failed to perform PositionSelect() for symbol ",
            symbol," Error ",GetLastError());
      return(-1);
     }
  }*/
  
  
//+------------------------------------------------------------------+
//|  returns the volume of current pending order by a symbol         |
//+------------------------------------------------------------------+
/*
double   PendingsVolume(string symbol)
  {
   double volume_on_symbol=0;
   ulong ticket;
//---  get the number of all currently placed orders by all symbols
   int all_orders=OrdersTotal();

//--- get over all orders in the loop
   for(int i=0;i<all_orders;i++)
     {
      //--- get the ticket of an order by its position in the list
      if(ticket=OrderGetTicket(i))
        {
         //--- if our symbol is specified in the order, add the volume of this order
         if(symbol==OrderGetString(ORDER_SYMBOL))
            volume_on_symbol+=OrderGetDouble(ORDER_VOLUME_INITIAL);
        }
     }
//--- return the total volume of currently placed pending orders for a specified symbol
   return(volume_on_symbol);
  }*/
  
//+------------------------------------------------------------------+
//| Return the maximum allowed volume for an order on the symbol     |
//+------------------------------------------------------------------+
/*
double NewOrderAllowedVolume(string symbol)
  {
   double allowed_volume=0;
//--- get the limitation on the maximal volume of an order
   double symbol_max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MAX);
//--- get the limitation on the volume by a symbol
   double max_volume=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_LIMIT);

//--- get the volume of the open position by a symbol
   double opened_volume=PositionVolume(symbol);
   if(opened_volume>=0)
     {
      //--- if we have exhausted the volume
      if(max_volume-opened_volume<=0)
         return(0);

      //--- volume of the open position doesn't exceed max_volume
      double orders_volume_on_symbol=PendingsVolume(symbol);
      allowed_volume=max_volume-opened_volume-orders_volume_on_symbol;
      if(allowed_volume>symbol_max_volume) allowed_volume=symbol_max_volume;
     }
   return(allowed_volume);
  }       */
  
   
  //+------------------------------------------------------------------+
//| Perform a Buy                                                    |
//+------------------------------------------------------------------+
bool Buy(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_BUY) ) return false;
  
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUY,NormalizeDouble(lt,2),price,10,sl,tp,"",magic,0,clrNONE);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY;                        // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Perform a Sell                                                   |
//+------------------------------------------------------------------+
bool Sell(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_SELL) ) return false;
  
//--- sell in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELL,NormalizeDouble(lt,2),price,10,sl,tp,"",magic,0,clrNONE);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- sell in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_DEAL;                     // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL;                       // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool BuyLimit(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYLIMIT,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_LIMIT;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool BuyStop(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_BUY) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_BUYSTOP,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_BUY_STOP;                   // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Sell Stop pending order                                  |
//+------------------------------------------------------------------+
bool SellLimit(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLLIMIT,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_LIMIT;                 // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+
//| Place a Buy Stop pending order                                   |
//+------------------------------------------------------------------+
bool SellStop(double price,double sl,double tp,double lt)
  {
  
  if ( !CheckMoneyForTrade(Symbol(), lt,OP_SELL) ) return false;
  
//--- buy in MQL4
#ifdef __MQL4__
   int ticket=OrderSend(Symbol(),OP_SELLSTOP,NormalizeDouble(lt,2),price,10,sl,tp);
   if(ticket<0)
      PrintFormat("OrderSend error %d",GetLastError());
#endif
//--- buy in MQL5         
#ifdef __MQL5__
//--- declare and initialize the trade request and result of trade request
   MqlTradeRequest request={0};
   MqlTradeResult  result={0};
//--- parameters of request
   request.action   =TRADE_ACTION_PENDING;                  // type of trade operation
   request.symbol   =Symbol();                              // symbol
   request.volume   =NormalizeDouble(lt,2);                                     // volume of 1 lot
   request.type     =ORDER_TYPE_SELL_STOP;                  // order type
   request.price    =price;                                 // price for opening
   request.sl       =sl;                                    // StopLoss price
   request.tp       =tp;                                    // TakeProfit price
   request.deviation=10;                                    // allowed deviation from the price
   request.magic    =magic;                                // MagicNumber of the order
//--- send the request
   if(!OrderSend(request,result))
      PrintFormat("OrderSend error %d",GetLastError());     // if unable to send the request, output the error code
//--- information about the operation
   PrintFormat("retcode=%u  deal=%I64u  order=%I64u",result.retcode,result.deal,result.order);
#endif  
//---
   return(false);
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Check the correctness of StopLoss and TakeProfit                 |
//+------------------------------------------------------------------+
bool CheckStopLoss_Takeprofit(ENUM_ORDER_TYPE type,double price,double SL,double TP)
  {
//--- get the SYMBOL_TRADE_STOPS_LEVEL level
   int stops_level=(int)SymbolInfoInteger(_Symbol,SYMBOL_TRADE_STOPS_LEVEL);
   if(stops_level!=0)
     {
      PrintFormat("SYMBOL_TRADE_STOPS_LEVEL=%d: StopLoss and TakeProfit must"+
                  " not be nearer than %d points from the closing price",stops_level,stops_level);
     }
//---
   bool SL_check=false,TP_check=false;
//--- check the order type
   switch(type)
     {
      //--- Buy operation
      case  ORDER_TYPE_BUY:
        {
         //--- check the StopLoss
         SL_check=(Bid-SL>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Bid=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Bid-stops_level*_Point,Bid,stops_level);
         //--- check the TakeProfit
         TP_check=(TP-Bid>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (Bid=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Bid+stops_level*_Point,Bid,stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- Sell operation
      case  ORDER_TYPE_SELL:
        {
         //--- check the StopLoss
         SL_check=(SL-Ask>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (Ask=%.5f + SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,Ask+stops_level*_Point,Ask,stops_level);
         //--- check the TakeProfit
         TP_check=(Ask-TP>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Ask=%.5f - SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,Ask-stops_level*_Point,Ask,stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyLimit pending order
      case  ORDER_TYPE_BUY_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price+stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellLimit pending order
      case  ORDER_TYPE_SELL_LIMIT:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
      //--- BuyStop pending order
      case  ORDER_TYPE_BUY_STOP:
        {
         //--- check the StopLoss
         SL_check=((price-SL)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be less than %.5f"+
                        " (Open-StopLoss=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price-stops_level*_Point,(int)((price-SL)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((TP-price)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be greater than %.5f"+
                        " (TakeProfit-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((TP-price)/_Point),stops_level);
         //--- return the result of checking
         return(SL_check&&TP_check);
        }
      //--- SellStop pending order
      case  ORDER_TYPE_SELL_STOP:
        {
         //--- check the StopLoss
         SL_check=((SL-price)>stops_level*_Point);
         if(!SL_check)
            PrintFormat("For order %s   StopLoss=%.5f must be greater than %.5f"+
                        " (StopLoss-Open=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),SL,price+stops_level*_Point,(int)((SL-price)/_Point),stops_level);
         //--- check the TakeProfit
         TP_check=((price-TP)>stops_level*_Point);
         if(!TP_check)
            PrintFormat("For order %s   TakeProfit=%.5f must be less than %.5f"+
                        " (Open-TakeProfit=%d points ==> SYMBOL_TRADE_STOPS_LEVEL=%d points)",
                        EnumToString(type),TP,price-stops_level*_Point,(int)((price-TP)/_Point),stops_level);
         //--- return the result of checking
         return(TP_check&&SL_check);
        }
      break;
     }

//---
   return false;
  }
  
//+------------------------------------------------------------------+
//| Return the total number of pending orders on the symbol          |
//+------------------------------------------------------------------+
int OrdersTotalPending(string sym)
  {
   int orders=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               orders++;
              }
           }
        }
     }
   return(orders);
  }
//+------------------------------------------------------------------+
//| Return the ticket of a pending order by number                   |
//+------------------------------------------------------------------+
int OrderPendingSelect(int ind,string sym)
  {
   int ticket=0,counter=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
        {
         if(OrderSymbol()==sym)
           {
            if((OrderType()!=OP_BUY) && (OrderType()!=OP_SELL))
              {
               if(counter==ind)
                 {
                  ticket=OrderTicket();
                  break;
                 }
               counter++;
              }
           }
        }
     }

   return(ticket);
  }
//+------------------------------------------------------------------+
//| Return the order type as a string                                |
//+------------------------------------------------------------------+
string GetOrderTypeString(int type)
  {
   switch(type)
     {
      case  OP_BUY:
         return("OP_BUY");       break;
      case  OP_SELL:
         return("OP_SELL");      break;
      case  OP_BUYLIMIT:
         return("OP_BUYLIMIT");  break;
      case  OP_SELLLIMIT:
         return("OP_SELLLIMIT"); break;
      case  OP_BUYSTOP:
         return("OP_BUYSTOP");   break;
      case  OP_SELLSTOP:
         return("OP_SELLSTOP");  break;
     }
//--- unknown order type     
   return("Unknown order type");
  }
//+------------------------------------------------------------------+
  
//+------------------------------------------------------------------+
//| Return the current order activation price                        |
//+------------------------------------------------------------------+
double GetActivationPrice(int ticket)
  {
//---
   double activation_price=0;
//---
   if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
     {
      int type=OrderType();
      //--- orders are activated by the Ask price
      if(type==OP_BUYLIMIT || type==OP_BUYSTOP)
        {
         activation_price=Ask;
        }
      else
      //--- orders are activated by the Bid price
      if(type==OP_SELLLIMIT || type==OP_SELLSTOP)
        {
         activation_price=Bid;
        }
     }
//--- price is not determined for the other orders
   return activation_price;
  }
//+------------------------------------------------------------------+
//| Calculate the nearest opening price for the current moment       |
//+------------------------------------------------------------------+
double GetNearestPrice(int type,int distance)
  {
   double price=0;
//--- iterate over the order types
   switch(type)
     {
      case  OP_SELLSTOP:
         price=Bid-distance*_Point;
         break;
      case  OP_BUYLIMIT:
         price=Ask-distance*_Point;
         break;
      case  OP_SELLLIMIT:
         price=Bid+distance*_Point;
         break;
      case  OP_BUYSTOP:
         price=Ask+distance*_Point;
         break;
      default:
         break;
     }
//--- return the received result
   return(NormalizeDouble(price,_Digits));
  }  