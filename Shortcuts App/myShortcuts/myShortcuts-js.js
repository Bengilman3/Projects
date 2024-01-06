var crnotice="  - myShortcuts (C) BG"
var debg=false;  // change to "true" to debug
var bgwidth=480;  // TODO: save this stuff to ini
var bgheight=653;  // TODO: save this stuff to ini
var prefix=".\\myShortcuts\\myShortcuts ";
var initDT="Shortcuts";  // initial (default) dataTable

// debg=true;
if (debg) {alert("9".concat(" .js Starting ".concat(prefix)))};
// debg=false;

window.resizeTo(bgwidth,bgheight);

$(document).ready(function(){

     $("#butrowLeft").html(read_buttons());
     $("#datatblSel").html(read_select(initDT));
     $("#datatblSel").val(initDT);
     $("#divDatatable").html(read_data(initDT));

     $("html").css({"background-color":"green",
          "margin-top":"0em", "margin-left":"0em",
          "margin-right":"0em", "margin-bottom":"0em",
          "padding":"0em", "padding-right":"0em",
          "overflow":"hidden",
          "overflow-x":"hidden",
          "width":"100%",
          "height":"100%"});

     $("body").css({"background-color":"lightgreen",
          "margin-top":".1em", "margin-left":".1em",
          "margin-right":"1em", "margin-bottom":".1em",
          "padding":"0.1em",
          "width":"100%",
          "height":"100%"});

     $(".bigBut").css({"width":"33%", "font-size":".6em"});
     $(".smBut").css({"width":"18%", "font-size":".6em",
          "height":"2.3em"});

     $(".breakSec").css({"clear":"both",
          "margin-top":"0em", "margin-left":".4em",
          "margin-right":".6em", "margin-bottom":"0em",
          "display":"none"});
     $("hr#timers").css({"display":"inline"});

     $(".divTimers").css({"clear":"both",
          "height":"2.1em"});
     $(".timersLeft").css({"float":"left", "margin-top":"0em",
          "margin-left":"0em", "width":"20%"});
     $(".timersMid").css({"float":"left", "width":"59%",
          "text-align":"center",
          "font-size":".8em"});
     $(".timersRight").css({"float":"left", "margin-top":"0em",
          "margin-right":"0em", "width":"20%"});

     $("#divAdditem").css({"clear":"both",
          "height":"5em"});
     $("#additemLeft").css({"float":"left", "margin-top":"0em",
          "margin-left":"0em", "display":"none"});
     $("#additemMid").css({"float":"left", "margin-top":"0em",
          "margin-left":"0em", "width":"69%",
          "font-size":"1em",
          "overflow":"auto",
          "overflow-x":"hidden",
          "overflow-y":"auto",
          "height":"1.47em"});
     $("#additemRight").css({"float":"left", "margin-top":"0em",
          "margin-right":"0em", "width":"30%"});

     $("#additemShort").css({"width":"73%"});
     $("#additemsLab").css({"font-size":".8em"});

     $("#additemfLab").css({"display":"none"});
     $("#datatblSelLab").css({"display":"none"});
     $("#butrowLeftLab").css({"display":"none"});

     $("#additemBot").css({"clear":"both",
          "width":"100%"});
     $("#additemFull").css({"overflow":"auto", "width":"97%",
          "height":"100%"});

     $("#divButrow").css({"clear":"both", 
          "overflow":"hidden",
          "height":"1.4em"});
     $("#butrowLeft").css({"float":"left", "margin-top":"0em",
          "margin-left":"0em", "overflow":"auto",
          "width":"68%", 
          "height":"1.4em"});
     $("#butrowRight").css({"float":"right", "margin-top":"0em",
          "margin-right":"0em", 
          "width":"30%"});

     $("#datatblSel").css({"margin-right":"0em", "width":"95%"});

     docTitle();
     tagArea.innerHTML = "0"
     msgArea.innerHTML = "Ready"

     if (debg) {alert("body On Load fired");};

// Change which data table to show"
     $("#datatblSel").change(function(){
          docTitle();
          //debg=true;
          if (debg) {
               var str1="You changed the selector to ";
               var str2=this.value.concat(" ",$("#datatblSel option:selected").text());
               var str3=" option!";
               var n = str1.concat(str2,str3);
               alert("111 .js ".concat(n));
               };
          //debg=false;

          switch(this.value){
               case "<new>":
                    if (debg) {alert($("#datatblSel option:selected").text().concat(" case"))};
                    var shell = new ActiveXObject("WScript.shell");
                    shell.run("notepad ".concat($.trim(prefix),"-dataTables.txt"));
                    break;
               default:
                    //debg=true;
                    if (this.value.substring(0,6)=="<auto>") {
                        if (debg) {alert("124 .js ".concat(this.value))};
                        var shell = new ActiveXObject("WScript.shell");
                        var str1='"'.concat($.trim(prefix),'-button.vbs" ');
                        var str2=this.value.substring(6);
                        if (debg) {alert("128 .js ".concat(str1.concat('"').concat(str2).concat('"')))};
                        shell.run(str1.concat('"').concat(str2).concat('"'));
                        if (debg) {alert("130 .js selected with ".concat($("#datatblSel option:selected").text()))};
                        };
                    //debg=false;
                    $("#divDatatable").html(read_data($("#datatblSel option:selected").text()));
                    read_format();
                    $("#rowbB").html("Row +");
               };
          });

//
//	$("button").controlclick(function(){
//	alert("onload Start Button: ".concat(this.value, ", ",
//	this.id, ", ",
//	this.parentNode.id, ", ",
//	this.parentNode.parentNode.id, ", ",
//	this.parentNode.parentNode.parentNode.id, ", ",
//	this.parentNode.parentNode.parentNode.parentNode.id, ", ",
//	this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))
//	});

     $("button").click(function(){
          //debg=true;
          if (debg) {
               var str1="You pressed the ";
               var str2=this.value;
               var str3=" button!";
               var n = str1.concat(str2,str3);
               alert("156 .js ".concat(n));
               };
          //debg=false;

          if (window.event.ctrlKey) {
               //ctrl was held down during the click
               alert("162 .js onload: ".concat(this.value, ", ",
                    this.id, ", ",
                    this.parentNode.id, ", ",
                    this.parentNode.parentNode.id, ", ",
                    this.parentNode.parentNode.parentNode.id, ", ",
                    this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                    this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"));
               var shell = new ActiveXObject("WScript.shell");
               shell.run('".\\myShortcuts\\"');
               var shell = "";
               return;
          };

          switch(this.value){
               case "Start":
                    //debg=true;
                    if (debg) {alert("178 .js onload Start Button: ".concat(this.value, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))};
                    //debg=false;
                    start_timer(this.parentNode.parentNode.id)
                    break;

               case "Stop":
                    if (debg) {alert("190 .js ".concat(this.parentNode.parentNode.id))};
                    StopTimer(this.parentNode.parentNode.id)
                    break;

               case "Add":
                    if (debg) {alert("195 .js ".concat(this.parentNode.parentNode.id))};
                    addButton();
                    break;

               case "Clear":
                    if (debg) {alert("200 .js ".concat(this.parentNode.parentNode.id))};
                    clrButton();
                    break;

               case "New":
                    if (debg) {alert("205 .js ".concat(this.parentNode.parentNode.id))};
                    var shell = new ActiveXObject("WScript.shell");
                    //alert('"notepad '.concat($.trim(prefix),'-buttons.txt"'))
                    shell.run('notepad '.concat($.trim(prefix),'-buttons.txt'));
                    break;

               case "Row +":
                    if (debg) {alert("212 .js ".concat(this.parentNode.parentNode.id))};

                    $("td div").css({"height":"7em"});
                    //$("table").resizable();

                    $(this).html("Row -");
                    break;

               case "Row -":
                    if (debg) {alert("221 .js ".concat(this.parentNode.parentNode.id))};

                    $("td div").css({"height":"2.4em"});
                    //if ($("table").resizable()>0) $("table").resizable("destroy");

                    $(this).html("Row +");
                    break;

               case "Edit":
                    //debg="y";
                    if (debg) {alert("231 .js ".concat(this.parentNode.parentNode.id))};
                    //debg="";
// THERE ARE TWO EDITS!
                    if (this.parentNode.parentNode.id=="divAdditem") {
                         //alert("Yes");
                         OpenNotepad();
                         break;
                    };
                    // else
                    var shell = new ActiveXObject("WScript.shell");
                    shell.run("explorer.exe .\\myShortcuts\\");
                    break;

               case "Sort":
                    if (debg) {alert("245 .js ".concat(this.parentNode.parentNode.id.concat(" ", this.value)))};
                    $("tbody").sortable();
                    $(this).html("Done");

                    //$(":button:eq(13)").html("8A");
                    //$(":button:contains('9')").html("9A");

                    break;

               case "Done":

                    //$(":button:eq(13)").html("8");
                    //$(":button:contains('9A')").html("9");

                    if (debg) {alert("259 .js ".concat(this.parentNode.parentNode.id.concat(" ", this.value)))};
                    if ($("tbody").sortable()>0) $("tbody").sortable("destroy");
                    $(this).html("Sort");
                    copytoHTM(datatblSel.value);
                    read_data(datatblSel.value);
                    read_format(datatblSel.value);
                    break;

 // TODO:
               case "RTF-it":
                    if (debg) {alert("268 .js ".concat($("#datatblSel option:selected").text().concat(" case")))};
                    $(this).html("TXT-it");
                    $(this).addClass("ed");

                    $("tr td:nth-child(2) div").css("color","darkblue");

                    break;

               case "TXT-it":
                    if (debg) {alert($("#datatblSel option:selected").text().concat(" case"))};

                    // divAdditem.style.display="block";
                    $(this).html("RTF-it");
                    $(this).removeClass("ed");

                    // $("#divDataout").css({"top":"8.9em",
                    //      "left":"0em"});

                    $("tr td:nth-child(2) div").css("color","black");

                    break;
//

               case "Screen Off":
                    if (debg) {alert(this.parentNode.parentNode.id)};
                    var shell = new ActiveXObject("WScript.shell");
                    shell.run('nircmd monitor off');
                    break;

               default:
                    var str1='"'.concat($.trim(prefix),'-button.vbs" ');
                    // alert(str1); // ".\myShortcuts\myShortcuts-button.vbs" 
                    var shell = new ActiveXObject("WScript.shell");
                    var str2=this.value;
					
                    // debg=true;
                    if (debg) {alert("305 .js Default onLoad Button: ".concat(str1, str2, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id))};
                    // debg=false;
					
                    while (str2.indexOf(" ")>0) {str2=str2.replace(" ", "%20")};
                    // alert(str2); //  "new%20button"
                    shell.run(str1.concat(str2,"%20",this.parentNode.parentNode.parentNode.id,"%20onLoad"));
                    var shell = "";
               };
          });

     read_format();

     });

function OpenNotepad(){
	OpenNotepad1();		 
	}
	 
	 
function docTitle(){
     document.title=$("#datatblSel option:selected").text().concat(crnotice);
     }

function read_format(){
     //debg=true;
     if (debg) {alert("335 .js ".concat('Hello World! (from "read_format")'))};
     //debg=false;

     var str1 = "<td><div class=bu>".concat("<button class=sm>c</button>",
          "<button class=sm>e</button>",
          "<button class=sm>d</button>", "</div></td>");
     if (debg) {alert("341 .js read_format adds this to a row: ".concat(str1))};

     $.each($("table tr"), function(index,value){
          //debg=true;
          if (debg) {alert("345 .js This row is ID: ".concat(value.id))};
          str2=value.innerHTML;
          str2=str2.concat(str1);
          if (debg) {alert("348 .j New value: ".concat(str2))};
          //debg=false;
          while (str2.indexOf("<BR></DIV>")>0) {str2=str2.replace("<BR></DIV>", "</DIV>")};
          $(this).html(str2);
          });

     $("#divDataout").css({"clear":"both", "margin-top":"0em",
          "margin-left":"0em", "margin-right":"0em",
          "margin-bottom":"0em", "width":"100%",
          "position":"absolute",
          "top":"8.9em",
          "left":"0em",
          "right":"0em",
          "bottom":"0em",
          "overflow":"auto"});

     $("#divDatatable").css({"margin-top":"0em",
          "margin-left":"0em", "margin-right":"0em",
          "margin-bottom":"0em",
          "width":"96%"});

     $("table").css({"table-layout":"fixed",
          "width":"100%"});

     $("table, th, td").css({"border":".1em solid darkgreen"});

     $("button.sm").css({"width":"100%", "height":"33%",
          "text-align":"center"});

     $("td div").css({"background-color":"lightgray",
          "height":"2.4em", "font-size":".8em",
          "overflow":"hidden",
          "overflow-y":"auto"});

     $("div.bu").css({"overflow-y":"hidden"});

     $("td:eq(0)").css({"width":"15%"});
     $("td:eq(1)").css({"width":"80%"});
     $("td:eq(2)").css({"width":"15px"});

// SM BUTTON CLICK
     $("button.sm").click(function(){
          //debg=true;
          if (debg) {var str1="391 .js You pressed the ";
               var str2=this.value;
               var str3=" button!";
               var n = str1.concat(str2,str3);
               alert(n);
               };
          //debg=false;

          switch(this.value){
               case "c":
                    //debg=true;
                    if (debg) {alert("402 .js read_format c sm Button: ".concat(this.value, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))};
                    if (debg) {alert(this.parentNode.parentNode.parentNode.id)};
                    //debg=false;
                    cbut(this.parentNode.parentNode.parentNode.id);
                    break;

               case "e":
                    //debg=true;
                    if (debg) {alert("read_format c sm Button: ".concat(this.value, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))};
                    if (debg) {alert(this.parentNode.parentNode.parentNode.id)};
                    //debg=false;

                         //colect all elements
                    elms=this.parentNode.parentNode.parentNode.getElementsByTagName("*");

                    //debg=true;
                    if (debg) {alert(elms.length);
                         for (var i=0; i<elms.length; i++) {alert(elms(i).innerHTML.concat(" index: ",i))};
                         };
                    //debg=false;

                         //wrap existing longText as a p and
                    longelms="<p>".concat(elms(3).innerHTML,"</p>");
                         //replace br with p
                    while (longelms.indexOf("<BR>")>0){
                         longelms=longelms.replace("<BR>", "</p><p>");
                         };

                    //debg=true;
                    if (debg) {alert(longelms)};
                    //debg=false;

                    if ($("button.ed").length){
                         //debg=true;
                         if (debg) {
                              alert("448 .js RTF Editing . . .\n".concat("Table: ", datatblSel.value,
                                   "\nRow: ", this.parentNode.parentNode.parentNode.id,
                                   "\nShort: ",elms(1).innerHTML,
                                   "\nLong: ",longelms));
                              };
                         //debg=false;

                         $(this).html("s");

                         var str1='"'.concat($.trim(prefix),'-rtfEdit.hta" ');
                         // var str1='"'.concat('_test rtfEdit.hta" ');

                         str2='"'.concat(this.parentNode.parentNode.parentNode.id,'" "',
                              datatblSel.value, '" "',
                              elms(1).innerHTML, '" "', longelms, '"');

                         //debg=true;
                         if (debg) {alert(str1.concat(elms2))};
                         //debg=false;

                         var shell = new ActiveXObject("WScript.shell");
                         shell.run(str1.concat(str2),1,true);

                         break;
                         };

                    ebut(this.parentNode.parentNode.parentNode.id);

                    this.parentNode.parentNode.parentNode.style.height="7em"

                    //debg=true;
                    if (debg) {alert(elms.length);
                         for (var i=0; i<elms.length; i++) {alert(elms(i).innerHTML)};
                         };
                    //debg=false;

                    var ht="7.82em"
                    elms(1).style.height="100%";
                    elms(1).style.overflow="hidden";

                    elms(3).style.height=ht;

                    elms(5).style.height="100%";
                    elms(5).style.overflow="hidden";

                    elms(7).style.height=ht;

                    elms(9).style.height="100%";
                    elms(9).style.overflow="hidden";

                    break;

               case "s":
                    //debg=true;
                    if (debg) {alert("read_format s sm Button: ".concat(this.value, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))};
                    if (debg) {alert(this.parentNode.parentNode.parentNode.id)};
                    //debg=false;

                    if ($("button.ed").length){
                         //debg=true;
                         if (debg) {
                              alert("RTF Editing . . .\n".concat("Table: ", datatblSel.value,
                                   "\nRow: ", this.parentNode.parentNode.parentNode.id));
                              };
                         //debg=false;

                         $(this).html("e");
                         $("#rowbB").html("Row +");

                         $(":button:contains('TXT-it')").html("RTF-it");
                         $(":button").removeClass("ed");

                         $("#divDatatable").html(read_data(datatblSel.value));
                         read_format();
                         break;
                         };

                    var whichRow=this.parentNode.parentNode.parentNode.id;

                    var x=document.getElementsByTagName("textarea");
                    var newOnes=x[1].innerHTML;
                    var newTwos=x[2].innerHTML;
                    // debg=true;
                    if (debg) {alert (newOnes.concat(" ,  ", newTwos))};
                    if (debg) {alert (datatblSel.value.concat(" ,  ", whichRow))};
                    // debg=false;
					
                    addEdited(datatblSel.value, whichRow, newOnes, newTwos);

                    $("#divDatatable").html(read_data(datatblSel.value));
                    read_format();
                    $("#rowbB").html("Row +");
                    break;

               case "d":
                    //debg=true;
                    if (debg) {alert("read_format d sm Button: ".concat(this.value, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.parentNode.id, " end"))};
                    if (debg) {alert(this.parentNode.parentNode.parentNode.id)};
                    //debg=false;
                    dbut(this.parentNode.parentNode.parentNode.id);
                    $("#divDatatable").html(read_data(datatblSel.value));
                    read_format();
                    break;

               default:
                    var shell = new ActiveXObject("WScript.shell");
                    var str1='"'.concat($.trim(prefix),'-button.vbs" ');
                    //debg=true;
                    if (debg) {alert(str1)};
                    var str2=this.value;
                    if (debg) {alert("571 .js read_format sm Button default: ".concat(str1, str2, ", ",
                         this.id, ", ",
                         this.parentNode.id, ", ",
                         this.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.id, ", ",
                         this.parentNode.parentNode.parentNode.parentNode.id));
                         };
                    //debg=false;
                    shell.run(str1.concat(str2.replace(" ","%20"),"%20",this.parentNode.parentNode.parentNode.id, "%20from%20read_format"));
               };
          });
     };

function rtfBut() {
     //alert(nicEditors.findEditor('area1').getContent().concat(" Here"));

     //debg=true;
     if (debg) {elms=document.getElementsByTagName("*")};
     if (debg) {alert(elms.length);
          for (var i=0; i<elms.length; i++) {alert(String(i).concat(" ",elms(i).innerHTML))};
          };
     //debg=false;

     };

function cancelBut() {
     //alert(nicEditors.findEditor('area1').getContent().concat(" Here"));

     //debg=true;
     if (debg) {elms=document.getElementsByTagName("*")};
     if (debg) {alert(elms.length);
          for (var i=0; i<elms.length; i++) {alert(String(i).concat(" ",elms(i).innerHTML))};
          };
     //debg=false;

     };
