var total_seconds=1*60;
var c_minutes=parseInt(total_seconds/60);
var c_seconds=parseInt(total_seconds%60);
function checkTime(){
  document.getElementById("timer").innerHTML
  = '<h4 id="time-box">' +c_minutes + ':' +c_seconds + ' </h4>';
  if(total_seconds<=0){

    alert('Time up!')
    document.getElementById('SubmitTag').click();

  }else{
    total_seconds=total_seconds-1;
    c_minutes=parseInt(total_seconds/60);
    c_seconds=parseInt(total_seconds%60);
    setTimeout("checkTime()",1000);
  }
}

setTimeout("checkTime()",1000)
