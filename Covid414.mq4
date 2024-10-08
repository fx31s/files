//+------------------------------------------------------------------+
//|                                                     Target79.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

/*
#define INTERNET_SERVICE_FTP    1
#define INTERNET_SERVICE_GOPHER 2
#define INTERNET_SERVICE_HTTP   3

#define FTP_TRANSFER_TYPE_UNKNOWN   0x00000000
#define FTP_TRANSFER_TYPE_ASCII     0x00000001
#define FTP_TRANSFER_TYPE_BINARY    0x00000002


//Importing the proper API functions to Upload a file from the proper windows library wininet.dll
//Please see Microsoft reference wininet API functions at http://msdn.microsoft.com/en-us/library/aa385473(VS.85).aspx
#import "wininet.dll"
   //To open an "empty" Internet Object
   int InternetOpenW(string Agent, int AccessType, string ProxyName, string ProxyBypass, int Flags);
   //To create a working session (connection) with the Internet Object previously created
   int InternetConnectW(int hInternetSession, string ServerName, int ServerPort, string UserName, string Password, int Service, int Flags, int Context);
   //To, in this case, uploading a file
   bool FtpPutFileW(int hFtpSession, string LocalFile, string RemoteFile, int Flags, int Context);
   //To close the Internet Object and its connections
   bool InternetCloseHandle(int hInet);
#import*/



string headers;
char posts[],post[], result[];


bool lock=true; 
string last_object="";
bool otomatik = true;


int ObjTotal = ObjectsTotal(ChartID(),0,-1);


string last_select_object = "";

datetime refresh_time;
bool first_time=false;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
  if ( int(TimeYear(TimeCurrent())) > 2023 ) ExpertRemove();
  
  
//--- create timer
   //EventSetTimer(60);
   
   /*string Sinyal=Symbol()+"-"+TFtoStr(Period())+"-Covid-"+Time[1];
   string usym = Symbol();
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+Symbol()+"|interval="+Period();
   
   Telegram(Sinyal,SinyalS);*/
      
   
   refresh_time=Time[1];
   
   
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

if ( int(TimeYear(TimeCurrent())) >= 2023 ) ExpertRemove();

   
   if ( refresh_time != Time[1] ) {
   //Bar_Avarage=BarOrtalama();
   //if ( DistanceSystem == true ) Distance=(Bar_Avarage/Point)*2;
   first_time=false;
   Covid();
   refresh_time=Time[1]; // Her Yeni Barda 1 Kere Çalışacak   
   first_time=true;
   }
 
   if ( first_time == true ) CovidAlert();
   
   
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




int trendfind414=StringFind(sparam,"LEVEL414",0);

if ( trendfind414 != -1 ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_RAY_RIGHT) == false ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_RAY_RIGHT,true);
}else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_RAY_RIGHT,false);
}

}

//Comment(sparam);

if ( sparam == 20 ) {

string test="2022.04.03 04:15:00LOWLEVEL662022.04.03 09:45:00";

CovidPhoto(test);

}


int trendfindlow=StringFind(sparam,"LOWTREND",0);
int trendfindhigh=StringFind(sparam,"HIGHTREND",0);

if ( trendfindlow != -1 || trendfindhigh != -1 ) {




  string desen = sparam;
  int replaced=StringReplace(desen,"LOWTREND",",");
  replaced+=StringReplace(desen,"HIGHTREND",",");
  

   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(desen,u_sep,results);
   
   //Print("K:",k);
   
      if(k>0)
     {
     
     string tm1=results[0];
     string tm2=results[1];
     
     Print(tm1,"/",tm2,"/",ChartNext(ChartID()));
     
     //CovidCopyObject(tm1,tm2,ChartNext(ChartID()));
     CovidCopyObject(tm1,tm2,-1);
     
     
     
      /*for(int i=0;i<k;i++)
        {
         PrintFormat("result[%d]=%s",i,results[i]);
        }*/
     };
     
     


}



   if ( sparam == 45 ) Covid();
   

if ( sparam == 24 ) { //o

if ( otomatik == true ) { otomatik=false;lock=false;} else {otomatik=true;lock=true;}

Comment(sparam,"Otomatik:",otomatik);

}



 //ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || 
