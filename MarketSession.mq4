//+------------------------------------------------------------------+
//|                                                     13King31.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "2.00"
#property strict
//#include <Arrays\ArrayString.mqh> // put this line at the begin of code after #property lines

#import "shell32.dll"
int ShellExecuteW(int hwnd, string Operation, string File, string Parameters, string Directory, int ShowCmd);
#import

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


/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_EMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=200;
extern int MB_W=200;
/////////////////////////////////////////////////////////


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int zaman[9];
   double up_down_level;
   double down_up_level;
string rapor="";

string Symbols[200,2];

string syms[200];


int sym_total;

bool first_time=false;

bool TRIANGLE_BLUE=false;
bool TRIANGLE_RED=false;

string Symbola[200];

bool full_list=true;

bool endeks_list=true;
bool crypto_list=true;
bool parite_list=true;
bool oil_list=true;
bool metals_list=true;


extern bool server_mode=true;
bool single_mode=false;


///////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////

bool time_line=false;
color event_color = clrLightSlateGray;

int tsp=145;

bool event_icon = false;

string TimeOH[11];
string TimeOM[11];
  
double tokyo_high;  
double tokyo_low;

double london_high;  
double london_low;

double newyork_high;  
double newyork_low;



string ipda_sinyal="";


int OnInit()
  {
  
  
  
  
  Telegram("Deneme","Deneme");
  
  
  if ( Period() != PERIOD_M1 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
  
  
  if ( Period() == PERIOD_M1 ) tsp=715;
  if ( Period() == PERIOD_M5 ) tsp=145;   
  if ( Period() == PERIOD_H1 ) tsp=11;   
  if ( Period() == PERIOD_M30 ) tsp=23;   
  if ( Period() == PERIOD_H4 ) tsp=3;   
  if ( Period() == PERIOD_M15 ) tsp=47;   
  if ( Period() == PERIOD_D1 ) tsp=1;   
  if ( Period() == PERIOD_W1 ) tsp=1;   
  if ( Period() == PERIOD_MN1 ) tsp=1;   
  


  
bool full_list=true;
/*
endeks_list=false;
crypto_list=true;
parite_list=false;
oil_list=false;
metals_list=false;*/
  
  
  //Alert(MarketInfo(Symbol(),MODE_PROFITCALCMODE));
  //Alert(SymbolInfoString(Symbol(),SYMBOL_PATH));
  
  //Alert("TradeAllow:",MarketInfo(Symbol(),MODE_TRADEALLOWED));
  
////////////////////////////////////////////////////////////////////////////////////////////////  
  string harf="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,R,S,T,U,V,Y,Z,X,W,.";

string to_split=harf;//"life_is_good";   // A string to split into substrings
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   
   //Alert(k);
   
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
 //if ( StringSubstr(pairz,0,3) == "EUR" && StringSubstr(pairz,3,3) == "EUR") {
 
 
 int s=-1;
   
   if(k>0)
     {
     
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);     
     
      for(int i=0;i<k;i++)
        {
        //PrintFormat("result[%d]=%s",i,results[i]);

      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      if(MarketInfo(pairswl[iwl],MODE_TRADEALLOWED) || full_list == true ){
      if ( StringSubstr(pairswl[iwl],0,1) == results[i] ) {
      s=s+1;
      Symbola[s]=pairswl[iwl]; 
      //if ( pairswl[iwl] == "GLDUSD" ) Symbola[s]="DXY"; 
      } 
      }
          
      }          
        
        }
        
        
    for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      //Print(Symbola[iwl]);
      }
              
        
        
        
        }
////////////////////////////////////////////////////////////////////////////        
        
          
  
     
   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrBlack);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrBlack);    
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrBlack);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrBlack);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrBlack);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
        
   
   

  
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;
  
  
  
  ObjectsDeleteAll();
  
  CreateSinyalButton();
  
//--- create timer
   //EventSetTimer(1);
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   

   OteEngine();

   if ( first_time == false ) {
   
   int iwl=-1;
     for (int bl=0;bl<=max_level_number;bl++){
     for (int bs=0;bs<=max_sinyal_number;bs++){
   iwl=iwl+1;
   
string buttonID=iwl+"ButtonSinyal";

if ( ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT) == "" ) {
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTime";   
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTimes";   
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTimex";   
ObjectDelete(ChartID(),buttonID);
first_time=true;
}


   
     }
     }
   
   ChartRedraw();
   //EventSetTimer(10);
   //if ( server_mode == true ) {EventSetTimer(60);} else {EventSetTimer(10);}

   if ( server_mode == true ) {
   int saniye=60;
   
   if ( int(TimeHour(TimeCurrent())) > 22 ) {
   saniye=600;
   }

   if ( int(TimeHour(TimeCurrent())) < 8 ) {
   saniye=600;
   }
      
   EventSetTimer(saniye);
   
   } else {EventSetTimer(10);}
      
   
   string Sinyal="FULL";   
   //Telegram(Sinyal,"");
   }
      




/////////////////////////////////////////////////////////////
// Chart Open System
/////////////////////////////////////////////////////////////
     int cevap=MessageBox("TradingView Open Chart All Symbol","Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
bool auto_chart_open=true;
if ( auto_chart_open == true ) {
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      
       
      
      
      int sym_num=-1;
      
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      int iwls=sym_total;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {

      sym_num=sym_num+1;
      string sym=Symbola[sym_num];


     if ( StringFind(sym,"USTECH",0) != -1 ) sym="NAS100";
     if ( StringFind(sym,"DE40",0) != -1 ) sym="DE40";
     if ( StringFind(sym,"US30",0) != -1 ) sym="US30";
     if ( StringFind(sym,"US500",0) != -1 ) sym="US500";
     if ( StringFind(sym,"US100",0) != -1 ) sym="US100";
     

   //  if ( TimeHour(TimeCurrent()) >= 15 ) Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
   //  if ( TimeHour(TimeCurrent()) < 15 ) Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
        
     
     if ( TimeHour(TimeCurrent()) >= 15 ) Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", "", 3);
     if ( TimeHour(TimeCurrent()) < 15 ) Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", "", 3);
     
     
     
     Sleep(500);
     
     }
     }
     }
//////////////////////////////////////////////////////     
     

/////////////////////////////////////////////////////////////
// Chart Open System
/////////////////////////////////////////////////////////////
if ( TimeHour(TimeCurrent()) >= 15 ) {
     int cevap=MessageBox("Toyko Session","Tokyo Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
bool auto_chart_open=true;
if ( auto_chart_open == true ) {
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      
       
      
      
      int sym_num=-1;
      
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      int iwls=sym_total;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {

      sym_num=sym_num+1;
      string sym=Symbola[sym_num];


     if ( StringFind(sym,"USTECH",0) != -1 ) sym="NAS100";
     if ( StringFind(sym,"DE40",0) != -1 ) sym="DE40";
     if ( StringFind(sym,"US30",0) != -1 ) sym="US30";
     if ( StringFind(sym,"US500",0) != -1 ) sym="US500";
     if ( StringFind(sym,"US100",0) != -1 ) sym="US100";
     
     
     
     //if ( TimeHour(TimeCurrent()) >= 15 ) Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     //if ( TimeHour(TimeCurrent()) < 15 ) 
     //Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", "", 3);
     
     
     
     Sleep(500);
     
     }
     }
     }
}     
//////////////////////////////////////////////////////  



/////////////////////////////////////////////////////////////
// Chart Open System
/////////////////////////////////////////////////////////////
     int cevaps=MessageBox("TradingView Open Cbdr Chart All Symbol","Open Chart Cbdr",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevaps == 6 ) {
bool auto_chart_open=true;
if ( auto_chart_open == true ) {
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      
       
      
      
      int sym_num=-1;
      
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      int iwls=sym_total;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      //if (iwl > 1)  continue;

      sym_num=sym_num+1;
      string sym=Symbola[sym_num];


     if ( StringFind(sym,"USTECH",0) != -1 ) sym="NAS100";
     if ( StringFind(sym,"DE40",0) != -1 ) sym="DE40";
     if ( StringFind(sym,"US30",0) != -1 ) sym="US30";
     if ( StringFind(sym,"US500",0) != -1 ) sym="US500";
     if ( StringFind(sym,"US100",0) != -1 ) sym="US100";
     
     //Alert(sym);
     
     //Shell32::ShellExecuteW(0, "open", "firefox.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", 3);
     ///Shell32::ShellExecuteW(0, "open", "C://Program Files (x86)//Opera//launcher.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", 3);
     Shell32::ShellExecuteW(0, "open", "C://Program Files (x86)//Opera//launcher.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", 3);
     //Shell32::ShellExecuteW(0, "open", "C://Program Files//Mozilla Firefox//firefox.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", 3);
     
     //if ( TimeHour(TimeCurrent()) >= 15 ) Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     //if ( TimeHour(TimeCurrent()) < 15 ) Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     
     
     
     Sleep(500);
     
     }
     }
     }
