//+------------------------------------------------------------------+
//|                                                    NectPanel.mq4 |
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
/*
#import "user32.dll"
void keybd_event(int bVk,int bScan,int dwFlags,int dwExtraInfo);
               int      SetWindowTextA(int hWnd,string lpString);
                  int      GetActiveWindow();
                  
#import

#define VK_RETURN 13 //ENTER key
*/



string last_select_object;
string last_object;
int ObjTotal = ObjectsTotal();
double Ortalama;

ENUM_TIMEFRAMES zaman[9];


extern int Pip=10000;
int Pips[150];
int Times[150];
string Symbols[150];
long currChart=ChartID();
datetime BarTimes[150];

int range_oran=6;

int mtop=10;
int mheight=19;


int bolum=2;
int alan=300;

#import "shell32.dll"
int ShellExecuteW(int hwnd, string Operation, string File, string Parameters, string Directory, int ShowCmd);
#import


//double m1_oran=1.5;
double m1_oran=2;

int hightouch=0;
int lowtouch=0;

bool kapsama = false;

int touch_total=3;

string headers;
char posts[],post[], result[];


bool lock=true; 
//string last_object="";
bool otomatik = true;


//int ObjTotal = ObjectsTotal(ChartID(),0,-1);


//string last_select_object = "";

datetime refresh_time;
bool first_time=false;

int start_bar=1133;


int alert_limit_bar=100;

bool desktop_alert = true; // Desktop Mode

//int left_bar_total=10;
//int right_bar_total=4;

extern int left_bar_total=6;
extern int right_bar_total=4;


bool first_time_alert = false;
datetime first_time_alert_time;
int select_per = Period();  


int carpan=8;
int carpans=5;
int carpann=10;

//bool single_mode=true;
bool single_mode=false;
bool merge_mode=false;
bool nect_mode=false;
bool flag_mode=false;
//bool bigbar_mode=true;
bool rsi_mode=false;
bool spike_mode=false;
bool fvg_mode=true;
bool superma_mode=false;
bool sfp_mode=false;


int OnInit()
  {
  /*
 keybd_event(VK_RETURN,0,0,0);
 SetWindowTextA(GetActiveWindow(),"2023.1.5 09:45");
 
  
  return 0;*/
  
  
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
   EventSetTimer(60);
   
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;
  
  
  //if ( nect_mode == true ) carpann=10;
  
   
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();
   if ( fvg_mode == true ) FvgEngine();
   if ( superma_mode == true ) SuperMaEngine();
   if ( sfp_mode == true ) SfpEngine();
   
   
   

string bilgiler="";


string filenames="bigbar";
filenames="Range\\"+filenames+".txt";


   string str,word;
   int handle = FileOpen(filenames,FILE_READ|FILE_TXT);

//if(handle==-1)return(0);// if not exist
//if(FileSize(handle)==0){FileClose(handle); return(0); } //if empty

int x=0;
//string bilgiler="";
while(!FileIsEnding(handle))//read file to the end by paragraph. if you have only one string, omit it
   {
   str=FileReadString(handle);//read one paragraph to the string variable
   if(str!="")//if string not empty
      {
      x=x+1;
      //Print(x,"/",str);
      bilgiler=bilgiler+str+"\r\n";
      
      }
      }
      
      
      FileClose(handle); //close file
      

//Alert(bilgiler);   
   
   
   bilgiler="";
   
   
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

datetime last_time = Time[0];

void OnTimer()
  {
//---

if ( spike_mode == true ) {
if ( last_time != Time[0] ) {
 ObjectsDeleteAll();
 List();
 SpikeEngine();
 last_time=Time[0];
 }
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


if ( sparam == 19 ) {


ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();
   if ( superma_mode == true ) SuperMaEngine();
   if ( fvg_mode == true ) FvgEngine();
   if ( sfp_mode == true ) SfpEngine();

}






if ( int(sparam) > 1 && int(sparam) <= 10 ) {

   if ( single_mode == true ) carpans=sparam;
   if ( merge_mode == true ) carpan=sparam;
   if ( nect_mode == true ) carpann=sparam;
   if ( rsi_mode == true ) carpann=sparam;
   
   if ( single_mode == true )  Print("Single Çarpan:",sparam);
   if ( merge_mode == true )  Print("Merge Çarpan:",sparam);
   if ( nect_mode == true )  Print("Nect Çarpan:",sparam);
   if ( rsi_mode == true ) Print("Nect Çarpan:",sparam);

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();

}




if ( sparam == 33 ) {

if ( flag_mode == true ) {flag_mode=False;} else {flag_mode=True;}

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();

}






if ( sparam == 31 ) {

if ( single_mode == true ) {single_mode=False;} else {single_mode=True;}

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();
}




if ( sparam == 50 ) {

if ( merge_mode == true ) {merge_mode=False;} else {merge_mode=True;}

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();

}


if ( sparam == 49 ) {

if ( nect_mode == true ) {nect_mode=False;} else {nect_mode=True;}

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();
}


if ( sparam == 17 ) {

if ( spike_mode == true ) {spike_mode=False;} else {spike_mode=True;}

ObjectsDeleteAll();
   List();
 
   if ( single_mode == true ) Engine();
   if ( merge_mode == true ) EngineMerge();
   if ( nect_mode == true ) NectEngine();
   if ( flag_mode == true ) FlagEngine();
   if ( rsi_mode == true ) RsiEngine();
   if ( spike_mode == true ) SpikeEngine();
}









   string obj_id = sparam;
   int indexb = StringFind(sparam,"Buton", 0); 
   if ( indexb != -1 ) { 
   int replaced=StringReplace(obj_id,"Buton","");
   int obj_num = StringToInteger(obj_id);
   
   //Alert(ObjectGetString(ChartID(),"Per"+obj_num,OBJPROP_TEXT,0));
   
   
   select_per=StringToInteger(ObjectGetString(ChartID(),"Per"+obj_num,OBJPROP_TEXT,0));
   
   
   Sleep(500);
   ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
   //ChartOpen(Symbols[obj_num],Times[obj_num]);
   
   //Alert(ChartNext(ChartFirst()));
   
   long ChartIDO;
   if ( ChartNext(ChartFirst()) == -1 ) {
   ChartIDO=ChartOpen(Symbols[obj_num],select_per);
   } else {
   ChartIDO=ChartNext(ChartFirst());
   ChartSetSymbolPeriod(ChartIDO,Symbols[obj_num],select_per);
   }
   
   ObjectCreate(ChartIDO,"range_oran",OBJ_HLINE,0,Time[0],MarketInfo(Symbols[obj_num],MODE_BID));
   ObjectSetString(ChartIDO,"range_oran",OBJPROP_TOOLTIP,range_oran);
   ObjectSetString(ChartIDO,"range_oran",OBJPROP_TEXT,range_oran);
   
   //string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
   

   
   
   }
   
   
   int indexba = StringFind(sparam,"Bar", 0); 
   int indexbp = StringFind(sparam,"BarPer", 0); 

   
   
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL && indexbp != -1 ) {




string filenames="bigbar";
filenames="Range\\"+filenames+".txt";


   string str,word;
   int handle = FileOpen(filenames,FILE_READ|FILE_TXT);

//if(handle==-1)return(0);// if not exist
//if(FileSize(handle)==0){FileClose(handle); return(0); } //if empty

int x=0;
string bilgiler="";
while(!FileIsEnding(handle))//read file to the end by paragraph. if you have only one string, omit it
   {
   str=FileReadString(handle);//read one paragraph to the string variable
   if(str!="")//if string not empty
      {
      x=x+1;
      //Print(x,"/",str);
      bilgiler=bilgiler+str+"\r\n";
      
      }
      }
      
      
      FileClose(handle); //close file
      
string bilgi=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT,0);
string tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP,0);

//Alert(tooltip);




   string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(bilgi,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   
   
   string select_sym = results[0];
   int select_per = results[1];
   string time = results[2];
   int finish_shift = results[3];
   int type_model = results[4];
   //int shift = results[3];

   //Alert(sym,"/",per,"/",StringToTime(time));
   
   //Alert(type_model,"/",finish_shift);
   
   
   int shifts=iBarShift(select_sym,select_per,StringToTime(time));
   
   //Alert(shifts,"/",shift);   
   //Alert(shifts,"/",select_per,"/",time);   
   
   
    int height=ChartGetInteger(ChartFirst(),CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(ChartFirst(),CHART_WIDTH_IN_PIXELS,0);
   
   //Alert(width+"/"+height);
   
   
     //int cevaps=MessageBox("Mt4","Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     int cevaps=6;
     if ( cevaps == 6 ) {   
   
   //long ChartIDO=ChartOpen(select_sym,select_per);
   long ChartIDO;
   //if ( ChartNext(ChartFirst()) == -1 ) {
   ChartIDO=ChartOpen(select_sym,select_per);
   //} else {
   
  /* ChartIDO=ChartNext(ChartFirst());
   ChartSetSymbolPeriod(ChartIDO,select_sym,select_per);
   ChartSetInteger(ChartIDO,CHART_BRING_TO_TOP,0,true); // ilk 
   //}*/
   

   ObjectCreate(ChartIDO,"range_oran",OBJ_HLINE,0,Time[0],MarketInfo(select_sym,MODE_ASK));
   ObjectSetString(ChartIDO,"range_oran",OBJPROP_TOOLTIP,range_oran); 
   ObjectSetString(ChartIDO,"range_oran",OBJPROP_TEXT,range_oran); 
   //ChartRedraw(ChartIDO);
   

   //Time[shifts]
   
   if ( finish_shift == -1 ) {
   ObjectCreate(ChartIDO,"range_time",OBJ_VLINE,0,StringToTime(time),MarketInfo(select_sym,MODE_ASK));
   ObjectSetString(ChartIDO,"range_time",OBJPROP_TOOLTIP,range_oran); 
   ObjectSetInteger(ChartIDO,"range_time",OBJPROP_WIDTH,2); 
   ObjectSetInteger(ChartIDO,"range_time",OBJPROP_COLOR,clrLightBlue); 
   ObjectSetInteger(ChartIDO,"range_time",OBJPROP_BACK,true); 
   ChartRedraw(ChartIDO);
   }
      
   
   if ( finish_shift != -1 ) {

   if ( type_model == 2 ) ObjectCreate(ChartIDO,"range_times",OBJ_RECTANGLE,0,iTime(select_sym,select_per,shifts),iHigh(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iLow(select_sym,select_per,finish_shift));
   if ( type_model == 3 ) ObjectCreate(ChartIDO,"range_times",OBJ_RECTANGLE,0,iTime(select_sym,select_per,shifts),iLow(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iHigh(select_sym,select_per,finish_shift));
   //if ( type_model == 4 ) ObjectCreate(ChartIDO,"range_times",OBJ_TREND,0,iTime(select_sym,select_per,shifts),iHigh(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iLow(select_sym,select_per,finish_shift));
   //if ( type_model == 5 ) ObjectCreate(ChartIDO,"range_times",OBJ_TREND,0,iTime(select_sym,select_per,shifts),iLow(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iHigh(select_sym,select_per,finish_shift));   
   //if ( type_model == 6 ) ObjectCreate(ChartIDO,"range_times",OBJ_TREND,0,iTime(select_sym,select_per,shifts),iHigh(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iLow(select_sym,select_per,finish_shift));
   //if ( type_model == 7 ) ObjectCreate(ChartIDO,"range_times",OBJ_TREND,0,iTime(select_sym,select_per,shifts),iLow(select_sym,select_per,shifts),iTime(select_sym,select_per,finish_shift),iHigh(select_sym,select_per,finish_shift));         
   /*ObjectSetString(ChartIDO,"range_times",OBJPROP_TOOLTIP,range_oran); 
   ObjectSetInteger(ChartIDO,"range_times",OBJPROP_WIDTH,2); 
   ObjectSetInteger(ChartIDO,"range_times",OBJPROP_COLOR,clrLightBlue); 
   ObjectSetInteger(ChartIDO,"range_times",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,"range_times",OBJPROP_RAY,false); */
   ChartRedraw(ChartIDO);
   
   if ( type_model == 4 || type_model == 5 || type_model == 6 || type_model == 7) {
   
   //Alert("Selam",type_model,"/",shifts);
   
   
   int i=shifts;
   
   ChartSetInteger(ChartIDO,CHART_AUTOSCROLL,false);
   
   //Sleep(500);
   
   
   
   
   string sym=select_sym;
   ENUM_TIMEFRAMES per=select_per;
   
   
   
   if ( type_model == 5 ) {
   
   
   string sym=select_sym;
   ENUM_TIMEFRAMES per=select_per;
   
  int shift=i;
  double high_price=iHigh(sym,per,shift);
  double low_price=iLow(sym,per,shift);
  double open_price=iOpen(sym,per,shift);
  double close_price=iClose(sym,per,shift);
  
  int shifts=i-1;
  double high_prices=iHigh(sym,per,shifts);
  double low_prices=iLow(sym,per,shifts);
  double open_prices=iOpen(sym,per,shifts);
  double close_prices=iClose(sym,per,shifts);   

string last_select_objectr="WDoji"+i;


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+10*PeriodSeconds(per),high_price);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+10*PeriodSeconds(per),low_price);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=10;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),high_prices,iTime(sym,per,i-1)+10*PeriodSeconds(per),high_prices);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=11;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),low_prices,iTime(sym,per,i-1)+10*PeriodSeconds(per),low_prices);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=20;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( high_prices > high_price ) ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),high_prices,iTime(sym,per,i-1)+10*PeriodSeconds(per),high_prices);
if ( high_price > high_prices ) ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i),high_price,iTime(sym,per,i)+10*PeriodSeconds(per),high_price);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=21;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( low_prices < low_price ) ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),low_prices,iTime(sym,per,i-1)+10*PeriodSeconds(per),low_prices);
if ( low_price < low_prices ) ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i),low_price,iTime(sym,per,i)+10*PeriodSeconds(per),low_price);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

