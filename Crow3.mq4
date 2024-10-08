//+------------------------------------------------------------------+
//|                                                        Crow3.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Ortalama;
double bar_ortalama;

ENUM_TIMEFRAMES zaman[9];

string chart_comment="";
int bolge=-1;


double pricess[50,6];

int start_time=-1;
bool alert=false;
string sinyal="";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  


 
  int psay=-1;
  
  
  
  for (int p=0;p<50;p++) {
  
  //Print("p:",p);
  
  pricess[p,0]=-1;
  pricess[p,1]=-1;
  pricess[p,2]=-1;
  pricess[p,3]=-1;
  pricess[p,4]=-1;
  pricess[p,5]=-1;
  
  
  }
  
  
  //pause=true;
  
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;  
  
  

  /*
  for(int x=8;x>-1;x--) {
  
  ENUM_TIMEFRAMES pers=zaman[x];
  
  if ( pers < Period() ) {
  Print(TFtoStr(pers));
  }
  
  }*/
  
  
  if ( pause == true ) return INIT_SUCCEEDED;
  
  bolge=-1;
  chart_comment="";
  Comment("");
  
  ObjectsDeleteAll();
  
    //ObjectCreate(ChartID(),"H",OBJ_HLINE,0,Time[0],68408.21);
  
  
  CreateSinyalButton();
  
  bar_ortalama=BarOrtalama(1,300,Symbol(),Period());
  
  //Comment("BarOrtalama:",bar_ortalama);
  
    
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();  
/*
  for(int i=1;i<500;i++) {
  
RefreshRates();
ChartRedraw();
WindowRedraw();

}*/
  
  int bar=500;
  if ( Bars < 500 );
  bar=Bars-60;
  
  bar=350;
  
  for(int i=1;i<bar;i++) {
  
RefreshRates();
ChartRedraw();
WindowRedraw();
 
  
  if ( Open[i+3] > Close[i+3] && Open[i+2] > Close[i+2] && Close[i+1] > Open[i+1] ) {


  //// Right
  
  int shiftx=i+1;
  bool findx=false;
  int sayx=0;
  double pricelx=High[i+1];
  
  for(int x=i+1;x>0;x--) {
  
  if ( Close[x] > Open[x] && findx == false ) {
  if ( pricelx < High[x] ) {
  shiftx=x;   
  sayx=sayx+1;   
  pricelx=iHigh(sym,per,shiftx);
  }
  } else {
  findx=true;
  }

  }
  
  
  
  //// Right
  
  int shift=i+1;
  bool find=false;
  int say=0;
  double pricel;
  
  for(int x=i+1;x>0;x--) {
  
  if ( Close[x] > Open[x] && find == false ) {
  shift=x;   
  say=say+1;   
  pricel=iHigh(sym,per,shift);
  } else {
  find=true;
  }

  }
  
  
  

  //// Left

  int shifts=i+2;
  bool finds=false;
  int says=0;
  double pricer;
  
  for(int x=i+2;x<i+50;x++) {
  
  if ( Open[x] > Close[x] && finds == false ) {
  shifts=x;   
  says=says+1;  
  pricer=iLow(sym,per,shifts+1);
  } else {
  finds=true;
  }  
  
  }
  

  //// Left Red

  int shifti=shifts+1;
  bool findi=false;
  int sayi=0;
  double pricei=iLow(sym,per,shifts+1);
  
  for(int x=shifts+1;x<shifts+50;x++) {
  
  if ( Close[x] > Open[x]   && findi == false ) {
  if ( Low[x] < pricei ) {
  shifti=x;   
  sayi=sayi+1;  
  pricei=iLow(sym,per,shifti);
  }
  } else {
  findi=true;
  }  
  
  }
    
  
  bool findw=false;
  double pricew;
  int sayw=0;
  int shiftw=0;
  
  for(int r=shift-1;r>0;r--) {
  
  if ( Close[r] > pricel && findw == false ) {//iLow(sym,per,shift)
  findw=true;
  shiftw=r;
  pricew=Close[r];
  }
  
  }

  bool findws=false;
  double pricews;
  int sayws=0;
  int shiftws=0;
  
  for(int r=shift-1;r>0;r--) {
  
  if ( High[r] > pricer && findws == false ) {//iLow(sym,per,shift)
  findws=true;
  shiftws=r;
  pricews=High[r];
  }
  
  }
  



double downrs=iLow(sym,per,shifti); // grup destek direnç
double downr=iLow(sym,per,shifts+1); // 1.
double downl=iHigh(sym,per,shift); 

 
  bool findmax=false;
  double pricemax=downl;
  int saymax=0;
  int shiftmax=shift;
  
  for(int r=shift;r>0;r--) {
  
  if ( findmax == true ) continue;
  
  if ( High[r] > pricemax ) {//iLow(sym,per,shift)
  if ( High[r] >= downrs ) findmax=true;
  shiftmax=r;
  pricemax=High[r];
  }
  
  }
  
//double yuzde=DivZero(iLow(sym,per,shifts+1)-iHigh(sym,per,shift),100);
double yuzde=DivZero((downrs-downl),100);
double range_yuzde=DivZero(downrs-pricemax,yuzde);  
double range_pip=DivZero(downrs-pricemax,Point);  
    
    
    
double range=iLow(sym,per,shifts+1)-iHigh(sym,per,shift);
double range_avarage=DivZero(range/Point(),bar_ortalama);



//Comment((downrs-downl)/Point);




   if ( pricel < pricer && pricei > pricel //&& (findw == false || (pricer-Bid > 0 && Bid > pricel && Bid < pricer) ) 
   
   && findws==false && range_avarage >= 2 &&
    range_yuzde > 10 ) {
   
   


 datetime start_time=Time[i+2];
 datetime end_time=Time[shifts+1];
 
  int start_shift=iBarShift(Symbol(),Period(),Time[i+2]);
 int end_shift=iBarShift(Symbol(),Period(),Time[shifts+1]);
   

  for(int x=8;x>-1;x--) {
  
  ENUM_TIMEFRAMES pers=zaman[x];
  
  if ( pers < Period() ) {
  
  if ( Period() >= PERIOD_H1 && pers == PERIOD_M1 ) continue;
  
  
  //if ( pers == PERIOD_M5 ) {
  
  //Print(x,TFtoStr(pers));
  
  int start_shift=iBarShift(Symbol(),pers,Time[i+2]);
 int end_shift=iBarShift(Symbol(),pers,Time[shifts+1]);
   

for(int t=start_shift;t<end_shift;t++) {  

if ( iClose(sym,pers,t) < iLow(sym,per,shifts+1) && iLow(sym,pers,t) > iHigh(sym,per,shiftx) && iOpen(sym,pers,t) < iClose(sym,pers,t) && iClose(sym,pers,t-1) < iOpen(sym,pers,t-1) && iClose(sym,pers,t-2) < iOpen(sym,pers,t-2) && iClose(sym,pers,t-3) < iOpen(sym,pers,t-3) ) {
//Print(x,sym,TFtoStr(pers),t);
   string name="DownSupport"+iTime(sym,pers,t);
   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,pers,t),iHigh(sym,pers,t),iTime(sym,pers,t)+50*PeriodSeconds(),iHigh(sym,pers,t)+(x*10000)*Point);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,pers,t),iLow(sym,pers,t),iTime(sym,pers,t)+50*PeriodSeconds(),iLow(sym,pers,t));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,x+" "+TFtoStr(pers));  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,x+1);  
   

} 

  
  }
  
  
  
  
 // }
  
  
  
  }
  
  }
  
  
     

   string name="DOWN"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+2),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);   
   

   name="DOWNMAX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shiftmax),iHigh(sym,per,shiftmax),iTime(sym,per,shiftmax)+50*PeriodSeconds(),iHigh(sym,per,shiftmax));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,say);  
  
  
     
   

