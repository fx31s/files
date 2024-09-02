#property strict
#property version   "1.00"
#include "WebRequests.mqh";

//string embed_1_link="https://sslecal2.forexprostools.com?columns=exc_flags,exc_currency,exc_importance,exc_actual,exc_forecast,exc_previous&category=_employment,_economicActivity,_inflation,_credit,_centralBanks,_confidenceIndex,_balance,_Bonds&importance=1,2,3&countries=25,6,72,22,17,10,35,43,26,12,4,5&calType=day&timeZone=55&lang=1";
//string embed_1_link="https://sslecal2.forexprostools.com?columns=exc_currency,exc_importance&importance=2,3&countries=72,17&calType=day&timeZone=17&lang=1";
//string embed_1_link="https://sslecal2.forexprostools.com?columns=exc_currency,exc_importance&importance=1,2,3&calType=day&timeZone=17&lang=1&countries=17,72&importance=3,2";
//string embed_1_link="https://sslecal2.forexprostools.com/?columns=exc_currency,exc_importance&importance=2,3&calType=day&timeZone=17&lang=1&countries=17,72&importance=3,2";
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
web_request WR;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

/*
for ( int s=0;s<=0;s++) {

string saat=s;
if ( s<10) saat="0"+s;


for ( int d=0;d<=59;d++) {
string dakika="";
dakika=d;
if ( d<10) dakika="0"+d;

string zaman = saat+":"+dakika;
Print(zaman);
}
}*/


//string deneme="evtStrtTime=\"10:30\"";
//Alert(deneme);


  if(!EventSetTimer(30)){return(INIT_FAILED);}
  return(INIT_SUCCEEDED);
  }

void OnTimer(){
EventKillTimer();
SetupWR();




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
   
  }
  

string Mozilla="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101 Firefox/80.0";
void SetupWR()
{

//https://sslecal2.forexprostools.com/?columns=exc_currency,exc_importance,exc_flags&calType=day&timeZone=17&lang=1&countries=17,72&importance=3
//https://sslecal2.forexprostools.com/?columns=exc_currency,exc_importance,exc_flags&importance=1,2,3&calType=day&timeZone=17&lang=1&countries=17,72&importance=3,2
WR.SetupWithBasicHeaders(wr_type_get,"https://sslecal2.forexprostools.com",5000);
WR.SetReferer("https://www.investing.com");
WR.SetUserAgent(Mozilla);
WR.Parameters+"columns"="exc_currency,exc_importance,exc_flags";
//WR.Parameters+"category"="_employment,_economicActivity,_inflation,_credit,_centralBanks,_confidenceIndex,_balance,_Bonds";
WR.Parameters+"importance"="3";
//WR.Parameters+"importance"="1,2,3";
WR.Parameters+"countries"="17,72,5"; // usd 5 almanya 17 eur 72
WR.Parameters+"calType"="day";
WR.Parameters+"timeZone"="17";
WR.Parameters+"lang"="1";
  simple_result result=WR.Send();
  Print("Errors : "+result.error);
  //Alert("response headers : \n"+result.response_headers+"\nresponse body : \n"+result.response_body);
  /*int f=FileOpen("site.html",FILE_WRITE|FILE_TXT);
  FileWriteString(f,result.response_body);
  FileClose(f);*/
  
  string veri=result.response_body;

for ( int s=0;s<=23;s++) {

string saat=s;
if ( s<10) saat="0"+s;


for ( int d=0;d<=59;d++) {
string dakika="";
dakika=d;
if ( d<10) dakika="0"+d;

string zaman = saat+":"+dakika;


//evtStrtTime="10:30"

//if ( StringFind(veri,">"+zaman+"<",0) != -1 ) {
if ( StringFind(veri,"evtStrtTime=\""+zaman+"\"",0) != -1 ) {



  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+zaman;
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime stop_time = some_time-PeriodSeconds(PERIOD_M30);
  datetime start_time = some_time+PeriodSeconds(PERIOD_M30);
  
  Print("Zaman:",zaman,"/",some_time,"/",stop_time,"/",start_time);
  
  //"Zaman Genişletme"


}



}
}

  
  
   
}

/*
fed konuşması açıklama toplandı
amerika üfe tüfe
alman üfe tüfe

1 saat öncesinden durması
30dk veya 1 saat sonra duracak.
*/