double hprice;
if ( high_prices > high_price ) hprice=high_prices;
if ( high_price > high_prices ) hprice=high_price;

double lprice;
if ( low_prices < low_price ) lprice=low_prices;
if ( low_price < low_prices ) lprice=low_price;

double yuzde=DivZero(hprice-lprice,100);

levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),lprice-levels*yuzde,iTime(sym,per,i-1)+10*PeriodSeconds(per),lprice-levels*yuzde);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=13.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartIDO,last_select_objectr+"Exp"+level);
//ObjectCreate(ChartIDO,last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartIDO,last_select_objectr+"Exp"+level,OBJ_TREND,0,iTime(sym,per,i-1),hprice+levels*yuzde,iTime(sym,per,i-1)+10*PeriodSeconds(per),hprice+levels*yuzde);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartIDO,last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);   
   
   
   
   
   
   return;
   
   }
   
   
   
   
   

 double high_price=iHigh(sym,per,shifts-1);
   double low_price=iLow(sym,per,shifts-1);
   double open_price=iOpen(sym,per,shifts-1);
   double close_price=iClose(sym,per,shifts-1);
   datetime time_date=iTime(sym,per,shifts-1);
   
   double high_low_yuzde=DivZero((high_price-low_price),100);
   
   double fark=0;
   double ust_fark=0;
   double alt_fark=0;
  /* if ( open_price > close_price ) {   
   fark=open_price-close_price;      
   ust_fark=high_price-open_price;
   alt_fark=close_price-low_price;
   }
   if ( close_price > open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
   
   if ( close_price == open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }*/
   
   double up_price=0;
   double down_price=0;
   
   if ( open_price > close_price ) {   
   fark=open_price-close_price;      
   ust_fark=high_price-open_price;
   alt_fark=close_price-low_price;
   up_price=open_price;
   down_price=close_price;
   }
   if ( close_price > open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   up_price=close_price;
   down_price=open_price;   
   }
   
   if ( close_price == open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   up_price=open_price;
   down_price=close_price;   
   }     
      
           
   double govde_yuzde=DivZero(fark,high_low_yuzde);
   
   double ust_yuzde=DivZero(ust_fark,high_low_yuzde);
   double alt_yuzde=DivZero(alt_fark,high_low_yuzde);
   
   double eq_price=low_price+high_low_yuzde*50;   
   
  // datetime time_date=iTime,select_sym,select_per,shifts-1);
   

   string name="F";
   ObjectCreate(ChartIDO,name,OBJ_VLINE,0,time_date,Ask);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,govde_yuzde);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrLimeGreen);
   //ObjectDelete(ChartIDO,name);
   
   name="FER";
   ObjectCreate(ChartIDO,name,OBJ_RECTANGLE,0,time_date,high_price,time_date+1*PeriodSeconds(per),low_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,govde_yuzde);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false);   
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrKhaki);   
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   

   name="ELow";
   ObjectCreate(ChartIDO,name,OBJ_TREND,0,time_date,low_price,time_date+10*PeriodSeconds(per),low_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,eq_price);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); 
      
   
   name="EHigh";
   ObjectCreate(ChartIDO,name,OBJ_TREND,0,time_date,high_price,time_date+10*PeriodSeconds(per),high_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,eq_price);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); 
   

   name="E";
   ObjectDelete(ChartIDO,name);
   ObjectCreate(ChartIDO,name,OBJ_TREND,0,time_date,eq_price,time_date+100*PeriodSeconds(per),eq_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,eq_price);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); 
   
/*
   name="EUp";
   ObjectCreate(ChartIDO,name,OBJ_TREND,0,time_date,up_price,time_date+10*PeriodSeconds(),up_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,eq_price);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); 
      
   
   name="EDown";
   ObjectCreate(ChartIDO,name,OBJ_TREND,0,time_date,down_price,time_date+10*PeriodSeconds(),down_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,eq_price);
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); */
      
   name="EBody";
   ObjectCreate(ChartIDO,name,OBJ_RECTANGLE,0,time_date+1*PeriodSeconds(per),up_price,time_date+10*PeriodSeconds(per),down_price);
   ObjectSetString(ChartIDO,name,OBJPROP_TOOLTIP,"Body");
   ObjectSetInteger(ChartIDO,name,OBJPROP_BACK,true); 
   ObjectSetInteger(ChartIDO,name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartIDO,name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartIDO,name,OBJPROP_RAY,false); 
      
   
   
   ChartRedraw(ChartIDO);
   
   //Alert(shifts);117733
   
   //ChartNavigate(ChartIDO,CHART_END,shifts);
   
   }   
   
   
   
   
   if ( type_model == 66 ) {


double higs=iHigh(select_sym,select_per,shifts);
double lows=iLow(select_sym,select_per,finish_shift);
int i=shifts;


double price50=lows+(higs-lows)/2;

double yuzde=(higs-lows)/100;


double price272=higs+(yuzde*27.2);

    ObjectDelete(ChartIDO,"OB272"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price272,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price272);
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrNavy);     
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  

double price414=higs+(yuzde*41.4);;

    ObjectDelete(ChartIDO,"OB414"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price414,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price414);
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  
    
        
    
    
    ObjectDelete(ChartIDO,"OBC"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price50,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price50);
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrChartreuse);     
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
/*
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i),iOpen(select_sym,select_per,i),iTime(select_sym,select_per,i)+200*PeriodSeconds(select_per),iOpen(select_sym,select_per,i));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  */

if ( iOpen(select_sym,select_per,finish_shift) > iClose(select_sym,select_per,finish_shift) ) {
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift),iOpen(select_sym,select_per,finish_shift),iTime(select_sym,select_per,finish_shift)+200*PeriodSeconds(select_per),iOpen(select_sym,select_per,finish_shift));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
} else {

if ( iOpen(select_sym,select_per,finish_shift+1) > iClose(select_sym,select_per,finish_shift+1) ) {
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift+1),iOpen(select_sym,select_per,finish_shift+1),iTime(select_sym,select_per,finish_shift+1)+200*PeriodSeconds(select_per),iOpen(select_sym,select_per,finish_shift+1));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
}
}




    
   
   }
   
   
   
   

   if ( type_model == 77 ) {
   
   //Alert("Kırmızı");

double higs=iHigh(select_sym,select_per,finish_shift);
double lows=iLow(select_sym,select_per,shifts);
int i=shifts;


double price50=lows+(higs-lows)/2;

double yuzde=(higs-lows)/100;


double price272=lows-(yuzde*27.2);

    ObjectDelete(ChartIDO,"OB272"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price272,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price272);
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrNavy);     
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartIDO,"OB272"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  

double price414=lows-(yuzde*41.4);;

    ObjectDelete(ChartIDO,"OB414"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price414,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price414);
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartIDO,"OB414"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  
    
        
    
    
    ObjectDelete(ChartIDO,"OBC"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price50,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(select_per),price50);
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrChartreuse);     
    ObjectSetInteger(ChartIDO,"OBC"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  

/*
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift+1),iOpen(select_sym,select_per,finish_shift+1),iTime(select_sym,select_per,finish_shift+1)+200*PeriodSeconds(),iOpen(select_sym,select_per,finish_shift+1));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2); */ 
    

if ( iClose(select_sym,select_per,finish_shift) > iOpen(select_sym,select_per,finish_shift) ) {
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift),iOpen(select_sym,select_per,finish_shift),iTime(select_sym,select_per,finish_shift)+200*PeriodSeconds(select_per),iOpen(select_sym,select_per,finish_shift));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
} else {

if ( iClose(select_sym,select_per,finish_shift+1) > iOpen(select_sym,select_per,finish_shift+1) ) {
    ObjectCreate(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift+1),iOpen(select_sym,select_per,finish_shift+1),iTime(select_sym,select_per,finish_shift+1)+200*PeriodSeconds(select_per),iOpen(select_sym,select_per,finish_shift+1));
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartIDO,"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
}
}
    
    
    

   
   }
   
      
   
   
   
   
   
   
   
   
   
   
   
      
   
   }
   
   
   
   
   }
   
   
string path = SymbolInfoString(select_sym,SYMBOL_PATH);
//Alert(select_sym+"/"+path);
   //symbolType(select_sym)
   //if ( MarketInfo(pairs[i],MODE_PROFITCALCMODE) == 0 ) {
   if ( StringFind(path,"Crypto",0) != -1 ) select_sym=select_sym+"TPERP";
   
   int rep=StringReplace(select_sym,"#","");
   
   int market_type = MarketInfo(select_sym,MODE_PROFITCALCMODE);   

    if ( StringFind(path,"Crypto",0) != -1 ) {
     int cevap=MessageBox("TradingView "+select_sym,"Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     
     Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+select_sym+"&interval="+select_per, "", "", 3);
     
     }; 
     };
     
   

   }
   
   

if ( StringFind(bilgiler,bilgi,0) == -1 ) {

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),sparam,OBJPROP_BGCOLOR,clrBlack);
//Alert(sparam,"/ Bilgi:",bilgi);

string filename="bigbar";
filename="Range\\"+filename+".txt";

bilgiler=bilgiler+bilgi;

          int fileHandle     =    FileOpen(filename , FILE_WRITE|FILE_TXT);
          FileWriteString(fileHandle,bilgiler);  
          FileClose(fileHandle); 
          Print("Write to Existing File Completed");
          //fileHandle,fibo_level+"\r\n"+fibo_color+"\r\n"+fibo_line+"\r\n"+fibo_name

}
   


}
   
   

   if ( indexba != -1 && indexbp == -1 ) { 
   int replaced=StringReplace(obj_id,"Bar0-","");
       replaced=+StringReplace(obj_id,"Bar1-","");
       replaced=+StringReplace(obj_id,"Bar2-","");
       replaced=+StringReplace(obj_id,"Bar3-","");
       replaced=+StringReplace(obj_id,"Bar4-","");
       replaced=+StringReplace(obj_id,"Bar5-","");
       
   if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE_LABEL ) {
   
   string select_sym = ObjectGetString(ChartID(),"Buton"+obj_id,OBJPROP_TEXT);
   
   //Alert(select_sym);
   
   string time_str=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);
   StringReplace(time_str,"/"+select_sym,"");   
   int select_per = StrtoTF(time_str);
   ObjectSetString(ChartID(),"Per"+obj_id,OBJPROP_TEXT,select_per);
   Ortalama=BarOrtalama(1,300,select_sym,select_per);
   ObjectSetString(ChartID(),"Pip"+obj_id,OBJPROP_TEXT,Ortalama/MarketInfo(select_sym,MODE_POINT));
   
   
   
   //Alert(time_str,"/",select_per,"/",obj_id,"/",select_sym);   
   
   /*
     int cevaps=MessageBox("Mt4","Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevaps == 6 ) {   
   
   long ChartIDO=ChartOpen(select_sym,select_per);

   ObjectCreate(ChartIDO,"range_oran",OBJ_HLINE,0,Time[0],MarketInfo(select_sym,MODE_ASK));
   ObjectSetString(ChartIDO,"range_oran",OBJPROP_TOOLTIP,range_oran); 
   ChartRedraw(ChartIDO);
   
   }
   
   
   int rep=StringReplace(select_sym,"#","");

     int cevap=MessageBox("TradingView","Open Chart",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     Shell32::ShellExecuteW(0, "open", "https://www.tradingview.com/chart/?symbol="+select_sym+"&interval="+select_per, "", "", 3);
     }; */
     
   
   
   
   
   
   
   
   }
   
   }   
   
   
  }
//+------------------------------------------------------------------+


int price_level(string sym,int per,int shift) {


double high_price=iHigh(sym,per,shift);
double low_price=iLow(sym,per,shift);
int high_shift=shift;
int low_shift=shift;



for ( int d=shift;d>=0;d--) {

if ( iHigh(sym,per,d) > high_price ) {
high_price=iHigh(sym,per,d);
high_shift=d;
}

if (iLow(sym,per,d) < low_price ) {
low_price=iLow(sym,per,d);
low_shift=d;
}



}


 double yuzde=DivZero((high_price-low_price),100);
 double price=DivZero((MarketInfo(sym,MODE_BID)-low_price),yuzde);
 
return price;


}


  
void List() {


   string LabelChartR="Renk";
   string LabelChartP="Pip";
   string Tsym = "GBPCHF+";
       Tsym = "";
string sym="";       
       //if ( !SERVER_MODE ) Tsym = Symbol();
       
       if ( IsTesting() ) Tsym = Symbol();
       

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      sym=pairswl[iwl];
      //Print(sym);
      int t=iwl;
      
      Symbols[t]=sym;
      Pips[t]=Pip;
      BarTimes[t]=-1;
      Times[t]=Period();
  //for (int t=0;t<=buton_sayisi;t++) {}

     
     LabelChartR="Buton"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,sym);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrOliveDrab);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 5);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 60); 
     //ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);+(t*80)
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);


     LabelChartP="Per"+t;
     if ( ObjectFind(ChartID(),LabelChartP)==-1 ) {
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Period());
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkRed);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 70);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 20); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Per");
     }

double RSI = 0.0;