//////////////////////////////////////////////////////  













   
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


   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

   if ( first_time == true ) {
   OteEngine();   
   string Sinyal="FULL";   
   //Telegram(Sinyal,"");
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

   //Print(sparam);
   
   
   if ( StringFind(sparam,"ButtonSinyalTimex",0) != -1 ) {
   
   string obj_tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);
   
   int rplc=StringReplace(obj_tooltip,"+","");
   int obj_tooltips=StringToInteger(obj_tooltip);
   //Alert(obj_tooltip,"/",Symbola[obj_tooltips]);

   ChartOpen(Symbola[obj_tooltips],PERIOD_M15);

   
   }
   
   if ( sparam == 18 ) {
   
   if ( endeks_list == true ) { endeks_list=false;} else {endeks_list=true;
   parite_list=false;
   crypto_list=false;
   oil_list=true;
   metals_list=true;   
   }
   
   Print("endeks_list",endeks_list);

   Reset();
      
   }

   if ( sparam == 46 ) {
   
   if ( crypto_list == true ) { crypto_list=false;} else {crypto_list=true;
   parite_list=false;
   endeks_list=false; 
   oil_list=false;
   metals_list=false;     
   }
   
   Print("crypto_list",crypto_list);

   Reset();
      
   }
   

   if ( sparam == 25 ) {
   
   if ( parite_list == true ) { parite_list=false;} else {parite_list=true;
   crypto_list=false;
   endeks_list=false; 
   oil_list=true;
   metals_list=true;    
   }
   
   Print("parite_list",parite_list);
  
   Reset();
      
   }
   

   if ( sparam == 24 ) {
   
   if ( oil_list == true ) { oil_list=false;} else {oil_list=true;
   crypto_list=false;
   endeks_list=false; 
   parite_list=false;
   metals_list=false;     
   }
   
   Print("oil_list",oil_list);
 
   Reset();
      
   }
   
   if ( sparam == 50 ) {
   
   if ( metals_list == true ) { metals_list=false;} else {metals_list=true;
   
   crypto_list=false;
   endeks_list=false; 
   parite_list=false;
   oil_list=false;    
     
   }
   
   Print("oil_list",oil_list);

   Reset();
      
   }
   
      
   
         
      
   
   
   
   if ( sparam == 33 ) {
   
   if ( full_list == true ) {full_list=false;} else {full_list=true;
   
   crypto_list=true;
   endeks_list=true; 
   parite_list=true;
   oil_list=true;  
   metals_list=true;
   
   }
   
   Comment("Full List:",full_list);

      
   Reset();
   
   
   }
   
   
   if ( sparam == 19 ) OteEngine();
   
   if ( StringFind(sparam,"ButtonSinyal",0) != -1 && StringFind(sparam,"ButtonSinyalTime",0) == -1 ) {
   
   string sym=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
   
   if ( sym == "GLDUSD" ) sym="DXY"; 
   //Alert(sym);
   
   //return;
   
   
   Sleep(100);
   
   ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
   
   
   //long chart_open=ChartOpen(sym,Period());
   //ChartSetInteger(chart_open,CHART_BRING_TO_TOP,true);
   
   string select_sym=sym;
   int select_per=Period();

string path = SymbolInfoString(select_sym,SYMBOL_PATH);
//Alert(select_sym+"/"+path);
   //symbolType(select_sym)
   //if ( MarketInfo(pairs[i],MODE_PROFITCALCMODE) == 0 ) {
   if ( StringFind(path,"Crypto",0) != -1 ) select_sym=select_sym+"TPERP";
   
   int rep=StringReplace(select_sym,"#","");
   
   int market_type = MarketInfo(select_sym,MODE_PROFITCALCMODE);   

    //if ( StringFind(path,"Crypto",0) != -1 ) {
    /*if ( market_type != -1 ) {
     int cevap=MessageBox("TradingView "+select_sym,"Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     
     //Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+select_sym+"&interval="+select_per, "", "", 3);
     Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+select_sym+"&interval="+5, "", "", 3);
     
     }; 
     };*/
     

     if ( StringFind(select_sym,"USTECH",0) != -1 ) sym="NAS100";
     if ( StringFind(select_sym,"DE40",0) != -1 ) sym="DE40";
     if ( StringFind(select_sym,"US30",0) != -1 ) sym="US30";
     if ( StringFind(select_sym,"US500",0) != -1 ) sym="US500";
     if ( StringFind(select_sym,"US100",0) != -1 ) sym="US100";     
     
     
     //Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+select_sym+"&interval="+5, "", "", 3);


     int cevap=MessageBox("Tokyo","Tokyo Sesison",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     //Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", "", 3);
     }
     
     int cevapn=MessageBox("Newyork","Newyork Session",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevapn == 6 ) {
     //Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", "", 3);
     }  
     
     int cevapc=MessageBox("CDBR","Cdbr Session",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevapc == 6 ) {
     //Shell32::ShellExecuteW(0, "open", "C://Program Files (x86)//Opera//launcher.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", 3);
     Shell32::ShellExecuteW(0, "open", "C://Program Files (x86)//Opera//launcher.exe", "www.tradingview.com/chart/?symbol="+sym+"&interval="+1, "", 3);
     }  
     
     
             
     
     /*
     if ( TimeHour(TimeCurrent()) >= 15 ) Shell32::ShellExecuteW(0, "open", "microsoft-edge:https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
     if ( TimeHour(TimeCurrent()) < 15 ) Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+5, "", "", 3);
        */  
     
     
        
   /*
    long chart_open=ChartControl(sym,Period());
    
    if ( chart_open == -1 ) {
    ChartOpen(sym,Period());
    } else {
    ChartSetInteger(chart_open,CHART_BRING_TO_TOP,true);
    }*/
       
   
   }
   
   
  }
//+------------------------------------------------------------------+
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Symbol Listesi
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int getAvailableCurrencyPairss(string& availableCurrencyPairs[])
{
//---   
   bool selected = false;
   const int symbolsCount = SymbolsTotal(selected);
   int currencypairsCount;
   ArrayResize(availableCurrencyPairs, symbolsCount);
   int idxCurrencyPair = 0;
   for(int idxSymbol = 0; idxSymbol < symbolsCount; idxSymbol++)
     {      
         string symbol = SymbolName(idxSymbol, selected);
         
         //if ( MarketInfo(symbol,MODE_BID) > 0) {
         //if ( MarketInfo(symbol,MODE_PROFITCALCMODE) == 0 ) {
         //Print(idxSymbol,") symbol = ",symbol);
         //}
         //}
         //if(IsTradeAllowed()) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         //Print(symbol,"=",MarketInfo(symbol,MODE_TRADEALLOWED));
         //if( MarketInfo(symbol,MODE_TRADEALLOWED) ) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         
         
         //string firstChar = StringSubstr(symbol, 0, 1);
         //if(firstChar != "#" && StringLen(symbol) == 6)
         availableCurrencyPairs[idxCurrencyPair++] = symbol; 
     
     }
     currencypairsCount = idxCurrencyPair-1;
     
     //Print(idxCurrencyPair); 
     ArrayResize(availableCurrencyPairs, currencypairsCount);
     return currencypairsCount;
}

// Market Watch List - Piyasa Gozlem Kur Listesi
int market_watch_list(string& availableCurrencyPairs[])
{
   int idxCurrencyPair = 0;
   int HowManySymbols=SymbolsTotal(true);
   ArrayResize(availableCurrencyPairs, HowManySymbols);
   string ListSymbols=" ";
   for(int i=0;i<HowManySymbols;i++)
     {
      ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),"\n");
      //Print("SymbolName(i,true)",SymbolName(i,true));
      string symbol = SymbolName(i,true);
      
      availableCurrencyPairs[idxCurrencyPair++] = symbol;

      
     }
     
     HowManySymbols=idxCurrencyPair-1;

     //Print("HowManySymbols",HowManySymbols);
    
return HowManySymbols;
    
}     
  

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


//////////////////////////////////////////////////////////
int StrtoTF(string sinyal_sym_periyod){
int Chart_Config_per=-1;
//sinyal_sym_periyod=StringToUpper(sinyal_sym_periyod);
   if ( sinyal_sym_periyod == "M1" ) Chart_Config_per = PERIOD_M1;
   if ( sinyal_sym_periyod == "M5" ) Chart_Config_per = PERIOD_M5;
   if ( sinyal_sym_periyod == "M15" ) Chart_Config_per = PERIOD_M15;
   if ( sinyal_sym_periyod == "M30" ) Chart_Config_per = PERIOD_M30;
   if ( sinyal_sym_periyod == "H1" ) Chart_Config_per = PERIOD_H1;
   if ( sinyal_sym_periyod == "H4" ) Chart_Config_per = PERIOD_H4;
   if ( sinyal_sym_periyod == "D1" ) Chart_Config_per = PERIOD_D1;
   if ( sinyal_sym_periyod == "W1" ) Chart_Config_per = PERIOD_W1;
   if ( sinyal_sym_periyod == "MN1" ) Chart_Config_per = PERIOD_MN1;
return Chart_Config_per;
}

string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : 0;//return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader



double DownUp(string sym,ENUM_TIMEFRAMES per) {



   for(int i=350;i>0;i--) {
   
   //if ( TRIANGLE_RED == true ) continue;
   
   //Print(i);
   
   // Left
   double low=iLow(sym,per,i);
   bool find=false;
   for(int b=i+1;b<i+200;b++) {
 
   if (  iLow(sym,per,b)   < low ) {
   find=true;
   }
   
   }
   

   
   bool finds=false;
   for(int b=i-1;b>0;b--) {
    if (  iLow(sym,per,b)   < low ) {
   finds=true;
   }
   
   }
   
   
   if ( find == false && finds == false ) {
   
   /*ObjectDelete(ChartID(),"VLINE"+Time[i]);
   ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);*/

   bool findh=false;
   double high=iHigh(sym,per,i);
   int high_shift;
   
   //for(int b=i-1;b>i-51;b--) {
   for(int b=i-1;b>0;b--) {
   
   if ( b < 0 ) continue;
   
    if (  iHigh(sym,per,b)   > high ) {
   high=iHigh(sym,per,b);
   high_shift=b;
   //findh=true;

   
   }
   
   }   


///////////////////////////////////////////
   if ( high_shift < 5 ) {    
 ///////////////////////////////////////////
    //for(int b=i-1;b>i-51;b--) {
   for(int b=i+1;b<i+51;b++) {
   //for(int b=i+1;b<WindowFirstVisibleBar();b++) {
   
   if ( b < 0 ) continue;
   
    if (  iHigh(sym,per,b)   > high ) {
   high=iHigh(sym,per,b);
   high_shift=b;
   //findh=true;   
   }
   
   }   
/////////////////////////////////////    
   }
////////////////////////////////////////// 



   bool find70=false;
   double fark=high-low;
   double yuzde=fark/100;
   
   for(int s=high_shift-1;s>0;s--) {
   
   //Print("s",s,"/",(high-iLow(sym,per,s))/yuzde);
   
   //if ( (high-iLow(sym,per,s))/Point < 200 ) continue;
   
   if ( s < 0 ) continue;
   
   if ( (high-iLow(sym,per,s))/yuzde > 65 && find70==false ) {
   find70=true;
   /*ObjectDelete(ChartID(),"HLINES"+Time[s]);
   ObjectCreate(ChartID(),"HLINES"+Time[s],OBJ_HLINE,0,Time[s],iLow(sym,per,s));
   ObjectSetString(ChartID(),"HLINES"+Time[s],OBJPROP_TOOLTIP,(high-iLow(sym,per,s))/yuzde);
   ObjectSetInteger(ChartID(),"HLINES"+Time[s],OBJPROP_BACK,true);*/
   }
   
   }
   
/*
   ObjectDelete(ChartID(),"HLINEOTE"+Time[i]);
   ObjectCreate(ChartID(),"HLINEOTE"+Time[i],OBJ_HLINE,0,Time[i],high-yuzde*70);
   ObjectSetString(ChartID(),"HLINEOTE"+Time[i],OBJPROP_TOOLTIP,"OTE70");
   ObjectSetInteger(ChartID(),"HLINEOTE"+Time[i],OBJPROP_COLOR,clrDodgerBlue);
   ObjectSetInteger(ChartID(),"HLINEOTE"+Time[i],OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"LLINEOTE79"+Time[i]);
   ObjectCreate(ChartID(),"LLINEOTE79"+Time[i],OBJ_HLINE,0,Time[i],high-yuzde*79);
   ObjectSetString(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_TOOLTIP,"OTE79");
   ObjectSetInteger(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_COLOR,clrDodgerBlue);
   ObjectSetInteger(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"LLINEOTE65"+Time[i]);
   ObjectCreate(ChartID(),"LLINEOTE65"+Time[i],OBJ_HLINE,0,Time[i],high-yuzde*65);
   ObjectSetString(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_TOOLTIP,"OTE65");
   ObjectSetInteger(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_COLOR,clrNavy);
   ObjectSetInteger(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_BACK,true);
   
   

  ObjectDelete(ChartID(),"VLINE"+Time[high_shift]);
   ObjectCreate(ChartID(),"VLINE"+Time[high_shift],OBJ_VLINE,0,Time[high_shift],Ask);
   ObjectSetString(ChartID(),"VLINE"+Time[high_shift],OBJPROP_TOOLTIP,(high-low)/Point);
   ObjectSetInteger(ChartID(),"VLINE"+Time[high_shift],OBJPROP_BACK,true);

   ObjectDelete(ChartID(),"HLINE"+Time[i]);
   ObjectCreate(ChartID(),"HLINE"+Time[i],OBJ_HLINE,0,Time[i],high);
   ObjectSetInteger(ChartID(),"HLINE"+Time[i],OBJPROP_BACK,true);

  ObjectDelete(ChartID(),"TLINE"+Time[high_shift]);
   ObjectCreate(ChartID(),"TLINE"+Time[high_shift],OBJ_TREND,0,Time[high_shift],high,Time[i],low);
   ObjectSetInteger(ChartID(),"TLINE"+Time[high_shift],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"TLINE"+Time[high_shift],OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+Time[high_shift],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+Time[high_shift],OBJPROP_BACK,true);
   //ObjectSetString(ChartID(),"TLINE"+Time[high_shift],OBJPROP_TOOLTIP,(high-low)/Point);
   

  ObjectDelete(ChartID(),"TLINET"+Time[high_shift]);
   ObjectCreate(ChartID(),"TLINET"+Time[high_shift],OBJ_TRIANGLE,0,Time[high_shift],high,Time[i],low,Time[high_shift]+((i-high_shift)/2)*PeriodSeconds(),high-yuzde*65);
   ObjectSetInteger(ChartID(),"TLINET"+Time[high_shift],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"TLINET"+Time[high_shift],OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"TLINET"+Time[high_shift],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINET"+Time[high_shift],OBJPROP_BACK,true);*/
      
      
      //down_up_level=(MarketInfo(sym,MODE_BID)-low)/yuzde;
      down_up_level=DivZero((high-MarketInfo(sym,MODE_BID)),yuzde);
   //Comment("Down Up Level:",down_up_level);
   
      TRIANGLE_RED=true;

   }
   
   
   
   }

return down_up_level;

}  


double UpDown(string sym,ENUM_TIMEFRAMES per) {


for(int i=350;i>0;i--) {
   
   
   //if ( TRIANGLE_BLUE == true ) continue;
   
   //Print(i);
   
   // Left
   double high=iHigh(sym,per,i);
   bool find=false;
   for(int b=i+1;b<i+200;b++) {
 
   if (  iHigh(sym,per,b)   > high ) {
   find=true;
   }
   
   }
   

   
   bool finds=false;
   for(int b=i-1;b>0;b--) {
    if (  iHigh(sym,per,b)   > high ) {
   finds=true;
   }
   
   }
   
   
   if ( find == false && finds == false ) {
   
   /*ObjectDelete(ChartID(),"VLINE"+Time[i]);
   ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);*/
   

   bool findl=false;
   double low=iLow(sym,per,i);
   int low_shift;
   
   //for(int b=i-1;b>i-51;b--) {
   for(int b=i-1;b>0;b--) {
   
   if ( b < 0 ) continue;
   
    if (  iLow(sym,per,b)   < low ) {
   low=iLow(sym,per,b);
   low_shift=b;
   //findh=true;

   
   }
   
   }   


///////////////////////////////////////////
   if ( low_shift < 5 ) {    
 ///////////////////////////////////////////
    //for(int b=i-1;b>i-51;b--) {
   for(int b=i+1;b<i+51;b++) {
   //for(int b=i+1;b<WindowFirstVisibleBar();b++) {
   
   if ( b < 0 ) continue;
   
    if (  iLow(sym,per,b)   < low ) {
   low=iLow(sym,per,b);
   low_shift=b;
   //findh=true;   
   }
   
   }   
/////////////////////////////////////    
   }
//////////////////////////////////////////   


   bool find70=false;
   double fark=high-low;
   double yuzde=fark/100;
   
   for(int s=low_shift-1;s>0;s--) {
   
   //Print("s",s,"/",(high-iLow(sym,per,s))/yuzde);
   
   //if ( (high-iLow(sym,per,s))/Point < 200 ) continue;
   
   if ( s < 0 ) continue;
   
   if ( (iHigh(sym,per,s)-low)/yuzde > 65 && find70==false ) {
   find70=true;
   /*ObjectDelete(ChartID(),"HLINES"+Time[s]);
   ObjectCreate(ChartID(),"HLINES"+Time[s],OBJ_HLINE,0,Time[s],iHigh(sym,per,s));
   ObjectSetString(ChartID(),"HLINES"+Time[s],OBJPROP_TOOLTIP,(iHigh(sym,per,s)-low)/yuzde);
   ObjectSetInteger(ChartID(),"HLINES"+Time[s],OBJPROP_BACK,true);*/
   }
   
   }
   

   /*ObjectDelete(ChartID(),"LLINEOTE"+Time[i]);
   ObjectCreate(ChartID(),"LLINEOTE"+Time[i],OBJ_HLINE,0,Time[i],low+yuzde*70);
   ObjectSetString(ChartID(),"LLINEOTE"+Time[i],OBJPROP_TOOLTIP,"OTE70");
   ObjectSetInteger(ChartID(),"LLINEOTE"+Time[i],OBJPROP_COLOR,clrDodgerBlue);
   ObjectSetInteger(ChartID(),"LLINEOTE"+Time[i],OBJPROP_BACK,true);

   ObjectDelete(ChartID(),"LLINEOTE79"+Time[i]);
   ObjectCreate(ChartID(),"LLINEOTE79"+Time[i],OBJ_HLINE,0,Time[i],low+yuzde*79);
   ObjectSetString(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_TOOLTIP,"OTE79");
   ObjectSetInteger(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_COLOR,clrDodgerBlue);
   ObjectSetInteger(ChartID(),"LLINEOTE79"+Time[i],OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"LLINEOTE65"+Time[i]);
   ObjectCreate(ChartID(),"LLINEOTE65"+Time[i],OBJ_HLINE,0,Time[i],low+yuzde*65);
   ObjectSetString(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_TOOLTIP,"OTE65");
   ObjectSetInteger(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_COLOR,clrNavy);
   ObjectSetInteger(ChartID(),"LLINEOTE65"+Time[i],OBJPROP_BACK,true);
   
   

  ObjectDelete(ChartID(),"VLINE"+Time[low_shift]);
   ObjectCreate(ChartID(),"VLINE"+Time[low_shift],OBJ_VLINE,0,Time[low_shift],Ask);
   ObjectSetString(ChartID(),"VLINE"+Time[low_shift],OBJPROP_TOOLTIP,(high-low)/Point);
   ObjectSetInteger(ChartID(),"VLINE"+Time[low_shift],OBJPROP_BACK,true);

   ObjectDelete(ChartID(),"HLINE"+Time[i]);
   ObjectCreate(ChartID(),"HLINE"+Time[i],OBJ_HLINE,0,Time[i],low);
   ObjectSetInteger(ChartID(),"HLINE"+Time[i],OBJPROP_BACK,true);
   

  ObjectDelete(ChartID(),"TLINE"+Time[low_shift]);
   ObjectCreate(ChartID(),"TLINE"+Time[low_shift],OBJ_TREND,0,Time[low_shift],low,Time[i],high);
   ObjectSetInteger(ChartID(),"TLINE"+Time[low_shift],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"TLINE"+Time[low_shift],OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+Time[low_shift],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+Time[low_shift],OBJPROP_BACK,true);
   //ObjectSetString(ChartID(),"TLINE"+Time[high_shift],OBJPROP_TOOLTIP,(high-low)/Point);


  ObjectDelete(ChartID(),"TLINET"+Time[low_shift]);
   ObjectCreate(ChartID(),"TLINET"+Time[low_shift],OBJ_TRIANGLE,0,Time[low_shift],low,Time[i],high,Time[low_shift]+((i-low_shift)/2)*PeriodSeconds(),low+yuzde*65);
   ObjectSetInteger(ChartID(),"TLINET"+Time[low_shift],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"TLINET"+Time[low_shift],OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINET"+Time[low_shift],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINET"+Time[low_shift],OBJPROP_BACK,true);*/
   
   
   up_down_level=DivZero((MarketInfo(sym,MODE_BID)-low),yuzde);
   //Comment("Up Down Level:",up_down_level);
   
   TRIANGLE_BLUE=true;

   }
   
   
   
   }
   
   
   return up_down_level;
   
   
}