if ( findw == true ) {   // Kırdığı yer
   name="DOWNW"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,shiftw),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH); 
   }
    
   
   if ( findws == true ) {   // Çalıştığı yer
   name="DOWNWS"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,shiftws),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH);  
   }
      
   
   name="DOWN"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iLow(sym,per,i+1),iTime(sym,per,shift),iHigh(sym,per,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,say);  
  


   name="DOWNHX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shiftx),iHigh(sym,per,shiftx),iTime(sym,per,shiftx)+50*PeriodSeconds(),iHigh(sym,per,shiftx));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  



   name="DOWNL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shift),iHigh(sym,per,shift),iTime(sym,per,shift)+50*PeriodSeconds(),iHigh(sym,per,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  
   
   name="DOWNHH"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iHigh(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iHigh(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_SOLID);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);



   name="DOWNR"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shifts+1),iLow(sym,per,shifts+1),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iLow(sym,per,shifts+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   

   name="DOWNRS"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shifti),iLow(sym,per,shifti),iTime(sym,per,shifti)+50*PeriodSeconds(),iLow(sym,per,shifti));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   

   name="DOWNRX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,per,shifti),iHigh(sym,per,shifti),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iLow(sym,per,shifts+1));
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,per,shifts+1),iLow(sym,per,shifts+1),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iHigh(sym,per,shifts+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   //ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGreenYellow);
   //ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   
   
   double price=iHigh(sym,per,shift);
   double priceh=iLow(sym,per,shifts+1);
   
//   chart_comment=ChartGetString(ChartID(),CHART_COMMENT)+"\n"+sym+" [Down] "+TFtoStr(per)+" Kalan:"+(price-Bid)/Point();

   bolge=bolge+1;
   string buttonID="ButtonSinyal"+bolge;
   double bolge_girisi_kalan=DoubleToString((price-Bid)/Point(),0);
   double hedef_kalan=DoubleToString((priceh-Bid)/Point(),0);
   string text="Bölge:"+bolge_girisi_kalan+" Hedef:"+hedef_kalan+" Range:"+DoubleToString(range/Point,0)+" %"+DoubleToString(range_yuzde,0)+" "+DoubleToString(range_pip,0);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,text);
   
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_TIMEFRAMES,PERIOD_CURRENT);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,int(iTime(sym,per,i+2)));

   chart_comment=chart_comment+"\n"+sym+" [Down] "+TFtoStr(per)+" Bölge Girişi Kalan:"+DoubleToString((price-Bid)/Point(),0)+" Hedef Kalan:"+DoubleToString((priceh-Bid)/Point(),0);

   psay=psay+1;
  pricess[psay,0]=bolge;
  pricess[psay,1]=downrs;
  pricess[psay,2]=downl;
  pricess[psay,3]=pricemax;
  pricess[psay,4]=downr;
  pricess[psay,5]=int(iTime(sym,per,i+2));
   
      
    
    }
    
  //Print("x:",x);
  
  
  
  
  
  
  }
  
  
  
  //continue;  
  
  
  
  
  
  
  
  
  
  
  
  
  
  if ( Close[i+3] > Open[i+3] && Close[i+2] > Open[i+2] && Open[i+1] > Close[i+1] ) {
  
  

  
    
  
  //// Right
  
  
  int shiftx=i+1;
  bool findx=false;
  int sayx=0;
  double pricelx=Low[i+1];
  
  for(int x=i+1;x>0;x--) {
  
  if ( Open[x] > Close[x] && findx == false ) {
  if ( pricelx > Low[x] ) {
  shiftx=x;   
  sayx=sayx+1;   
  pricelx=iLow(sym,per,shiftx);
  }
  } else {
  findx=true;
  }

  }
  
  
    
  
  int shift=i+1;
  bool find=false;
  int say=0;
  double pricel;
  
  for(int x=i+1;x>0;x--) {
  
  if ( Open[x] > Close[x] && find == false ) {
  shift=x;   
  say=say+1;   
  pricel=iLow(sym,per,shift);
  } else {
  find=true;
  }

  }
  
  
  

  //// Left

  int shifts=i+2;
  bool finds=false;
  int says=0;
  double pricer;
  
  for(int x=i+2;x<i+50;x++) {
  
  if ( Close[x] > Open[x] && finds == false ) {
  shifts=x;   
  says=says+1;  
  pricer=iHigh(sym,per,shifts+1);
  } else {
  finds=true;
  }  
  
  }
  

  //// Left Red

  int shifti=shifts+1;
  bool findi=false;
  int sayi=0;
  double pricei=pricer;
  
  for(int x=shifts+1;x<shifts+50;x++) {
  
  if ( Open[x] > Close[x]  && findi == false ) {
  if ( High[x] > pricei ) {
  shifti=x;   
  sayi=sayi+1;  
  pricei=iHigh(sym,per,shifti);
  }
  } else {
  findi=true;
  }  
  
  }
    
  
  bool findw=false;
  double pricew;
  int sayw=0;
  int shiftw=0;
  
  for(int r=shift-1;r>0;r--) {
  
  if ( Close[r] < pricel && findw == false ) {//iLow(sym,per,shift)
  findw=true;
  shiftw=r;
  pricew=Close[r];
  }
  
  }

  bool findws=false;
  double pricews;
  int sayws=0;
  int shiftws=0;
  
  for(int r=shift-1;r>0;r--) {
  
  if ( Low[r] < pricer && findws == false ) {//iLow(sym,per,shift)
  findws=true;
  shiftws=r;
  pricews=Low[r];
  }
  
  }
    
double range=iLow(sym,per,shift)-iHigh(sym,per,shifts+1);
double range_avarage=DivZero(range/Point(),bar_ortalama);




double downrs=iHigh(sym,per,shifti); // grup destek direnç
double downr=iHigh(sym,per,shifts+1); // 1.
double downl=iLow(sym,per,shift); 

 
  bool findmax=false;
  double pricemax=downl;
  int saymax=0;
  int shiftmax=shift;
  
  for(int r=shift;r>0;r--) {
  
  if ( findmax == true ) continue;
  
  if ( Low[r] < pricemax ) {//iLow(sym,per,shift)
  if ( Low[r] <= downrs ) findmax=true;
  shiftmax=r;
  pricemax=Low[r];
  }
  
  }
  
//double yuzde=DivZero(iLow(sym,per,shifts+1)-iHigh(sym,per,shift),100);
double yuzde=DivZero((downl-downrs),100);
double range_yuzde=DivZero(pricemax-downrs,yuzde);  
double range_pip=DivZero(pricemax-downrs,Point);      
    








   if ( pricel > pricer && pricei < pricel //&& (findw == false || (Bid-pricer > 0 && Bid < pricel && Bid > pricer)) 
   
   && findws==false && range_avarage >= 2 
   && range_yuzde > 10 
   
   ) {
   


 datetime start_time=Time[i+2];
 datetime end_time=Time[shifts+1];
 
  int start_shift=iBarShift(Symbol(),Period(),Time[i+2]);
 int end_shift=iBarShift(Symbol(),Period(),Time[shifts+1]);
   

  for(int x=8;x>-1;x--) {
  
  ENUM_TIMEFRAMES pers=zaman[x];
  
  if ( pers < Period() ) {
  
  if ( Period() >= PERIOD_H1 && pers == PERIOD_M1 ) continue;
  if ( Period() >= PERIOD_H4 && pers == PERIOD_M5 ) continue;
  
  
  //if ( pers == PERIOD_M5 ) {
  
  //Print(x,TFtoStr(pers));
  
  int start_shift=iBarShift(Symbol(),pers,Time[i+2]);
 int end_shift=iBarShift(Symbol(),pers,Time[shifts+1]);
   

for(int t=start_shift;t<end_shift;t++) {  

if ( iClose(sym,pers,t) > iHigh(sym,per,shifts+1) &&  iHigh(sym,pers,t) < iLow(sym,per,shiftx) && iOpen(sym,pers,t) > iClose(sym,pers,t) && iClose(sym,pers,t-1) > iOpen(sym,pers,t-1) && iClose(sym,pers,t-2) > iOpen(sym,pers,t-2) && iClose(sym,pers,t-3) > iOpen(sym,pers,t-3) ) {
//Print(x,sym,TFtoStr(pers),t);
   string name="UPSupport"+iTime(sym,pers,t);
   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,pers,t),iHigh(sym,pers,t),iTime(sym,pers,t)+50*PeriodSeconds(),iHigh(sym,pers,t)+(x*10000)*Point);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,pers,t),iHigh(sym,pers,t),iTime(sym,pers,t)+50*PeriodSeconds(),iHigh(sym,pers,t));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBisque);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,x+" "+TFtoStr(pers));  
   ObjectSetString(ChartID(),name,OBJPROP_TEXT,x+" "+TFtoStr(pers));  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,x+1);  
   

} 

  
  }
  
  
  
  
 // }
  
  
  
  }
  
  }
  
  
  
   
   
   

   string name="UP"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+2),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);   
   

   name="UPMAX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shiftmax),iLow(sym,per,shiftmax),iTime(sym,per,shiftmax)+50*PeriodSeconds(),iLow(sym,per,shiftmax));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,say);  
      
   

