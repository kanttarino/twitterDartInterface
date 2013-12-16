import 'dart:html';

void main() {
  
  querySelector("#message")
    ..onKeyUp.listen(addTweetToTimeline);

}

void addTweetToTimeline(KeyboardEvent event){
  InputElement user = querySelector("#username");
  TextAreaElement message = querySelector("#message");
  
  if (event.keyCode == 13){
    DivElement tweet = createTweet(user, message);
    if (tweet != null){
      querySelector("#ti_tweet_list").insertAdjacentElement("afterBegin", tweet);  
      message.value = '';  
    }
  }  
}

void checkHasthtag(List list, int index, String string){
  if (string[0] == "#" || string[0] == "@")
  {
    list[index] = '<span class="named_or_hashtagged">' + string + '</span>';
  }
}

DivElement createTweet(InputElement userElement, TextAreaElement messageElement){
  if (userElement.value == '' || messageElement.value == ''){
    return null;
  }

  var message = messageElement.value;
  
  List parts = message.split(" ");
  for (int i = 0; i < parts.length ; i++){
      checkHasthtag(parts, i, parts[i]);
  }
  
  var time = new DateTime.now();
  
  var checkedText = parts.join(" ");
  
  DivElement messageDiv = new DivElement();
  messageDiv.classes.add("ti_tweet_message");
  messageDiv.appendHtml(checkedText);
  
  DivElement userDiv = new DivElement();
  userDiv.classes.add("ti_tweet_username");
  userDiv.appendHtml('@' + userElement.value);
  userDiv.appendHtml(' <span class="ti_tweet_date"> said at ' + buildTime(time) + '</span>');
  
  DivElement tweet = new DivElement();
  tweet.classes.add("ti_tweet");
  tweet.children.add(userDiv);
  tweet.children.add(messageDiv);
  
  return tweet;
}

String buildTime(DateTime time){
  List days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  List months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 
                 'September', 'October', 'November', 'December'];
  String theDay = time.day.toString();
  if (theDay == "1") theDay += "st";
  else if (theDay[theDay.length - 1] == "2" ) theDay += "nd";
  else if (theDay[theDay.length - 1] == "3" ) theDay += "rd";
  else theDay += "th";

  String theTimeIs =  
      'said at ' +
      time.hour.toString() + ':' + time.minute.toString() +
      ' on ' + days[time.weekday - 1] + ', ' +  months[time.month - 1] + 
      ' the' + theDay + " of " + time.year.toString();
      
 return theTimeIs;
}