//70 te %1 85 ve 90 üzerinde %2 şer olarak

        //int iShift = iBarShift(Symbol(), PERIOD_H1, Time[0], false);
        //int iShift = iBarShift(Symbol(), PERIOD_CURRENT, Time[0], false);
        int iShift = iBarShift(Symbol(), PERIOD_D1, iTime(sym,PERIOD_D1,0), false);
        
        RSI = iRSI(sym, PERIOD_D1, 14, PRICE_CLOSE, iShift);
        //RSI = iRSI(NULL, PERIOD_CURRENT, RSILength, PRICE_CLOSE, iShift);
        

     LabelChartP="Pip"+t;     
     if ( ObjectFind(ChartID(),LabelChartP)== -1 ) {
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 95);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 30); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Pip");
     }
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,DoubleToString(RSI,0));
     




     
 int prc_level0=price_level(sym,zaman[0],300);
     
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     //Profit=ObjectGetString(ChartID(),"ProfitVol",OBJPROP_TEXT,0);  
     int barpip=(iHigh(sym,Period(),1)-iLow(sym,Period(),1))/MarketInfo(sym,MODE_POINT);
     if (barpip==0)barpip=1;
     LabelChartP="Bar0-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[0])+"/"+sym+"/"+prc_level0);
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);  

    
     CreateLevelIndicator(1,sym,zaman[0],0,iwl,0,prc_level0,clrBlue);     
     

 int prc_level1=price_level(sym,zaman[1],300);
     
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     //Profit=ObjectGetString(ChartID(),"ProfitVol",OBJPROP_TEXT,0);       
     LabelChartP="Bar1-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*1));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 300); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[1])+"/"+sym+"/"+prc_level1); 
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);      

CreateLevelIndicator(1,sym,zaman[1],1,iwl,0,prc_level1,clrRed);     


 int prc_level2=price_level(sym,zaman[2],300);
    

     LabelChartP="Bar2-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*2));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[2])+"/"+sym+"/"+prc_level1);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true); 
     

CreateLevelIndicator(1,sym,zaman[2],2,iwl,0,prc_level2,clrLimeGreen);     

 int prc_level3=price_level(sym,zaman[3],300);
     
     
     LabelChartP="Bar3-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*3));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[3])+"/"+sym+"/"+prc_level3);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);    

CreateLevelIndicator(1,sym,zaman[3],3,iwl,0,prc_level3,clrMaroon);     


 int prc_level4=price_level(sym,zaman[4],300);
    

     LabelChartP="Bar4-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*4));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[4])+"/"+sym+"/"+prc_level4);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);    

CreateLevelIndicator(1,sym,zaman[4],4,iwl,0,prc_level4,clrMagenta);     


 int prc_level5=price_level(sym,zaman[5],300);
   
   

     LabelChartP="Bar5-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*5));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[5])+"/"+sym+"/"+prc_level5);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);    
             
CreateLevelIndicator(1,sym,zaman[5],5,iwl,0,prc_level5,clrNavy);     


int prc_level6=price_level(sym,zaman[6],300);
                          
     LabelChartP="Bar6-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*6));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[6])+"/"+sym+"/"+prc_level6);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);   

CreateLevelIndicator(1,sym,zaman[6],6,iwl,0,prc_level6,clrLightGray);     


     
     LabelChartP="Bar7-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*7));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[7])+"/"+sym);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);   
     
     LabelChartP="Bar8-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*8));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(t*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, alan/bolum); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,TFtoStr(zaman[8])+"/"+sym);   
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);   
                                         

    /* LabelChartP="Bar3-"+t;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,barpip);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 770);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 45+(t*25));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 3); 
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YSIZE, 15); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Pip");   */
          
     
}



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
  
  
  


string spike_sinyal="";

void SpikeEngine() {

bool sonuc=false;


string Comment_Line = "";

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
    
  int prc_level=price_level(sym,per,300);  
    
  double bar_ortalama=BarOrtalama(1,300,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   for (int t=0;t<3;t++) {
   /*
   string LabelChartP=sym+"BarPer0-"+per+"-"+t;   
   ObjectDelete(ChartID(),LabelChartP);*/
   


   double c=1.3;

//if ( Close[t] >= eq_price && side == "HIGH"
//if ( prc_level >= 50 ) {
if ( prc_level >= 0 ) {

   if ( (iOpen(sym,per,t) > Close[t] && iHigh(sym,per,t)-iOpen(sym,per,t) > bar_ortalama*c) || (iOpen(sym,per,t) < iClose(sym,per,t) && iHigh(sym,per,t)-iClose(sym,per,t) > bar_ortalama*c)// ||
   
   //(Open[t] > Close[t] && Close[t]-Low[t] > bar_ortalama*c) || (Open[t] < Close[t] && Open[t]-Low[t] > bar_ortalama*c)
   
   ) {
   
   
   bool find=false;
   for ( int b=t+1;b<t+15;b++) {

   //Print("B:",b);
   
   if ( iHigh(sym,per,b) > iHigh(sym,per,t) ) {
   find=true;
   sonuc=false;
   }
   
   }  
    
   if ( find == false ) {   
   
    CreateIndicator(t,sym,per,z,iwl,1,-1);
    
    //|| t== 0
    if ( t==1  ) {
    
    string sinyal=sym+"BarPer0-"+per+"-"+t;
    
    if ( StringFind(spike_sinyal,sinyal,0) == -1  && per >= PERIOD_M15 ) {    
    
  if ( per == PERIOD_W1 && DayOfWeek()!=1 ) continue;
  if ( per == PERIOD_MN1 && Day()!=1 ) continue;
  if ( per == PERIOD_H1 && TimeMinute(TimeCurrent())> 10 ) continue;   
  if ( per == PERIOD_H4 && TimeMinute(TimeCurrent())> 15 ) continue;  
  if ( per == PERIOD_M15 && TimeMinute(TimeCurrent())> 5 ) continue;    
  
double ttc = iTime(sym,per,0) + per*60 - TimeCurrent();

double toplam_zaman=per*60;
double toplam_zaman_yuzde=DivZero(toplam_zaman,100);
double gecen_zaman = toplam_zaman-ttc;
double gecen_zaman_yuzde = DivZero(gecen_zaman,toplam_zaman_yuzde);


//Comment("Kalan Zaman:",ttc," / Toplam Zaman:",toplam_zaman,"/ Geçen Zaman:",gecen_zaman," toplam_zaman_yuzde:",toplam_zaman_yuzde,"gecen_zaman_yuzde:",DoubleToString(gecen_zaman_yuzde,0));


       if ( gecen_zaman_yuzde > 28 && per == PERIOD_W1 ) continue;
       if ( gecen_zaman_yuzde > 15 && per != PERIOD_W1 ) continue;
     
    
    spike_sinyal=spike_sinyal+" "+sinyal;    
    Alert("Spike:",sym," ",TFtoStr(per)," ",t);  
    
    
    bool chart_open=ChartControl(sym,per);

    
    if ( chart_open == false ) {
    
  
    
    
    long ChartIDN=ChartOpen(sym,per);

      ObjectCreate(ChartIDN,"VLINE"+iTime(sym,per,t),OBJ_VLINE,0,iTime(sym,per,t),MarketInfo(sym,MODE_ASK));   
      ObjectSetInteger(ChartIDN,"VLINE"+iTime(sym,per,t),OBJPROP_BACK,true);
      /*
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_RAY,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_SELECTABLE,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_COLOR,clrBlue);*/
      
      ObjectsDeleteAll(ChartIDN,WindowOnDropped(),OBJ_ARROW);

    }
    
    
    }
    
    }
   

   
   
   
   sonuc=true;
   
   }
   
   
   }  else {
   
   sonuc=false;
   
   } 
   

}


//if ( Close[t] <= eq_price && side == "LOW" ) {
//if ( prc_level <= 50 ) {
if ( prc_level <= 150 ) {


   if ( //(Open[t] > Close[t] && High[t]-Open[t] > bar_ortalama*c) || (Open[t] < Close[t] && High[t]-Close[t] > bar_ortalama*c) ||
   
   (iOpen(sym,per,t) > iClose(sym,per,t) && iClose(sym,per,t)-iLow(sym,per,t) > bar_ortalama*c) || (iOpen(sym,per,t) < iClose(sym,per,t) && iOpen(sym,per,t)-iLow(sym,per,t) > bar_ortalama*c)
   
   ) {


   bool find=false;
   for ( int b=t+1;b<t+15;b++) {

   //Print("B:",b);
   
   if ( iLow(sym,per,b) < iLow(sym,per,t) ) {
   find=true;
   sonuc=false;
   }
   
   }
  
  
  

  
  
   if ( find == false ) {  
   
    CreateIndicator(t,sym,per,z,iwl,0,-1);
    //|| t== 0
    if ( t==1 ) {
    
    string sinyal=sym+"BarPer0-"+per+"-"+t;
    
    if ( StringFind(spike_sinyal,sinyal,0) == -1 && per >= PERIOD_M15 ) {   
    
  if ( per == PERIOD_W1 && DayOfWeek()!=1 ) continue;
  if ( per == PERIOD_MN1 && Day()!=1 ) continue;    
  if ( per == PERIOD_H1 && TimeMinute(TimeCurrent())> 10 ) continue;   
  if ( per == PERIOD_H4 && TimeMinute(TimeCurrent())> 15 ) continue;  
  if ( per == PERIOD_M15 && TimeMinute(TimeCurrent())> 5 ) continue;  
  
double ttc = iTime(sym,per,0) + per*60 - TimeCurrent();

double toplam_zaman=per*60;
double toplam_zaman_yuzde=DivZero(toplam_zaman,100);
double gecen_zaman = toplam_zaman-ttc;
double gecen_zaman_yuzde = DivZero(gecen_zaman,toplam_zaman_yuzde);


       if ( gecen_zaman_yuzde > 28 && per == PERIOD_W1 ) continue;
       if ( gecen_zaman_yuzde > 15 && per != PERIOD_W1 ) continue;
       

    spike_sinyal=spike_sinyal+" "+sinyal;    
    Alert("Spike:",sym," ",TFtoStr(per)," ",t);   
    
    bool chart_open=ChartControl(sym,per);
    
    if ( chart_open == false ) {
    
 
    
    long ChartIDN=ChartOpen(sym,per);

      ObjectCreate(ChartIDN,"VLINE"+iTime(sym,per,t),OBJ_VLINE,0,iTime(sym,per,t),MarketInfo(sym,MODE_ASK));   
      ObjectSetInteger(ChartIDN,"VLINE"+iTime(sym,per,t),OBJPROP_BACK,true);
      /*ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_RAY,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_SELECTABLE,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartIDN,"VLINE"+Time[t],OBJPROP_COLOR,clrBlue);*/

      ObjectsDeleteAll(ChartIDN,WindowOnDropped(),OBJ_ARROW);
      

    }    
    
    }
    
    }    
   
         
     sonuc=true;

}      
   
   
   
   }  else {
   
   sonuc=false;
   
   } 
   
   
   }
   
  
   
   
   
  /* double RSI = iRSI(sym, per, 12, PRICE_CLOSE, i);
     
   //int sonuc=BigBarControl(i,sym,per,z,iwl);
   
   if ( RSI <= 22 ) CreateIndicator(i,sym,per,z,iwl,0,-1);
   if ( RSI >= 78 ) CreateIndicator(i,sym,per,z,iwl,1,-1);*/
   
   /*if ( i > 50 ) {
   sonuc = MergeOrtalama(i,sym,per,z,iwl);
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc);
   }*/


   
   
   
   }
  
  
  
  }
  
  }
  



}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Connect
/////////////////////////////////////////////////////////////////////////////////////////////////////////

