//+------------------------------------------------------------------+
//|                                                   MaEaSearch.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



ENUM_TIMEFRAMES zaman[9];

/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=50;
extern int MB_W=10;
extern int MC_W=20;
/////////////////////////////////////////////////////////

double ma_high=-1;
double ma_low=1000000;


double ma_level[1001];


int swing_power=34;

string cmt="";



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   
   ObjectsDeleteAll();
   
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;
  
   EngineClear();
   MaEngine();
   EngineClearVline();
   ChartRedraw();
   
   Comment("MaSearch:",cmt);
   
   
   
   
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



void MaEngine() {


string Comment_Line = "";

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string sym=pairswl[iwl];
      ENUM_TIMEFRAMES per=Period();
      //Print(sym);
      bool bigbar=false;
      
      
      //if ( sym != Symbol() ) continue;
      
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  per=zaman[z];
  
  if ( per == PERIOD_M1 ) continue;
  //if ( per == PERIOD_M5 ) continue;
  //if ( per == PERIOD_M15 ) continue;
  //if ( per == PERIOD_M30 ) continue;
  //if ( per == PERIOD_H1 ) continue;
  //if ( per == PERIOD_H4 ) continue;
  //if ( per == PERIOD_D1 ) continue;
  if ( per == PERIOD_MN1 ) continue;
  if ( per == PERIOD_W1 ) continue;
  
  
  //Print(sym,"/",TFtoStr(per));
  
  //int ma_shift=50;


MaFind(sym,per,0);

  

   //string select_sym=Symbol();
   //int select_per=Period();
   
   int select_per=per;
   string select_sym=sym;
   
   
   }}}


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

string bilgiler="";



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
  

void EngineClear() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"MAL",0) != -1 || StringFind(names,"MBL",0) != -1 ) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}

void EngineClearVline() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"VLINE",0) != -1 || StringFind(names,"VLINE",0) != -1 ) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}


void MaFind(string sym,ENUM_TIMEFRAMES per,int ma_shift) {

int Barss=Bars-100;
Barss=1000;


for(int i=1;i<1000;i++){


double ma=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, i);


/*
if ( iClose(sym,per,i) > ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && 
find==false && iClose(sym,per,b) < ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}
*/


/*
if ( iClose(sym,per,i) < ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && 
find==false && iClose(sym,per,b) > ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}
*/











//continue;

/*
if ( iClose(sym,per,i) > mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma > mab && 
find==false && iClose(sym,per,b) < mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}
*/
/*
if ( iClose(sym,per,i) < mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma < mab && 
find==false && iClose(sym,per,b) > mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}
*/



}



for ( int i=Barss;i>65;i--) {

if ( Bars < i ) continue;

double ma=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma < iHigh(sym,per,b) && find==false) {
say=say+1;
} else {
//find=true;
}

}






if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     int kalan=(ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) < ma ) {Print("MaTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"\nMATop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
     
           
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     }
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) < ma ) {Print("MaTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"\nMATop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
            
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MAL"+i);
     }
          

}






}


//return 0;


for ( int i=Barss;i>25;i--) {

if ( Bars < i ) continue;

double ma=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, per, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma > iLow(sym,per,b) && find==false) {
say=say+1;
} else {
//find=true;
}

}




if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT);
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) > ma ) {Print("MaDown: ",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"\nMADown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
           
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     }     

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT);
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) > ma ) {Print("MaDown: ",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"\nMADown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
           
     
     if ( Symbol() == sym //&& per == Period() 
     ) {
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MAL"+i);  
     }   

}







}




for ( int i=Barss;i>65;i--) {


if ( Bars < i ) continue;


double ma=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma < iHigh(sym,per,b) && find==false) {
say=say+1;
} else {
//find=true;
}

}






if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) < ma ) {Print("MBTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"\nMBTop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
            
          
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectDelete(ChartID(),"MBL"+i);
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrLightGray);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MBL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     }
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) < ma ) {Print("MbTop:",sym,":",kalan,"Time:",TFtoStr(per));
     cmt=cmt+"\nMBTop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }            
          
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrLightGray);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MBL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MBL"+i);
     }
          

}







}


//return 0;


for ( int i=Barss;i>25;i--) {


if ( Bars < i ) continue;

double ma=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, per, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma > iLow(sym,per,b) && find==false) {
say=say+1;
} else {
//find=true;
}

}




if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT);
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) > ma ) {Print("MBDown:",sym,":",kalan,"Time:",TFtoStr(per));   
          cmt=cmt+"\nMBDown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
     
     if ( Symbol() == sym //&& per == Period()
      ) {
     ObjectDelete(ChartID(),"MBL"+i);
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MBL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     }     

}



if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     int kalan=(MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT);
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= 500 && MarketInfo(sym,MODE_BID) > ma ) {Print("MBDown:",sym,":",kalan,"Time:",TFtoStr(per));
     cmt=cmt+"\nMBDown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
     }
          
     
     if ( Symbol() == sym //&& per == Period() 
     ) {
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetString(ChartID(),"MBL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MBL"+i);     
     }
}





}

}

//EngineClearVline();  