void OteEngine() {

//Print("Selam");


///////////////////////////////////////////////////////////////////////////////////////////////////////

/*
   int time_saat_farki = 0;
   int time_dakika_farki=0;
   bool time_cikar = false;
   bool time_topla = false;
   

   if ( TimeHour(TimeLocal()) > TimeHour(TimeCurrent()) ) {
   time_saat_farki=int(TimeHour(TimeLocal()))-int(TimeHour(TimeCurrent()));
   time_dakika_farki=(TimeLocal()-TimeCurrent())/60;
   time_cikar=true;
   time_topla=false;
   }
   
   if ( TimeHour(TimeCurrent()) > TimeHour(TimeLocal()) ) {
   time_saat_farki=int(TimeHour(TimeCurrent()))-int(TimeHour(TimeLocal()));
   time_dakika_farki=(TimeCurrent()-TimeLocal())/60;
   time_topla=true;
   time_cikar=false;
   }

  int Time1=3;
  int Time1dk=0;
  int Time2=12;
  int Time2dk=00;
  int Time3=10; 
  int Time3dk=0;
  int Time4=19; 
  int Time4dk=0;
  int Time5=15; 
  int Time5dk=0;      
  int Time6=23; 
  int Time6dk=55;

  int Time7=0; 
  int Time7dk=0;
  int Time8=7; 
  int Time8dk=0;
      
  int Time9=8; 
  int Time9dk=0;
  int Time10=17; 
  int Time10dk=0;



  if ( StringFind(Symbol(),"ETH",0) != -1 ) {
  Time4=17; 
  Time4dk=35;  
  Time1=19; 
  Time1dk=30;       
  }

  if ( StringFind(Symbol(),"BTC",0) != -1 ) {
  Time4=17; 
  Time4dk=35;
  Time1=19; 
  Time1dk=30;          
  }   
  
  
  if ( StringFind(Symbol(),"TECH",0) != -1 ) {
  Time2=17;
  Time2dk=25; 
  Time3=15; 
  Time3dk=0;   
  Time4=1; 
  Time4dk=0;      
  }
  
  if ( StringFind(Symbol(),"DE40",0) != -1 ) {
  Time1=16;
  Time1dk=30;  
  Time2=11;
  Time2dk=0; 
  Time3=10; 
  Time3dk=0; 
  Time4=1; 
  Time4dk=0;        
  }  
  

TimeOH[1]=Time1;
TimeOM[1]=Time1dk;
TimeOH[2]=Time2;
TimeOM[2]=Time2dk;
TimeOH[3]=Time3;
TimeOM[3]=Time3dk;
TimeOH[4]=Time4;
TimeOM[4]=Time4dk;  
TimeOH[5]=Time5;
TimeOM[5]=Time5dk;  
TimeOH[6]=Time6;
TimeOM[6]=Time6dk;  
TimeOH[7]=Time7;
TimeOM[7]=Time7dk;  
TimeOH[8]=Time8;
TimeOM[8]=Time8dk;  
TimeOH[9]=Time9;
TimeOM[9]=Time9dk;  
TimeOH[10]=Time10;
TimeOM[10]=Time10dk;  


  if ( DayOfWeek()==0 || DayOfWeek()==6 ) {
  ////////////////////////////////
  time_saat_farki=1;
  Time1=Time1-time_saat_farki;
  Time2=Time2-time_saat_farki;
  Time3=Time3-time_saat_farki;
  Time4=Time4-time_saat_farki;
  Time5=Time4-time_saat_farki;
  Time6=Time6-time_saat_farki;
  ////////////////////////////////  
  } else {
    
  
 
  if ( time_cikar == true ) {
  Time1=Time1-time_saat_farki;
  Time2=Time2-time_saat_farki;
  Time3=Time3-time_saat_farki;
  Time4=Time4-time_saat_farki;
  Time5=Time5-time_saat_farki;
  Time6=Time6-time_saat_farki;  
  }

  if ( time_topla == true ) {
  Time1=Time1+time_saat_farki;
  Time2=Time2+time_saat_farki;
  Time3=Time3+time_saat_farki;
  Time4=Time4+time_saat_farki;
  Time5=Time5+time_saat_farki;
  Time6=Time6+time_saat_farki;
  } 
  
  
  }

  string yenitarih;
  datetime some_time;

  int defaul_time=PERIOD_M5;
  int toplam_dakika=Bars*Period(); // M1
  if ( defaul_time != PERIOD_M1 ) {
  toplam_dakika=Bars;
  }
  toplam_dakika=400;
  
 int last_shift,shift;
 int last_shifts,shifts;
 int last_shiftn,shiftn; 
 int last_shiftsd,shiftsd;
 int last_shiftf,shiftf;*/








////////////////////////////////////////////////////////////////////////////////////////////////////////

Comment("");
  
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;
  
  
  
  //ObjectsDeleteAll();
  
  
  //CreateSinyalButton();
//--- create timer
   //EventSetTimer(60);
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   




         
   

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      
       
      
      
      int sym_num=-1;
      
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      int iwls=sym_total;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string path = SymbolInfoString(pairswl[iwl],SYMBOL_PATH);
      
      if ( StringFind(path,"Crypto",0) != -1 && crypto_list==false ) continue;
      if ( StringFind(path,"Forex",0) != -1 && parite_list==false ) continue;
      if ( StringFind(path,"Equity",0) != -1 && endeks_list==false ) continue;      
      if ( StringFind(path,"CFD",0) != -1 && endeks_list==false ) continue;      
      if ( StringFind(path,"Indices",0) != -1 && endeks_list==false ) continue;            
      if ( StringFind(path,"Oil",0) != -1 && oil_list==false ) continue;
      if ( StringFind(path,"Metals",0) != -1 && metals_list==false ) continue;      
      
      if(MarketInfo(pairswl[iwl],MODE_TRADEALLOWED) == false && full_list == false ) continue;
      //string sym=pairswl[iwl];


      //if ( StringFind(pairswl[iwl],"GBP",0) != -1 ) continue;
      
      //Print(pairswl[iwl]);
      
      
      
      //iwls=iwls-1;
      
      //string sym=syms[iwl];
      //string sym=Symbola[iwl];
      
      
      sym_num=sym_num+1;
      string sym=Symbola[sym_num];
      
      for(int z=0;z<ArraySize(zaman);z++) {
      
      ENUM_TIMEFRAMES per=zaman[z];
      //per=zaman[z];
      if ( per != Period() ) continue;
      
      
      
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double high_414;
double low_414;
double session_high_price;
double session_low_price;

double session_lnd_high_price;
double session_lnd_low_price;


datetime ty_start_time;
datetime ty_end_time;

datetime lnd_start_time;
datetime lnd_end_time;

symi=sym;
peri=per;

string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);
    
  ty_end_time=some_time;

  int ty_end_shift=iBarShift(sym,per,some_time);


  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  some_time = StringToTime(yenitarih);
  int lnd_start_shift=iBarShift(sym,per,some_time);
  ty_start_time=some_time;
  

if ( int(TimeHour(TimeCurrent())) >= 2 ) {

if ( int(TimeHour(TimeCurrent())) <= 11 )   ty_end_time=TimeCurrent();

ty_end_shift=iBarShift(sym,per,ty_end_time);

//int i=iBarShift(sym,per,ty_end_time);


int shift=iBarShift(sym,per,ty_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
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

   session_high_price=high_price;
   session_low_price=low_price;
   
   
   }

/////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////      



//if ( int(TimeHour(TimeCurrent())) > 8 ) {
if ( int(TimeHour(TimeCurrent())) > 10 ) {


  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 18:00";
  datetime some_time = StringToTime(yenitarih);
    
  lnd_end_time=some_time;

  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  some_time = StringToTime(yenitarih);
  int lnd_start_shift=iBarShift(sym,per,some_time);
  lnd_start_time=some_time;
  


if ( int(TimeHour(TimeCurrent())) <= 18 )   lnd_end_time=TimeCurrent();
  
    int lnd_end_shift=iBarShift(sym,per,lnd_end_time);
    
 

////////////////////////////////////////////////////////////////////////////////////
 int shift=iBarShift(sym,per,lnd_start_time);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shift;s>lnd_end_shift;s--) {
   
   if ( int(TimeHour(Timei(s))) < 18 ) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
      
  }
   
   
   }


session_lnd_high_price=high_price;
session_lnd_low_price=low_price;



}




















      
      ///string buttonID=iwl+"ButtonSinyal"; // Support LeveL Show
      string buttonID=sym_num+"ButtonSinyal"; // Support LeveL Show
      
      
      
      

/////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////      
 
 buttonID=sym_num+"ButtonSinyalTimex"; 
 
bool monday_find=false;
string mon_price_levels;
double mon_price_level;
bool mon_overflow=false;