if ( findw == true ) {   // Kırdığı yer
   name="UPW"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,shiftw),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH); 
   }
    
   
   if ( findws == true ) {   // Çalıştığı yer
   name="UPWS"+iTime(sym,per,i+2);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,shiftws),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DASH);  
   }
      
   
   name="UP"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iHigh(sym,per,i+1),iTime(sym,per,shift),iLow(sym,per,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,say);  
  



   name="UPLL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iLow(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iLow(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_SOLID);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
   

   name="UPL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shift),iLow(sym,per,shift),iTime(sym,per,shift)+50*PeriodSeconds(),iLow(sym,per,shift));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  


   name="UPLX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shiftx),iLow(sym,per,shiftx),iTime(sym,per,shiftx)+50*PeriodSeconds(),iLow(sym,per,shiftx));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,DivZero(range/Point(),bar_ortalama));  
   
   

   name="UPR"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shifts+1),iHigh(sym,per,shifts+1),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iHigh(sym,per,shifts+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   

   name="UPRS"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,shifti),iHigh(sym,per,shifti),iTime(sym,per,shifti)+50*PeriodSeconds(),iHigh(sym,per,shifti));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   

   name="UPRX"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,per,shifti),iHigh(sym,per,shifti),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iLow(sym,per,shifts+1));
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(sym,per,shifts+1),iHigh(sym,per,shifts+1),iTime(sym,per,shifts+1)+50*PeriodSeconds(),iLow(sym,per,shifts+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGreenYellow);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);    
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,says); 
   
   double price=iLow(sym,per,shift); // Bölge Girişi
   double priceh=iHigh(sym,per,shifts+1); // Bölge Hedefi
 
    chart_comment=chart_comment+"\n"+sym+" [Up] "+TFtoStr(per)+" Bölge Girişi Kalan:"+DoubleToString((Bid-price)/Point(),0)+" Hedef Kalan:"+DoubleToString((Bid-priceh)/Point(),0);
       
    bolge=bolge+1;
   string buttonID="ButtonSinyal"+bolge;
   double bolge_girisi_kalan=DoubleToString((Bid-price)/Point(),0);
   double hedef_kalan=DoubleToString((Bid-priceh)/Point(),0);
   string text="Bid-Bölge Girişi:"+bolge_girisi_kalan+" Bid-Hedef:"+hedef_kalan+" Range:"+DoubleToString(range/Point,0)+" %"+DoubleToString(range_yuzde,0)+" "+DoubleToString(range_pip,0);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,text);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrYellowGreen);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_TIMEFRAMES,PERIOD_CURRENT);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,int(iTime(sym,per,i+2)));
     
   psay=psay+1;
  pricess[psay,0]=bolge;
  pricess[psay,1]=downrs;
  pricess[psay,2]=downl;
  pricess[psay,3]=pricemax;
  pricess[psay,4]=downr;
  pricess[psay,5]=int(iTime(sym,per,i+2));
   
   
   
   //chart_comment=ChartGetString(ChartID(),CHART_COMMENT)+"\n"+sym+" [Up] "+TFtoStr(per)+" Kalan:"+(Bid-price)/Point();
     
     //Print(chart_comment); 
    
    }
    
  //Print("x:",x);
  
  
  
  
  
  
  }
  
  
  
  
  
  
  }
  
  
  
  
  
  
  //Comment(chart_comment);

  
  
  
  start_time=Time[1];
  
  //OnTick();
  
  
  
  
  return 0;
  
  


  

  
  
