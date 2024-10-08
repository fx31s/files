//+------------------------------------------------------------------+
//|                                                  OrderAnaliz.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Alpc Forex - Mehmet Ozhan Hastaoglu"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

ENUM_TIMEFRAMES per=Period();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  /*if ( TimeMonth(TimeCurrent()) != 4 ) {
  ExpertRemove();
  return(0);
  }*/
  
  
  
//--- create timer
   EventSetTimer(1);
   FeAnaliz(); 
   
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
int OrderToplam=-1;//OrdersTotal();

void OnTimer()
  {
//---
   if ( OrderToplam!=OrdersTotal() ) {   
   OrderToplam=OrdersTotal();
   ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
   FeAnaliz();
   }
   
   if ( per!=Period() ) {
   OrderToplam=OrdersTotal();
   ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
   FeAnaliz();   
   per=Period();
   
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
  
  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ARROW ) {
  
  //Alert("Sparam",sparam);
  
////////////////////////////////////////////////////////////////////////////      
   string sym_line="";
   string ord="";
   
   //if ( sym_periyod == "" ) {  
   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sparam,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   //sym_line = results[0];
   ord = results[0]; 
   
   int indextic = StringFind(sparam,"#", 0);
   int indexsym = StringFind(sparam,Symbol(), 0);
   
   if ( indextic != -1 && indexsym != -1 ) {
   
   int replaced=StringReplace(ord,"#",""); 
   
   //Alert(ord); 
   
   
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();

   
     
   }  
     
   }
   
   
   
   //}
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   
  }
  
  
  
  
  
  
  
  
//---
   
//Print("Sparam",sparam,"/",id);
//////////////////////////////////////////////////////////////////////
int indexfel = StringFind(sparam,"FeOrderLoad", 0);
int indexfes = StringFind(sparam,"FeOrderSave", 0);
int indexfed = StringFind(sparam,"FeOrderDelete", 0);

// Normal çalışması için OrderTicket yerine Symbol konulabilinir.

if ( indexfes != -1 && id==1) {

//Alert("Selam");

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderSave","");
      
    
       string tpl_files = ord +"-"+Period()+"-.tpl";
//Alert("TPL:",tpl_files);

      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);

      //FileDelete("\\Files\\"+tpl_files,1);
      FileDelete(tpl_files,1);
      Sleep(100);
      //ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      
               
      Print("OrderTicket",ord);
      
      //ObjectDelete("FeOrderLoad"+ord);
      //ObjectDelete("FeOrderSave"+ord);
      //ObjectDelete("FeOrderDelete"+ord);
      Sleep(100);
      FeAnaliz();
      
      
}




if ( indexfed != -1 && id==1) {



         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderDelete","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1) && Period() == 1 ) {
    tpl_files = tpl_files +"-1-.tpl";
    FileDelete(tpl_files,1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = tpl_files +"-5-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1) && Period() == 15) {
    tpl_files = tpl_files +"-15-.tpl";
    FileDelete(tpl_files,1);
    }     
                

    if(FileIsExist(tpl_files +"-30-.tpl",1) && Period() == 30) {
    tpl_files = tpl_files +"-30-.tpl";
    FileDelete(tpl_files,1);
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = tpl_files +"-60-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = tpl_files +"-240-.tpl";
    FileDelete(tpl_files,1);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1) && Period() == 1440 ) {
    tpl_files = tpl_files +"-1440-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)  && Period() == 10080) {
    tpl_files = tpl_files +"-10080-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = tpl_files +"-43200-.tpl";
    FileDelete(tpl_files,1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}



if ( indexfel != -1 && id==1) {

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderLoad","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();
      
      
}
////////////////////////////////////////////////////////////////////////////

   
   
  }
//+------------------------------------------------------------------+




void FeAnaliz() {



  int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    if ( Symbol() == OrderSymbol() ) {
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+OrderTicket();
    if ( ObjectFind("FeOrderSave"+OrderTicket()) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }



bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=OrderTicket();
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5";
    }         
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M15";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      //datetime OrderTime=Time[WindowFirstVisibleBar()]+5*PeriodSeconds();
      datetime OrderTime=Time[WindowFirstVisibleBar()-5];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-20];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+20*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,tpl_files_time);
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-40];
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID()); 
      
          
    
    }
    
    }
    
    
    
  
    
    
    }

}





void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }
ChartRedraw();

}