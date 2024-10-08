//+------------------------------------------------------------------+
//|                                                RsiMultiAlert.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double rsi_high=78;
double rsi_low=22;

datetime refresh_time;
/*
string headers;
char posts[],post[], result[];
*/


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
/*
rsi_high=65;
rsi_low=30;*/
  
  
 
 
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


   if ( refresh_time != Time[1] ) {
   //Bar_Avarage=BarOrtalama();
   //if ( DistanceSystem == true ) Distance=(Bar_Avarage/Point)*2;
   //first_time=false;
   //MumAnaliz();
   refresh_time=Time[1]; // Her Yeni Barda 1 Kere Çalışacak   
   //first_time=true;
   RsiSearch();
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
   


if ( sparam == 45 ) {

RsiSearch();

}
 
      
   
   
  }
//+------------------------------------------------------------------+
int dist=250;
ENUM_TIMEFRAMES per=PERIOD_H1;
void RsiSearch() {

string pairs[];
      ///int length = getAvailableCurrencyPairss(pairs);
      int length = market_watch_list(pairs);
      
      //Print("length:",length);
      
      for(int i=0; i <= length-1; i++)
      {

 string sym = pairs[i];
 
 double market_mode = MarketInfo(sym,MODE_PROFITCALCMODE);
 
   dist=250;
  if ( StringFind(sym,"BTC",0) != -1 ) dist=25000;
  if ( StringFind(sym,"ETH",0) != -1 ) dist=2500;
  if ( StringFind(sym,"XAU",0) != -1 ) dist=500;
  
 


if ( iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/MarketInfo(sym,MODE_POINT) >= dist 
     (iClose(sym,per,1)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT) >= dist 
     
     ) {
     
   string Sinyal=sym+"-"+TFtoStr(PERIOD_H1)+"-RSI-HIGH-"+Time[1];
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "Pump Level"+Time[1];//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);    
 
     
     }
     
     
if ( iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= dist
     (iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= dist
     
     ) {

     
   string Sinyal=sym+"-"+TFtoStr(PERIOD_H1)+"-RSI-HIGH-"+Time[1];
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "Pump Level"+Time[1];//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);
     
     }
     
     
     
     
 /*
 if ( market_mode == 0 && StringFind(sym,"JPY",0) == -1 && StringFind(sym,"CHF",0) == -1  ) {
 
 }
 */
 
 
 }
 
 
 
}


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


//////////////////////////////////////////////////////////////////////
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
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader


string sinyal_list="";


void Telegram(string Sinyal,string Sinyals) {


if ( StringFind(sinyal_list,Sinyal,0) == -1 ) {
sinyal_list=sinyal_list+","+Sinyal;
} else {
return;
}


   //string Sinyal=Symbol()+" Robot Başladı";
   string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;

         url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal+" "+Sinyals;

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
   
//TelegramPhoto();


}


     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };
  