for (int i=1;i<=7;i++) {


double d1_high_price=iHigh(sym,PERIOD_D1,i);
double d1_low_price=iLow(sym,PERIOD_D1,i);
double d1_fark=d1_high_price-d1_low_price;
double d1_yuzde=DivZero(d1_fark,100);
double d1_eq_price=d1_low_price+d1_yuzde*50;

double d1_price_level;
string d1_price_levels;

int weekday=TimeDayOfWeek(iTime(sym,PERIOD_D1,i));


//iOpen(Symbol(),PERIOD_W1,0) Week
if ( weekday == 1 && monday_find == false ) {
monday_find=true;
////////////////////////////////////////////////////////////////////////
      if ( MarketInfo(sym,MODE_BID) > d1_low_price ) {
      double day_fark=(MarketInfo(sym,MODE_BID)-d1_low_price);
      d1_price_level=DivZero(day_fark,d1_yuzde);
      d1_price_levels=DoubleToString(d1_price_level,2);
      
    

      if ( d1_price_level >= 100 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      mon_overflow=true;
      } 

      if ( d1_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( d1_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } 

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < d1_low_price ) {      
      double day_fark=(d1_low_price-MarketInfo(sym,MODE_BID));
      d1_price_level=DivZero(day_fark,d1_yuzde);
      d1_price_levels="-"+DoubleToString(d1_price_level,2);
      
      if ( d1_price_level >= 0 ) {
      mon_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( d1_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( d1_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }       
         
      
      }
      

mon_price_levels=d1_price_levels;
mon_price_level=d1_price_level;        
      
      }
/////////////////////////////////////////////////////////////////////////////////////////////////
}

      int weekday=TimeDayOfWeek(iTime(sym,PERIOD_D1,0));
      if ( weekday == 1 ) mon_overflow=false;
      
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////      
 



double d1_high_price=iHigh(sym,PERIOD_D1,1);
double d1_low_price=iLow(sym,PERIOD_D1,1);
double d1_fark=d1_high_price-d1_low_price;
double d1_yuzde=DivZero(d1_fark,100);
double d1_eq_price=d1_low_price+d1_yuzde*50;

double d1_price_level;
string d1_price_levels;
bool pw_overflow=false;

//iOpen(Symbol(),PERIOD_W1,0) Week

////////////////////////////////////////////////////////////////////////
      if ( MarketInfo(sym,MODE_BID) > d1_low_price ) {
      double day_fark=(MarketInfo(sym,MODE_BID)-d1_low_price);
      d1_price_level=DivZero(day_fark,d1_yuzde);
      d1_price_levels=DoubleToString(d1_price_level,2);

      if ( d1_price_level >= 100 ) {
      pw_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      } 

      if ( d1_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( d1_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } 

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < d1_low_price ) {      
      double day_fark=(d1_low_price-MarketInfo(sym,MODE_BID));
      d1_price_level=DivZero(day_fark,d1_yuzde);
      d1_price_levels="-"+DoubleToString(d1_price_level,2);
      
      if ( d1_price_level >= 0 ) {
      pw_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( d1_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( d1_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }       
         
      
      }
/////////////////////////////////////////////////////////////////////////////////////////////////
      
if ( weekday == 2 ) pw_overflow=false; // Salı ise sadece mon göstersin.


////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double w_high_price=iHigh(sym,PERIOD_W1,1);
double w_low_price=iLow(sym,PERIOD_W1,1);
double w_fark=w_high_price-w_low_price;
double w_yuzde=DivZero(w_fark,100);
double w_eq_price=w_low_price+w_yuzde*50;

double w_price_level;
string w_price_levels;
bool w_overflow=false;

//iOpen(Symbol(),PERIOD_W1,0) Week

////////////////////////////////////////////////////////////////////////
      if ( MarketInfo(sym,MODE_BID) > w_low_price ) {
      double week_fark=(MarketInfo(sym,MODE_BID)-w_low_price);
      w_price_level=DivZero(week_fark,w_yuzde);
      w_price_levels=DoubleToString(w_price_level,2);

      if ( w_price_level >= 100 ) {
      w_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      } 

      if ( w_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( w_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } 

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < w_low_price ) {      
      double week_fark=(w_low_price-MarketInfo(sym,MODE_BID));
      w_price_level=DivZero(week_fark,w_yuzde);
      w_price_levels="-"+DoubleToString(w_price_level,2);
      
      if ( w_price_level >= 0 ) {
      w_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( w_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( w_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }       
         
      
      }
/////////////////////////////////////////////////////////////////////////////////////////////////
      
//if ( weekday == 2 ) w_overflow=false; // Salı ise sadece mon göstersin.


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IPDA    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
bool ipda=true;
bool ipda_alert=true;



if ( ipda == true ) {
    
    
    
    
   string yenitarih= TimeYear(TimeCurrent())+"."+int(TimeMonth(TimeCurrent()))+"."+IntegerToString(22)+" 00:00";
   
   if ( int(TimeDay(TimeCurrent())) < 22 ) TimeYear(TimeCurrent())+"."+(int(TimeMonth(TimeCurrent()))-1)+"."+IntegerToString(22)+" 00:00";
   
  datetime some_time = StringToTime(yenitarih);
  
  
  
  int shift=iBarShift(sym,PERIOD_D1,some_time);
  
  int last_month=1;

  yenitarih= TimeYear(TimeCurrent())+"."+IntegerToString(int(TimeMonth(TimeCurrent()))-last_month)+"."+IntegerToString(23)+" 00:00";
  if ( int(TimeMonth(TimeCurrent())) == 1 ) yenitarih= IntegerToString(TimeYear(TimeCurrent())-last_month)+"."+IntegerToString(12)+"."+IntegerToString(23)+" 00:00";

if ( int(TimeDay(TimeCurrent())) < 22 ) {
last_month=2;
  yenitarih= TimeYear(TimeCurrent())+"."+IntegerToString(int(TimeMonth(TimeCurrent()))-last_month)+"."+IntegerToString(23)+" 00:00";
  if ( int(TimeMonth(TimeCurrent())) == 1 ) yenitarih= IntegerToString(TimeYear(TimeCurrent())-1)+"."+IntegerToString(11)+"."+IntegerToString(23)+" 00:00";
}





  datetime some_times = StringToTime(yenitarih);

int shiftss=iBarShift(sym,PERIOD_D1,some_times);

  
  /*
  string yenitarihs= TimeYear(TimeCurrent())+"."+IntegerToString(int(TimeMonth(TimeCurrent()))-1)+"."+IntegerToString(23)+" 00:00";
  if ( int(TimeMonth(TimeCurrent())) == 1 ) yenitarihs= IntegerToString(TimeYear(TimeCurrent())-1)+"."+IntegerToString(12)+"."+IntegerToString(23)+" 00:00";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_times = StringToTime(yenitarihs);
  
  int shifts=iBarShift(Symbol(),PERIOD_D1,some_times);*/
  
//int val_index=iHighest(sym,PERIOD_D1,MODE_HIGH,23,shift);
//int val_indexs=iLowest(sym,PERIOD_D1,MODE_LOW,23,shift);


//double i_high_price=iHigh(sym,PERIOD_D1,val_index);
//double i_low_price=iLow(sym,PERIOD_D1,val_indexs);

  double i_high_prices=-1;
  double i_low_prices=1000000000;
  bool find=false;
  int total=0;
  int high_shift=0;
  int low_shift=0;
  
  for (int r=shiftss;r>shiftss-23;r--) {
  
  if ( TimeDay(iTime(sym,PERIOD_D1,r)) == 23 ) total=total+1;
  
  if ( total > 1 ) continue;
  
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))== i
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))+1 == i
  
  if ( i_high_prices < iHigh(sym,PERIOD_D1,r) ) {i_high_prices=iHigh(sym,PERIOD_D1,r);high_shift=r;}
  if ( i_low_prices > iLow(sym,PERIOD_D1,r) ) {i_low_prices=iLow(sym,PERIOD_D1,r);low_shift=r;}


  }
  
double i_high_price=i_high_prices;
double i_low_price=i_low_prices;

//Print(sym,"/",i_high_price,"/",i_low_prices);


double i_fark=i_high_price-i_low_price;
double i_yuzde=DivZero(i_fark,100);
double i_eq_price=i_low_price+i_yuzde*50;
  
double i_price_level;
string i_price_levels;
bool i_overflow=false;  
    

////////////////////////////////////////////////////////////////////////
      if ( MarketInfo(sym,MODE_BID) > i_low_price ) {
      double ipda_fark=(MarketInfo(sym,MODE_BID)-i_low_price);
      i_price_level=DivZero(ipda_fark,i_yuzde);
      i_price_levels=DoubleToString(i_price_level,2);

      if ( i_price_level >= 100 ) {
      i_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      } 

      if ( i_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( i_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } 

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < i_low_price ) {      
      double ipda_fark=(i_low_price-MarketInfo(sym,MODE_BID));
      i_price_level=DivZero(ipda_fark,i_yuzde);
      i_price_levels="-"+DoubleToString(i_price_level,2);
      
      if ( i_price_level >= 0 ) {
      i_overflow=true;
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( i_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( i_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }       
         
      
      }
      
      
      // Dıştan Lowa
      if ( iOpen(sym,PERIOD_M5,0) < i_low_price && iHigh(sym,PERIOD_M5,0) >= i_low_price ) {
      
      string sinyal=sym+" "+"OutLow";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
      
      // İçten Lowa
      if ( iOpen(sym,PERIOD_M5,0) > i_low_price && iLow(sym,PERIOD_M5,0) <= i_low_price ) {
      
      string sinyal=sym+" "+"InLow";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
         

      // Dıştan Higha
      if ( iOpen(sym,PERIOD_M5,0) > i_high_price && iLow(sym,PERIOD_M5,0) <= i_high_price ) {
      
      string sinyal=sym+" "+"OutHigh";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
      
      // İçten Higha
      if ( iOpen(sym,PERIOD_M5,0) < i_high_price && iHigh(sym,PERIOD_M5,0) >= i_high_price ) {
      
      string sinyal=sym+" "+"InHigh";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      } 
            
      
      }
         
   double high_price=i_high_price;
   double low_price=i_low_price;
   double yuzde = DivZero(high_price-low_price, 100);
   
   double level618=yuzde*61.8; // 50 
   double level382=yuzde*38.2; // 38.2
   double level500=yuzde*50; // 50 
   
   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   
   double level886=yuzde*88.6; // 50           
                     
double level=level382;
double level_price=low_price+level;
string levels="382";  

      // Up Down
      if ( iOpen(sym,PERIOD_M5,0) > level_price && iLow(sym,PERIOD_M5,0) <= level_price ) {
      
      string sinyal=sym+" 500-382";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }      
      }
      
      // İçten Level
      if ( iOpen(sym,PERIOD_M5,0) < level_price && iHigh(sym,PERIOD_M5,0) >= level_price ) {

      string sinyal=sym+" 272-382";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }      
            
      }
      
      
      

level=level618;
level_price=low_price+level;

      // Dıştan Level 
      if ( iOpen(sym,PERIOD_M5,0) > level_price && iLow(sym,PERIOD_M5,0) <= level_price ) {
      
      string sinyal=sym+" "+levels+" 700-618";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }      
      }      
      
      
      
      // İçten Higha
      if ( iOpen(sym,PERIOD_M5,0) < level_price && iHigh(sym,PERIOD_M5,0) >= level_price ) {

      string sinyal=sym+" 500-618";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      } 
      
            
      }
      

///////////////////////////////////
level=level272;
level_price=low_price-level;

level=level414;
level_price=low_price-level;

level=level618;
level_price=low_price-level;

level=level886;
level_price=low_price-level;


      // Dıştan Level 
      if ( iOpen(sym,PERIOD_M5,0) > level_price && iLow(sym,PERIOD_M5,0) <= level_price ) {

      string sinyal=sym+" Low618-886";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }      
      }  
    
      
      // Dıştan Level
      if ( iOpen(sym,PERIOD_M5,0) < level_price && iHigh(sym,PERIOD_M5,0) >= level_price ) {
      
      string sinyal=sym+" Low2000-886";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
      
//////////////////////////////////////
level=level272;
level_price=high_price+level;

level=level414;
level_price=high_price+level;

level=level618;
level_price=high_price+level;

level=level886;
level_price=high_price+level;

      // Dıştan Level 
      if ( iOpen(sym,PERIOD_M5,0) > level_price && iLow(sym,PERIOD_M5,0) <= level_price ) {
      
      string sinyal=sym+" High2000-886";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
      
      // İçten Higha
      if ( iOpen(sym,PERIOD_M5,0) < level_price && iHigh(sym,PERIOD_M5,0) >= level_price ) {
      
      string sinyal=sym+" High618-886";
      if ( StringFind(ipda_sinyal,sinyal,0) == -1 ) {
      ipda_sinyal=ipda_sinyal+","+sinyal;
      if ( ipda_alert == true ) Alert(sinyal);
      Telegram(sinyal,"");
      }       
      
      }
            

      
/////////////////////////////////////////////////////////////////////////////////////////////////

ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,i_price_levels);

buttonID="xxx";
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
     
      
      
      if ( mon_overflow == true && pw_overflow == true ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"P%"+d1_price_levels+" M%"+mon_price_levels);
      if ( mon_overflow == true && pw_overflow == false ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"Mon %"+mon_price_levels);
      if ( mon_overflow == false && pw_overflow == true ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"Pre %"+d1_price_levels);
      
      if ( w_overflow == true  ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"Week %"+w_price_levels);
      
      ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,sym);
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,sym+" "+mon_price_levels);

string malives=MaLive(sym);

if ( malives != "" ) ObjectSetString(0,buttonID,OBJPROP_TEXT,malives);




buttonID=sym_num+"ButtonSinyal";

      ObjectSetString(0,buttonID,OBJPROP_TEXT,sym);
      if ( sym=="GLDUSD" ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"DXY");
      


      
      
      //if ( z > 0 ) continue;

      
      //double sym_down_up=DownUp(sym,per);
      //double sym_up_down=UpDown(sym,per);
      // OTE
      double sym_down_up=DownUp(sym,PERIOD_M5);
      double sym_up_down=UpDown(sym,PERIOD_M5);
            

      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
      if ( sym_down_up >= 60 && sym_down_up <=85 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrRed);
      if ( sym_up_down >= 60 && sym_up_down <=85 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlue);
      
      // FİYAT SEVİYESİ
      //int prc_level=price_level(sym,zaman[z],300);
      int prc_level=price_level(sym,PERIOD_M5,300);
      
      //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,DivZero(ObjectGetInteger(0,buttonID,OBJPROP_YSIZE),100)*prc_level);
      
      
      
      //buttonID=iwl+"ButtonSinyalTime";
      buttonID=sym_num+"ButtonSinyalTime";

      ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" / "+int(sym_up_down)+" ("+prc_level+")");
      
      double RSI = iRSI(sym, PERIOD_H1, 14, PRICE_CLOSE, 0);
      double RSIs = iRSI(sym, PERIOD_H4, 14, PRICE_CLOSE, 0);
      
      double RSI12 = iRSI(sym, PERIOD_H1, 12, PRICE_CLOSE, 0);
      double RSIs12 = iRSI(sym, PERIOD_H4, 12, PRICE_CLOSE, 0);
      
      
      if ( sym_down_up >= 60 && sym_down_up <=85 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
      if ( sym_up_down >= 60 && sym_up_down <=85 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_up_down)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));


      if ( RSI <= 35 || RSIs <=35 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkGray);
      if ( RSI >= 65 || RSIs >=65 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkGray);
      


      if ( RSI <= 22 || RSIs <=22 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      if ( RSI >= 78 || RSIs >=78 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      
      if ( RSI <= 22 || RSIs <=22 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_up_down)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
      if ( RSI >= 78 || RSIs >=78 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
      
      //if ( sym_down_up >= 60 && sym_down_up <=85 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" ("+prc_level+") "+int(RSI));
      //if ( sym_up_down >= 60 && sym_up_down <=85 ) ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_up_down)+" ("+prc_level+") "+int(RSI));
      
      
      //Print(sym,"/",TFtoStr(per),"/ sym_down_up:",sym_down_up," sym_up_down",sym_up_down);

     //if ( sym_down_up 
     if ( sym == Symbol() ) rapor = rapor+"\n\n"+sym+":"+TFtoStr(per)+" / Down Up:"+DoubleToString(sym_down_up,0)+" UpDown:"+DoubleToString(sym_up_down,0)+"\n";
     
     if ( sym != Symbol() )  rapor = rapor+"\n"+sym+":"+TFtoStr(per)+" / Down Up:"+DoubleToString(sym_down_up,0)+" UpDown:"+DoubleToString(sym_up_down,0);


///////////////////////////////////////////////////////////////////////////////////



int c=0;
double sum=0;
double AvgRange=0;
double AvgRgHigh, AvgRgLow, TodaysRange;
int NumOfDays=14;
double hi,lo;

for (int i=1; i<Bars-1; i++)  {
    double hi = iHigh(sym,PERIOD_D1,i);
    double lo = iLow(sym,PERIOD_D1,i);
    datetime dt = iTime(sym,PERIOD_D1,i);
    if (TimeDayOfWeek(dt) > 0 && TimeDayOfWeek(dt) < 6)  {
      sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(sym, PERIOD_D1, i) - iLow(sym, PERIOD_D1, i));
      
      if (c>=NumOfDays) break;    
  } }
  hi = iHigh(sym,PERIOD_D1,0);
  lo = iLow(sym,PERIOD_D1,0);
  


 AvgRange = AvgRange / NumOfDays;

 TodaysRange = (hi-lo);
  
  
   AvgRgHigh = NormalizeDouble(lo + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
    
  int AvgRgHigh_Fark = DivZero(((lo + AvgRange)-MarketInfo(sym,MODE_BID)),MarketInfo(sym,MODE_POINT));
  int AvgRgLow_Fark = DivZero((MarketInfo(sym,MODE_BID)-(hi - AvgRange)),MarketInfo(sym,MODE_POINT));
  

double AvgRhYuzde=DivZero((AvgRgHigh-AvgRgLow),100);
double AvgRgLevel=DivZero(AvgRgLow_Fark,(AvgRhYuzde/MarketInfo(sym,MODE_POINT)));

/////////////////////////////////////////////////////////////////////////////////////
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,AvgRgHigh_Fark+" / "+AvgRgHigh);
      ObjectSetString(0,buttonID,OBJPROP_TEXT,AvgRgHigh_Fark+" / "+AvgRgLow_Fark);
      
      string pbilgi="";//"A:"+int(AvgRgLevel);
      
      if ( AvgRgLevel <= 10 || AvgRgLevel >= 90 ) pbilgi="A:"+int(AvgRgLevel);
      if ( pbilgi != "" ) pbilgi=pbilgi+" / ";
      if ( prc_level <= 10 || prc_level >= 90 ) pbilgi=pbilgi+"PL:"+prc_level;

      if ( RSIs <=22 || RSIs >=78 ) {
      if ( pbilgi != "" ) pbilgi=pbilgi+" / ";
      pbilgi=pbilgi+"RSI:"+int(RSIs);
      }      

if ( sym_down_up >= 60 && sym_down_up <=85 ) {
if ( pbilgi != "" ) pbilgi=pbilgi+" / ";

      if ( sym_down_up >= 60 && sym_down_up <=85 ) pbilgi=pbilgi+"DU:"+int(sym_down_up);
      if ( sym_up_down >= 60 && sym_up_down <=85 ) pbilgi=pbilgi+"UD:"+int(sym_up_down);

}



ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
      
      

      
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_up_down)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
      //if  ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" ("+prc_level+") "+int(RSI)+"/"+int(RSIs));
            
      
      //if ( prc_level <= 10 || prc_level >= 90 ) pbilgi="A:"+int(AvgRgLevel)+" / PL:"+prc_level;
      
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,"A:"+int(AvgRgLevel)+" / PL:"+prc_level);
      ObjectSetString(0,buttonID,OBJPROP_TEXT,pbilgi);
      
      

      if ( AvgRgHigh_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      if ( AvgRgLow_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      
      if ( AvgRgHigh_Fark < 100  ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"H"+AvgRgHigh_Fark);
      if ( AvgRgLow_Fark < 100  ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"L"+AvgRgLow_Fark);
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////




c=0;
//double sum=0;
AvgRange=0;
//double AvgRgHigh, AvgRgLow, PresentRange;
int NumOfPeriods=14;

ENUM_TIMEFRAMES ATRPeriod=PERIOD_W1;

for (int i=1; i<Bars-1; i++)  {
    //double hi = iHigh(sym,ATRPeriod,i);
    //double lo = iLow(sym,ATRPeriod,i);
    //datetime dt = iTime(sym,ATRPeriod,i);
    {
      //sum += hi - lo;
      c++;  
         
      AvgRange = AvgRange + (iHigh(sym, ATRPeriod, i) - iLow(sym, ATRPeriod, i));
      
      if (c>=NumOfPeriods) break;    
  } }
  hi = iHigh(sym,ATRPeriod,0);
  lo = iLow(sym,ATRPeriod,0);
  


 AvgRange = AvgRange / NumOfPeriods;

 //PresentRange = (hi-lo);
  
 
  
   AvgRgHigh = NormalizeDouble(lo + AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   AvgRgLow =  NormalizeDouble(hi - AvgRange, MarketInfo(sym,MODE_DIGITS)-1);
   
    
  int AvgRgHighAtr_Fark = DivZero(((lo + AvgRange)-MarketInfo(sym,MODE_BID)),MarketInfo(sym,MODE_POINT));
  int AvgRgLowAtr_Fark = DivZero((MarketInfo(sym,MODE_BID)-(hi - AvgRange)),MarketInfo(sym,MODE_POINT));

double AvgRhAtrYuzde=DivZero((AvgRgHigh-AvgRgLow),100);
double AvgRgAtrLevel=DivZero(AvgRgLowAtr_Fark,(AvgRhAtrYuzde/MarketInfo(sym,MODE_POINT)));


if ( AvgRgAtrLevel <= 10 || AvgRgAtrLevel >= 90 ) {
if ( pbilgi != "" ) pbilgi=pbilgi+" / ";
pbilgi=pbilgi+"ATR:"+int(AvgRgAtrLevel);
}


ObjectSetString(0,buttonID,OBJPROP_TEXT,pbilgi);
  
/////////////////////////////////////////////////////////////////////////////////////
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,AvgRgHighAtr_Fark+" / "+AvgRgLowAtr_Fark);
/*
      if ( AvgRgHighAtr_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkOrange);
      if ( AvgRgLowAtr_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkKhaki);
      
      if ( AvgRgHigh_Fark < 0  ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"H"+AvgRgHigh_Fark+" / ATR "+AvgRgHighAtr_Fark);
      if ( AvgRgLow_Fark < 0  ) ObjectSetString(0,buttonID,OBJPROP_TEXT,"L"+AvgRgLow_Fark+" / ATR "+AvgRgLowAtr_Fark);
*/

      
/////////////////////////////////////////////////////////////////////////////////////////////////////////






      buttonID=sym_num+"ButtonSinyalTimes";


//if ( StringFind(path,"Indices",0) != -1 || StringFind(path,"Equity",0) != -1 || StringFind(path,"CFD",0) != -1 ) {
      ObjectSetString(0,buttonID,OBJPROP_TEXT,int(sym_down_up)+" / "+int(sym_up_down)+" ("+prc_level+") "+int(RSI12)+"/"+int(RSIs12));



      //if ( RSI12 <= 22 || RSIs12 <=22 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      //if ( RSI12 >= 78 || RSIs12 >=78 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      
      bool filter=false;
      
      if ( (RSI12 <= 22 || RSIs12 <=22) && prc_level <= 30 ) {ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);filter=true;}
      if ( (RSI12 >= 78 || RSIs12 >=78) && prc_level >= 70 ) {ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);filter=true;}      

      if ( (RSI12 <= 22 || RSIs12 <=22) ) {ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);filter=true;}
      if ( (RSI12 >= 78 || RSIs12 >=78) ) {ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);filter=true;}      


      if ( filter == false ) {
      ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
      }


      /*double highlow_414_yuzde=DivZero((high_414-low_414),100);
      double highlow_414_price_level=0;
      
      if ( MarketInfo(sym,MODE_BID) > low_414 ) {
      double highlow_414_fark=(MarketInfo(sym,MODE_BID)-low_414);
      highlow_414_price_level=DivZero(highlow_414_fark,highlow_414_yuzde);
      }*/



   double session_yuzde = DivZero(session_high_price-session_low_price, 100);
   double yuzde=session_yuzde;
   
   double eq=session_low_price+yuzde*50; // 50
   
   double level45=session_low_price+yuzde*45; // 50
   double level55=session_low_price+yuzde*55; // 50
   
   double level70=session_low_price+yuzde*70; // 50
   double level79=session_low_price+yuzde*79; // 50
   double level21=session_low_price+yuzde*21; // 50
   double level30=session_low_price+yuzde*30; // 50

   double level168=session_yuzde*16.18; // 50
   double level130=session_yuzde*13; // 50
   double level272=session_yuzde*27.2; // 50
   double level414=session_yuzde*41.4; // 50   
   

double session_price_level=0;   
string session_price_levels="";
   
      //double highlow_414_yuzde=DivZero((high_414-low_414),100);
      //double highlow_414_price_level=0;
      


///////////////////////////////////////////////////////////////////////////////////////////////////////
// Sabah Tokyo Low High Yaklaşanlar
////////////////////////////////////////////////////////////////////////////////////////////////////////
int session_low_fark=(MarketInfo(sym,MODE_BID)-session_low_price)/MarketInfo(sym,MODE_POINT);
int session_high_fark=(session_high_price-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
//double session_hl_fark=(session_high_price-session_low_price);

if ( TimeHour(TimeCurrent()) < 11 || pbilgi=="" ) {
      double session_fark=(MarketInfo(sym,MODE_BID)-session_low_price);
      session_price_level=DivZero(session_fark,session_yuzde);
      
if ( session_low_fark < session_high_fark && session_low_fark >= 0 && (int(session_price_level) >= 80 || int(session_price_level) <= 20) ) ObjectSetString(0,sym_num+"ButtonSinyalTime",OBJPROP_TEXT,"Low:"+session_low_fark+" %"+int(session_price_level));
if ( session_low_fark > session_high_fark && session_high_fark >= 0 && (int(session_price_level) >= 80 || int(session_price_level) <= 20) ) ObjectSetString(0,sym_num+"ButtonSinyalTime",OBJPROP_TEXT,"High:"+session_high_fark+" %"+int(session_price_level));
}
////////////////////////////////////////////////////////////////////////////////////////////////////////
// Robotta eğer fiyat çok yaklaştıysa daha fazla yukarı çıkmadan döndüğü için canlı işleme girebilir.
////////////////////////////////////////////////////////////////////////////////////////////////////////

//ObjectSetString(0,sym_num+"ButtonSinyalTime",OBJPROP_TEXT,session_high_fark+"/"+session_low_fark);

      
      
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkGray);
      
      if ( MarketInfo(sym,MODE_BID) > session_low_price ) {
      double session_fark=(MarketInfo(sym,MODE_BID)-session_low_price);
      session_price_level=DivZero(session_fark,session_yuzde);
      session_price_levels=DoubleToString(session_price_level,2);

      if ( session_price_level >= 100 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      } 

      if ( session_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( session_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } 

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < session_low_price ) {      
      double session_fark=(session_low_price-MarketInfo(sym,MODE_BID));
      session_price_level=DivZero(session_fark,session_yuzde);
      session_price_levels="-"+DoubleToString(session_price_level,2);
      
      if ( session_price_level >= 0 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( session_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( session_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }       
         
      
      }


      buttonID=sym_num+"ButtonSinyal"; // Support LeveL Show
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,sym);
      
      //if ( z > 0 ) continue;

      
      //double sym_down_up=DownUp(sym,per);
      //double sym_up_down=UpDown(sym,per);

      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
      if ( session_price_level <= 10 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrRed);
      if ( session_price_level >= 90 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlue);      

      if ( AvgRgHigh_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      if ( AvgRgLow_Fark < 100  ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
            
      
   buttonID=sym_num+"ButtonSinyalTimes";

/////////////////////////////////////////////////////////////////////////////////////////////////


double session_lnd_price_level=0;   
string session_lnd_price_levels="";

if ( int(TimeHour(TimeCurrent())) > 8 ) { 


   double session_lnd_yuzde = DivZero(session_lnd_high_price-session_lnd_low_price, 100);
   double yuzde_lnd=session_lnd_yuzde;
   
   
      //double highlow_414_yuzde=DivZero((high_414-low_414),100);
      //double highlow_414_price_level=0;
      
      //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkGray);
      
      if ( MarketInfo(sym,MODE_BID) > session_lnd_low_price ) {
      double session_lnd_fark=(MarketInfo(sym,MODE_BID)-session_lnd_low_price);
      session_lnd_price_level=DivZero(session_lnd_fark,session_lnd_yuzde);
      session_lnd_price_levels=DoubleToString(session_lnd_price_level,2);
/*
      if ( session_price_level >= 100 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightBlue);
      } 

      if ( session_price_level >= 127.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepSkyBlue);
      } 

      if ( session_price_level >= 141.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkBlue);
      } */

            
      
      }
   
      
      if ( MarketInfo(sym,MODE_BID) < session_lnd_low_price ) {      
      double session_lnd_fark=(session_lnd_low_price-MarketInfo(sym,MODE_BID));
      session_lnd_price_level=DivZero(session_lnd_fark,session_lnd_yuzde);
      session_lnd_price_levels="-"+DoubleToString(session_lnd_price_level,2);
      
      /*
      if ( session_price_level >= 0 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightPink);
      }   
      
      //if ( session_price_level >= -27.2 ) {
      if ( session_price_level >= 27.2 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDeepPink);
      }   
      
      //if ( session_price_level <= -41.4 ) {
      if ( session_price_level >= 41.4 ) {
      ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrDarkRed);
      }  */     
         
      
      }

}



















//////////////////////////////////////////////////////////////////////////////////////////////////

   
         
      
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,high_414+"/"+low_414);
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,session_low_price);
      //ObjectSetString(0,buttonID,OBJPROP_TEXT,session_high_price);
      ObjectSetString(0,buttonID,OBJPROP_TEXT,session_price_levels);
      
      if ( session_lnd_price_levels != "0.00" ) ObjectSetString(0,buttonID,OBJPROP_TEXT,session_price_levels+" / "+session_lnd_price_levels);
      

//}



      
      }
      
      
      
      
      }   
   
   ///Comment(rapor);
   //Alert(rapor);
   rapor="";

ChartRedraw(ChartID());
WindowRedraw();


}