if ( lock == true &&  (ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) && StringFind(sparam,"LIQ",0) == -1 ) {

last_select_object=sparam;
last_object=sparam;


//last_object=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);

int shift1=iBarShift(Symbol(),Period(),obj_time1);
int shift2=iBarShift(Symbol(),Period(),obj_time2);
          

//ObjectMove(ChartID(),sparam,0,Time[shift1],High[shift1]);
//ObjectMove(ChartID(),sparam,1,Time[shift2],Low[shift1]);


if ( TimeYear(obj_time2) != Year()+1 ) {

  //string yenitarih= Year()+"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  string yenitarih= (TimeYear(obj_time2)+1)+"."+TimeMonth(obj_time2)+"."+TimeDay(obj_time2)+" "+TimeHour(obj_time2)+":"+TimeMinute(obj_time2);
  
  //datetime yenitarih = 
  //TimeNew;  
  
  datetime some_time = StringToTime(yenitarih);

ObjectSetInteger(ChartID(),last_select_object,OBJPROP_TIME,1,some_time);
ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTED,true);
} else {

if ( TimeYear(obj_time2) == Year()+1 ) {

  //string yenitarih= Year()+"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  string yenitarih= (TimeYear(obj_time2)-1)+"."+TimeMonth(obj_time2)+"."+TimeDay(obj_time2)+" "+TimeHour(obj_time2)+":"+TimeMinute(obj_time2);
  
  //datetime yenitarih = 
  //TimeNew;  
  
  datetime some_time = StringToTime(yenitarih);

ObjectSetInteger(ChartID(),last_select_object,OBJPROP_TIME,1,some_time);
ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTED,true);

}
}





}
          
          
             
   
  }
//+------------------------------------------------------------------+
void Covid() {

   double HLevel=-1;
   double LLevel=1000000;
   double HPrice=-1;
   double LPrice=1000000;
   int HShift;
   int HTop=0;
   int LShift;
   int LTop=0;
   int Limit=10;//9;
   int Distance=0;
   int PointLimitHL = 100; // Sinyal Tepe ve Dibin Limit arasında Pip mesafesi
   int BarLimit=10; // Tepe ve Dip arasını geçen barın aralığı bar sayısı
   int BarToplam=520;//120;
   
   int Limits=10;//10;


ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
ObjectsDeleteAll(ChartID(),-1,OBJ_TRIANGLE);


   int start_shift=0;
   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   start_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   }
   
   if ( start_shift == 0 ) start_shift=1;
   
   
   start_shift=start_shift+10;
   
   start_shift=Limits;
   
   
   ObjectDelete(ChartID(),"START");
   ObjectCreate(ChartID(),"START",OBJ_VLINE,0,Time[start_shift],0);
   