//--- create timer
   //EventSetTimer(60);
   
   

   
   

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string sym=pairswl[iwl];
      int per=Period();
      //Print(sym);
      bool bigbar=false;
      
      
      
      
  for(int z=0;z<ArraySize(zaman);z++) {

  per=zaman[z];
    
   
  double bar_ortalama=BarOrtalama(1,300,sym,per);
  
  
  //Print(sym,"/",TFtoStr(per),"/",bar_ortalama);
  
  
  
  }
  
  }   
   
   
   string chart_comment="";
   
   ObjectsDeleteAll();
   
   for (int i=1;i<Bars-500;i++) {
   
   

///////////////////////
// 1-1 
///////////////////////
   if ( 
   iClose(sym,per,i+3) > iOpen(sym,per,i+3) 
   && iClose(sym,per,i+2) < iOpen(sym,per,i+2) 
   && iOpen(sym,per,i+1) < iClose(sym,per,i+1) 
   && iClose(sym,per,i) < iOpen(sym,per,i) 
   
  
   && (iHigh(sym,per,i+2)-iLow(sym,per,i+2))/Point > bar_ortalama*4
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) > iHigh(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="DOWN"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);   
   
   
   name="DOWNH"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iHigh(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iHigh(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   }   
   
   
   
   }
   
   
   
  
   
   if ( 
   
   iClose(sym,per,i+3) < iOpen(sym,per,i+3) 
   && iClose(sym,per,i+2) > iOpen(sym,per,i+2) 
   && iOpen(sym,per,i+1) > iClose(sym,per,i+1) 
   && iClose(sym,per,i) > iOpen(sym,per,i)
   

   
   && (iHigh(sym,per,i+2)-iLow(sym,per,i+2))/Point > bar_ortalama*4
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) < iLow(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="UP"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);      
   
   
   name="UPL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iLow(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iLow(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   }   
   
   
   
   }



