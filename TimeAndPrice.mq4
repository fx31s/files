//+------------------------------------------------------------------+
//|                                                 TimeAndPrice.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

     long sinyal_charid=ChartID();
     long currChart=ChartID();
     
     double Ortalama;
     
     datetime alarm_time;
     
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer



     
 int k=10;

 for(int i=0;i<k;i++)
        {
         //PrintFormat("result[%d]=%s",i,results[i]);
         
     
     string LabelChartu = "Bilgi"+i;
     ObjectDelete(sinyal_charid,LabelChartu);
     ObjectCreate(sinyal_charid,LabelChartu, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,"");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_CORNER, 1);
     ObjectSetString(sinyal_charid,LabelChartu, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_XDISTANCE, 50);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_YDISTANCE, i*20); 
 
        }
        
        
        
        

   EventSetTimer(1);
   
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

datetime bar_time;

void OnTimer()
  {
//---

	int min, sec;
	
   min = Time[0] + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   

     string LabelChartu = "Bilgi"+1;
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,min + ":" + sec);
        
   
   
   if ( bar_time != Time[1] ) {
   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   
   //Comment("Bar Ortalama:",Ortalama);
   
   Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec"+"\nBar Ortalama:",int(Ortalama/Point));
   
  string sym=Symbol();
  ENUM_TIMEFRAMES per=Period();
       
       
       
       for (int i=1;i<200;i++) {
       
       ObjectDelete(ChartID(),"MAL"+i);
       
     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*3 ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     
     if ( i == 1 && alarm_time != Time[1] ) {alarm_time=Time[1];
     Alert(TFtoStr(Period())+" "+Symbol()+" Buy "+int(ort));
     
   color color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrLimeGreen);       
   Sleep(3000);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,color_bg);       
   
     
     }
          
  
  }
  
     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*3 ) {
     
     double ort=DivZero(iOpen(sym,per,i)-iClose(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrCrimson);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     
     if ( i == 1 && alarm_time != Time[1] ) {alarm_time=Time[1];
     Alert(TFtoStr(Period())+" "+Symbol()+" Sell "+int(ort));

   color color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrCrimson);       
   Sleep(3000);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,color_bg);        
     
     }
          
  
  }
    
    }
    
    
    
    
    
    
    
    bar_time=Time[1];
    
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

Print(sparam);


if ( sparam == 2 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
if ( sparam == 3 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
if ( sparam == 4 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
if ( sparam == 5 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
if ( sparam == 6 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
if ( sparam == 7 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
if ( sparam == 8 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
if ( sparam == 9 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
if ( sparam == 10 ) ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);

if ( int(sparam) >= 2 && int(sparam) <=10 ) {
ChartSymCid();
ObjectsDeleteAll();
bar_time=0;
}




if ( sparam == 19 ) {

int i=1;

     ObjectDelete(ChartID(),"MAR"+Time[i]);
     ObjectCreate(ChartID(),"MAR"+Time[i],OBJ_RECTANGLE,0,Time[1],Open[1],Time[1]+50*PeriodSeconds(),Close[1]);
     ObjectSetInteger(ChartID(),"MAR"+Time[i],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAR"+Time[i],OBJPROP_COLOR,clrDarkGray);
     //ObjectSetInteger(ChartID(),"MAR"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAR"+Time[i],OBJPROP_BACK,true);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     
     

}

if ( sparam == 38 ) {


int i=1;

     ObjectDelete(ChartID(),"MAL"+Time[i]);
     ObjectCreate(ChartID(),"MAL"+Time[i],OBJ_HLINE,0,Time[i],Open[1]);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_COLOR,clrDarkGray);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+Time[i],OBJPROP_BACK,true);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     
     

}







if ( sparam == 31 ) {

Print("Set Chart Period");
ChartSymCid();


}


if ( sparam == 45 ) {
bar_time=0;
ChartRedraw();

}


   
  }
//+------------------------------------------------------------------+


void ChartSymCid() {

int counts=0;
long cid=0;
   
   for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {counts++;
      string csym=ChartSymbol(chartid);
      string cper=ChartPeriod(chartid);
      
      //Print(csym);
      
      if ( ChartID() != chartid ) ChartSetSymbolPeriod(chartid,csym,Period());
      
      
      }
      
}





long ChartSymCid(string sym) {

int counts=0;
long cid=0;
   
   for(long chartid=ChartFirst(); chartid != -1; chartid=ChartNext(chartid) ) {counts++;
      string csym=ChartSymbol(chartid);
      string cper=ChartPeriod(chartid);
      
      //Print(csym);
      
      if ( csym == sym ) cid=chartid;
      
      
      }
      
return cid;
      
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