//Bars-50;//
   int finish_shift=990;
   
   
   ObjectDelete(ChartID(),"FINISH");
   ObjectCreate(ChartID(),"FINISH",OBJ_VLINE,0,Time[finish_shift],0);
   //Bars-50;
      //int BarStart=990;
      int BarStart=WindowFirstVisibleBar();
   
   
   string xxx="";
   
   if ( xxx!="yyy" ) {
   for(int b=BarStart;b>start_shift;b--) {
   
   /////////////////////////////////////////////////////////////////////////////////
   // LEFT   
   for(int t=b+1;t<b+Limit+1;t++) { 

   if ( High[b] > High[t] ) {
   HTop=HTop+1;
   } else {
   HTop=0;
   }
   
   }
   
   
   if ( HTop == Limit ) {
   
   //ObjectDelete(ChartID(),"HIGH"+Time[b]);
   //ObjectCreate(ChartID(),"HIGH"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[b-9],High[b]);
   //ObjectSetInteger(ChartID(),"HIGH"+Time[b],OBJPROP_RAY,false);
   
   }
   
   
   
   /////////////////////////////////////////////////////////////////////////////////
   // RIGHT
   /////////////////////////////////////////////////////////////////////////////////      
   for(int t=b-1;t>b-(Limit+1);t--) { 

   if ( High[b] > High[t] ) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }
   
   
   if ( HTop == Limit && LTop == Limit ) {
   
   /*ObjectDelete(ChartID(),Time[b]+"HIGH"+Time[b]);
   ObjectCreate(ChartID(),Time[b]+"HIGH"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[b-9],High[b]);
   ObjectSetInteger(ChartID(),Time[b]+"HIGH"+Time[b],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGH"+Time[b],OBJPROP_COLOR,clrWhite);
   ObjectSetString(ChartID(),Time[b]+"HIGH"+Time[b],OBJPROP_TOOLTIP,b);*/

   HTop=0;
   LTop=0;  
   
   bool LowFind=false;
   
   //////////////////////////////////////////////////////////////////////////////////////////////
   
   if ( b != 1250000 ) {
   
   
   
      //for(int bb=b;bb<finish_shift;bb++) {
      for(int bb=b;bb>start_shift;bb--) {
   
   
   
   /////////////////////////////////////////////////////////////////////////////////
   // LEFT   
   /*for(int t=bb+1;t<bb+Limits+1;t++) { 

   if ( Low[bb] < Low[t]) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }*/

   /////////////////////////////////////////////////////////////////////////////////
   // Right   
   for(int t=bb-1;t>bb-(Limits+1);t--) { 

   if ( Low[bb] < Low[t]) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }
   
   




//&& (High[b]-Low[bb])/Point > 700
   if ( LTop == Limits && LowFind == False ) {
   

   ObjectDelete(ChartID(),Time[b]+"HIGH"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGH"+Time[bb],OBJ_TREND,0,Time[b],High[b],Time[b-9],High[b]);
   ObjectSetInteger(ChartID(),Time[b]+"HIGH"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGH"+Time[bb],OBJPROP_COLOR,clrWhite);
   ObjectSetString(ChartID(),Time[b]+"HIGH"+Time[bb],OBJPROP_TOOLTIP,b);
      
   
   ObjectDelete(ChartID(),Time[b]+"HIGHLOW"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLOW"+Time[bb],OBJ_TREND,0,Time[bb],Low[bb],Time[bb-9],Low[bb]);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLOW"+Time[bb],OBJPROP_RAY,false);
   
   ObjectDelete(ChartID(),Time[b]+"HIGHTREND"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHTREND"+Time[bb],OBJ_TREND,0,Time[b],High[b],Time[bb],Low[bb]);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHTREND"+Time[bb],OBJPROP_RAY,false);
   ObjectSetString(ChartID(),Time[b]+"HIGHTREND"+Time[bb],OBJPROP_TOOLTIP,(High[b]-Low[bb])/Point);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHTREND"+Time[bb],OBJPROP_COLOR,clrChartreuse);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHTREND"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
   
   double Range = (High[b]-Low[bb])/Point;
   double Yuzde = Range/100;
   double Level70 = Low[bb]+(Yuzde*70)*Point;
   double Level79 = Low[bb]+(Yuzde*79)*Point;
   double Level66 = Low[bb]+(Yuzde*66)*Point;
   double Level414s = Low[bb]+(Yuzde*141.4)*Point;
   double Level414 = Low[bb]+(Yuzde*137)*Point;

   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb],OBJ_TREND,0,Time[b],Level414,Time[bb-9],Level414);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb],OBJPROP_SELECTABLE,true);   
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb],OBJPROP_COLOR,clrBlack); 
   
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb],OBJ_TREND,0,Time[b],Level414s,Time[bb-9],Level414s);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb],OBJPROP_SELECTABLE,true);   
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb],OBJPROP_COLOR,clrBlack);      
   
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJ_TREND,0,Time[b],Level66,Time[bb-9],Level66);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJPROP_SELECTABLE,true);   
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJPROP_COLOR,clrBlack);   
   
   
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb],OBJ_TREND,0,Time[b],Level70,Time[bb-9],Level70);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb],OBJPROP_SELECTABLE,false);      

   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb],OBJ_TREND,0,Time[b],Level79,Time[bb-9],Level79);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb],OBJPROP_RAY,false);      
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb],OBJPROP_SELECTABLE,true);      

   ObjectDelete(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb],OBJ_RECTANGLE,0,Time[b],Level70,Time[bb-9],Level79);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb],OBJPROP_RAY,true);



   bool covid_find=false;
   
   
   for (int i=bb;i>0;i--){
   
   if ( High[i] >= Level66 && covid_find == false ) {
   
   /*ObjectDelete(ChartID(),Time[b]+"HIGH"+Time[b]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLOW"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHTREND"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb]);*/

   /*ObjectDelete(ChartID(),"HIGHTIME"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIME"+Time[b],OBJ_TREND,0,Time[bb],Low[bb],Time[i],High[i]);
   ObjectSetInteger(ChartID(),"HIGHTIME"+Time[b],OBJPROP_RAY,false);   
   
   ObjectDelete(ChartID(),"HIGHTIMES"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIMES"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[i],High[i]);
   ObjectSetInteger(ChartID(),"HIGHTIMES"+Time[b],OBJPROP_RAY,false);  


   ObjectDelete(ChartID(),"HIGHTIMET"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIMET"+Time[b],OBJ_TRIANGLE,0,Time[b],High[b],Time[i],High[i],Time[bb],Low[bb]);
   ObjectSetInteger(ChartID(),"HIGHTIMET"+Time[b],OBJPROP_RAY,false);  
   ObjectSetInteger(ChartID(),"HIGHTIMET"+Time[b],OBJPROP_COLOR,clrDarkGray);
   */
   /*ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb],OBJPROP_COLOR,clrNavy);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJPROP_COLOR,clrNavy);  
   covid_find=true;*/
   
   }
   
   if ( High[i] >= Level414 && covid_find == false ) {
   
   /*ObjectDelete(ChartID(),Time[b]+"HIGH"+Time[b]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLOW"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHTREND"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL70"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL79"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb]);*/

   /*ObjectDelete(ChartID(),"HIGHTIME"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIME"+Time[b],OBJ_TREND,0,Time[bb],Low[bb],Time[i],High[i]);
   ObjectSetInteger(ChartID(),"HIGHTIME"+Time[b],OBJPROP_RAY,false);   
   
   ObjectDelete(ChartID(),"HIGHTIMES"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIMES"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[i],High[i]);
   ObjectSetInteger(ChartID(),"HIGHTIMES"+Time[b],OBJPROP_RAY,false);  


   ObjectDelete(ChartID(),"HIGHTIMET"+Time[b]);
   ObjectCreate(ChartID(),"HIGHTIMET"+Time[b],OBJ_TRIANGLE,0,Time[b],High[b],Time[i],High[i],Time[bb],Low[bb]);
   ObjectSetInteger(ChartID(),"HIGHTIMET"+Time[b],OBJPROP_RAY,false);  
   ObjectSetInteger(ChartID(),"HIGHTIMET"+Time[b],OBJPROP_COLOR,clrDarkGray);
   */
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVELREC"+Time[bb],OBJPROP_COLOR,clrNavy);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL66"+Time[bb],OBJPROP_COLOR,clrNavy);  
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414"+Time[bb],OBJPROP_COLOR,clrNavy);
   ObjectSetInteger(ChartID(),Time[b]+"HIGHLEVEL414s"+Time[bb],OBJPROP_COLOR,clrNavy);  
   covid_find=true;
   
   }
   
      
   
   
   
      
   }
   
   





      
   
   
   LowFind=true;
   
   }

   LTop=0;

   
   
   }
   
   
      
   
   
   
   
   
   
   
   }
   

   
   
   ///////////////////////////////////////////////////////////////////////////////////////////
   
   
   }
   
   
   
   /////////////////////////////////////////////////////////////////////////////////
   
   HTop=0;
   LTop=0;   
   
   
   
   
   
   
   //Print(b);
   
   
   }
   }
   