///////////////////////
// 2-1 
///////////////////////
   if ( iClose(sym,per,i+4) > iOpen(sym,per,i+4) 
   && iClose(sym,per,i+3) < iOpen(sym,per,i+3) 
   && iClose(sym,per,i+2) < iOpen(sym,per,i+2) 
   && iOpen(sym,per,i+1) < iClose(sym,per,i+1) 
   && iClose(sym,per,i) < iOpen(sym,per,i) 
   
   && iClose(sym,per,i+3) > iClose(sym,per,i+2) 
   
   && (iHigh(sym,per,i+3)-iLow(sym,per,i+2))/Point > bar_ortalama*4
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) > iHigh(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="DOWN"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);   
   
   
   name="DOWNH"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iHigh(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iHigh(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   }   
   
   
   
   }
   
   
   
  
   
   if ( iClose(sym,per,i+4) < iOpen(sym,per,i+4) 
   
   && iClose(sym,per,i+3) > iOpen(sym,per,i+3) 
   && iClose(sym,per,i+2) > iOpen(sym,per,i+2) 
   && iOpen(sym,per,i+1) > iClose(sym,per,i+1) 
   && iClose(sym,per,i) > iOpen(sym,per,i)
   
   && iClose(sym,per,i+3) < iClose(sym,per,i+2)
   
   && (iHigh(sym,per,i+2)-iLow(sym,per,i+3))/Point > bar_ortalama*4
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) < iLow(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="UP"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);      
   
   
   name="UPL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iLow(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iLow(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   }   
   
   
   
   }