int max_sinyal_number = (ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)-130) / 140;

int max_level_number = (ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0)-60) / 70;


void CreateSinyalButton() {

if ( single_mode == true ) {
CreateSinyalButtonSingle();
return;
}


  
  
  string buttonID="";
  
  int iwl=-1;
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bl=0;bl<=max_level_number;bl++){
     for (int bs=0;bs<=max_sinyal_number;bs++){

    //for (int bl=max_level_number;bl>=0;bl--){
     //for (int bs=max_sinyal_number;bs>=0;bs--){
     
     
     iwl=iwl+1;
     
     //iwl=sym_total-1;
   
   //buttonID=bl+"ButtonSinyal"+bs; // Support LeveL Show
   buttonID=iwl+"ButtonSinyal"; // Support LeveL Show
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,60+(120*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,50);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl);
   


   buttonID=iwl+"ButtonSinyalTimes";
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,110+(120*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl+"+");
   
   
   //buttonID=bl+"ButtonSinyalTime"+bs;
   buttonID=iwl+"ButtonSinyalTime";
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,130+(120*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl+"+");
      
   //buttonID=bl+"ButtonSinyalTime"+bs;
   buttonID=iwl+"ButtonSinyalTimex";
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,150+(120*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl+"+");   
   
   
      
   
   }
   
   }
   
   
   ChartRedraw(ChartID());
   WindowRedraw();

}         