/////////////////////////////////////////////////////////////////////////////////////////////////
// LOW
////////////////////////////////////////////////////////////////////////////////////////////////      
   
   HTop=0;
   LTop=0;   
   //string xxx="";
      
   if ( xxx!="yyy" ) {
   for(int b=BarStart;b>start_shift;b--) {
   
   /////////////////////////////////////////////////////////////////////////////////
   // LEFT   
   for(int t=b+1;t<b+Limit+1;t++) { 

   if ( Low[b] < Low[t] ) {
   HTop=HTop+1;
   } else {
   HTop=0;
   }
   
   }
   
   
   if ( HTop == Limit ) {
   
   //ObjectDelete(ChartID(),"HIGH"+Time[b]);
   //ObjectCreate(ChartID(),"HIGH"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[b-9],High[b]);
   //ObjectSetInteger(ChartID(),"HIGH"+Time[b],OBJPROP_RAY,false);
   
   }
   
   
   
   /////////////////////////////////////////////////////////////////////////////////
   // RIGHT
   /////////////////////////////////////////////////////////////////////////////////      
   for(int t=b-1;t>b-(Limit+1);t--) { 

   if ( Low[b] < Low[t] ) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }
   
   
   if ( HTop == Limit && LTop == Limit ) {
   
   /*ObjectDelete(ChartID(),Time[b]+"LOW"+Time[b]);
   ObjectCreate(ChartID(),Time[b]+"LOW"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[b-9],Low[b]);
   ObjectSetInteger(ChartID(),Time[b]+"LOW"+Time[b],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOW"+Time[b],OBJPROP_COLOR,clrWhite);
   ObjectSetString(ChartID(),Time[b]+"LOW"+Time[b],OBJPROP_TOOLTIP,b);*/

   HTop=0;
   LTop=0;  
   
   bool LowFind=false;
   
   //////////////////////////////////////////////////////////////////////////////////////////////
   
   if ( b != 14599999 ) {
   
   
   
      //for(int bb=b;bb<finish_shift;bb++) {
      for(int bb=b;bb>start_shift;bb--) {
   
   
   
   /////////////////////////////////////////////////////////////////////////////////
   // LEFT   
   /*for(int t=bb+1;t<bb+Limits+1;t++) { 

   if ( Low[bb] < Low[t]) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }*/

   //Limits=15;
   

   

   /////////////////////////////////////////////////////////////////////////////////
   // Right  
   ///////////////////////////////////////////////////////////////////////////////// 
   for(int t=bb-1;t>bb-(Limits+1);t--) { 

   if ( High[bb] > High[t]) {
   LTop=LTop+1;
   } else {
   LTop=0;
   }
   
   }
   
   
//&& (High[b]-Low[bb])/Point > 700
   if ( LTop == Limits && LowFind == False  ) {
   

   ObjectDelete(ChartID(),Time[b]+"LOW"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOW"+Time[bb],OBJ_TREND,0,Time[b],Low[b],Time[b-9],Low[b]);
   ObjectSetInteger(ChartID(),Time[b]+"LOW"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOW"+Time[bb],OBJPROP_COLOR,clrWhite);
   ObjectSetString(ChartID(),Time[b]+"LOW"+Time[bb],OBJPROP_TOOLTIP,b);
      
   
   ObjectDelete(ChartID(),Time[b]+"LOWHIGH"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWHIGH"+Time[bb],OBJ_TREND,0,Time[bb],High[bb],Time[bb-9],High[bb]);
   ObjectSetInteger(ChartID(),Time[b]+"LOWHIGH"+Time[bb],OBJPROP_RAY,false);
   
   ObjectDelete(ChartID(),Time[b]+"LOWTREND"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWTREND"+Time[bb],OBJ_TREND,0,Time[b],Low[b],Time[bb],High[bb]);
   ObjectSetInteger(ChartID(),Time[b]+"LOWTREND"+Time[bb],OBJPROP_RAY,false);
   ObjectSetString(ChartID(),Time[b]+"LOWTREND"+Time[bb],OBJPROP_TOOLTIP,(High[bb]-Low[b])/Point);
   ObjectSetInteger(ChartID(),Time[b]+"LOWTREND"+Time[bb],OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),Time[b]+"LOWTREND"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
   
   /*ObjectDelete(ChartID(),"LOWTIME"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIME"+Time[b],OBJ_TREND,0,Time[bb],Low[bb],Time[bb],High[bb]);
   ObjectSetInteger(ChartID(),"LOWTIME"+Time[b],OBJPROP_RAY,true);*/  

   //ObjectDelete(ChartID(),"LOWTIME"+Time[b]);
   //ObjectCreate(ChartID(),"LOWTIME"+Time[b],OBJ_TREND,0,Time[bb],Low[b],Time[bb],High[bb]);
   //ObjectSetInteger(ChartID(),"LOWTIME"+Time[b],OBJPROP_RAY,true);
   
   
   double Range = (High[bb]-Low[b])/Point;
   double Yuzde = Range/100;
   double Level70 = Low[b]+(Yuzde*30)*Point;
   double Level79 = Low[b]+(Yuzde*21)*Point;
   double Level66 = Low[b]+(Yuzde*36)*Point;

   double Level414s = Low[b]-(Yuzde*41.4)*Point;
   double Level414 = Low[b]-(Yuzde*37)*Point;

   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb],OBJ_TREND,0,Time[b],Level414,Time[bb-9],Level414);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb],OBJPROP_SELECTABLE,true);   
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb],OBJPROP_COLOR,clrBlack); 

   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb],OBJ_TREND,0,Time[b],Level414s,Time[bb-9],Level414s);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb],OBJPROP_SELECTABLE,true);   
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb],OBJPROP_COLOR,clrBlack); 
         
   
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb],OBJ_TREND,0,Time[b],Level70,Time[bb-9],Level70);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb],OBJPROP_SELECTABLE,true);      
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb],OBJPROP_COLOR,clrBlack);      

   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb],OBJ_TREND,0,Time[b],Level79,Time[bb-9],Level79);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb],OBJPROP_RAY,false);      
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb],OBJPROP_SELECTABLE,true);      

   ObjectDelete(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb],OBJ_RECTANGLE,0,Time[b],Level70,Time[bb-9],Level79);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb],OBJPROP_COLOR,clrLightGray);
      
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb]);
   ObjectCreate(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJ_TREND,0,Time[b],Level66,Time[bb-9],Level66);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJPROP_SELECTABLE,true);       
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJPROP_COLOR,clrBlack);     
   
   
   
   bool covid_find=false;
   
   
   for (int i=bb;i>0;i--){
   

   if ( Low[i] <= Level414 && covid_find == false ) {
      /*
   ObjectDelete(ChartID(),Time[b]+"LOW"+Time[b]);
   ObjectDelete(ChartID(),Time[b]+"LOWHIGH"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWTREND"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb]);*/
   
   /*
   
   /*ObjectDelete(ChartID(),"LOWTIME"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIME"+Time[b],OBJ_TREND,0,Time[bb],High[bb],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"LOWTIME"+Time[b],OBJPROP_RAY,false);   

   ObjectDelete(ChartID(),"LOWTIMES"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIMES"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"LOWTIMES"+Time[b],OBJPROP_RAY,false);  

   ObjectDelete(ChartID(),"LOWTIMET"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIMET"+Time[b],OBJ_TRIANGLE,0,Time[b],Low[b],Time[i],Low[i],Time[bb],High[bb]);
   ObjectSetInteger(ChartID(),"LOWTIMET"+Time[b],OBJPROP_RAY,false);  
   */
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb],OBJPROP_COLOR,clrMaroon);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414"+Time[bb],OBJPROP_COLOR,clrMaroon); 
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL414s"+Time[bb],OBJPROP_COLOR,clrMaroon); 
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJPROP_COLOR,clrMaroon); 
   covid_find=true;
   
   }
   
      
   
   if ( Low[i] <= Level66 && covid_find == false ) {
      /*
   ObjectDelete(ChartID(),Time[b]+"LOW"+Time[b]);
   ObjectDelete(ChartID(),Time[b]+"LOWHIGH"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWTREND"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL70"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL79"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb]);
   ObjectDelete(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb]);*/
   
   /*
   
   /*ObjectDelete(ChartID(),"LOWTIME"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIME"+Time[b],OBJ_TREND,0,Time[bb],High[bb],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"LOWTIME"+Time[b],OBJPROP_RAY,false);   

   ObjectDelete(ChartID(),"LOWTIMES"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIMES"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"LOWTIMES"+Time[b],OBJPROP_RAY,false);  

   ObjectDelete(ChartID(),"LOWTIMET"+Time[b]);
   ObjectCreate(ChartID(),"LOWTIMET"+Time[b],OBJ_TRIANGLE,0,Time[b],Low[b],Time[i],Low[i],Time[bb],High[bb]);
   ObjectSetInteger(ChartID(),"LOWTIMET"+Time[b],OBJPROP_RAY,false);  
   */
   /*ObjectSetInteger(ChartID(),Time[b]+"LOWLEVELREC"+Time[bb],OBJPROP_COLOR,clrMaroon);
   ObjectSetInteger(ChartID(),Time[b]+"LOWLEVEL66"+Time[bb],OBJPROP_COLOR,clrMaroon); 
   covid_find=true;*/
   
   }
      
   }
   
      
   LowFind=true;
   
   }

   LTop=0;

   
   
   }
   
      
   
   }
     
   ///////////////////////////////////////////////////////////////////////////////////////////
   
   
   }
         
   /////////////////////////////////////////////////////////////////////////////////
   
   HTop=0;
   LTop=0;   
   

   
   //Print(b);
   
   
   }
   }
   
   
 }
 
 ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
 //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
 
 
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