///////////////////////
// x-1 
///////////////////////
   if ( iClose(sym,per,i+4) < iOpen(sym,per,i+4) && iClose(sym,per,i+3) < iOpen(sym,per,i+3) && iClose(sym,per,i+2) < iOpen(sym,per,i+2) && iOpen(sym,per,i+1) < iClose(sym,per,i+1) && iClose(sym,per,i) < iOpen(sym,per,i) 
   
   && iClose(sym,per,i+4) > iClose(sym,per,i+3) && iClose(sym,per,i+3) > iClose(sym,per,i+2) 
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) > iHigh(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="DOWN"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);   
   
   
   name="DOWNH"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iHigh(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iHigh(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   double price=iHigh(sym,per,i+1);
   
   chart_comment=ChartGetString(ChartID(),CHART_COMMENT)+"\n"+sym+" [Down] "+TFtoStr(per)+" Kalan:"+(price-Bid)/Point();

   
   
   }   
   
   
   
   }
   
   
   
  
   
   if ( iClose(sym,per,i+4) > iOpen(sym,per,i+4) && iClose(sym,per,i+3) > iOpen(sym,per,i+3) && iClose(sym,per,i+2) > iOpen(sym,per,i+2) && iOpen(sym,per,i+1) > iClose(sym,per,i+1) && iClose(sym,per,i) > iOpen(sym,per,i)
   
   && iClose(sym,per,i+4) < iClose(sym,per,i+3) && iClose(sym,per,i+3) < iClose(sym,per,i+2)
   
   ) {
   

   bool find=false;
   int x=i-1;
   if ( x-1 > 0 ) {
   for (x=i-1;x>0;x--) {
   if ( find == true ) continue;
   if ( iClose(sym,per,x) < iLow(sym,per,i+1) ) {
   find=true;
   }
 
   }  
   }

   if ( find == false ) {
   string name="UP"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,iTime(sym,per,i+1),Ask);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);      
   
   
   name="UPL"+iTime(sym,per,i);
   
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(sym,per,i+1),iLow(sym,per,i+1),iTime(sym,per,i+1)+50*PeriodSeconds(),iLow(sym,per,i+1));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,3);
   
   double price=iLow(sym,per,i+1);
   
   chart_comment=ChartGetString(ChartID(),CHART_COMMENT)+"\n"+sym+" [Up] "+TFtoStr(per)+" Kalan:"+(Bid-price)/Point();
   
   
   
   }   
   
   
   
   }
   
   
   Comment(chart_comment);
   
   
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



if ( start_time != Time[1] ) {
OnInit();
start_time=Time[1];
//alert=true;
}
 
 

  for (int p=0;p<50;p++) {
  
  //Print("p:",pricess[p,0]);
  
  if ( pricess[p,0] > -1 ) {
  
  double bolge=pricess[p,0];
  double downrs=pricess[p,1];
  double downl=pricess[p,2];
  double pricemax=pricess[p,3];
  double downr=pricess[p,4];
  double times=pricess[p,5];
  
  //if ( bolge == 0 ) pricemax=Bid;
  
  if ( downl > downrs ) {
//Print("OnTick2");
double yuzde=DivZero((downl-downrs),100);
double range_yuzde=DivZero(pricemax-downrs,yuzde);  
double range_pip=DivZero(pricemax-downrs,Point);      
   
  double price=downl;//iLow(sym,per,shift); // Bölge Girişi
  double priceh=downr;//iHigh(sym,per,shifts+1); // Bölge Hedefi
   
double range=downl-downr;

    //bolge=bolge+1;
   string buttonID="ButtonSinyal"+int(bolge);
   double bolge_girisi_kalan=DoubleToString((Bid-price)/Point(),0);
   double hedef_kalan=DoubleToString((Bid-priceh)/Point(),0);
   string text="Bid-Bölge Girişi:"+bolge_girisi_kalan+" Bid-Hedef:"+hedef_kalan+" Range:"+DoubleToString(range/Point,0)+" %"+DoubleToString(range_yuzde,0)+" "+DoubleToString(range_pip,0);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,text);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrYellowGreen);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_TIMEFRAMES,PERIOD_CURRENT);
   //ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,int(iTime(sym,per,i+2)));
 

