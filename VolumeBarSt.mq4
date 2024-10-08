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

int yakinlik=100;

double Ortalama;


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
   CreateSinyalButton();
   
   //Comment("MaSearch:",cmt);
   
   
   
   int bs=-1;

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      

   string buttonID="ButtonSinyal"+iwl; // Support LeveL Show
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");      
      
      string sym=pairswl[iwl];
      
      if ( StringFind(cmt,sym,0) != -1 ) {

   bs=bs+1;
   string buttonID="ButtonSinyal"+bs; // Support LeveL Show
   ObjectSetString(0,buttonID,OBJPROP_TEXT,sym);
         
      
      
      }
      
      
      }   
   
   
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

datetime refrest_time=Time[1];

void OnTick()
  {
//---

if ( Time[1] != refrest_time ) {
cmt="";
OnInit();
refrest_time=Time[1];
}

	int min, sec;
	
   min = Time[0] + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
   
   
   
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


if ( sparam == 45 ) {
cmt="";
OnInit();

}

if ( StringFind(sparam,"ButtonSinyal",0) != -1 ) {

string bs_sym=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);
Sleep(500);
ChartOpen(bs_sym,Period());
//Alert(bs_sym);
}

if ( ObjectType(sparam) == OBJ_TEXT ) {


string strs=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//Alert(strs);

int pers=StrtoTF(strs);

//ChartSetSymbolPeriod(ChartID(),Symbol(),pers);

ChartOpen(Symbol(),pers);


}


   
  }
//+------------------------------------------------------------------+



void MaEngine() {

bool multi_symbol=true;
/*
     int cevap=MessageBox("Single Symbol","Search",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) multi_symbol=false;

*/

string Comment_Line = "";

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      
      //if ( iwl > 5 ) continue;
      
      string sym=pairswl[iwl];
      ENUM_TIMEFRAMES per=Period();
      //Print(sym);
      bool bigbar=false;
      
      if ( multi_symbol == false ) {
      if ( sym != Symbol() ) continue;
      }
      
      cmt=cmt+"\n";
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  per=zaman[z];
  /*
  if ( per == PERIOD_M1 ) continue;
  //if ( per == PERIOD_M5 ) continue;
  if ( per == PERIOD_M15 ) continue;
  if ( per == PERIOD_M30 ) continue;
  if ( per == PERIOD_H1 ) continue;
  if ( per == PERIOD_H4 ) continue;
  if ( per == PERIOD_D1 ) continue;
  if ( per == PERIOD_MN1 ) continue;
  if ( per == PERIOD_W1 ) continue;*/
  
  if ( per != Period() ) continue;
  
  
  
  /*
  //if ( per == PERIOD_M1 ) continue;
  if ( per == PERIOD_M5 ) continue;
  if ( per == PERIOD_M15 ) continue;
  if ( per == PERIOD_M30 ) continue;
  if ( per == PERIOD_H1 ) continue;
  if ( per == PERIOD_H4 ) continue;
  if ( per == PERIOD_D1 ) continue;
  if ( per == PERIOD_MN1 ) continue;
  if ( per == PERIOD_W1 ) continue;
    */
  
  //Print(sym,"/",TFtoStr(per));
  
  //int ma_shift=50;

yakinlik=100;

//MaFind(sym,per,0);

  Ortalama=BarOrtalama(1,300,sym,per);
  
  if ( iClose(sym,per,2)-iOpen(sym,per,2) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+" "+Ortalama/MarketInfo(sym,MODE_POINT); 
  }

  if ( iOpen(sym,per,2)-iClose(sym,per,2) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+Ortalama/MarketInfo(sym,MODE_POINT); 
  }
  

  if ( iClose(sym,per,0)-iOpen(sym,per,0) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+" "+Ortalama/MarketInfo(sym,MODE_POINT); 
  }

  if ( iOpen(sym,per,0)-iClose(sym,per,0) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+Ortalama/MarketInfo(sym,MODE_POINT); 
  }
  

  if ( iClose(sym,per,1)-iOpen(sym,per,1) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+" "+Ortalama/MarketInfo(sym,MODE_POINT); 
  }

  if ( iOpen(sym,per,1)-iClose(sym,per,1) > Ortalama*3 ) {
  cmt=cmt+","+sym+TFtoStr(per)+Ortalama/MarketInfo(sym,MODE_POINT); 
  }
      
    
  

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
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) < ma ) {Print("MaTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"MATop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     
     ObjectDelete(ChartID(),"MALT"+i);
     ObjectCreate(ChartID(),"MALT"+i,OBJ_TEXT,0,Time[i],ma);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MALT"+i,OBJPROP_TEXT,TFtoStr(per));
          
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
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) < ma ) {Print("MaTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"MATop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) > ma ) {Print("MaDown: ",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"MADown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     
     ObjectDelete(ChartID(),"MALT"+i);
     ObjectCreate(ChartID(),"MALT"+i,OBJ_TEXT,0,Time[i],ma);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MALT"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MALT"+i,OBJPROP_TEXT,TFtoStr(per));
          
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
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) > ma ) {Print("MaDown: ",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"MADown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) < ma ) {Print("MBTop:",sym,":",kalan,"Time:",TFtoStr(per));
          cmt=cmt+"MBTop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     

     ObjectDelete(ChartID(),"MBLT"+i);
     ObjectCreate(ChartID(),"MBLT"+i,OBJ_TEXT,0,Time[i],ma);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MBLT"+i,OBJPROP_TEXT,TFtoStr(per));
     
          
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
     
     if ( (ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) < ma ) {Print("MbTop:",sym,":",kalan,"Time:",TFtoStr(per));
     cmt=cmt+"MBTop:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) > ma ) {Print("MBDown:",sym,":",kalan,"Time:",TFtoStr(per));   
          cmt=cmt+"MBDown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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


     ObjectDelete(ChartID(),"MBLT"+i);
     ObjectCreate(ChartID(),"MBLT"+i,OBJ_TEXT,0,Time[i],ma);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBLT"+i,OBJPROP_BACK,true);
     ObjectSetString(ChartID(),"MBLT"+i,OBJPROP_TEXT,TFtoStr(per));
          
     
     
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
     
     if ( (MarketInfo(sym,MODE_BID) - ma)/MarketInfo(sym,MODE_POINT) <= yakinlik && MarketInfo(sym,MODE_BID) > ma ) {Print("MBDown:",sym,":",kalan,"Time:",TFtoStr(per));
     cmt=cmt+"MBDown:"+sym+":"+kalan+"Time:"+TFtoStr(per);
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



void CreateSinyalButton() {

  int max_sinyal_number = 10;
  
  string buttonID="";
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bs=0;bs<=max_sinyal_number;bs++){
   
   buttonID="ButtonSinyal"+bs; // Support LeveL Show
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,60);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SINYAL");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_LOWER); 
   /*
   buttonID="ButtonSinyalTime"+bs;
   
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"TIME");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_LOWER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);*/
   
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