long ChartControl(string sinyal_sym,int sinyal_per) {

     bool pairCheck=false;
     long cid=-1;
     
          long currChart,prevChart=ChartFirst();
   int i=0,limit=30;
   Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      if(currChart<0) break;          // Have reached the end of the chart list
      Print(i,ChartSymbol(currChart)," ID =",currChart);
      //ChartSetSymbolPeriod(currChart,Symbol(), ChartPeriod(currChart));      
      //ChartSetInteger(currChart,CHART_AUTOSCROLL,false);

      //if ( ChartSymbol(currChart) == sinyal_sym &&  ChartPeriod(currChart) == sinyal_per ) pairCheck = true;
      if ( ChartSymbol(currChart) == sinyal_sym &&  ChartPeriod(currChart) == sinyal_per ) cid = currChart;
   
      //if ( ChartFirst() != currChart && pairCheck && Symbol() != ChartSymbol(currChart) ) {pairCheck =false;ChartClose(currChart);} // onceki pair kapatip sona acar

      prevChart=currChart;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
     }
     
     
     //return pairCheck;
     return cid;
     
     
     }
     


int price_level(string sym,int per,int shift) {


double high_price=iHigh(sym,per,shift);
double low_price=iLow(sym,per,shift);
int high_shift=shift;
int low_shift=shift;



for ( int d=shift;d>=0;d--) {

if ( iHigh(sym,per,d) > high_price ) {
high_price=iHigh(sym,per,d);
high_shift=d;
}

if (iLow(sym,per,d) < low_price ) {
low_price=iLow(sym,per,d);
low_shift=d;
}



}


 double yuzde=DivZero((high_price-low_price),100);
 double price=DivZero((MarketInfo(sym,MODE_BID)-low_price),yuzde);
 
return price;


}