void Connect() {

double connect_oran=2.7;

string Comment_Line = "";

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string sym=pairswl[iwl];
      ENUM_TIMEFRAMES per=Period();
      //Print(sym);
      bool bigbar=false;
      
      
      double Points=MarketInfo(sym,MODE_POINT);
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  //if ( z > 4 ) continue;
  
  per=zaman[z];
  
  int bar_ortalama_bar=300;
  
  if ( per > PERIOD_H4 ) bar_ortalama_bar=30;
  
  
  
 double Ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  

for (int i=300;i>0;i--) {




if ( iClose(sym,per,i+1) > iOpen(sym,per,i+1) && iOpen(sym,per,i+2) > iClose(sym,per,i+2) ) {

bool find=false;
int say=0;
int shift=i+2;
bool find_big=false;

for ( int b=i+2;b<i+10;b++) {

if ( find == false ) {
if ( iOpen(sym,per,b) > iClose(sym,per,b) //&& High[b] < Close[i+2]
 ) {
 
 if ( DivZero((iOpen(sym,per,b)-iClose(sym,per,b)),Ortalama) >= connect_oran ) find_big=true;
 
say=say+1;
} else {
shift=b;
find=true;
}
}
}


if ( say==1 && iLow(sym,per,i+3) < iLow(sym,per,i+2) ) {
continue;
}

bool finds=false;
int says=0;
int shifts=i+1;

for ( int b=i+1;b>i-10;b--) {

if ( b < 1 ) continue;

if ( finds == false ) {
if ( iClose(sym,per,b) > iOpen(sym,per,b) ) {
if ( iOpen(sym,per,shift) > iClose(sym,per,b) && iOpen(sym,per,shift) > iHigh(sym,per,b)   ) {
says=says+1;
shifts=b;
}
} else {
finds=true;
}
}
}


bool findr=false;
int sayr=0;
int shiftr=i+1;

for ( int b=i+1;b>i-10;b--) {

if ( b < 1 ) continue;

if ( findr == false ) {
if ( iClose(sym,per,b) > iOpen(sym,per,b) ) {
sayr=sayr+1;
shiftr=b;
} else {
findr=true;
}
}
}



int shifth=i+2;
double low_price=iLow(sym,per,i+2);

for ( int b=i+2;b<shift;b++) {

if ( iClose(sym,per,b) > iOpen(sym,per,b) ) {
if ( iLow(sym,per,b) < low_price ) {
low_price=iLow(sym,per,b);
shifth=b;
}
}
}



bool findk=false;
int sayk=0;
int shiftk=shift;
double low_prices=iLow(sym,per,shift);

for ( int b=shift;b<i+10;b++) {

if ( b < 1 ) continue;

if ( findk == false ) {
if ( iOpen(sym,per,b) < iClose(sym,per,b) ) {
if ( low_prices > iLow(sym,per,b) ) {   
sayk=sayk+1;
shiftk=b;
low_prices=iLow(sym,per,b);
}
} else {
findk=true;
}
}
}





if ( find_big && true && iLow(sym,per,shift) <= iHigh(sym,per,shifts) && iLow(sym,per,shift) > low_price && iOpen(sym,per,shift) > iClose(sym,per,i+2) && iHigh(sym,per,shifts) < iOpen(sym,per,shift) && iHigh(sym,per,shiftr) < iClose(sym,per,shift) && iLow(sym,per,shiftk) > iClose(sym,per,i+2) ) {

CreateIndicator(i+1,sym,per,z,iwl,4,i+1);
/*
ObjectCreate(ChartID(),"T"+Time[i],OBJ_TREND,0,Time[shift],Low[shift],Time[shifts],High[shifts]);
ObjectSetInteger(ChartID(),"T"+Time[i],OBJPROP_RAY,False);

ObjectCreate(ChartID(),"H"+Time[i],OBJ_TREND,0,Time[i+2],Low[i+2],Time[i+2]+5*PeriodSeconds(),Low[i+2]);
ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"HH"+Time[i],OBJ_TREND,0,Time[shifth],Low[shifth],Time[shifth]+5*PeriodSeconds(),Low[shifth]);
ObjectSetInteger(ChartID(),"HH"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"HH"+Time[i],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"LF"+Time[i],OBJ_TREND,0,Time[shiftr],High[shiftr],Time[shiftr]+5*PeriodSeconds(),High[shiftr]);
ObjectSetInteger(ChartID(),"LF"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"LF"+Time[i],OBJPROP_COLOR,clrLightGray);

ObjectCreate(ChartID(),"HL"+Time[i],OBJ_TREND,0,Time[shiftk],Low[shiftk],Time[shiftk]+5*PeriodSeconds(),Low[shiftk]);
ObjectSetInteger(ChartID(),"HL"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"HL"+Time[i],OBJPROP_COLOR,clrTurquoise);
*/

}



}


}

//////////////////////////////



for (int i=300;i>0;i--) {




if ( iOpen(sym,per,i+1) > iClose(sym,per,i+1) && iClose(sym,per,i+2) > iOpen(sym,per,i+2) ) {

bool find=false;
int say=0;
int shift=i+2;
bool find_big=false;

for ( int b=i+2;b<i+10;b++) {

if ( find == false ) {
if ( iClose(sym,per,b) > iOpen(sym,per,b) //&& High[b] < Close[i+2]
 ) {
 
  if ( DivZero((iClose(sym,per,b)-iOpen(sym,per,b)),Ortalama) >= connect_oran ) find_big=true;
 
 
say=say+1;
} else {
shift=b;
find=true;
}
}
}


if ( say==1 && iHigh(sym,per,i+3) > iHigh(sym,per,i+2) ) {
continue;
}

bool finds=false;
int says=0;
int shifts=i+1;

for ( int b=i+1;b>i-10;b--) {

if ( b < 1 ) continue;

if ( finds == false ) {
if ( iOpen(sym,per,b) > iClose(sym,per,b) ) {
if ( iOpen(sym,per,shift) < iClose(sym,per,b) && iOpen(sym,per,shift) < iLow(sym,per,b)   ) {
says=says+1;
shifts=b;
}
} else {
finds=true;
}
}
}


bool findr=false;
int sayr=0;
int shiftr=i+1;

for ( int b=i+1;b>i-10;b--) {

if ( b < 1 ) continue;

if ( findr == false ) {
if ( iOpen(sym,per,b) > iClose(sym,per,b) ) {
sayr=sayr+1;
shiftr=b;
} else {
findr=true;
}
}
}



int shifth=i+2;
double high_price=iHigh(sym,per,i+2);

for ( int b=i+2;b<shift;b++) {

if ( iClose(sym,per,b) > iOpen(sym,per,b) ) {
if ( iHigh(sym,per,b) > high_price ) {
high_price=iHigh(sym,per,b);
shifth=b;
}
}
}



bool findk=false;
int sayk=0;
int shiftk=shift;
double high_prices=iHigh(sym,per,shift);

for ( int b=shift;b<i+10;b++) {

if ( b < 1 ) continue;

if ( findk == false ) {
if ( iOpen(sym,per,b) > iClose(sym,per,b) ) {
if ( high_prices < iHigh(sym,per,b) ) {   
sayk=sayk+1;
shiftk=b;
high_prices=iHigh(sym,per,b);
}
} else {
findk=true;
}
}
}





if ( find_big == true && iHigh(sym,per,shift) >= iLow(sym,per,shifts) && iHigh(sym,per,shift) < high_price && iOpen(sym,per,shift) < iClose(sym,per,i+2) && iLow(sym,per,shifts) > iOpen(sym,per,shift) && iLow(sym,per,shiftr) > iClose(sym,per,shift) && iHigh(sym,per,shiftk) < iClose(sym,per,i+2) ) {


CreateIndicator(i+1,sym,per,z,iwl,5,i+1); 

/*
ObjectCreate(ChartID(),"T"+Time[i],OBJ_TREND,0,Time[shift],High[shift],Time[shifts],Low[shifts]);
ObjectSetInteger(ChartID(),"T"+Time[i],OBJPROP_RAY,False);

ObjectCreate(ChartID(),"H"+Time[i],OBJ_TREND,0,Time[i+2],High[i+2],Time[i+2]+5*PeriodSeconds(),High[i+2]);
ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"H"+Time[i],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"HH"+Time[i],OBJ_TREND,0,Time[shifth],High[shifth],Time[shifth]+5*PeriodSeconds(),High[shifth]);
ObjectSetInteger(ChartID(),"HH"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"HH"+Time[i],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"LF"+Time[i],OBJ_TREND,0,Time[shiftr],Low[shiftr],Time[shiftr]+5*PeriodSeconds(),Low[shiftr]);
ObjectSetInteger(ChartID(),"LF"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"LF"+Time[i],OBJPROP_COLOR,clrLightGray);

ObjectCreate(ChartID(),"HL"+Time[i],OBJ_TREND,0,Time[shiftk],High[shiftk],Time[shiftk]+5*PeriodSeconds(),High[shiftk]);
ObjectSetInteger(ChartID(),"HL"+Time[i],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"HL"+Time[i],OBJPROP_COLOR,clrTurquoise);*/


}



}

   
   
   }
   
   
   }
   
   
   }
   
   
   }
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Breakout
/////////////////////////////////////////////////////////////////////////////////////////////////////////

void Breakout() {

string Comment_Line = "";

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string sym=pairswl[iwl];
      ENUM_TIMEFRAMES per=Period();
      //Print(sym);
      bool bigbar=false;
      
      
      double Points=MarketInfo(sym,MODE_POINT);
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  if ( z > 4 ) continue;
  
  per=zaman[z];
  
  int bar_ortalama_bar=300;
  
  if ( per > PERIOD_H4 ) bar_ortalama_bar=30;
  
  
  
  double Ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  
   for(int i=1;i<50;i++) {
   
   //Print(i);
   
ChartRedraw();
   
   double high_price=iHigh(sym,per,i);
   double high_prices=iHigh(sym,per,i-1);
   
   double low_price=iLow(sym,per,i);
   double low_prices=iLow(sym,per,i-1);
   
    double open_price=iOpen(sym,per,i);
   double open_prices=iOpen(sym,per,i-1);
   
    double close_price=iClose(sym,per,i);
   double close_prices=iClose(sym,per,i-1);
   
   double body=0;
   double bodys=0;
   double body_low=0;
   double body_lows=0;
   double body_high=0;
   double body_highs=0;
   
   
   if ( close_price > open_price ) {
   
   body_high=high_price-close_price;
   body_low=open_price-low_price;
   body=close_price-open_price;
   
   }
   if ( open_price >= close_price ) {
   
   body_high=high_price-open_price;
   body_low=close_price-low_price;
   body=open_price-close_price;
   
   }
   
   if ( close_prices > open_prices ) {
   
   body_highs=high_prices-close_prices;
   body_lows=open_prices-low_prices;
   body=close_price-open_price;  
   
   bodys=close_prices-open_prices;

   }
   
   
   if ( open_prices >= close_prices ) {
   
   body_highs=high_prices-open_prices;
   body_lows=close_prices-low_prices;
   bodys=open_prices-close_prices;
   
   }
   
   
   
   double scr_high_price=-1;
   double scr_low_price=1000000;
   int scr_high_shift=i;
   int scr_low_shift=i;
   
   bool high_find=false;
   bool low_find=false;
   
   for(int r=i+1;r<i+480;r++) {
   
   /*
   
   if ( high_find == true ) continue;
   
   if ( scr_high_price < iHigh(sym,per,r) ) {
   
  
   
   for(int s=r+1;s<r+500;s++) {
   
   if ( s > Bars-50 ) continue;
   
   if ( scr_high_price > High[s] ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }  
   }   
   
   if ( high_say > 100 ) {  
   scr_high_price=iHigh(sym,per,r);
   scr_high_shift=r;
   high_find=true;
   }
*/

   int high_say=0;
   bool find=false; 

for(int s=r+1;s<r+50;s++) {

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,r) > iHigh(sym,per,s) ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}



if ( high_say > 30 && high_find==false ) {
   
if ( scr_high_price < iHigh(sym,per,r) ) {
      scr_high_price=iHigh(sym,per,r);
   scr_high_shift=r;
   high_find=true;
   }
   
   }


   int low_say=0;
   bool finds=false; 

for(int s=r+1;s<r+50;s++) {

   if ( finds == true ) continue;
   
   if ( iLow(sym,per,r) < iLow(sym,per,s) ) {
   low_say=low_say+1;    
   } else {
   finds=true;
   }

}
   
   
   
   if ( low_say > 30 && low_find == false ) {
   
   if ( scr_low_price > iLow(sym,per,r)  ) {
   scr_low_price=iLow(sym,per,r);
   scr_low_shift=r;
   low_find=true;
   }
      
      }
   
   }
   
   
   double yuzde=DivZero(scr_high_price-scr_low_price,100);
   
   
   
   
   
   if ( DivZero(body,Ortalama) >= 2 ) {
   
/*
   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   */
   
   if ( open_price > close_price ) {
   
   double candle_level=DivZero(scr_high_price-close_price,yuzde);
   
   int shift=DivZero((iTime(sym,per,i)-iTime(sym,per,scr_high_shift)),PeriodSeconds(per));
   
   //if ( shift < 200 ) {
   if ( shift < 150 && candle_level < 70 
   ) {
   
   CreateIndicator(i+1,sym,per,z,iwl,4,i+1);
   /*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Close[i],Time[scr_high_shift],scr_high_price);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);*/
   
   }
   
   }   
   
   
   

   if ( close_price > open_price ) {
   
   
   double candle_level=DivZero(close_price-scr_low_price,yuzde);
   
      int shift=DivZero((iTime(sym,per,i)-iTime(sym,per,scr_low_shift)),PeriodSeconds(per));
   
   //if ( shift < 200 ) {
   if ( shift < 150 && candle_level < 70
     ) {
     
     CreateIndicator(i+1,sym,per,z,iwl,5,i+1); 
     
   /*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Close[i],Time[scr_low_shift],scr_low_price);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);*/
   
   }
   
   }   
      
   
   
   
   }
   
   
   
   
   
   
   }
   
  }
  
  
  
  }
  
  
  
  
  
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////
// Supdem Engine
/////////////////////////////////////////////////////////////////////////////////////////////////////////

void DoubleDoji() {

string Comment_Line = "";

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
      
      
      double Points=MarketInfo(sym,MODE_POINT);
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  per=zaman[z];
  
  int bar_ortalama_bar=300;
  
  //if ( per > PERIOD_H4 ) bar_ortalama_bar=30;
  
  double bar_ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   for (int i=1;i<20;i++) {
   
   


  int shift=i;
  double high_price=iHigh(sym,per,shift);
  double low_price=iLow(sym,per,shift);
  double open_price=iOpen(sym,per,shift);
  double close_price=iClose(sym,per,shift);
  
  int shifts=i-1;
  double high_prices=iHigh(sym,per,shifts);
  double low_prices=iLow(sym,per,shifts);
  double open_prices=iOpen(sym,per,shifts);
  double close_prices=iClose(sym,per,shifts);
  
  
  
  
  
  if ( (iClose(sym,per,i+1) > iOpen(sym,per,i+1) && iClose(sym,per,i+2) > iOpen(sym,per,i+2)// && iClose(sym,per,i+3) > iOpen(sym,per,i+3)
  
  ) ||
  
  (iClose(sym,per,i+1) < iOpen(sym,per,i+1) && iClose(sym,per,i+2) < iOpen(sym,per,i+2) //&& iClose(sym,per,i+3) < iOpen(sym,per,i+3)
  
  ) ) {
  
  } else {
  
  continue;
  
  }
  
  
/*
  if ( (   
  
  
  (iClose(sym,per,i+1) - iOpen(sym,per,i+1))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iClose(sym,per,i+2) - iOpen(sym,per,i+2))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iClose(sym,per,i+3) - iOpen(sym,per,i+3))/Point >= (bar_ortalama/Point)*2
  
  
  
  
    
     
     
     ) ||
  

  (iOpen(sym,per,i+1) - iClose(sym,per,i+1))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iOpen(sym,per,i+2) - iClose(sym,per,i+2))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iOpen(sym,per,i+3) - iClose(sym,per,i+3))/Point >= (bar_ortalama/Point)*2  
  
  
  
  
  
   ) {
  
  } else {
  
  continue;
  
  }
  */
    
  
  
  if ( (open_price > close_price && (open_price - close_price) <= bar_ortalama/Points) || 
  
  (close_price > open_price && (close_price-open_price) <= bar_ortalama/Points)
  
  ) {
  
  double fark=MathAbs(open_price-close_price);
  
  double farks=MathAbs(open_prices-close_prices);
  
  if ( fark/Points <= (bar_ortalama/Points)/1.5 && farks/Points <= (bar_ortalama/Points)/1.5 ) {
  
  //CreateIndicator(i+1,sym,per,z,iwl,4,i+1);
  CreateIndicator(i+1,sym,per,z,iwl,5,i+1);  
  
/*
string last_select_objectr="WDoji"+i;


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],low_price,Time[i]+10*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=10;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],high_prices,Time[i-1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],low_prices,Time[i-1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=20;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( high_prices > high_price ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],high_prices,Time[i-1]+10*PeriodSeconds(),high_prices);
if ( high_price > high_prices ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( low_prices < low_price ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],low_prices,Time[i-1]+10*PeriodSeconds(),low_prices);
if ( low_price < low_prices ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],low_price,Time[i]+10*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

double hprice;
if ( high_prices > high_price ) hprice=high_prices;
if ( high_price > high_prices ) hprice=high_price;

double lprice;
if ( low_prices < low_price ) lprice=low_prices;
if ( low_price < low_prices ) lprice=low_price;

double yuzde=DivZero(hprice-lprice,100);

levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],lprice-levels*yuzde,Time[i-1]+10*PeriodSeconds(),lprice-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=13.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],hprice+levels*yuzde,Time[i-1]+10*PeriodSeconds(),hprice+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);*/
  
  
  }
  
  }
     
   
   
   
   
   
   
   
   
   }
   
   
   }
   
   }




}