void CovidAlert() {

//Print("AlertSistemi-Search");

//int objtotal = ObjectsTotal();

long oda_charid=ChartID();
int oda_window=-1;
int oda_type=-1;
     string oda_wilcard="LEVEL";
     string oda_wilcardl="LIMIT";
     
     //string oda_wilcardhl="HIGHLEVEL66";
     //string oda_wilcardll="LOWLEVEL66";     


     string oda_wilcardhl="HIGHLEVEL414";
     string oda_wilcardll="LOWLEVEL414"; 
     

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
     
        
string last_select_object=name;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          
          
if ( obj_typ == OBJ_TREND ) {          
          
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
                  
        

        
        
  //int index = StringFind(name,oda_wilcard, 0); 
  //int indexl = StringFind(name,oda_wilcardl, 0); 
  int indexhl = StringFind(name,oda_wilcardhl, 0); 
  int indexll = StringFind(name,oda_wilcardll, 0); 

  //if ( index != -1 && indexl == -1 ) {
  
  
  if ( indexhl != -1 ) {
  
  if ( obj_color == clrBlack ) {
  
  double HPrice = obj_prc1;
  int HShift = iBarShift(Symbol(),Period(),obj_time1);

   if ( //(
   Bid >= HPrice //|| ( Distance > 0 && (HPrice-Bid)/Point < Distance )) && ( BarLimit == 0 || HShift >= BarLimit )
      ) {
      
      
   string sym=Symbol();
   int symi=StringReplace(sym,"#","");
   string path = SymbolInfoString(sym,SYMBOL_PATH);
      
         if ( StringFind(path,"Crypto",0) != -1 ) sym=sym+"TPERP";
         
   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNavy);
   //ObjectSetString(ChartID(),"HLEVEL"+HShift,OBJPROP_TOOLTIP,"Mesafe Bar:"+HShift);   
   
   //if ( w == 0 && High[w] == Bid ) { // Canlı Olan Seviye  
   string Sinyal=Symbol()+"-"+TFtoStr(Period())+"-Covid414-Short-"+Time[HShift]+"-"+HPrice;
   string usym = Symbol();
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+Period();
   
   //"https://www.tradingview.com/chart/?symbol=FX:"EURUSD&interval=120
   //"https://www.tradingview.com/chart/?symbol=FX:"+ StringToUpper(Symbol())+"&interval="+Period()   
   
   Telegram(Sinyal,SinyalS);
   CovidPhoto(name);
   
   }
   
   
   
   }

 
  } 
  //}
  

  if ( indexll != -1 ) {
  
  if ( obj_color == clrBlack ) {
  
  double LPrice = obj_prc1;
  int LShift = iBarShift(Symbol(),Period(),obj_time1);  
  
  
   if ( //(
   Bid <= LPrice 
   //|| ( Distance > 0 && (Bid-LPrice)/Point < Distance )) && ( BarLimit == 0 || LShift >= BarLimit ) 
   
    ){
    
    
   string sym=Symbol();
   int symi=StringReplace(sym,"#","");
   string path = SymbolInfoString(sym,SYMBOL_PATH);
      
         if ( StringFind(path,"Crypto",0) != -1 ) sym=sym+"TPERP";    
    
   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrMaroon);
   //ObjectSetString(ChartID(),"LLEVEL"+LShift,OBJPROP_TOOLTIP,"Mesafe Bar:"+LShift);   

   //if ( w == 0 && Low[w] =< Bid ) {
   string Sinyal=Symbol()+"-"+TFtoStr(Period())+"-Covid414-Long-"+Time[LShift]+"-"+LPrice;
   string usym = Symbol();
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+Period();
   
   //"https://www.tradingview.com/chart/?symbol=FX:"EURUSD&interval=120
   //"https://www.tradingview.com/chart/?symbol=FX:"+ StringToUpper(Symbol())+"&interval="+Period()   
   
   Telegram(Sinyal,SinyalS);
   CovidPhoto(name);
   
   
   }
   
   
     
  
  
  
  
  }
  
  }
  
  
  //Print(name);
  
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
   }  
   
  }


}
 
 
double BarOrtalama() {

int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}
  
  


