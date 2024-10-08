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

long ChartIDS;
datetime time_date;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
/*
rsi_high=65;
rsi_low=30;*/
  
  ChartIDS=ChartOpen(Symbol(),Period());
 
 
   
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
     
     /*
   string Sinyal=sym+"-"+TFtoStr(PERIOD_H1)+"-RSI-HIGH-"+Time[1];
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "Pump Level"+Time[1];//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS); */ 
   
   time_date=Time[1];
   
ObjectsDeleteAll(ChartIDS,-1,-1);
ChartSetSymbolPeriod(ChartIDS,sym,PERIOD_H1);
PeriodInfo(sym,ChartIDS,per);

datetime time1=iTime(sym,per,1);
datetime time2=iTime(sym,per,2);
datetime time4=iTime(sym,per,4);
time_date=time1;

     ObjectCreate(ChartIDS,"S"+time1,OBJ_TREND,0,time1,iClose(sym,per,1),time1+10*PeriodSeconds(per),iClose(sym,per,1));
     ObjectSetInteger(ChartIDS,"S"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"S"+time1,OBJPROP_COLOR,clrLimeGreen);

     ObjectCreate(ChartIDS,"SH"+time1,OBJ_TREND,0,time2,iHigh(sym,per,2),time1+10*PeriodSeconds(per),iHigh(sym,per,2));
     ObjectSetInteger(ChartIDS,"SH"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"SH"+time1,OBJPROP_COLOR,clrBlue);
     
     ObjectCreate(ChartIDS,"SL"+time1,OBJ_TREND,0,time4,iLow(sym,per,4),time4+10*PeriodSeconds(per),iLow(sym,per,4));
     ObjectSetInteger(ChartIDS,"SL"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"SL"+time1,OBJPROP_COLOR,clrBlue);
     
     

Sleep(100);    
 
   string Sinyal=sym+"-"+TFtoStr(per)+"-Supdem-Reserval-Long";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   SinyalS=sym+per+"SRL"+time_date;
   
string fname="Supdem";
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 
  

bool sinyal_sonuc=Telegram(Sinyal,SinyalS,filename,per,sym);
if ( sinyal_sonuc ) TelegramPhoto("Supdem",per,ChartIDS,sym);

   
   
     
 
     
     }
     
     
if ( iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= dist
     (iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= dist
     
     ) {
     
     
     time_date=Time[1];

ObjectsDeleteAll(ChartIDS,-1,-1);     
ChartSetSymbolPeriod(ChartIDS,sym,PERIOD_H1);
PeriodInfo(sym,ChartIDS,per);

datetime time1=iTime(sym,per,1);
datetime time2=iTime(sym,per,2);
datetime time4=iTime(sym,per,4);
time_date=time1;

     ObjectCreate(ChartIDS,"S"+time1,OBJ_TREND,0,time1,iClose(sym,per,1),time1+10*PeriodSeconds(per),iClose(sym,per,1));
     ObjectSetInteger(ChartIDS,"S"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"S"+time1,OBJPROP_COLOR,clrLimeGreen);

     ObjectCreate(ChartIDS,"SL"+time1,OBJ_TREND,0,time2,iLow(sym,per,2),time2+10*PeriodSeconds(per),iLow(sym,per,2));
     ObjectSetInteger(ChartIDS,"SL"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"SL"+time1,OBJPROP_COLOR,clrBlue);

     ObjectCreate(ChartIDS,"SH"+time1,OBJ_TREND,0,time4,iHigh(sym,per,4),time4+10*PeriodSeconds(per),iHigh(sym,per,4));
     ObjectSetInteger(ChartIDS,"SH"+time1,OBJPROP_RAY,False);
     ObjectSetInteger(ChartIDS,"SH"+time1,OBJPROP_COLOR,clrBlue);
          


Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-Supdem-Reserval-Short";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+time_date;
   
string fname="Supdem";
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif";    
   

bool sinyal_sonuc=Telegram(Sinyal,SinyalS,filename,per,sym);
if ( sinyal_sonuc ) TelegramPhoto("Supdem",per,ChartIDS,sym);



     /*
   string Sinyal=sym+"-"+TFtoStr(PERIOD_H1)+"-RSI-HIGH-"+Time[1];
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "Pump Level"+Time[1];//"https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);*/
   
   
   
   
     
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
string headers;
char posts[],post[], result[];




bool Telegram(string Sinyal,string Sinyals,string object_name,int per,string sym) {

bool sonuc=false;

if ( StringFind(sinyal_list,Sinyals,0) == -1 ) {
sinyal_list=sinyal_list+","+Sinyals;
sonuc=true;
} else {
sonuc=false;
return sonuc;
}


Sinyal = Sinyal;//+" http://85.215.201.11/"+object_name;

//string resim="http://85.215.201.11/"+object_name;

//Sinyal = "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+per;


/*
if ( desktop_alert == true ) {
Alert(Sinyal);
return; 
}*/

//if ( desktop_alert == false ) {
   //string Sinyal=Symbol()+" Robot Başladı";
   string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;

         url="http://www.yorumlari.org/telegram.php?img="+object_name+"&sym="+sym+"&per="+per+"&sinyal="+Sinyal+"&xxx=yyy";//+" "+Sinyals;
         //url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal;//+" "+Sinyals;

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
   
   
   
   
      //CovidCopyObject(object_name,"",-1);
   
   //}
   
   
return sonuc; 

}
  
  


void TelegramPhoto(string fname,int per,long cid,string sym) {

  
//Sleep(3000);
/////////////////////////////////////////////////////////////
//price=NormalizeDouble(price,Digits); 
//string prices=DoubleToString(price,Digits);
//string image_files=Symbol()+"-Covid"+int(TimeMinute(TimeCurrent()));
//string image_files=Symbol()+"-fname-"+IntegerToString(int(TimeMinute(TimeCurrent())));
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 


   int height=ChartGetInteger(cid,CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(cid,CHART_WIDTH_IN_PIXELS,0);
   
   height=600;
   width=800;
   
   
  //if(ChartScreenShot(cid,filename,width,height,ALIGN_CENTER)){
  if(ChartScreenShot(cid,filename,width,height,ALIGN_RIGHT)){
  //if(WindowScreenShot(ChartIDS,filename,1500,800,ALIGN_RIGHT)){
  //Alert("Take to Shoot");


 if (!SendFTP(filename,NULL)) {
 Print("ScreenShot2webspace EA: Send2Ftp - Error "+GetLastError());
 } else {
 
 
  Sleep(500);
  
 
       string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   ///int resi = WebRequest("POST", "http://45.144.154.90/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   int resi = WebRequest("GET", "http://yorumlari.org/forex.net.tr/resim-sendphoto.php?resim="+filename+"&chat_ids="+chat_ids, "", NULL, 10000, post, ArraySize(post), result, headers);


 //Alert("Analiz Resmi Gönderildi");
 //ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);
 }
 
 
 
 
 }
 
  
////////////////////////////////////////////////////////////

}
   
  
     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };
    
    


void PeriodInfo(string sym,long ChartIDS,ENUM_TIMEFRAMES per) {

        string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
        //if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=sym+" "+TFtoStr(per);    
     
     ObjectCreate(ChartIDS,LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartIDS,LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartIDS,LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_COLOR, clrDarkRed);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_YDISTANCE, 30);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartIDS,LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartIDS,LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartIDS,LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_XDISTANCE, 33);
     ObjectSetInteger(ChartIDS,LabelChart, OBJPROP_YDISTANCE, 30); 
     
     
}      