void FvgEngine() {
//SupdemEngine();
//DoubleDoji();
//Breakout();
Connect();
}

 double govde_oran=20;
 double ust_oran=30;
 double alt_oran=30; 
 
 double birinci_mum_orani=1;
 //double ucuncu_mum_orani=2;
 double ucuncu_mum_orani=1;
 
 
 

void SupdemEngine() {



string Comment_Line = "";

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
  
  int bar_ortalama_bar=300;
  
  //if ( per > PERIOD_H4 ) bar_ortalama_bar=30;
  
  double bar_ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   for (int i=1;i<20;i++) {
   


//int i=0;
/////////////////////////////////////////////////////////////
   int shift=i;
   double high_price=iHigh(sym,per,shift);
   double low_price=iLow(sym,per,shift);
   double open_price=iOpen(sym,per,shift);
   double close_price=iClose(sym,per,shift);
   datetime time_date=iTime(sym,per,shift);
   
   double high_low_yuzde=DivZero((high_price-low_price),100);
   
   double fark=0;
   double ust_fark=0;
   double alt_fark=0;
   if ( open_price > close_price ) {   
   fark=open_price-close_price;      
   ust_fark=high_price-open_price;
   alt_fark=close_price-low_price;
   }
   if ( close_price > open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
   
   if ( close_price == open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
      
           
   double govde_yuzde=DivZero(fark,high_low_yuzde);
   
   double ust_yuzde=DivZero(ust_fark,high_low_yuzde);
   double alt_yuzde=DivZero(alt_fark,high_low_yuzde);
   
   double eq_price=low_price+high_low_yuzde*50;
   
   
   shift=i+1;
   double high_prices=iHigh(sym,per,shift);
   double low_prices=iLow(sym,per,shift);
   double open_prices=iOpen(sym,per,shift);
   double close_prices=iClose(sym,per,shift);
   datetime time_dates=iTime(sym,per,shift);
      
   
//////////////////////////////////////////////////////////////////////   

   if ( govde_yuzde < govde_oran && ust_yuzde >=ust_oran && alt_yuzde >=alt_oran ) {
   
   
if ( close_prices > open_prices && (close_prices-open_prices) >= bar_ortalama*ucuncu_mum_orani) {
CreateIndicator(i+1,sym,per,z,iwl,4,i+1);
}   
   
   if ( open_prices > close_prices && (open_prices-close_prices) >= bar_ortalama*ucuncu_mum_orani   ) {         
 CreateIndicator(i+1,sym,per,z,iwl,5,i+1);  
}   
  
  
   
   }
      
      
      

   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   }
  
  
  
  }
  
  }
  







}    


/////////////////////////////////////////////////////////////////////////////////////////////////////////

extern ENUM_MA_METHOD MaMethod=MODE_EMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTime = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTimes = PERIOD_CURRENT;


int ma_shift = 1; // Zaman
int shiftma  = 0;
int shift=0;


void SuperMaEngine() {

   int bar_toplam = 2500;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   
int limit=Bars-50;
bar_toplam=limit;

//Alert("Selam");


string Comment_Line = "";

      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      

      
      
      string sym=pairswl[iwl];
      
      //if ( sym != "US30" ) continue;
      
      int per=Period();
      //Print(sym);
      bool bigbar=false;
      
         
  for(int z=0;z<ArraySize(zaman);z++) {
  
  
bool flag_up=false;
bool flag_down=false;

bool up_br=false;
bool down_br=false;

int up_shift=-1;
int down_shift=-1;  
  
  
  
  per=zaman[z];
  
  double bar_ortalama=BarOrtalama(1,300,sym,per);
  
  /* for (int t=1;t<=limit;t++) {
   
   bar_pip = bar_pip + MathAbs(iClose(sym,per,t)-iOpen(sym,per,t));
   
   }
   
   
   
   
   bar_ortalama = bar_pip / bar_toplam;*/
   //bar_ortalama=int(bar_ortalama);
   
   //Alert(bar_ortalama,"/",per);
   
   
     
  
  //Print(sym+"/"+zaman[z]);
  
   //for (int i=0;i<300;i++) {
   
   for (int i=300;i>0;i--) {
   
    

   //double RSI = iRSI(sym, per, 12, PRICE_CLOSE, i);
     
   //int sonuc=BigBarControl(i,sym,per,z,iwl);
   
   //if ( RSI <= 22 ) CreateIndicator(i,sym,per,z,iwl,0,-1);
   //if ( RSI >= 78 ) CreateIndicator(i,sym,per,z,iwl,1,-1);
   
   /*if ( i > 50 ) {
   sonuc = MergeOrtalama(i,sym,per,z,iwl);
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc);
   }*/

int shift=i;
double MA200=iMA(sym, per, 200, ma_shift, MaMethod, MaPrice, shift); 
double MA100=iMA(sym, per, 100, ma_shift, MaMethod, MaPrice, shift);      
double MA9=iMA(sym, per, 9, ma_shift, MaMethod, MaPrice, shift); 
double MA22=iMA(sym, per, 22, ma_shift, MaMethod, MaPrice, shift); 
double MA50=iMA(sym, per, 50, ma_shift, MaMethod, MaPrice, shift); 
   
   if ( iOpen(sym,per,i) < MA200 && iClose(sym,per,i) > MA200 ) {flag_up=true;flag_down=false;up_br=false;up_shift=i;} 
   
   if ( iOpen(sym,per,i) > MA200 && iClose(sym,per,i) < MA200 ) {flag_down=true;flag_up=true;down_br=false;down_shift=i;}
     

   if ( 
   
   MA22 > MA50 && MA50 > MA100 && MA100 > MA200 &&
   
    (iClose(sym,per,i) - iOpen(sym,per,i)) > bar_ortalama*2  
   && iClose(sym,per,i) > MA200 && iOpen(sym,per,i) > MA200
   && flag_up == true 
   
   && up_shift-i > 10 
   
   && (iOpen(sym,per,i)-MA200)/bar_ortalama < 7 && (iOpen(sym,per,i)-MA200)/bar_ortalama >= 1  
   
   ) {
   
   /*ObjectDelete(ChartID(),"VLINE"+i);
   ObjectCreate(ChartID(),"VLINE"+i,OBJ_TREND,0,Time[i],MA200,Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_BACK,true);
   ObjectSetString(ChartID(),"VLINE"+i,OBJPROP_TOOLTIP,up_shift-i+"/"+(Open[i]-MA200)/bar_ortalama); */  
   
   //CreateIndicator(i,sym,per,z,iwl,0,-1);
   
   
   if ( up_br == false ) {
   
   /*   
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_WIDTH,3);
   ObjectDelete(ChartID(),"VLINET"+i);
   ObjectCreate(ChartID(),"VLINET"+i,OBJ_TREND,0,Time[i],Close[i],Time[i]+50*PeriodSeconds(),Close[i]);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_RAY,false);*/
   //ObjectSetString(ChartID(),*/"VLINET"+i,OBJPROP_TOOLTIP,down_shift-i+"/"+(MA200-Open[i])/bar_ortalama);   
   
   up_br=true;
   /*ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_STYLE,STYLE_DOT);*/
   
   CreateIndicator(i,sym,per,z,iwl,0,-1);
   
   }
   else {
   
   //ObjectDelete(ChartID(),"VLINE"+i);}
   
   }
    
    
   }
     

   if (
   
   MA22 < MA50 &&  MA50 < MA100 &&  MA100 < MA200  // Sıralı Ma
   
   && (iOpen(sym,per,i) - iClose(sym,per,i) ) > bar_ortalama*2  // Br Mum Boyu
   
   && iClose(sym,per,i) < MA200 && iOpen(sym,per,i) < MA200  // Ma Altında Olması
   
   && down_shift-i > 10  // Ma Uzaklığı Bar Olarak
   
   && (MA200-iOpen(sym,per,i))/bar_ortalama < 7 && (MA200-iOpen(sym,per,i))/bar_ortalama >= 1 // Ma Uzaklığı Mesafe Olarak
   
    ) {
   
   /*ObjectDelete(ChartID(),"VLINE"+i);
   ObjectCreate(ChartID(),"VLINE"+i,OBJ_TREND,0,Time[i],MA200,Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_BACK,true);
   ObjectSetString(ChartID(),"VLINE"+i,OBJPROP_TOOLTIP,down_shift-i+"/"+(MA200-Open[i])/bar_ortalama);*/


      //CreateIndicator(i,sym,per,z,iwl,1,-1);
   
   if ( down_br == false ) {
   
   
   //ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_WIDTH,3);
   down_br=true;
   
   /*ObjectDelete(ChartID(),"VLINET"+i);
   ObjectCreate(ChartID(),"VLINET"+i,OBJ_TREND,0,Time[i],Close[i],Time[i]+50*PeriodSeconds(),Close[i]);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),"VLINET"+i,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),"VLINET"+i,OBJPROP_TOOLTIP,down_shift-i+"/"+(MA200-Open[i])/bar_ortalama);   

   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_STYLE,STYLE_DOT);*/   
   
   CreateIndicator(i,sym,per,z,iwl,1,-1);
   
   }  
   else {
   //ObjectDelete(ChartID(),"VLINE"+i);
   }
   
     
     }
   
   
   
   
  
  
  
  }
  
  }
  

}


}



int price_levels(string sym,int per,int shift) {

if ( per >= 240 ) return 0;


int shifts=shift+300;


double high_price=iHigh(sym,per,shifts);
double low_price=iLow(sym,per,shifts);
int high_shift=shifts;
int low_shift=shifts;


for ( int d=shifts;d>=shift;d--) {

if ( iHigh(sym,per,d) > high_price ) {
high_price=iHigh(sym,per,d);
high_shift=d;
}

if (iLow(sym,per,d) < low_price ) {
low_price=iLow(sym,per,d);
low_shift=d;
}


}


 double yuzde=(high_price-low_price)/100;
 //double price=(MarketInfo(sym,MODE_BID)-low_price)/yuzde;
 //double price=(MarketInfo(sym,MODE_BID)-low_price)/yuzde;
 double price=(iClose(sym,per,shift)-low_price)/yuzde;
 
return price;


}



