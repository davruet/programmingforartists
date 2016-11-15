


/*
 *  This sketch sends data via HTTP GET requests to data.sparkfun.com service.
 *
 *  You need to get streamId and privateKey at data.sparkfun.com and paste them
 *  below. Or just customize this script to talk to other HTTP servers.
 *
 */

#ifdef ESP8266
#include <ESP8266WiFi.h>
#include <ESP8266mDNS.h>
#include <ArduinoOTA.h>
#else
#include <WiFi.h>
 #include <WiFiClientSecure.h>

#endif

const char* ssid     = "uowireless";
const char* host = "data.sparkfun.com";
const char* streamId   = "my github public key";
const char* privateKey = "my github private key";

const char* authhost = "wireless-auth.uoregon.edu";

const char* username = "myusername";
const char* password = "mypassword";

void login(){
  WiFiClientSecure sClient;
  if (!sClient.connect(authhost, 443)){
    Serial.println("Wireless connection failed.");
  } else {
    sClient.print(String("POST /login.html") +" HTTP/1.1\r\n" + 
        "Host: wireless-auth.uoregon.edu\r\n"
        "Connection: keep-alive\r\n"
        "Content-Length: 147\r\n"
        "Cache-Control: max-age=0\r\n"
        "Origin: https://wireless-auth.uoregon.edu\r\n"
        "Upgrade-Insecure-Requests: 1\r\n"
        "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/54.0.2840.71 Safari/537.36\r\n"
        "Content-Type: application/x-www-form-urlencoded\r\n"
        "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\r\n"
        "Referer: https://wireless-auth.uoregon.edu/fs/customwebauth/login.html?switch_url=https://wireless-auth.uoregon.edu/login.html&");

   
  
   sClient.printf(
         "ap_mac=%s&client_mac=%s&wlan=uowireless&redirect=www.theonion.com/\r\n", WiFi.BSSIDstr().c_str(), WiFi.macAddress().c_str());

    sClient.print(
         "Accept-Encoding: gzip, deflate, br\r\n"
          "Accept-Language: en-US,en;q=0.8\r\n");

    sClient.print("\r\n");
    sClient.print("buttonClicked=4&err_flag=0&err_msg=&info_flag=0&info_msg=&redirect_url=www.theonion.com%2F&username=");
    sClient.print(username);
    sClient.print("&password=");
    sClient.print(password);
    sClient.print("&x=41&y=17");
    
    //sClient.print("\r");

    Serial.println("request sent");
    while (sClient.connected()) {
      String line = sClient.readStringUntil('\n');
      Serial.print(line);
      if (line == "\r") {
        Serial.println("headers received");
        break;
      }
    }
  Serial.println("Body:");
  while (sClient.connected()){
    String line = sClient.readStringUntil('\n');
    Serial.print(line);
  }
  
}
}

void setup() {
  Serial.begin(115200);
  delay(10);

  // We start by connecting to a WiFi network

  Serial.println();
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  
  WiFi.begin(ssid);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");  
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

  login();
  
}


void loop() {
  delay(5000);

  Serial.print("connecting to ");
  Serial.println(host);
  
  // Use WiFiClient class to create TCP connections
  WiFiClient client;
  const int httpPort = 80;
  if (!client.connect(host, httpPort)) {
    Serial.println("connection failed");
    return;
  }
  
  // We now create a URI for the request
  String url = "/input/";
  url += streamId;
  url += "?private_key=";
  url += privateKey;
  url += "&gsr=";
  url += analogRead(A0);
  
  Serial.print("Requesting URL: ");
  Serial.println(url);
  
  // This will send the request to the server
  client.print(String("GET ") + url + " HTTP/1.1\r\n" +
               "Host: " + host + "\r\n" + 
               "Connection: close\r\n\r\n");
  unsigned long timeout = millis();
  while (client.available() == 0) {
    if (millis() - timeout > 5000) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return;
    }
  }
  
  // Read all the lines of the reply from server and print them to Serial
  while(client.available()){
    String line = client.readStringUntil('\r');
    Serial.print(line);
  }
  
  Serial.println();
  Serial.println("closing connection");
}

