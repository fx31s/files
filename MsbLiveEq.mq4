//+------------------------------------------------------------------+
//|                                                          Msb.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string headers;
char posts[],post[], result[];

string sinyal_list="";


bool first_work=false;
datetime work_time;
string msb_sinyal_list="";
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   /*
    for (int ll=10;ll>1;ll--){ 
    Print(ll);
    }*/
    

   
   
   
   
   
   
   
   
   
   
   
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

if ( work_time != Time[1] ) {
work_time=Time[1];
MsbEngine();
first_work=true;
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


void MsbEngine() {


   ObjectsDeleteAll();
   
   int left_limit=50;
   
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   double high_price;
   double low_price;
   
   for (int i=1550;i>0;i--) {
   
   
   high_price=iHigh(sym,per,i);
   low_price=iLow(sym,per,i);
   
   bool left_up=true;
   bool right_up=true;

   bool left_down=true;
   bool right_down=true;   
   
   for (int l=i+1;l<i+left_limit;l++){   
   double highs_price=iHigh(sym,per,l);   
   if ( high_price < highs_price ) left_up=false;   
   
   double lows_price=iLow(sym,per,l);   
   if ( low_price > lows_price ) left_down=false;   
      
   
   }   
   
   if ( left_up == true ) {
   /*ObjectCreate(ChartID(),"UP"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_RAY,false);*/

   }

   if ( left_down == true ) {
   /*ObjectCreate(ChartID(),"DOWN"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_RAY,false);*/

   }
      
   
   for (int l=i-1;l>i-left_limit;l--){ 
   
     
   double highs_price=iHigh(sym,per,l);   
   if ( high_price < highs_price ) right_up=false;   
   
   double lows_price=iLow(sym,per,l);   
   if ( low_price > lows_price ) right_down=false;   
      
   
   }   
   
   if ( right_up == true ) {
   /*ObjectCreate(ChartID(),"UPR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_COLOR,clrBlue);*/

   }

   if ( right_down == true ) {
   /*ObjectCreate(ChartID(),"UPR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPR"+Time[i],OBJPROP_COLOR,clrBlue);*/

   }
   
      

   if ( left_up == true && right_up == true ) {
   
    ///////////////////////////////////
   bool work=false;
   for (int w=i-1;w>1;w--){ 
   if ( work == true ) continue;
   if ( iClose(sym,per,w) >= high_price ) {
   work=true;
   }
   
   }
   ////////////////////////////
   if ( work == true ) continue;
      
   
   ObjectCreate(ChartID(),"UPLR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+100*PeriodSeconds(),high_price);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_WIDTH,4);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"UPLR"+Time[i],OBJPROP_COLOR,clrLightGray);
   
   low_price=iLow(sym,per,i);
   
   double msb_low_price=low_price;
   bool find=false;
   
   for (int l=i+1;l<i+left_limit;l++) {
   
   double lows_price=iLow(sym,per,l);
   double lown_price=iLow(sym,per,l+1);
   double closen_price=iClose(sym,per,l+1);
   
   if ( lows_price < low_price && lown_price > lows_price && closen_price > lows_price && find == false ) {
   msb_low_price=lows_price;
   find=true;
   
   ObjectCreate(ChartID(),"DOWN"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_low_price,iTime(sym,per,l)+100*PeriodSeconds(),msb_low_price);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),"DOWN"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   

   ObjectCreate(ChartID(),"EQ"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_low_price+((high_price-msb_low_price)/2),iTime(sym,per,l)+100*PeriodSeconds(),msb_low_price+((high_price-msb_low_price)/2));
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   
   double yuzde=DivZero(high_price-msb_low_price,100);
   double level40=msb_low_price+yuzde*40;
   

   for (int ll=i-1;ll>0;ll--){ 
   
   double lowf_price=iLow(sym,per,ll-1);
   
   bool find=false;
   if ( msb_low_price > lowf_price && find == false ) {   
   find=true;
   
   ObjectCreate(ChartID(),"PR"+Time[i],OBJ_TREND,0,iTime(sym,per,ll),msb_low_price,iTime(sym,per,ll),high_price);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_WIDTH,1);
   
   
   ///////////////////////////////////
   bool eq_work=false;
   for (int w=ll-1;w>1;w--){ 
   if ( eq_work == true ) continue;
   if ( iClose(sym,per,w) >= level40 ) {
   //ObjectDelete(ChartID(),"UPLR"+Time[i]);
   //ObjectDelete(ChartID(),"DOWN"+Time[i]);
   //ObjectDelete(ChartID(),"EQ"+Time[i]);   
   //ObjectDelete(ChartID(),"PR"+Time[i]);
   //eq_work=true;

   


   if ( first_work == false ) msb_sinyal_list=msb_sinyal_list+"PR"+Time[i];
   
   if ( StringFind(msb_sinyal_list,"PR"+Time[i],0) == -1 ) {
   msb_sinyal_list=msb_sinyal_list+"PR"+Time[i];
   
bool sinyal_telegram=true;

datetime time_date=Time[i];

if ( sinyal_telegram == true ) {

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();
long ChartIDS=ChartID();

Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-MsbEq-Sell";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+time_date;
   
string fname="Abcd";
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
        
   
   }
   
   ////////////////////////////////////////////////////////
   }
   
   }
   ////////////////////////////      
   
   ///////////////////////////////////
   bool work=false;
   for (int w=ll-1;w>1;w--){ 
   if ( work == true ) continue;
   if ( iClose(sym,per,w) >= high_price ) {
   ObjectDelete(ChartID(),"UPLR"+Time[i]);
   ObjectDelete(ChartID(),"DOWN"+Time[i]);
   ObjectDelete(ChartID(),"EQ"+Time[i]);   
   ObjectDelete(ChartID(),"PR"+Time[i]);
   work=true;
   }
   
   }
   ////////////////////////////
   
   
   
   
   
   }
      
   
   } 

   
      
   }

   
   }
 
   
   
   

   }      
   

   if ( left_down == true && right_down == true ) {
   
    ///////////////////////////////////
   bool work=false;
   for (int w=i-1;w>1;w--){ 
   if ( work == true ) continue;
   if ( iClose(sym,per,w) <= low_price ) {
   work=true;
   }
   
   }
   ////////////////////////////
   if ( work == true ) continue;
      
   
   ObjectCreate(ChartID(),"DOWNLR"+Time[i],OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+100*PeriodSeconds(),low_price);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_WIDTH,4);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"DOWNLR"+Time[i],OBJPROP_COLOR,clrLightBlue);
   
   
   high_price=iHigh(sym,per,i);
   
   double msb_high_price=high_price;
   bool find=false;
   
   for (int l=i+1;l<i+left_limit;l++) {
   
   double highs_price=iHigh(sym,per,l);
   double highn_price=iHigh(sym,per,l+1);
   double closen_price=iClose(sym,per,l+1);
   
   if ( highs_price > high_price && highn_price < highs_price && closen_price < highs_price && find == false ) {
   msb_high_price=highs_price;
   find=true;
   
   ObjectCreate(ChartID(),"UP"+Time[i],OBJ_TREND,0,iTime(sym,per,l),msb_high_price,iTime(sym,per,l)+100*PeriodSeconds(),msb_high_price);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_COLOR,clrLightBlue);
   ObjectSetInteger(ChartID(),"UP"+Time[i],OBJPROP_STYLE,STYLE_DOT);

   ObjectCreate(ChartID(),"EQ"+Time[i],OBJ_TREND,0,iTime(sym,per,l),low_price+((msb_high_price-low_price)/2),iTime(sym,per,l)+100*PeriodSeconds(),low_price+((msb_high_price-low_price)/2));
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"EQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   
   double yuzde=DivZero(msb_high_price-low_price,100);
   double level40=low_price+yuzde*40;

   for (int ll=i-1;ll>0;ll--){ 
   
   double highf_price=iHigh(sym,per,ll-1);
   
   bool find=false;
   if ( msb_high_price < highf_price && find == false ) {   
   find=true;
   
   ObjectCreate(ChartID(),"PR"+Time[i],OBJ_TREND,0,iTime(sym,per,ll),msb_high_price,iTime(sym,per,ll),low_price);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_STYLE,STYLE_DOT);
   //ObjectSetInteger(ChartID(),"PR"+Time[i],OBJPROP_WIDTH,3);
   
   
   
   ///////////////////////////////////
   bool eq_work=false;
   for (int w=ll-1;w>1;w--){ 
   if ( eq_work == true ) continue;
   if ( iClose(sym,per,w) <= level40 ) {
   //ObjectDelete(ChartID(),"UPLR"+Time[i]);
   //ObjectDelete(ChartID(),"DOWN"+Time[i]);
   //ObjectDelete(ChartID(),"EQ"+Time[i]);   
   //ObjectDelete(ChartID(),"PR"+Time[i]);
   //eq_work=true;   
   
   
   
   if ( first_work == false ) msb_sinyal_list=msb_sinyal_list+"PR"+Time[i];
   
   if ( StringFind(msb_sinyal_list,"PR"+Time[i],0) == -1 ) {
   msb_sinyal_list=msb_sinyal_list+"PR"+Time[i];
   
bool sinyal_telegram=true;

datetime time_date=Time[i];

if ( sinyal_telegram == true ) {

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();
long ChartIDS=ChartID();

Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-MsbEq-Buy";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+time_date;
   
string fname="Abcd";
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
     
        
   
   }


   ////////////////////////////////////////////////////////
   }
   
   }
   ////////////////////////////    
   
    ///////////////////////////////////
   bool work=false;
   for (int w=ll-1;w>1;w--){ 
   if ( work == true ) continue;
   if ( iClose(sym,per,w) <= low_price ) {
   ObjectDelete(ChartID(),"DOWNLR"+Time[i]);
   ObjectDelete(ChartID(),"UP"+Time[i]);
   ObjectDelete(ChartID(),"EQ"+Time[i]);   
   ObjectDelete(ChartID(),"PR"+Time[i]);
   work=true;
   }
   
   }
   ////////////////////////////
   
   
   
   }
      
   
   } 

   
   
   
   }


   }

   }     
   
   
   //Print(i);
   
   
   
   
   
   }
   
   
   

}




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
    



void TelegramOld(string Sinyal,string Sinyals) {



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

         //url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal+" "+Sinyals;
         url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal;
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

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