/////////////////////////////////////////////////////////////////////////////////////////////////////////
void SfpEngine() {


double last_high_price=-1;
int last_high_shift=-1;

double last_low_price=-1;
int last_low_shift=-1;




string Comment_Line = "";

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
  
  if ( per >= 240 ) continue;
  
  //Ortalama=BarOrtalama(1,300,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   //for (int i=0;i<300;i++) {
   
   /*double RSI = iRSI(sym, per, 12, PRICE_CLOSE, i);
     
   //int sonuc=BigBarControl(i,sym,per,z,iwl);
   
   if ( RSI <= 22 ) CreateIndicator(i,sym,per,z,iwl,0,-1);
   if ( RSI >= 78 ) CreateIndicator(i,sym,per,z,iwl,1,-1);*/
   
   /*if ( i > 50 ) {
   sonuc = MergeOrtalama(i,sym,per,z,iwl);
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc);
   }*/


   
   
   
   //}
   
   
   

   for ( int i=300;i>10;i--) {
   
   if ( i == 0 ) continue;
   
   if ( iHigh(sym,per,i) < iHigh(sym,per,i+1) ) continue;
   
   //Print(i);
   
   double high_price=iHigh(sym,per,i);
   int high_shift=0;
   bool find=false;
   int high_total=0;
   for (int r=i-1;r>i-4;r--) {   // Sağ Doğru
   if ( find == false ) {
   if ( high_price > iHigh(sym,per,r) ) {
   high_total=high_total+1;
   } else {   
   find=false;
   }
   
   }
   
   if ( find == false && high_total == 3 ) {
   
   bool left_high=false;
   for (int s=i+1;s<i+11;s++) {
   
   if ( high_price < iHigh(sym,per,s) ) {
   left_high=true;
   }
   
   
   }
   
   if ( left_high==false ) {
   
   if ( last_high_price != -1  ){
   if ( high_price < last_high_price ) {
   //ObjectDelete(ChartID(),"High"+last_high_shift);
   //ObjectDelete(ChartID(),"HighUp"+last_high_shift);
   }   
   }


   
   if ( last_high_price != -1  ){
   
   
   double bar_pip = 0;
   double bar_ortalama=0;
   int bar_toplam=300;

   for (int b=i;b<=i+300;b++) {
   
   bar_pip = bar_pip + MathAbs(iClose(sym,per,b)-iOpen(sym,per,b));
   
   }

   
   bar_ortalama = bar_pip / bar_toplam;
   
      
   
   
   int prc_level=price_levels(sym,per,i);
   
   if ( (high_price-last_high_price)/MarketInfo(sym,MODE_POINT) < 0 || prc_level < 70 ) {
   /*ObjectDelete(ChartID(),"High"+last_high_shift);
   ObjectDelete(ChartID(),"HighUp"+last_high_shift);
   ObjectDelete(ChartID(),"HighT"+last_high_shift);*/
   } else {
   
   
   /*
   string name="HighT"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],high_price,Time[last_high_shift]+100*PeriodSeconds(),last_high_price);   
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],high_price,Time[last_high_shift],last_high_price);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(high_price-last_high_price)/Point+"/"+prc_level+"/"+bar_ortalama/Point+"/"+(high_price-last_high_price)/bar_ortalama);*/
   
   CreateIndicator(i,sym,per,z,iwl,0,-1);
   //CreateIndicator(last_high_shift,sym,per,z,iwl,4,i);
   
   
   }
   
   }
   
   /*
   string name="High"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),high_price);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,RSI);
   
   
   
   name="HighUp"+i;
   if ( Close[i] > Open[i] ) ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),Close[i]);   
   if ( Close[i] < Open[i] ) ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),Open[i]);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);*/
   
   
   last_high_price=high_price;
   last_high_shift=i;
   }
   }
   
   
   
   }

   
   }



///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////


for ( int i=300;i>10;i--) {
   
   if ( i == 0 ) continue;
   
   if ( iLow(sym,per,i) > iLow(sym,per,i+1) ) continue;
   
   //Print(i);
   
   double low_price=iLow(sym,per,i);
   int low_shift=0;
   bool find=false;
   int low_total=0;
   for (int r=i-1;r>i-4;r--) {   
   if ( find == false ) {
   if ( low_price < iLow(sym,per,r) ) {
   low_total=low_total+1;
   } else {   
   find=false;
   }
   
   }
   
   if ( find == false && low_total == 3 ) {
   
   bool left_low=false;
   for (int s=i+1;s<i+11;s++) {
   
   if ( low_price > iLow(sym,per,s) ) {
   left_low=true;
   }
   
   
   }
   
   if ( left_low==false ) {
   
   /*if ( last_low_price != -1  ){
   if ( low_price > last_low_price ) {
   ObjectDelete(ChartID(),"Low"+last_low_shift);
   ObjectDelete(ChartID(),"LowDown"+last_low_shift);
   }   
   }*/
   
   double bar_pip = 0;
   double bar_ortalama=0;
   int bar_toplam=300;

   for (int b=i;b<=i+300;b++) {
   
   bar_pip = bar_pip + MathAbs(iClose(sym,per,b)-iOpen(sym,per,b));
   
   }

   
   bar_ortalama = bar_pip / bar_toplam;
   
   
   

   int prc_level=price_levels(sym,per,i);

   if ( last_low_price != -1 ){
   
   if ( (last_low_price-low_price)/Point < 0 || prc_level > 30 ) {
   ObjectDelete(ChartID(),"Low"+last_low_shift);
   ObjectDelete(ChartID(),"LowDown"+last_low_shift);
   ObjectDelete(ChartID(),"LowT"+last_low_shift);
   } else {
   
   CreateIndicator(i,sym,per,z,iwl,1,-1);
   //CreateIndicator(last_low_shift,sym,per,z,iwl,5,i);
   
   
   /*string name="LowT"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],high_price,Time[last_high_shift]+100*PeriodSeconds(),last_high_price);   
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],low_price,Time[last_low_shift],last_low_price);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(last_low_price-low_price)/Point+"/"+prc_level+"/"+bar_ortalama/Point+"/"+(last_low_price-low_price)/bar_ortalama);*/
   }
   
   }
   
   
      

   
   /*
   string name="Low"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),low_price);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,RSI);
   
   
   
   name="LowDown"+i;
   if ( Close[i] > Open[i] ) ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),Open[i]);   
   if ( Close[i] < Open[i] ) ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),Close[i]);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);*/
   
   last_low_price=low_price;
   last_low_shift=i;
   }
   }
   
   
   
   }

   
   }
        


   
   
   
  
  
  
  }
  
  }





}



/////////////////////////////////////////////////////////////////////////////////////////////////////////
void RsiEngine() {



string Comment_Line = "";

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
  
  Ortalama=BarOrtalama(1,300,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   for (int i=0;i<300;i++) {
   
   double RSI = iRSI(sym, per, 12, PRICE_CLOSE, i);
     
   //int sonuc=BigBarControl(i,sym,per,z,iwl);
   
   if ( RSI <= 22 ) CreateIndicator(i,sym,per,z,iwl,0,-1);
   if ( RSI >= 78 ) CreateIndicator(i,sym,per,z,iwl,1,-1);
   
   /*if ( i > 50 ) {
   sonuc = MergeOrtalama(i,sym,per,z,iwl);
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc);
   }*/


   
   
   
   }
  
  
  
  }
  
  }
  



}


  
  
void Engine() {



string Comment_Line = "";

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
  
  Ortalama=BarOrtalama(1,300,sym,per);
  
  //Print(sym+"/"+zaman[z]);
  
   for (int i=1;i<300;i++) {
   
   int sonuc=BigBarControl(i,sym,per,z,iwl);
   
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc,-1);
   
   /*if ( i > 50 ) {
   sonuc = MergeOrtalama(i,sym,per,z,iwl);
   if ( sonuc != -1 )  CreateIndicator(i,sym,per,z,iwl,sonuc);
   }*/


   
   
   
   }
  
  
  
  }
  
  }
  



}



int BigBarControl(int i,string sym,string per,int z,int iwl) {

int sonuc=-1;

  // string select_sym=Symbol();
  // int select_per=Period();
   
    
    
    //Comment("Ortalam:",Ortalama/Point);
    
   //for ( int i=1000;i>0;i--) {
   
   
   if ( (iHigh(sym,per,i) - iLow(sym,per,i) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(select_sym,select_per,i),0);
   //Print(i);   
   }
   
   if ( (iClose(sym,per,i) - iOpen(sym,per,i) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   //Print(i);   
   sonuc=0;
   }
      
   if ( (iOpen(sym,per,i) - iClose(sym,per,i) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   sonuc=1;
   //Print(i);   
   }
   
         
   
   
   
   //}
   
   
  
   
   
   return sonuc;
   
   
   }
   
   
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




void CreateLevelIndicator(int start_bar,string sym,int per,int z,int iwl,int typs,int finish_bar,color renk) {

int shiftdt=start_bar;


  
     //Print("Per",per,"/Sym"+sym+"/",shiftdt,"/zaman"+z+"/"+iwl,"/"+(130+shiftdt));

     
     long currChart=ChartID();
     string LabelChartP=sym+"BarPer0-"+per+"-"+shiftdt;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+Time[shiftdt]+","+shiftdt);
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+Time[shiftdt]);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+iTime(sym,per,shiftdt)+","+finish_bar+","+typs);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     if  ( typs == 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrYellow);
     if  ( typs == 1  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkKhaki);
     if  ( typs == 2 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrBlue);
     if  ( typs == 3  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDodgerBlue);
     if  ( typs == 4 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrLimeGreen);
     if  ( typs == 5  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrCrimson); 
     if  ( typs == 6 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrLimeGreen);
     if  ( typs == 7  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrCrimson);  
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, renk);          
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     if ( z == 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+(shiftdt/bolum));
     if ( z > 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*z)+(shiftdt/bolum));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(iwl*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, finish_bar*1.5); 
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YSIZE, 1); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,shiftdt+"/"+finish_bar);  
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);  
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_BACK,false);  


     
string bilgi=sym+","+per+","+iTime(sym,per,shiftdt);

if ( StringFind(bilgiler,bilgi,0) != -1 ) {

ObjectSetInteger(currChart,LabelChartP,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(currChart,LabelChartP,OBJPROP_BGCOLOR,clrBlack);

}

     
    


}

   
   
void CreateIndicator(int start_bar,string sym,int per,int z,int iwl,int typs,int finish_bar) {

int shiftdt=start_bar;


  
     //Print("Per",per,"/Sym"+sym+"/",shiftdt,"/zaman"+z+"/"+iwl,"/"+(130+shiftdt));

     
     long currChart=ChartID();
     string LabelChartP=sym+"BarPer0-"+per+"-"+shiftdt;
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+Time[shiftdt]+","+shiftdt);
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+Time[shiftdt]);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,sym+","+per+","+iTime(sym,per,shiftdt)+","+finish_bar+","+typs);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrWhite);
     if  ( typs == 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrYellow);
     if  ( typs == 1  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkKhaki);
     if  ( typs == 2 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrBlue);
     if  ( typs == 3  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDodgerBlue);
     /*if  ( typs == 4 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrLimeGreen);
     if  ( typs == 5  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrCrimson); 
     if  ( typs == 6 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrLimeGreen);
     if  ( typs == 7  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrCrimson);           */
     
     if  ( typs == 4 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrLimeGreen);//117733
     if  ( typs == 5  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrPink); 
     
     if  ( typs == 4 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrBlue);//117733
     if  ( typs == 5  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrGreen); 
     
     
     if  ( typs == 6 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrBlue);
     if  ( typs == 7  ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrRed);   
     
          
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     if ( z == 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+(shiftdt/bolum));
     if ( z > 0 ) ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 130+((alan/bolum)*z)+(shiftdt/bolum));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 10+(iwl*mheight));
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 3); 
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YSIZE, 15); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,shiftdt+"/"+finish_bar);  
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_SELECTABLE,true);  
     ObjectSetInteger(currChart,LabelChartP,OBJPROP_BACK,false);  
     
string bilgi=sym+","+per+","+iTime(sym,per,shiftdt);

if ( StringFind(bilgiler,bilgi,0) != -1 ) {

ObjectSetInteger(currChart,LabelChartP,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(currChart,LabelChartP,OBJPROP_BGCOLOR,clrBlack);

}

     
    


}


void EngineMerge() {

Print("EngineMerge");





   if ( WindowFirstVisibleBar() < WindowBarsPerChart() ) {
   end_bar=0;
   } else {
   end_bar=WindowFirstVisibleBar()-WindowBarsPerChart();
   }
   start_bar=300;//WindowFirstVisibleBar();
   end_bar=4;
   
   //Comment("Bar",WindowFirstVisibleBar(),"/",WindowBarsPerChart(),"=",end_bar);
   
  //Print(start_bar,"/",end_bar);
   
   
   
 
string Comment_Line = "";

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
  
  Ortalama=BarOrtalama(1,300,sym,per);
   
   
  string select_sym=sym;
  int select_per=per;
   
  //Print(sym,"/",per);
  
   
   
   if ( end_bar > 3 ) {
   
   for (int t=start_bar;t>=end_bar;t--) {
   
   //Print(t);
   
   if ( iClose(select_sym,select_per,t) < iOpen(select_sym,select_per,t) && iClose(select_sym,select_per,t-1) > iOpen(select_sym,select_per,t-1) ) {
   //ObjectCreate(ChartID(),"V"+Time(select_sym,select_per,t),OBJ_VLINE,0,Time(select_sym,select_per,t),Ask);
   up_time=iTime(select_sym,select_per,t-1);
   up_low=iLow(select_sym,select_per,t-1);
   up_shift=t;
   }

   if ( iClose(select_sym,select_per,t) > iOpen(select_sym,select_per,t) && iClose(select_sym,select_per,t-1) < iOpen(select_sym,select_per,t-1) && up_time != -1 ) {
   up_end_shift=t;
   up_high=iHigh(select_sym,select_per,t);
   //ObjectCreate(ChartID(),"V"+Time(select_sym,select_per,t),OBJ_VLINE,0,Time(select_sym,select_per,t),Ask);   
   up_end_time=iTime(select_sym,select_per,t);   
   
   if ( up_shift - up_end_shift > 1 && (up_high-up_low) > Ortalama*carpan  ) {
   
   /*ObjectDelete("V"+iTime(select_sym,select_per,t));
   ObjectCreate(ChartID(),"V"+iTime(select_sym,select_per,t),OBJ_RECTANGLE,0,up_end_time,up_high,up_time,up_low);  
   ObjectSetInteger(ChartID(),"V"+iTime(select_sym,select_per,t),OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"V"+iTime(select_sym,select_per,t),OBJPROP_COLOR,clrDodgerBlue);
   ObjectSetInteger(ChartID(),"V"+iTime(select_sym,select_per,t),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"V"+iTime(select_sym,select_per,t),OBJPROP_FILL,False);*/
   //DodgerBlue
   //Print(sym,"/",per,"Doger");
   CreateIndicator(t,sym,per,z,iwl,2,up_shift);
   
   }
   up_time=-1;
   
    
   
   }   
   
   
/////////////////////////////////////////////////////////////////////////////

   if ( iClose(select_sym,select_per,t) > iOpen(select_sym,select_per,t) && iClose(select_sym,select_per,t-1) < iOpen(select_sym,select_per,t-1) ) {
   //ObjectCreate(ChartID(),"V"+Time(select_sym,select_per,t),OBJ_VLINE,0,Time(select_sym,select_per,t),Ask);
   down_time=iTime(select_sym,select_per,t-1);
   down_high=iHigh(select_sym,select_per,t-1);
   down_shift=t;
   }

   if ( iClose(select_sym,select_per,t) < iOpen(select_sym,select_per,t) && iClose(select_sym,select_per,t-1) > iOpen(select_sym,select_per,t-1) && down_time != -1 ) {
   down_end_shift=t;
   down_low=iLow(select_sym,select_per,t);
   //ObjectCreate(ChartID(),"V"+Time(select_sym,select_per,t),OBJ_VLINE,0,Time(select_sym,select_per,t),Ask);   
   down_end_time=iTime(select_sym,select_per,t);   
   
   if ( down_shift - down_end_shift > 1 && (down_high-down_low) > Ortalama*carpan ) {
   /*ObjectDelete("V"+iTime(select_sym,select_per,t));
   ObjectCreate(ChartID(),"VD"+iTime(select_sym,select_per,t),OBJ_RECTANGLE,0,down_end_time,down_high,down_time,down_low);  
   ObjectSetInteger(ChartID(),"VD"+iTime(select_sym,select_per,t),OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VD"+iTime(select_sym,select_per,t),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"VD"+iTime(select_sym,select_per,t),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VD"+iTime(select_sym,select_per,t),OBJPROP_FILL,False);*/
   //DodgerBlue
   //Print(sym,"/",per,"Blue");
     CreateIndicator(t,sym,per,z,iwl,3,down_shift);
   
   
   
   }
   down_time=-1;
   
    
   
   }     
   
   
   
   
   }
   
   }



}

}









}