void CovidCopyObject(string first,string second,long ChartIDS) {




if ( ChartIDS == -1 ) ChartIDS  = ChartOpen(Symbol(),Period());

ChartSetInteger(ChartIDS,CHART_SCALE,0);





long oda_charid=ChartID();
int oda_window=-1;
int oda_type=-1;
  

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
     
        
string last_select_object=name;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          
          
if ( obj_typ == OBJ_TREND || obj_typ == OBJ_RECTANGLE ) {          
          
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          bool obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          int obj_style = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_STYLE);
          int obj_selectable = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE);

  int first_word = StringFind(name,first, 0); 
  int second_word = StringFind(name,second, 0); 
  int trend_word = StringFind(name,"TREND", 0); 

  if ( first_word != -1 && ( second_word != -1 || second == "" ) ) {
  
  ObjectDelete(ChartIDS,name);
  ObjectCreate(ChartIDS,name,obj_typ,0,obj_time1,obj_prc1,obj_time2,obj_prc2);
  ObjectSetInteger(ChartIDS,name,OBJPROP_COLOR,obj_color);
  ObjectSetInteger(ChartIDS,name,OBJPROP_BGCOLOR,obj_bgcolor);
  ObjectSetInteger(ChartIDS,name,OBJPROP_RAY,obj_ray);
  ObjectSetInteger(ChartIDS,name,OBJPROP_STYLE,obj_style);
  ObjectSetInteger(ChartIDS,name,OBJPROP_WIDTH,obj_width);
  ObjectSetInteger(ChartIDS,name,OBJPROP_BACK,obj_back);
  ObjectSetInteger(ChartIDS,name,OBJPROP_SELECTABLE,obj_selectable);
  Print(name);
  
  if ( trend_word == -1 ) {
  ObjectSetInteger(ChartIDS,name,OBJPROP_TIME,1,Time[0]);
  }
  
  
  
  
  
  

  }
  

   }  
   
  }
  
  ChartRedraw(ChartIDS);
  