if ( alert == true && range_pip > 0 && Bid < downl && StringFind(sinyal,times,0) == -1 && range_yuzde > 80 ) {
Alert("SELL"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
sinyal=sinyal+","+times;
//Discord("SELL");
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrBlue);
}


  
   
  
  } else {
  
  
double yuzde=DivZero((downrs-downl),100);
double range_yuzde=DivZero(downrs-pricemax,yuzde);  
double range_pip=DivZero(downrs-pricemax,Point); 

  double price=downl;//iLow(sym,per,shift); // Bölge Girişi
  double priceh=downr;//iHigh(sym,per,shifts+1); // Bölge Hedefi
   
double range=downl-downr;
   
//   chart_comment=ChartGetString(ChartID(),CHART_COMMENT)+"\n"+sym+" [Down] "+TFtoStr(per)+" Kalan:"+(price-Bid)/Point();

   string buttonID="ButtonSinyal"+int(bolge);
   double bolge_girisi_kalan=DoubleToString((price-Bid)/Point(),0);
   double hedef_kalan=DoubleToString((priceh-Bid)/Point(),0);
   string text="Bölge:"+bolge_girisi_kalan+" Hedef:"+hedef_kalan+" Range:"+DoubleToString(range/Point,0)+" %"+DoubleToString(range_yuzde,0)+" "+DoubleToString(range_pip,0);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,text);
   
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_TIMEFRAMES,PERIOD_CURRENT);
   //ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,int(iTime(sym,per,i+2)));
  
if ( alert == true && range_pip > 0 && Bid > downl && StringFind(sinyal,times,0) == -1 && range_yuzde > 80 ) {
Alert("BUY"+Symbol()+TFtoStr(Period()));
ChartSetInteger(ChartID(),CHART_BRING_TO_TOP,True);
sinyal=sinyal+","+times;
//Discord("SELL");
ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrBlue);
}


  
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

bool pause=false;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


//Print(sparam);

if ( StringFind(sparam,"Support",0) != -1 ) {

string last_select_objectr=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
         if ( obj_ray == true ) {
         ObjectSetInteger(ChartID(),last_select_objectr,OBJPROP_RAY,False);
         } else {
         ObjectSetInteger(ChartID(),last_select_objectr,OBJPROP_RAY,True);
         }
          


}


if ( sparam == 25 ) {

if ( pause == true ) {pause=false;} else {pause=true;}

Comment("Puase:",pause);

}

if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}


if ( ObjectType(sparam) == OBJ_BUTTON ) {
string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
string tool=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);
datetime times=StringToInteger(tool);
int shift=iBarShift(Symbol(),Period(),times);

ChartSetInteger(ChartID(),CHART_AUTOSCROLL,False);

ChartNavigate(ChartID(),CHART_END,shift*-1);
//Alert(shift);
//Alert(text,"/",tool,"/",shift);
Sleep(100);
Comment(text);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);

ObjectDelete(ChartID(),"VLINESELECT");
ObjectCreate(ChartID(),"VLINESELECT",OBJ_VLINE,0,times,Ask);
ObjectSetInteger(ChartID(),"VLINESELECT",OBJPROP_WIDTH,5);

Sleep(500);
ObjectDelete(ChartID(),"VLINESELECT");


}



   
  }
//+------------------------------------------------------------------+
int ortalama_last_bar= -1;

 
int BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

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
  
   
   bar_ortalama = DivZero(bar_pip,bar_toplam)/Point;
   
   return bar_ortalama;

}
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