int end_bar=0;
//int start_bar;
int up_time=-1;
int up_end_time;
double up_low;
double up_high;
int up_shift;
int up_end_shift;

int down_time=-1;
int down_end_time;
double down_low;
double down_high;
int down_shift;
int down_end_shift;






void NectEngine() {


string Comment_Line = "";

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


   //string select_sym=Symbol();
   //int select_per=Period();
   
   int select_per=per;
   string select_sym=sym;
   
   
   
   
    Ortalama=BarOrtalama(1,300,select_sym,select_per);
    
    //Comment("Ortalam:",Ortalama/Point);
    
    //ObjectCreate(ChartID(),"VLINE"+iTime(select_sym,select_per,0),OBJ_VLINE,0,iTime(select_sym,select_per,135),0);
    

   int red=0;
   int blue=0;
   bool finish_find=false;
   int finish_shift=-1;
   int start_shift=-1;
    
   for ( int i=300;i>5;i--) {
   
   
   
  
   if ( iClose(select_sym,select_per,i+3) > iOpen(select_sym,select_per,i+3) && iOpen(select_sym,select_per,i+2) > iClose(select_sym,select_per,i+2) && iOpen(select_sym,select_per,i+1) > iClose(select_sym,select_per,i+1) && iOpen(select_sym,select_per,i) > iClose(select_sym,select_per,i) ) {
   
   red=0;
   blue=0;
   finish_find=false;
   finish_shift=-1;
   start_shift=i+2;
   double last_high=-1;
   int last_high_shift=-1;   
   double last_low=1000000;
   int last_low_shift=-1;
   
   for(int r=i+2;r>i-50;r--) {
   
   if ( r < 5 ) continue;
 
   if ( iOpen(select_sym,select_per,r) > iClose(select_sym,select_per,r) && finish_find == false ) {
   red=red+1;   
   }
   
   if ( iClose(select_sym,select_per,r) > iOpen(select_sym,select_per,r) && finish_find == false && iClose(select_sym,select_per,r) < iOpen(select_sym,select_per,r+2) ) {
   blue=blue+1;   
   }
   
  
   if ( iClose(select_sym,select_per,r-3) > iOpen(select_sym,select_per,r-3) && iClose(select_sym,select_per,r-2) > iOpen(select_sym,select_per,r-2) && iClose(select_sym,select_per,r-1) > iOpen(select_sym,select_per,r-1) && finish_find == false )  {  
   finish_find=true;
   finish_shift=r;
   }
   
   
   if ( iLow(select_sym,select_per,r) < last_low ) {
   last_low=iLow(select_sym,select_per,r);
   last_low_shift=r;
   }   

   
   }
   

/////////////////////////////////////////////////////////////
   for(int r=last_low_shift;r<i+50;r++) {
   
   if ( iHigh(select_sym,select_per,r) > last_high ) {
   
   last_high=iHigh(select_sym,select_per,r);
   last_high_shift=r;
   
   }
   
   }
///////////////////////////////////////////////////////////////   
 
 
    
   
   
   if ( finish_find == true && red >= 5 && blue > 0 && blue < 8 && (iHigh(select_sym,select_per,start_shift)-iLow(select_sym,select_per,finish_shift)) > Ortalama*carpann ) {
   
   
   double price50=last_high-((last_high-last_low)/2);
   double price80=last_high-(((last_high-last_low)/100)*80);
   double price40=last_high-(((last_high-last_low)/100)*40);
   double price70=last_high-(((last_high-last_low)/100)*70);     
   
   
   bool work=false;
   
   for ( int c=last_low_shift;c>0;c--) {
   
   if ( iHigh(select_sym,select_per,c) >= price50 ) work=true;
   //if ( iHigh(select_sym,select_per,c) >= price70 ) work=true;
   
   }
   
   if ( work==true ) continue;
   
   
   CreateIndicator(start_shift,sym,per,z,iwl,4,finish_shift);
   
   
   /*

   ObjectCreate(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_high_shift),last_high,iTime(select_sym,select_per,last_high_shift)+50*PeriodSeconds(),last_high);
   ObjectSetInteger(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,"Tepe");
      
   ObjectCreate(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_low_shift),last_low,iTime(select_sym,select_per,last_low_shift)+50*PeriodSeconds(),last_low);
   ObjectSetInteger(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,"Dip");   
   
   
   ObjectCreate(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),iHigh(select_sym,select_per,start_shift),iTime(select_sym,select_per,finish_shift),iLow(select_sym,select_per,finish_shift));
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,blue);
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_STYLE,STYLE_DOT);  
   

   ObjectCreate(ChartID(),"VLINEDIPL"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_low_shift),last_low,iTime(select_sym,select_per,last_high_shift),last_high);
   ObjectSetInteger(ChartID(),"VLINEDIPL"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,red);
   ObjectSetInteger(ChartID(),"VLINEDIPL"+iTime(select_sym,select_per,start_shift),OBJPROP_STYLE,STYLE_DOT);   
   ObjectSetInteger(ChartID(),"VLINEDIPL"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlack);   
   



 
   

   ObjectCreate(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price50,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price50);
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2);   

   ObjectCreate(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price40,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price40);
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2);      
   
   ObjectCreate(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price70,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price70);
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2); */   
   
      
 
   for ( int x=start_shift;x>finish_shift;x--) {
   
   if ( iClose(select_sym,select_per,x) > iOpen(select_sym,select_per,x) //&& iClose(select_sym,select_per,x-1) < iOpen(select_sym,select_per,x-1) 
    ) {
   
      
      //if ( iClose(select_sym,select_per,x) <= price40 && iClose(select_sym,select_per,x) >= price70  ) ObjectCreate(ChartID(),"VLINE"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
  
if ( iLow(select_sym,select_per,x) <= price40 && iOpen(select_sym,select_per,x) <= price40 && iLow(select_sym,select_per,x) >= price70 ) {
 //ObjectCreate(ChartID(),"VLINEL"+iTime(select_sym,select_per,x),OBJ_TREND,0,iTime(select_sym,select_per,x),iLow(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iLow(select_sym,select_per,x));
  //ObjectSetInteger(ChartID(),"VLINEL"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrBlack);
  //ObjectSetInteger(ChartID(),"VLINEL"+iTime(select_sym,select_per,x),OBJPROP_RAY,false);   
     }
     
   
   }
   
   
   
   if (// iClose(select_sym,select_per,x) >= price40 && 
   iClose(select_sym,select_per,x) <= price70 && iClose(select_sym,select_per,x) > iOpen(select_sym,select_per,x) && iHigh(select_sym,select_per,x)-iClose(select_sym,select_per,x) > iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iLow(select_sym,select_per,x) > iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) && iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) < Ortalama/2  ) {
   
   //ObjectCreate(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
   //ObjectSetInteger(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrLimeGreen);
     
   
   }
   

 if ( //iOpen(select_sym,select_per,x) >= price40 && 
 iOpen(select_sym,select_per,x) <= price70 && iOpen(select_sym,select_per,x) > iClose(select_sym,select_per,x) && iHigh(select_sym,select_per,x)-iClose(select_sym,select_per,x) > iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iLow(select_sym,select_per,x) > iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) < Ortalama/2  ) {
   
   //ObjectCreate(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
   //ObjectSetInteger(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrCrimson);
     
   
   }
   
   
   
 
   
   
   
   
   
   }
 
 
 
   
   }
   
   
   
   }
   
 

  if ( iOpen(select_sym,select_per,i+3) > iClose(select_sym,select_per,i+3) && iClose(select_sym,select_per,i+2) > iOpen(select_sym,select_per,i+2) && iClose(select_sym,select_per,i+1) > iOpen(select_sym,select_per,i+1) && iClose(select_sym,select_per,i) > iOpen(select_sym,select_per,i) ) {
   
   red=0;
   blue=0;
   finish_find=false;
   finish_shift=-1;
   start_shift=i+2;
   double last_high=-1;
   int last_high_shift=-1;   
   double last_low=1000000;
   int last_low_shift=-1;
      
   
   for(int r=i+2;r>i-50;r--) {
   
   if ( r < 5 ) continue;
 
   if ( iClose(select_sym,select_per,r) > iOpen(select_sym,select_per,r) && finish_find == false ) {
   blue=blue+1;   
   }
   
   if ( iOpen(select_sym,select_per,r) > iClose(select_sym,select_per,r) && finish_find == false && iClose(select_sym,select_per,r) > iOpen(select_sym,select_per,r+2) ) {
   red=red+1;   
   }
   
  
   if ( //iOpen(select_sym,select_per,r-4) > iClose(select_sym,select_per,r-4) && 
   iOpen(select_sym,select_per,r-3) > iClose(select_sym,select_per,r-3) && iOpen(select_sym,select_per,r-2) > iClose(select_sym,select_per,r-2) && iOpen(select_sym,select_per,r-1) > iClose(select_sym,select_per,r-1) && finish_find == false )  {  
   finish_find=true;
   finish_shift=r;
   }
   
   if ( iHigh(select_sym,select_per,r) > last_high ) {
   last_high=iHigh(select_sym,select_per,r);
   last_high_shift=r;
   }
   
   
   
   
   }
   
   
/////////////////////////////////////////////////////////////
   for(int r=last_high_shift;r<i+50;r++) {
   
   if ( iLow(select_sym,select_per,r) < last_low ) {
   
   last_low=iLow(select_sym,select_per,r);
   last_low_shift=r;
   
   }
   
   }
///////////////////////////////////////////////////////////////   
   
   
   
   if ( finish_find == true && blue >= 5 && red > 0 && red < 8 && (iHigh(select_sym,select_per,finish_shift)-iLow(select_sym,select_per,start_shift)) > Ortalama*carpann ) {
   
   
   
   double price50=last_low+((last_high-last_low)/2);
   double price80=last_low+(((last_high-last_low)/100)*80);
   double price40=last_low+(((last_high-last_low)/100)*40);
   double price70=last_low+(((last_high-last_low)/100)*70);     
   
   bool works=false;
   
   for ( int c=last_high_shift;c>0;c--) {
   
   //if ( iLow(select_sym,select_per,c) <= price70 ) works=true;
   if ( iLow(select_sym,select_per,c) <= price50 ) works=true;
   
   }
   
   if ( works==true ) continue;
   
   CreateIndicator(start_shift,sym,per,z,iwl,5,finish_shift);
   
   
   /*ObjectCreate(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_high_shift),last_high,iTime(select_sym,select_per,last_high_shift)+50*PeriodSeconds(),last_high);
   ObjectSetInteger(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINETEPE"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,"Tepe");
      
   ObjectCreate(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_low_shift),last_low,iTime(select_sym,select_per,last_low_shift)+50*PeriodSeconds(),last_low);
   ObjectSetInteger(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINEDIP"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,"Dip");
         
   
   
   
   ObjectCreate(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,finish_shift),iHigh(select_sym,select_per,finish_shift),iTime(select_sym,select_per,start_shift),iLow(select_sym,select_per,start_shift));
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   ObjectSetString(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,red);
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_STYLE,STYLE_DOT);   
   ObjectSetInteger(ChartID(),"VLINE"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrDarkGray);     
   

   ObjectCreate(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,last_high_shift),last_high,iTime(select_sym,select_per,last_low_shift),last_low);
   ObjectSetInteger(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJPROP_TOOLTIP,red);
   ObjectSetInteger(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJPROP_STYLE,STYLE_DOT);   
   ObjectSetInteger(ChartID(),"VLINETEPEL"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlack);
   



 
   
   
   
   ObjectCreate(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price50,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price50);
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2);   

   ObjectCreate(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price40,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price40);
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER40"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2);   

   ObjectCreate(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJ_TREND,0,iTime(select_sym,select_per,start_shift),price70,iTime(select_sym,select_per,start_shift)+50*PeriodSeconds(),price70);
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_RAY,false);   
   ObjectSetInteger(ChartID(),"VLINECENTER70"+iTime(select_sym,select_per,start_shift),OBJPROP_WIDTH,2);*/       
    
 
   for ( int x=start_shift;x>finish_shift;x--) {
   
   if ( iOpen(select_sym,select_per,x) > iClose(select_sym,select_per,x) //&& iOpen(select_sym,select_per,x-1) < iClose(select_sym,select_per,x-1)
    ) {
   
   //if ( iOpen(select_sym,select_per,x) >= price40 && iOpen(select_sym,select_per,x) <= price70) ObjectCreate(ChartID(),"VLINE"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
   
  if ( iHigh(select_sym,select_per,x) >= price40 && iOpen(select_sym,select_per,x) >= price40 && iOpen(select_sym,select_per,x) <= price70 ) {
  //ObjectCreate(ChartID(),"VLINEH"+iTime(select_sym,select_per,x),OBJ_TREND,0,iTime(select_sym,select_per,x),iHigh(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iHigh(select_sym,select_per,x));
  //ObjectSetInteger(ChartID(),"VLINEH"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrBlack);
  //ObjectSetInteger(ChartID(),"VLINEH"+iTime(select_sym,select_per,x),OBJPROP_RAY,false);   
   }
   
   
   
   }
   


   if ( //iClose(select_sym,select_per,x) >= price40 && 
   iClose(select_sym,select_per,x) <= price70 && iClose(select_sym,select_per,x) > iOpen(select_sym,select_per,x) && iHigh(select_sym,select_per,x)-iClose(select_sym,select_per,x) > iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iLow(select_sym,select_per,x) > iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) && iClose(select_sym,select_per,x)-iOpen(select_sym,select_per,x) < Ortalama/2  ) {
   
   ObjectCreate(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
   ObjectSetInteger(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrLimeGreen);
     
   
   }
   

 if ( //iOpen(select_sym,select_per,x) >= price40 && 
 iOpen(select_sym,select_per,x) <= price70 && iOpen(select_sym,select_per,x) > iClose(select_sym,select_per,x) && iHigh(select_sym,select_per,x)-iClose(select_sym,select_per,x) > iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iLow(select_sym,select_per,x) > iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) && iOpen(select_sym,select_per,x)-iClose(select_sym,select_per,x) < Ortalama/2  ) {
   
   //ObjectCreate(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJ_RECTANGLE,0,iTime(select_sym,select_per,x),iOpen(select_sym,select_per,x),iTime(select_sym,select_per,x)+150*PeriodSeconds(),iClose(select_sym,select_per,x));
   //ObjectSetInteger(ChartID(),"VLINEB"+iTime(select_sym,select_per,x),OBJPROP_COLOR,clrCrimson);
     
   
   }
      
      


      
   
   
   }
 
 
 
   
   }
   
   
   
   }   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   }
   
   
   
   }
   
   }
   
   


}




