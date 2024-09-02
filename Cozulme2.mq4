//+------------------------------------------------------------------+
//|                                                     Cozulme2.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool low_mode=true;
bool high_mode=true;

int start_time=-1;
bool alert=false;
string sinyal="";

extern bool step_two=true;

bool discord=false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
  
     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };
  
string FormatNumber(double x, int width, int precision)
{
   string p = DoubleToStr(x, precision);
   
   while(StringLen(p) < width) p = " "+p;
   
   return(p);
}
  
  
  
void Discord(string sinyal_tip) {

return;

//string sinyal_tip="BUY";
string sinyal_per=TFtoStr(Period());
//double sinyal_price=DoubleToString(Close[0],Digits);
double sinyal_price=FormatNumber(Close[0],0, Digits);
string sinyal_sym=Symbol();
string sinyal_time=IntegerToString(int(Time[1]));


//string image_files=Symbol()+"-Covid"+IntegerToString(int(TimeMinute(TimeCurrent())));
string image_files=sinyal_sym+sinyal_time+sinyal_per;

           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".png";
        

  //string filename = image_files;//pair+"-line.gif"; 
  //string filename =  toLower(image_files);//pair+"-line.gif"; 
    string filename =  image_files;//pair+"-line.gif"; 
    
    //FileDelete(filename);

    //Sleep(100);

   int height=ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   

  if(ChartScreenShot(ChartID(),filename,width,height,ALIGN_CENTER)){
  
 

   //string Sinyal=Symbol()+" Robot Başladı";
   //string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;


    string sym_path=SymbolInfoString(Symbol(),SYMBOL_PATH);
    
    string sym_type="currency";
    
    if ( StringFind(sym_path,"Crypto",0) != -1 ) sym_type="crypto";         
                  
    string url="https://www.senguller.com/discord.php?sym="+sinyal_sym+"&tip="+sinyal_tip+"&per="+sinyal_per+"&price="+sinyal_price+"&zaman="+sinyal_time+"&symtip="+sym_type+"&";
    

         //url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal+" "+Sinyals;
    //string url="https://www.senguller.com/discord.php?sym="+sinyal_sym+"&tip="+sinyal_tip+"&per="+sinyal_per+"&price="+sinyal_price+"&zaman="+sinyal_time+"&";




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
  
 
  


}


int OnInit()
  {
  
    /*
  if ( IsTesting() == False ) {
  if ( int(TimeMonth(TimeCurrent())) != 3 ) {
  ExpertRemove();
  }
  }
  */
  
  //FileDelete("NAS100M1.png");
  
//--- create timer
   //EventSetTimer(60);
   
   /*
   if ( discord == false && StringFind(Symbol(),"XAU",0) != -1 && Period() == PERIOD_M1 ) {
   
   Discord("Sinyal");
   
   discord=true;
   
   }*/
   
   ObjectsDeleteAll();
   
   PeriodBilgisi();
   
   
   start_time=Time[1];
   
   
   //Comment("Sinyal:",sinyal);

   //Alert("StartTime:",start_time);
   
   //Alert(StringFind(sinyal,"BUY"+Symbol()+TFtoStr(Period())+Time[1],0));
   
   
   for (int i=10;i<Bars-500;i++) {
   
   //Print(i);
   
   
if ( low_mode==true ) {   
   
   double low_price=Low[i];
   
   bool find=false;
   int say=0;
   int shift=0;
   
   for ( int r=i+1;r<i+100;r++) {
   
   if ( low_price < Low[r] && find == false ) {
   say=say+1; 
   } else {
   find=true;
   shift=r;
}





if ( say > 50 ) {

   double low_price=Low[i];
   
   bool find=false;
   int say=0;
   int shift=0;
   
   for ( int r=i-1;r>i-100;r--) {
   
   if ( r < 0 ) continue;
   
   if ( low_price < Low[r] && find == false ) {
   say=say+1; 
   } else {
   find=true;
   shift=r;
}

}

if ( (say > 50) || ( i < 50 && say > 10 ) ) {


ObjectCreate(ChartID(),"TrendLow"+Time[i],OBJ_TREND,0,Time[i]-50*PeriodSeconds(),Low[i],Time[i]+50*PeriodSeconds(),Low[i]);
ObjectSetInteger(ChartID(),"TrendLow"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendLow"+Time[i],OBJPROP_COLOR,clrLimeGreen);


int say=0;
double high_box=-1;
int max_bar=70;
int bar_say=0;

for (int y=i-1;y>0;y--) {

bar_say=bar_say+1;
if ( bar_say > max_bar ) continue;

if ( // 
//Close[y+3] > Open[y+3] && 
Close[y+2] > Open[y+2] && Close[y+1] > Open[y+1] && Open[y] > Close[y] && High[y] > high_box && say < 3 ) {
say=say+1;
ObjectCreate(ChartID(),"TrendHighBox"+Time[y],OBJ_RECTANGLE,0,Time[y],High[y],Time[y]+10*PeriodSeconds(),Low[y]);
ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_RAY,False);
if ( say == 1 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrLightGreen);
if ( say == 2 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrDarkGreen);
if ( say == 3 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_BACK,True);
high_box=High[y];

if ( say == 3 ) {
ObjectCreate(ChartID(),"TrendEntry"+Time[i],OBJ_TREND,0,Time[y],Close[y],Time[i]+50*PeriodSeconds(),Close[y]);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_COLOR,clrLavender);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_WIDTH,2);

if ( StringFind(sinyal,"BUY"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"BUY"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("BUY"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("BUY");
}


}


}

if ( say == 2 ) {


if ( StringFind(Symbol(),"XAUUSD",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 || step_two == true ) {
if ( StringFind(sinyal,"BUY2"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"BUY2"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("BUY2"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("BUYLevel2");
}

}
}






int sayg=0;
bool findg=false;
int shiftg=0;

for (int x=y-1;x>y-4;x--) {

if ( x < 0 || findg == true ) continue;

if ( Close[x] > Open[x] && findg == false ) {
sayg=sayg+1;
shiftg=x;
} else {
findg=true;
}

}

if ( sayg == 3 ) {

ObjectCreate(ChartID(),"TrendEntryQ"+Time[i],OBJ_TREND,0,Time[shiftg],Close[shiftg],Time[shiftg]+30*PeriodSeconds(),Close[shiftg]);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_COLOR,clrLavender);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);

if ( StringFind(sinyal,"BUYQ"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"BUYQ"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("BUYQ"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("BUYQuick");
}

}



}

}





}


}



}

   
   
   }
   
   
   
   
   
   
   
   }
   
   }
   
   
   

if ( high_mode==true ) {   
   
   double high_price=High[i];
   
   bool find=false;
   int say=0;
   int shift=0;
   
   for ( int r=i+1;r<i+100;r++) {
   
   if ( high_price > High[r] && find == false ) {
   say=say+1; 
   } else {
   find=true;
   shift=r;
}





if ( say > 50 ) {

   double high_price=High[i];
   
   bool find=false;
   int say=0;
   int shift=0;
   
   for ( int r=i-1;r>i-100;r--) {
   
   if ( r < 0 ) continue;
   
   if ( high_price >= High[r] && find == false ) {
   say=say+1; 
   } else {
   find=true;
   shift=r;
}

}

if ( (say > 50) || ( i < 50 && say > 10 ) ) {


ObjectCreate(ChartID(),"TrendHigh"+Time[i],OBJ_TREND,0,Time[i]-50*PeriodSeconds(),High[i],Time[i]+50*PeriodSeconds(),High[i]);
ObjectSetInteger(ChartID(),"TrendHigh"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendHigh"+Time[i],OBJPROP_COLOR,clrBlue);


int say=0;
int max_bar=70;
int bar_say=0;
double low_box=100000000;

for (int y=i-1;y>0;y--) {

bar_say=bar_say+1;
if ( bar_say > max_bar ) continue;


if ( //Close[y+3] < Open[y+3] && 
Close[y+2] < Open[y+2] && Close[y+1] < Open[y+1] && Open[y] < Close[y] && Low[y] < low_box && say < 3 ) {
say=say+1;
ObjectCreate(ChartID(),"TrendHighBox"+Time[y],OBJ_RECTANGLE,0,Time[y],High[y],Time[y]+10*PeriodSeconds(),Low[y]);
ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_RAY,False);
if ( say == 1 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrDarkRed);
if ( say == 2 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrOrangeRed);
if ( say == 3 ) ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_COLOR,clrPink);
ObjectSetInteger(ChartID(),"TrendHighBox"+Time[y],OBJPROP_BACK,True);
ObjectSetString(ChartID(),"TrendHighBox"+Time[y],OBJPROP_TEXT,say);
low_box=Low[y];

if ( say == 3 ) {
ObjectCreate(ChartID(),"TrendEntry"+Time[i],OBJ_TREND,0,Time[y],Close[y],Time[i]+50*PeriodSeconds(),Close[y]);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"TrendEntry"+Time[i],OBJPROP_WIDTH,2);

if ( StringFind(sinyal,"SELL"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"SELL"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("SELL"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("SELL");
}

}





}



if ( say == 2 ) {

if ( StringFind(Symbol(),"XAUUSD",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 || step_two == true) {
if ( StringFind(sinyal,"SELL2"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"SELL2"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("SELL2"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("SELLLevel2");
}

}
}



int sayg=0;
bool findg=false;
int shiftg=0;

for (int x=y-1;x>y-4;x--) {

if ( x < 0 || findg == true ) continue;

if ( Close[x] < Open[x] && findg == false ) {
sayg=sayg+1;
shiftg=x;
} else {
findg=true;
}

}

if ( sayg == 3 ) {

ObjectCreate(ChartID(),"TrendEntryQ"+Time[i],OBJ_TREND,0,Time[shiftg],Close[shiftg],Time[shiftg]+30*PeriodSeconds(),Close[shiftg]);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_COLOR,clrLavender);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"TrendEntryQ"+Time[i],OBJPROP_STYLE,STYLE_DOT);

if ( StringFind(sinyal,"SELLQ"+Symbol()+TFtoStr(Period())+Time[i],0) == -1 ) {
sinyal=sinyal+"SELLQ"+Symbol()+TFtoStr(Period())+Time[i];

if ( alert == true ) {
Alert("SELLQ"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
Discord("SELLQuick");
}

}




}

}







}


}





}

   
   
   }
   
   
   
   
   
   
   
   }
   
   }
      
   
   
   }
   
    //Comment("Sinyal:",sinyal);
   
   
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

if ( start_time != Time[1] ) {
OnInit();
start_time=Time[1];
//alert=true;
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



void PeriodBilgisi() {


string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
      //  if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=Symbol() + " [" + TFtoStr(Period())+"]";
    // if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     /*
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_LEFT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkBlue);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 18);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 5);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 35);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrLimeGreen);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 18);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 4);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 35); */
     

     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_LEFT_UPPER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkBlue);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 105);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 40);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_UPPER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBisque);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 104);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 40);      
     
/*
     LabelChart="SpreadBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString(((Ask-Bid)/Point),0));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 44);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 80);   


     LabelChart="SureBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"00:00");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 74);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 120);   


     LabelChart="LotBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"LotBilgisi");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 300);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 160);    */    
          
          
     
         
    /* } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     }*/
  
  

}