void Reset() {


////////////////////////////////////////////////////////////////////////////////////////////////  
  string harf="A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,R,S,T,U,V,Y,Z,X,W,.";

string to_split=harf;//"life_is_good";   // A string to split into substrings
   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   
   //Alert(k);
   
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
 //if ( StringSubstr(pairz,0,3) == "EUR" && StringSubstr(pairz,3,3) == "EUR") {
 
 
 int s=-1;
   
   if(k>0)
     {
     
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);     
     
      for(int i=0;i<k;i++)
        {
        //PrintFormat("result[%d]=%s",i,results[i]);

      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string path = SymbolInfoString(pairswl[iwl],SYMBOL_PATH);
      
      if ( StringFind(path,"Crypto",0) != -1 && crypto_list==false ) continue;
      if ( StringFind(path,"Forex",0) != -1 && parite_list==false ) continue;
      if ( StringFind(path,"Equity",0) != -1 && endeks_list==false ) continue;
      if ( StringFind(path,"CFD",0) != -1 && endeks_list==false ) continue;      
      if ( StringFind(path,"Indices",0) != -1 && endeks_list==false ) continue;      
      if ( StringFind(path,"Oil",0) != -1 && oil_list==false ) continue;
      if ( StringFind(path,"Metals",0) != -1 && metals_list==false ) continue;
      
      if(MarketInfo(pairswl[iwl],MODE_TRADEALLOWED) || full_list == true ){
      if ( StringSubstr(pairswl[iwl],0,1) == results[i] ) {
      s=s+1;
      Symbola[s]=pairswl[iwl];    
      } 
      }
          
      }          
        
        }
        
        
    for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      //Print(Symbola[iwl]);
      }
              
        
        
        
        }
////////////////////////////////////////////////////////////////////////////        
        
        
        
  ObjectsDeleteAll();
  
  CreateSinyalButton();

   OteEngine();

   //if ( first_time == false ) {
   
   int iwl=-1;
     for (int bl=0;bl<=max_level_number;bl++){
     for (int bs=0;bs<=max_sinyal_number;bs++){
   iwl=iwl+1;
   
string buttonID=iwl+"ButtonSinyal";

if ( ObjectGetString(ChartID(),buttonID,OBJPROP_TEXT) == "" ) {
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTime";   
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTimes";   
ObjectDelete(ChartID(),buttonID);
buttonID=iwl+"ButtonSinyalTimex";   
ObjectDelete(ChartID(),buttonID);
first_time=true;
}


   
     }
     }
   
   ChartRedraw();
   
//   }
      

}



string sinyal_list="";
// Sinyal hafızaya alınır,
// Sinyals Telegram Sinyali olarak gönderilir.





void Telegram(string Sinyal,string Sinyals) {



//if ( server_mode == false ) return;

//Sinyals=Sinyal+"-"+TFtoStr(Period());
Sinyals=Sinyal;
//Alert(Sinyal);


/*
if ( StringFind(sinyal_list,Sinyal,0) == -1 ) {
sinyal_list=sinyal_list+","+Sinyal;
} else {
return;
}

if ( first_time == false ) return;
*/

   //string Sinyal=Symbol()+" Robot Başladı";
   string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;
   //string url="https://api.telegram.org/bot5290598636:AAFNFWf8xsUX6DOpZ8M_Qhc1Eral2c6AYA4/sendMessage?chat_id=380108128&text="+Sinyal;

         url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal+" "+Sinyals;
         //url="http://www.yorumlari.org/telegram-king.php?sinyal="+Sinyals;

     string cookie=NULL,headers;
   char post[],result[];
   //int res;
//--- to enable access to the server, you should add URL "https://www.google.com/finance"
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"):
   //string url=server;
//--- Reset the last error code
   ResetLastError();
//--- Loading a html page from Google Finance
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection
   int res=WebRequest("POST",url,cookie,NULL,timeout,post,0,result,headers);
   

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//string image_files=Symbol()+"-"+Sinyal+"-"+TFtoStr(Period());
string image_files=Sinyal+"-"+TFtoStr(Period());

           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 


   int height=ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   

  if(ChartScreenShot(ChartID(),filename,width,height,ALIGN_CENTER)){
  

  if (!SendFTP(filename,NULL)) {
 Print("ScreenShot2webspace EA: Send2Ftp - Error "+GetLastError());
 } else {
 
 
  Sleep(500);
  
 
       string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   ///int resi = WebRequest("POST", "http://45.144.154.90/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   int resi = WebRequest("GET", "http://yorumlari.org/forex.net.tr/resim-sendphoto-king.php?resim="+filename+"&chat_ids="+chat_ids, "", NULL, 10000, post, ArraySize(post), result, headers);

 //Alert(resi);
 
 }
 
 
 }*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////



}
     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };




void CreateSinyalButtonSingle() {

  
  
  string buttonID="";
  
  int iwl=-1;
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bl=0;bl<=max_level_number;bl++){
     for (int bs=0;bs<=max_sinyal_number;bs++){

    //for (int bl=max_level_number;bl>=0;bl--){
     //for (int bs=max_sinyal_number;bs>=0;bs--){
     
     
     iwl=iwl+1;
     
     //iwl=sym_total-1;
   
   //buttonID=bl+"ButtonSinyal"+bs; // Support LeveL Show
   buttonID=iwl+"ButtonSinyal"; // Support LeveL Show
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,60+(110*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,80);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl);
   
   //buttonID=bl+"ButtonSinyalTime"+bs;
   buttonID=iwl+"ButtonSinyalTime";
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,130+(110*bl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,iwl+"+");
   
   }
   
   }
   
   
   ChartRedraw(ChartID());
   WindowRedraw();

}         



string MaLive(string sym) {


string sonuc="";

   double MA4H=iMA(sym, PERIOD_H4, MA_W, ma_shift, MaMethod, MaPrice, 0); 
   
   double MB4H=iMA(sym, PERIOD_H4, MB_W, ma_shift, MaMethods, MaPrices, 0); 
   
   double MAD1=iMA(sym, PERIOD_D1, MA_W, ma_shift, MaMethod, MaPrice, 0); 
   
   double MBD1=iMA(sym, PERIOD_D1, MB_W, ma_shift, MaMethods, MaPrices, 0);    

   double MAW1=iMA(sym, PERIOD_W1, MA_W, ma_shift, MaMethod, MaPrice, 0); 
   
   double MBW1=iMA(sym, PERIOD_W1, MB_W, ma_shift, MaMethods, MaPrices, 0);
   
   
   int ma4h_fark=0;
   if ( MA4H > MarketInfo(sym,MODE_BID)) ma4h_fark = (MA4H-MarketInfo(sym,MODE_BID))/Point;
   
   int mad1_fark=0;
   if ( MAD1 > MarketInfo(sym,MODE_BID)) mad1_fark = (MAD1-MarketInfo(sym,MODE_BID))/Point;
   
   int maw1_fark=0;
   if ( MAW1 > MarketInfo(sym,MODE_BID)) maw1_fark = (MAW1-MarketInfo(sym,MODE_BID))/Point;




   
   if ( MA4H < MarketInfo(sym,MODE_BID)) ma4h_fark = (MarketInfo(sym,MODE_BID)-MA4H)/Point;
      
   if ( MAD1 < MarketInfo(sym,MODE_BID)) mad1_fark = (MarketInfo(sym,MODE_BID)-MAD1)/Point;
      
   if ( MAW1 < MarketInfo(sym,MODE_BID)) maw1_fark = (MarketInfo(sym,MODE_BID)-MAW1)/Point;

//////////////////////////////////////////////////////////////////////////////////////////////////


   int mb4h_fark=0;
   if ( MB4H > MarketInfo(sym,MODE_BID)) mb4h_fark = (MB4H-MarketInfo(sym,MODE_BID))/Point;
   
   int mbd1_fark=0;
   if ( MBD1 > MarketInfo(sym,MODE_BID)) mbd1_fark = (MBD1-MarketInfo(sym,MODE_BID))/Point;
   
   int mbw1_fark=0;
   if ( MBW1 > MarketInfo(sym,MODE_BID)) mbw1_fark = (MBW1-MarketInfo(sym,MODE_BID))/Point;




   
   if ( MB4H < MarketInfo(sym,MODE_BID)) mb4h_fark = (MarketInfo(sym,MODE_BID)-MB4H)/Point;
      
   if ( MBD1 < MarketInfo(sym,MODE_BID)) mbd1_fark = (MarketInfo(sym,MODE_BID)-MBD1)/Point;
      
   if ( MBW1 < MarketInfo(sym,MODE_BID)) mbw1_fark = (MarketInfo(sym,MODE_BID)-MBW1)/Point;


//return sonuc = mb4h_fark +"/"+mbd1_fark+"/"+mbw1_fark;   // simple
      
string ma4h_farks="4H:"+ma4h_fark;
string mad1_farks="D1:"+mad1_fark;      
string maw1_farks="W1:"+maw1_fark;

string bilgi="";

if ( ma4h_fark < 100 ) bilgi = ma4h_farks;

if ( bilgi != "" ) {
bilgi = bilgi + " ";
}

if ( mad1_fark < 100 ) bilgi = bilgi + mad1_farks;


if ( maw1_fark < 100 ) bilgi = bilgi + " " + maw1_farks;


//+"/D1:"+mad1_fark+"/ W1:"+maw1_fark;

if ( bilgi != "" ) bilgi = "E: "+bilgi;


string mb4h_farks="4H:"+mb4h_fark;
string mbd1_farks="D1:"+mbd1_fark;      
string mbw1_farks="W1:"+mbw1_fark;

string bilgis="";

if ( mb4h_fark < 100 ) bilgis = mb4h_farks;

if ( bilgis != "" ) {
bilgis = bilgis + " ";
}

if ( mbd1_fark < 100 ) bilgis = bilgis + mbd1_farks;


if ( mbw1_fark < 100 ) bilgis = bilgis + " " + mbw1_farks;


//+"/D1:"+mad1_fark+"/ W1:"+maw1_fark;

if ( bilgis != "" ) bilgis = "S: "+bilgis;

sonuc = bilgi;

if ( bilgi != "" && bilgis != "" ) sonuc = bilgi + " " + bilgis;

if ( bilgi == "" && bilgis != "" ) sonuc = bilgis;

      
return sonuc; // ema
      
   
   
}