void CreateSinyalButton() {


//Lot=0;


  //int max_sinyal_number = 17;
  int max_sinyal_number = 14;
  
  string buttonID="";
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bs=0;bs<=max_sinyal_number;bs++){
   
   buttonID="ButtonSinyal"+bs; // Support LeveL Show
   
   string text="";
   color renk=clrGreen;
   
/*
   if ( bs ==  2 ) text ="Wick";
   if ( bs ==  0 ) text ="Eq";
   if ( bs ==  3 ) text ="Reset";
   if ( bs ==  1 ) text ="FiveZero";
   if ( bs ==  4 ) text ="Sinyal";
   if ( bs ==  5 ) text ="Buy";
   if ( bs ==  6 ) text ="Sell";
   if ( bs ==  7 ) text ="Time";
   if ( bs ==  8 ) text ="Spread";
   if ( bs ==  9 ) text ="Buy Lot";
   if ( bs ==  10 ) text ="Sell Lot";
   if ( bs ==  11 ) text ="Buy Line";
   if ( bs ==  12 ) text ="Sell Line";
   if ( bs ==  13 ) text ="Profit Alarm";
   if ( bs ==  14 ) text ="Profit Close";
   */
      
   /*
   if ( bs ==  2 ) text ="Auto";
   if ( bs ==  1 ) text ="Otomatik";
   if ( bs ==  0 ) text ="Mode";
   if ( bs ==  4 ) text ="Reset";
   if ( bs ==  5 ) text ="Wick";
   if ( bs ==  3 ) text ="Price";
   if ( bs ==  6 ) text ="Order";
   if ( bs ==  7 ) text ="Up";
   if ( bs ==  8 ) text ="Down";
   if ( bs ==  9 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT);
   if ( bs ==  10 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2;
   if ( bs ==  11 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3;
   if ( bs ==  12 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4;
   if ( bs ==  13 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5;
   if ( bs ==  14 ) text ="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2);
   if ( bs ==  15  ) text ="Aggressive";
   if ( bs ==  16  ) text ="Standart";
   if ( bs ==  17  ) text ="Defensive";
   if ( bs ==  15  ) text ="Trend";
   if ( bs ==  16  ) text ="Reserval";
   if ( bs ==  17  ) text ="Turbo";
   */
   
   //if ( bs == 10  ) renk=clrLightBlue;   
   //if ( bs == 11  ) renk=clrPink;    
   //if ( text=="Auto" && auto_mode == true ) renk=clrRed;
   //if ( text=="Otomatik" && oto_system == true ) renk=clrRed;
   //if ( text=="Mode" && mode == true ) renk=clrRed;
   /*
   if ( text=="Wick" && wick == true ) renk=clrRed;
   if ( text=="Eq" && eqsys == true ) renk=clrRed;
   if ( text=="FiveZero" && skyper == true ) renk=clrRed;
   if ( text=="Sinyal" && sinyal_sys == true ) renk=clrRed;
   if ( text=="Buy Line" && buy_line == true ) renk=clrNavy;
   if ( text=="Sell Line" && sell_line == true ) renk=clrDarkRed;
   if ( text=="Profit Close" && profit_close == true  ) renk=clrRed;
  
   if ( bs == 5  ) renk=clrNavy;
   if ( bs == 6  ) renk=clrDarkRed;
   if ( bs == 6  ) renk=clrDarkRed;
   if ( bs == 7  ) renk=clrYellowGreen;
   if ( bs == 8  ) renk=clrLightGray;
   if ( bs == 9  ) renk=clrDarkBlue;
   if ( bs == 13  ) renk=clrLimeGreen;
*/
   //if ( bs == 12  ) renk=clrDarkRed; 
   //if ( text=="Price" && price_level == true ) renk=clrDarkGreen;
   //if ( text=="Order" && order_mode == true ) renk=clrLightGray;
   //if ( text=="Down" && order_mode_buy == true ) renk=clrBlue;
   //if ( text=="Up" && order_mode_sell == true ) renk=clrOrangeRed;
/*
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT) && order_mode_one == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT);}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2 && order_mode_two == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*2;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3 && order_mode_three == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*3;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4 && order_mode_four == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*4;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5 && order_mode_five == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*5;}
   if ( text=="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2) && order_mode_six == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*10;}
   */
   /*
   if ( text=="Aggressive" && order_mode_aggressive == true ) {renk=clrRed;}
   
   if ( text=="Standart" && order_mode_standart == true ) {renk=clrRed;}
      
   if ( text=="Defensive" && order_mode_defensive == true ) {renk=clrRed;}      
   */
/*
   if ( text=="Trend" && order_mode_trend == true ) renk=clrNavy;
   if ( text=="Reserval" && order_mode_reserval == true ) renk=clrMaroon;
   if ( text=="Turbo" && order_mode_turbo == true ) renk=clrLimeGreen;
   
      */
      
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrNONE);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);  
   ObjectSetInteger(0,buttonID,OBJPROP_TIMEFRAMES,-1);  
   
    
   /* 
   if ( bs >= 5 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,150+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   
   
   if ( bs >= 7 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,180+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
      


   if ( bs >= 9 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,210+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   


   if ( bs >= 11 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,250+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
      

   if ( bs >= 13 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,270+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }   
   */
   
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
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