void FlagEngine() {


string Comment_Line = "";

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


   //string select_sym=Symbol();
   //int select_per=Period();
   
   int select_per=per;
   string select_sym=sym;
   
   
   
   
    Ortalama=BarOrtalama(1,300,select_sym,select_per);




   for (int i=300;i>20;i--) {
   
   //Print(i);
   


///////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   if ( iOpen(select_sym,select_per,i) > iClose(select_sym,select_per,i) ) {
   
   
   int blue=0;
   int red=0;
   int red_shift=-1;
   
   for (int r=i-1;r>i-20;r--) {
   
   //Print(i,"/",r);
   
    if ( red == 0 ) {

    if ( iClose(select_sym,select_per,r)  > iOpen(select_sym,select_per,r) || iClose(select_sym,select_per,r)  == iOpen(select_sym,select_per,r) ) { 
    
    blue=blue+1;
    
    }
    
    else{
    red=red+1;
    red_shift=r;
    
    if ( (iHigh(select_sym,select_per,r+1)-iLow(select_sym,select_per,i)) > Ortalama*10 //&& blue >= 3 
    ) {
    blue=5;    
    }
    
    }
    
    }
    
  
    
    }
    
    
    if ( blue >= 5 && (iHigh(select_sym,select_per,red_shift+1)-iLow(select_sym,select_per,i)) > Ortalama*10) {
    
double lows;
double higs;   
int higs_shift;
int lows_shift;
    
    ObjectCreate(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i),iOpen(select_sym,select_per,i),iTime(select_sym,select_per,i)+200*PeriodSeconds(),iOpen(select_sym,select_per,i));
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
    
    if ( iHigh(select_sym,select_per,red_shift) > iHigh(select_sym,select_per,red_shift+1) ) {
    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,red_shift),iHigh(select_sym,select_per,red_shift),iTime(select_sym,select_per,red_shift)+10*PeriodSeconds(),iHigh(select_sym,select_per,red_shift));
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    higs=iHigh(select_sym,select_per,red_shift);
    higs_shift=red_shift;
    } else {
    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,red_shift+1),iHigh(select_sym,select_per,red_shift+1),iTime(select_sym,select_per,red_shift+1)+10*PeriodSeconds(),iHigh(select_sym,select_per,red_shift+1));
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);        
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlue);   
    higs=iHigh(select_sym,select_per,red_shift+1);
    higs_shift=red_shift+1;
    }



//if ( higs < iHigh(select_sym,select_per,red_shift-1) ) {
//    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
//    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,red_shift-1),iHigh(select_sym,select_per,red_shift-1),iTime(select_sym,select_per,red_shift-1)+10*PeriodSeconds(),iHigh(select_sym,select_per,red_shift-1));
//    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);        
//    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlue); 
//   higs=iHigh(select_sym,select_per,red_shift-1);
//   higs_shift=red_shift-1;
//}





    if ( iLow(select_sym,select_per,i) < iLow(select_sym,select_per,i-1)  ) {
    ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i),iLow(select_sym,select_per,i),iTime(select_sym,select_per,i)+10*PeriodSeconds(),iLow(select_sym,select_per,i));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    lows=iLow(select_sym,select_per,i);
    lows_shift=i;
    } else {
   ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i-1),iLow(select_sym,select_per,i-1),iTime(select_sym,select_per,i-1)+10*PeriodSeconds(),iLow(select_sym,select_per,i-1));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    lows=iLow(select_sym,select_per,i-1);
    lows_shift=i-1;
    }
    

    if ( lows > iLow(select_sym,select_per,i+1)  ) {
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),iLow(select_sym,select_per,i+1),iTime(select_sym,select_per,i+1)+10*PeriodSeconds(),iLow(select_sym,select_per,i+1));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    lows=iLow(select_sym,select_per,i+1);
    lows_shift=i+1;
    } else {
  // ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i-1),iLow(select_sym,select_per,i-1),iTime(select_sym,select_per,i-1)+10*PeriodSeconds(),iLow(select_sym,select_per,i-1));
   // ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    }    
        
    
    
    
    
    
    double price50=lows+(higs-lows)/2;
    
    
    double yuzde=(higs-lows)/100;
    
    if ( price50-iOpen(select_sym,select_per,i) < Ortalama*4 ) {
    
    ObjectDelete(ChartID(),"OB"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    
    // Enter ile %50 arası düşük olanlar iptal
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
    
    continue;
    }
    
    
    bool work=false;
    for ( int w=red_shift;w>0;w--) {
    
    if ( iLow(select_sym,select_per,w) <= iOpen(select_sym,select_per,i) && work == false) {
    work=true;    
    }
    
    }
    
    if ( work == true ) {
    
    ObjectDelete(ChartID(),"OB"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    
    // Enter ile %50 arası düşük olanlar iptal
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);      
    
    continue;
    
    }
    
    
    CreateIndicator(higs_shift,sym,per,z,iwl,6,lows_shift);    
    
    
    
    ObjectDelete(ChartID(),"OBC"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price50,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price50);
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrChartreuse);     
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  

double price272=higs+(yuzde*27.2);;

    ObjectDelete(ChartID(),"OB272"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price272,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price272);
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrNavy);     
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  

double price414=higs+(yuzde*41.4);;

    ObjectDelete(ChartID(),"OB414"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price414,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price414);
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  
    
    

    
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrLightGray);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
        
    
    
    
    }

    
   
   }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   
   
   
   }
   
   
   
   


   for (int i=300;i>20;i--) {
   
   //Print(i);
   


///////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   if ( iClose(select_sym,select_per,i) > iOpen(select_sym,select_per,i) ) {
   
   
   int blue=0;
   int red=0;
   int blue_shift=-1;
   
   for (int r=i-1;r>i-20;r--) {
   
   //Print(i,"/",r);
   
    if ( blue == 0 ) {

    if ( iOpen(select_sym,select_per,r)  > iClose(select_sym,select_per,r) || iClose(select_sym,select_per,r)  == iOpen(select_sym,select_per,r) ) { 
    
    red=red+1;
    
    }
    
    else{
    blue=blue+1;
    blue_shift=r;
        
    if ( (iHigh(select_sym,select_per,i-1)-iLow(select_sym,select_per,r+1)) > Ortalama*10 //&& red >= 3
     ) {
    red=5;    
    }

    
    
    
    
    
    }
    
    }
    
  
    
    }
    
    
    if ( red >= 5 && (iHigh(select_sym,select_per,i)-iLow(select_sym,select_per,blue_shift+1)) > Ortalama*10) {
    
double lows;
double higs;   
int higs_shift;
int lows_shift;
    
    ObjectCreate(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i),iOpen(select_sym,select_per,i),iTime(select_sym,select_per,i)+200*PeriodSeconds(),iOpen(select_sym,select_per,i));
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlack);  
    ObjectSetInteger(ChartID(),"OB"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
    
    if ( iLow(select_sym,select_per,blue_shift) < iLow(select_sym,select_per,blue_shift+1) ) {
    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,blue_shift),iLow(select_sym,select_per,blue_shift),iTime(select_sym,select_per,blue_shift)+10*PeriodSeconds(),iLow(select_sym,select_per,blue_shift));
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    lows=iLow(select_sym,select_per,blue_shift);
    lows_shift=blue_shift;
    } else {
    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,blue_shift+1),iLow(select_sym,select_per,blue_shift+1),iTime(select_sym,select_per,blue_shift+1)+10*PeriodSeconds(),iLow(select_sym,select_per,blue_shift+1));
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);        
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlue);   
    lows=iLow(select_sym,select_per,blue_shift+1);
    lows_shift=blue_shift+1;
    }
/*
if ( higs < iHigh(select_sym,select_per,red_shift-1) ) {
    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,red_shift-1),iHigh(select_sym,select_per,red_shift-1),iTime(select_sym,select_per,red_shift-1)+10*PeriodSeconds(),iHigh(select_sym,select_per,red_shift-1));
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);        
    ObjectSetInteger(ChartID(),"OBH"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrBlue); 
   higs=iHigh(select_sym,select_per,red_shift-1);
   higs_shift=red_shift-1;
}*/




    if ( iHigh(select_sym,select_per,i) > iHigh(select_sym,select_per,i-1)  ) {
    ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i),iHigh(select_sym,select_per,i),iTime(select_sym,select_per,i)+10*PeriodSeconds(),iHigh(select_sym,select_per,i));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    higs=iHigh(select_sym,select_per,i);
    higs_shift=i;
    } else {
   ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i-1),iHigh(select_sym,select_per,i-1),iTime(select_sym,select_per,i-1)+10*PeriodSeconds(),iHigh(select_sym,select_per,i-1));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    higs=iHigh(select_sym,select_per,i-1);
    higs_shift=i-1;
    }
    

    if ( higs < iHigh(select_sym,select_per,i+1)  ) {
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),iHigh(select_sym,select_per,i+1),iTime(select_sym,select_per,i+1)+10*PeriodSeconds(),iHigh(select_sym,select_per,i+1));
    ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    higs=iHigh(select_sym,select_per,i+1);
    higs_shift=i+1;
    } else {
  // ObjectCreate(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i-1),iLow(select_sym,select_per,i-1),iTime(select_sym,select_per,i-1)+10*PeriodSeconds(),iLow(select_sym,select_per,i-1));
   // ObjectSetInteger(ChartID(),"OBL"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    }    
        
    
    
    
    
    
    double price50=lows+(higs-lows)/2;
    
   if ( iOpen(select_sym,select_per,i)-price50 < Ortalama*4 ) {
    
    ObjectDelete(ChartID(),"OB"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    
    // Enter ile %50 arası düşük olanlar iptal
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrTurquoise);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_BACK,true);  
    
    continue;
    }
    


    bool work=false;
    for ( int w=blue_shift;w>0;w--) {
    
    if ( iHigh(select_sym,select_per,w) >= iOpen(select_sym,select_per,i) && work == false) {
    work=true;    
    }
    
    }
    
    if ( work == true ) {
    
    ObjectDelete(ChartID(),"OB"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBH"+iTime(select_sym,select_per,i));
    ObjectDelete(ChartID(),"OBL"+iTime(select_sym,select_per,i));
    
    // Enter ile %50 arası düşük olanlar iptal
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);      
    
    continue;
    
    }
    
    
    CreateIndicator(lows_shift,sym,per,z,iwl,7,higs_shift);    
    

double yuzde=(higs-lows)/100;


double price272=lows-(yuzde*27.2);;

    ObjectDelete(ChartID(),"OB272"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price272,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price272);
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrNavy);     
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartID(),"OB272"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  

double price414=lows-(yuzde*41.4);;

    ObjectDelete(ChartID(),"OB414"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price414,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price414);
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrCrimson);     
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,1);  
    ObjectSetInteger(ChartID(),"OB414"+iTime(select_sym,select_per,i),OBJPROP_STYLE,STYLE_DOT);  
    
        
    
    
    ObjectDelete(ChartID(),"OBC"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,i+1),price50,iTime(select_sym,select_per,i+1)+200*PeriodSeconds(),price50);
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrChartreuse);     
    ObjectSetInteger(ChartID(),"OBC"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  


    
    ObjectDelete(ChartID(),"OBT"+iTime(select_sym,select_per,i));
    ObjectCreate(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJ_TREND,0,iTime(select_sym,select_per,lows_shift),lows,iTime(select_sym,select_per,higs_shift),higs);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_RAY,false);
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_COLOR,clrLightGray);     
    ObjectSetInteger(ChartID(),"OBT"+iTime(select_sym,select_per,i),OBJPROP_WIDTH,2);  
        
    
    
    
    }

    
   
   }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   
   
   
   }
   

    
    
    
    }
    
    
    }
    
    
    ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
    
    }
    



bool ChartControl(string sinyal_sym,int sinyal_per) {

     bool pairCheck=false;
     
          long currChart,prevChart=ChartFirst();
   int i=0,limit=100;
   Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);
   while(i<limit)// We have certainly not more than 100 open charts
     {
      currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID
      if(currChart<0) break;          // Have reached the end of the chart list
      Print(i,ChartSymbol(currChart)," ID =",currChart);
      //ChartSetSymbolPeriod(currChart,Symbol(), ChartPeriod(currChart));      
      //ChartSetInteger(currChart,CHART_AUTOSCROLL,false);

      if ( ChartSymbol(currChart) == sinyal_sym &&  ChartPeriod(currChart) == sinyal_per ) pairCheck = true;
   
      //if ( ChartFirst() != currChart && pairCheck && Symbol() != ChartSymbol(currChart) ) {pairCheck =false;ChartClose(currChart);} // onceki pair kapatip sona acar

      prevChart=currChart;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter
     }
     
     
     return pairCheck;
     
     
     }
     
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);


 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
     