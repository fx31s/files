//+------------------------------------------------------------------+
//|                                                    PriceKing.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
  ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrRed);
  
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
          
  
//--- create timer
   //EventSetTimer(60);
   
   /*
   string sym=Symbol();
   int digits=MarketInfo(sym,MODE_DIGITS);
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int str_len=StringLen(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 5 ) {
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }*/
   
   /*
   string sym=Symbol();
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 2 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }*/
   
    string buttonID="ButtonBuySinyal";
 
   for ( int t=1;t<11;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,330);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
   

 for ( int t=11;t<21;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,490);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-10));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
 for ( int t=21;t<31;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,650);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-20));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
   

 for ( int t=31;t<41;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,810);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-30));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,16);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
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
void OnTick()
  {
//---
   
   //return;
   
   if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) != 1 ) return;
   
   

       int t=0;
       string pairswl[];
       string sym="";
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
     sym=pairswl[iwl];
      
      Print(sym);
      
   int digits=MarketInfo(sym,MODE_DIGITS);
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int str_len=StringLen(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 5 ) {
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 0 ) {
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
   
   t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
      
   
   
   }
   }
   
   
   if ( StringFind(sym,"XAUUSD",0) != -1 ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 2 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
   
 if ( StringFind(sym,"DE5540",0) != -1 ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   
  
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
 if ( StringFind(sym,"BRENT",0) != -1 || StringFind(sym,"USTECH",0) != -1 || StringFind(sym,"DE40",0) != -1 || StringFind(sym,"US30",0) != -1  || StringFind(sym,"US500",0) != -1 || StringFind(sym,"XAG",0) != -1  ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   if ( StringFind(sym,"BRENT",0) != -1 ) prices=prices+0; // Brenth
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   
   string results="";
   if ( digits >= 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   results=StringSubstr(prices,str_len-3,3);
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
   
   
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   //Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
   
   
  if ( StringFind(SymbolInfoString(sym,SYMBOL_PATH),"Crypto",0) != -1 )   {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   if ( StringFind(sym,"BRENT",0) != -1 ) prices=prices+0; // Brenth
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   
   string results="";
   if ( digits >= 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   results=StringSubstr(prices,str_len-3,3);
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
   
      
   
   
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   //Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
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


if ( StringFind(sparam,"ButtonSymbolSinyal",0) != -1 ) {

string obj_tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);

//Alert(obj_tooltip);

ChartOpen(obj_tooltip,Period());

Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);


}


   
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
  
  
  