//Sleep(3000);
/////////////////////////////////////////////////////////////
//price=NormalizeDouble(price,Digits); 
//string prices=DoubleToString(price,Digits);
//string image_files=Symbol()+"-Covid"+int(TimeMinute(TimeCurrent()));
string image_files=Symbol()+"-Covid"+IntegerToString(int(TimeMinute(TimeCurrent())));

           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 


   int height=ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   

  if(ChartScreenShot(ChartIDS,filename,width,height,ALIGN_CENTER)){
  //if(WindowScreenShot(ChartIDS,filename,1500,800,ALIGN_RIGHT)){
  //Alert("Take to Shoot");






/*
int hIntObj, hIntObjConn;
   string Password, ServerName, UserName, LocalFile, HostFile;
   bool Success;
  
   //Uploading the file
   hIntObj=InternetOpenW("MyInternetObjectName",1,NULL,NULL,NULL);//We create an object of type "Internet"
   if (hIntObj>0)
      {
         ServerName="92.205.8.201";//Your ftp server
         UserName="forex@forex.net.tr";//Your username you use when manually establish a ftp session
         Password="117733OzH*";//Your password you use when manually establish a ftp session
         hIntObjConn=InternetConnectW(hIntObj, ServerName, 0, UserName, Password, INTERNET_SERVICE_FTP, NULL, NULL);//We hang a FTP session on our internet object created.
         //The session could have been a HTTP session or even a HTTPS session.
         //See http://msdn.microsoft.com/en-us/library/aa385473(VS.85).aspx
         if (hIntObjConn>0)
            {
               LocalFile=filename;//"Hi.txt";//The physical address in your local machine where the file to be uploaded is. (I put this file in MQL4/Files folder)
               HostFile=filename;//"Hi.txt";//The name of the remote file uploaded
               Success=FtpPutFileW(hIntObjConn, LocalFile, HostFile, FTP_TRANSFER_TYPE_BINARY, NULL);
            }
      }
   InternetCloseHandle(hIntObj);
   
   if (Success==FALSE) {MessageBox("Uploading error. Check the name and root of your file to be uploaded and your username and password of your ftp server","http://www.forexmq4.blogspot.com",1);}
   else {
   MessageBox("Uploading sucessfull!!","http://www.forexmq4.blogspot.com",1);

  Sleep(500);
  
 
       string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   ///int resi = WebRequest("POST", "http://45.144.154.90/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   int resi = WebRequest("GET", "http://yorumlari.org/forex.net.tr/resim-sendphoto.php?resim="+filename+"&chat_ids="+chat_ids, "", NULL, 10000, post, ArraySize(post), result, headers);


   
   }
   */
   

 //Sleep(5000);
 

 //Alert(filename);


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
 
  ChartClose(ChartIDS);







////////////////////////////////////////////////////////////

}
   
  
     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };
  
  
