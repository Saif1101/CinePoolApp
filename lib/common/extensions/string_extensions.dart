extension StringExtension on String{
  String intelliTrim(){
    return this.length > 12 ? '${this.substring(0,12)}...':this;
  }

  String getYear(){
    return this.isEmpty?'':this.substring(0,4);
  }

  String getDateTime(){
    return this.isEmpty?'':this.substring(0,19);
  }

  String getDateFromTimestamp(){
    String newSt =  this.isEmpty?'':this.substring(2,10);
    return newSt.replaceAll('-', '/');
  }

  String getTimeFromTimestamp(){
    return this.isEmpty?'':this.substring(11,16);
  }
}