//////////////////////////////////////////////////////////////////////////////////////////  
/// OBJE Adınının içindeki bilgileri alıyoruz.Sonra Objecleri Kopyalayıp Resmi Çekip Sinyali Gönderiyoruz.
/////////////////////////////////////////////////////////////////////////////////////////
void CovidPhoto(string sparams) {



int trendfindlow=StringFind(sparams,"LOWTREND",0);
int trendfindhigh=StringFind(sparams,"HIGHTREND",0);

int trendfindlow66=StringFind(sparams,"LOWLEVEL66",0);
int trendfindhigh66=StringFind(sparams,"HIGHLEVEL66",0);

int trendfindlow414=StringFind(sparams,"LOWLEVEL414",0);
int trendfindhigh414=StringFind(sparams,"HIGHLEVEL414",0);  


if ( trendfindlow != -1 || trendfindhigh != -1 || trendfindlow66 != -1 || trendfindhigh66 != -1 || trendfindlow414 != -1 || trendfindhigh414 != -1 ) {

//Comment(sparams);


  string desen = sparams;
  int replaced=StringReplace(desen,"LOWTREND",",");
  replaced+=StringReplace(desen,"HIGHTREND",",");
  replaced+=StringReplace(desen,"HIGHLEVEL66",",");
  replaced+=StringReplace(desen,"LOWLEVEL66",",");
  replaced+=StringReplace(desen,"HIGHLEVEL414",",");
  replaced+=StringReplace(desen,"LOWLEVEL414",",");  

   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(desen,u_sep,results);
   
   //Print("K:",k);
   
      if(k>0)
     {
     
     string tm1=results[0];
     string tm2=results[1];
     
     //Print(tm1,"/",tm2,"/",ChartNext(ChartID()));
     
     //CovidCopyObject(tm1,tm2,ChartNext(ChartID()));
     CovidCopyObject(tm1,tm2,-1);
     
     
     
      /*for(int i=0;i<k;i++)
        {
         PrintFormat("result[%d]=%s",i,results[i]);
        }*/
     };
     
     


}


}  
  ////////////////////////////////////////////////////////////////////////////////////////////// The Fin
  
  
