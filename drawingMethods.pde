private final int STROKE_WEIGHT = 15;
/*
* Draws side bar which shows current players scores.
* Also shows buttons that change background.
*/
private void drawSideBar() {
    textFont(normalFont);
    
    image(oilCanvas, 5*width/6, 0, width, height);

    fill(0);
    stroke(0);
    rect(5*width/6, 0, 5*width/6 + 5, height);

    //information about exit
    textSize(height/30);
    fill(127, 0, 0);
    text("Izlaz: esc", 6*width/7, height/15);
    if(soundOn) {
        image(sound, width*0.96, height/20, width*0.02, height*0.02);
    } else {
        image(noSound, width*0.96, height/20, width*0.02, height*0.02);
    }
    text("Legenda:", 6*width/7, height/5);
    textSize(height/40);
    float textHeight = textAscent() - textDescent();
    fill(speed.getColor());
    drawStar(6*width/7, height/5 + 3*textHeight, 3, 8, 5);
    text(" Ubrzaj igrače", 6*width/7 + 10, height/5 + 3*textHeight + textHeight/2);
    fill(size.getColor());
    drawStar(6*width/7, height/5 + 5*textHeight, 3, 8, 5);
    text(" Podebljaj igrače", 6*width/7 + 10, height/5 + 5*textHeight + textHeight/2);
    fill(changeKeys.getColor());
    drawStar(6*width/7, height/5 + 7*textHeight, 3, 8, 5);
    text(" Promjeni smjer", 6*width/7 + 10, height/5 + 7*textHeight + textHeight/2);
    
    
    
    fill(127, 0, 0);
    //Curent players scores
    textSize(height/30);
    text("Rezultat:", 6*width/7, height*0.4);
    textSize(height/40);
    drawPlayerScore(playerOne, 3*textHeight);
    drawPlayerScore(playerTwo, 5*textHeight);
    if(numOfPlayers == 3 ||numOfPlayers == 4) {
        drawPlayerScore(playerThree, 7*textHeight);
    }
    if(numOfPlayers == 4) {
        drawPlayerScore(playerFour, 9*textHeight);
    }
    
    if(startTimer > 0) {
        fill(127, 0, 0);
        text("Proteklo vrijeme (s): ", 6*width/7, height*0.12);
        textHeight = textAscent() - textDescent();
        if(paused) {
            text(timerWhenPaused/1000, 6*width/7, height*0.12 + 2*textHeight);
        } else {
            text((millis() - startTimer)/1000, 6*width/7, height*0.12 + 2*textHeight);
        }
    } 
    
    if(!betweenRounds && !endOfGame) {
        drawPauseButton();
    }
}

/*
* Draws a score for each player. Only called in drawSideBar().
*/
private void drawPlayerScore(Player player, float distance) {
    fill(player.getColor());
    text(player.getName()+ ": ", 6*width/7, height*0.4 + distance);
    text(player.getScore(), 6*width/7 + textWidth(player.getName()+ ": "), height*0.4 + distance);
}

/*
* Draw one player current position and update his listOfPassedPoints.
*/
private void drawPlayersCurrentPosition(Player player) {
    if(player.isAlive()) {
        fill(player.getColor());
        stroke(player.getColor());   
        ellipse(player.getX(), player.getY(), player.getSize(), player.getSize());
    }
}

/*
* Draws black or white background over playing area based on users wish.
*/
void drawTexture() {
    fill(0);
    stroke(0);
    strokeWeight(STROKE_WEIGHT);
    ellipse(5*width/12, height/2, width/3, 3*height/7);
    strokeWeight(1);
    image(currentTexture, 0, 0, width, height);
}

private void chooseTextureRandomly() {
    int texture = (int)random(1, 5.99);
    if(texture == 1) {
        currentTexture = snowTexture;
    } else if(texture == 2) {
        currentTexture = blackTexture;
    } else if(texture == 3) {
        currentTexture = brownTexture;
    } else if(texture == 4) {
        currentTexture = parquetTexture;
    } else if (texture == 5) {
         currentTexture = yellowTexture;
    }
}

private void chooseBackgroundRandomly() {
    int background = (int)random(1, 4.99);
    if(background == 1) {
        currentBackground = symmetricalBackground;
    } else if(background == 2) {
        currentBackground = xmasBackground;
    } else if(background == 3) {
        currentBackground = dirtyPaperBackground;
    } else if(background == 4) {
        currentBackground = redBackground;
    } 
}

private void chooseBGMusicRandomly() {
  int backgroundMusic = (int)random(1, 4.99);
    if(backgroundMusic == 1) {
        currentBGMusic = bgMusic;
    } else if(backgroundMusic == 2) {
        currentBGMusic = bgMusic2;
    } else if(backgroundMusic == 3) {
        currentBGMusic = bgMusic3;
    } else if(backgroundMusic == 4) {
        currentBGMusic = bgMusic4;
    } 
}

/*
* Draws again button on side bar. Only called when round is over.
*/
private void drawAgainButton() {
    textSize(height/35);
    betweenRounds = true;
    float textHeight = textAscent() - textDescent();
    float textWidth = textWidth("Nova runda!");
    fill(0, 255, 0);
    strokeWeight(3);
    ellipse(11*width/12, height*0.85, textWidth*0.6, textWidth*0.6);
    strokeWeight(1);
    fill(127, 0, 0);
    text("Nova runda!", 11*width/12 - textWidth/2, height*0.85 + textHeight/2);  
}

private void drawPauseButton() {
    textSize(height/35);
    float textHeight = textAscent() - textDescent();
    float textWidth = textWidth("Nova runda!");
    fill(0, 0, 255);
    strokeWeight(3);
    ellipse(11*width/12, height*0.85, textWidth*0.6, textWidth*0.6);
    strokeWeight(1);
    fill(255, 0, 0);
    if(!paused) {
        textWidth = textWidth("Pauziraj!");
        text("Pauziraj!", 11*width/12 - textWidth/2, height*0.85 + textHeight/2);  
    } else {
       textWidth = textWidth("Nastavi!");
       text("Nastavi!", 11*width/12 - textWidth/2, height*0.85 + textHeight/2);  
    }
}  


private void initializeBooster(Booster booster, String methodName) {
    if(millis() - booster.getStartTime() > 1000 && booster.getStartInterval() > 0 && !booster.getShown()) {
        booster.setStartTime(millis());
        booster.setStartInterval(booster.getStartInterval() - 1);
    }
        
    if(booster.getStartInterval() == 0 && !booster.getShown()) {
        int x, y;
        do {
            float u = random(0, 1);
            float v = random(0, 1);
            float t = 2 * PI * v;
            x = int(sqrt(u) * cos(t) * 3*width/10);
            y = int(sqrt(u) * -sin(t) * 3*height/8);
        } while(!available(5*width/12 + x, height/2 + y));
        booster.setX(5*width/12 + x);
        booster.setY(height/2 + y);
        booster.setShown(true);
        booster.setStartInterval(6);
        try {
            booster.setTask(MMS.class.getMethod(methodName, Player.class, Booster.class));
        } catch(NoSuchMethodException e) {
          println(e.getMessage()); //<>//
        }
         try {
           if(booster.getCollector() != null) {
               booster.getTask().invoke(this, booster.getCollector(), booster);
           }
        } catch (Exception e) {
            println(e.getMessage());
        }
    }     
}

private boolean available(int x, int y) {
    for (int i = x - 10; i <= x + 10; i++) {
        for (int j = y - 10; j <= y + 10; j++) {
            color c = get(i, j);
            if(hasCrashedIntoPlayer(c) 
            || c == size.getColor() || c == speed.getColor()
            || c == changeKeys.getColor()) return false;
        }
    }
    return true;
}

private void drawBooster(Booster booster) {
    pushMatrix();
    mask1.ellipse(booster.getX(), booster.getY(), BOOSTER_SIZE/2 + 2, BOOSTER_SIZE/2 + 2);
    currentTexture.mask(mask1);
    image(currentTexture, booster.getX() - BOOSTER_SIZE, booster.getY() - BOOSTER_SIZE, 2*(BOOSTER_SIZE + 2), 2*(BOOSTER_SIZE + 2));  
    translate(booster.getX(), booster.getY());
    rotate(frameCount / -10.0);
    fill(booster.getColor());
    stroke(booster.getColor());
    drawStar(0, 0, 3, BOOSTER_SIZE/2, 5); 
    popMatrix();
}

private void drawStartScreen() {
  
   image(frontPageBackground, 0, 0, width, height);
   
    image(frontPageBackground, 0, 0, width, height);
   
    
    textFont(titleFont);  
    fill(0);
    text("Pazi!", width/20, height*0.45);
    text("KRIVULJA", width/9, height*0.45 + (textAscent() - textDescent())*1.5);
   
    textFont(menuFont);
    
     if(soundOn) {
        image(sound, width*0.96, height/20, width*0.02, height*0.02);
    } else {
        image(noSound, width*0.96, height/20, width*0.02, height*0.02);
    }
   
    text("NOVA IGRA", width*0.8 - textWidth("NOVA IGRA")/2, height*0.5);
    text("IZLAZ", width*0.8 - textWidth("IZLAZ")/2, height*0.5 + (textAscent() - textDescent())*1.5);
   
}
private void checkIfMouseAboveMenu() {
    if(width*0.8 - textWidth("NOVA IGRA")/2 <= mouseX && mouseX <= width*0.8 + textWidth("NOVA IGRA")/2 && height*0.5 >= mouseY && height*0.5 - textAscent() + textDescent() <= mouseY) {
        frontScreen = false;
        textFont(menuFontBold);
        textSize(height/10);
        float textHeight = textAscent() - textDescent();
        nameField = new GTextField(this, width*0.4 + textWidth("Ime: "), (height - textHeight)/2, width/10, textHeight/2);
        nameField.setVisible(false);
        btnLeft = new GButton(this, width*0.4 + textWidth("Lijevo: "), height/2 + textHeight, width/20, textHeight);
        btnRight = new GButton(this, width*0.4 + textWidth("Lijevo: "), height/2 + 3*textHeight, width/20, textHeight);
        btnLeft.setVisible(false);
        btnRight.setVisible(false);
        drawChoosePlayersScreen();
        newGame = true;
    } else if(width*0.8 - textWidth("IZLAZ")/2 <= mouseX && mouseX <= width*0.8 + textWidth("IZLAZ")/2 && height*0.5 + (textAscent() - textDescent())*1.5 >= mouseY && height*0.5 + (textAscent() - textDescent())/2 <= mouseY) {
         exit();
    }
}

private void drawMenu(int pos) {
   image(frontPageBackground, 0, 0, width, height);
    if(soundOn) {
        image(sound, width*0.96, height/20, width*0.02, height*0.02);
    } else {
        image(noSound, width*0.96, height/20, width*0.02, height*0.02);
    }
   
  
   
   
    textFont(titleFont);  
    fill(0);
    text("Pazi!", width/20, height*0.45);
    text("KRIVULJA", width/9, height*0.45 + (textAscent() - textDescent())*1.5);
   
    if(pos == 0) {
        textFont(menuFont);
        text("NOVA IGRA", width*0.8 - textWidth("NOVA IGRA")/2, height*0.5);
        text("IZLAZ", width*0.8 - textWidth("IZLAZ")/2, height*0.50 + (textAscent() - textDescent())*1.5);
        menuDrawn = true;
    } else if(pos == 1) {
        textFont(menuFontBold);
        fill(127, 0, 0);
        text("NOVA IGRA", width*0.8 - textWidth("NOVA IGRA")/2, height*0.5);
        textFont(menuFont);
        fill(0);
        text("IZLAZ", width*0.8 - textWidth("IZLAZ")/2, height*0.50 + (textAscent() - textDescent())*1.5);
        menuDrawn = false;
    } else if(pos == 2) {
        textFont(menuFont);
        text("NOVA IGRA", width*0.8 - textWidth("NOVA IGRA")/2, height*0.5);
        fill(127, 0, 0);
        textFont(menuFontBold);
        text("IZLAZ", width*0.8 - textWidth("IZLAZ")/2, height*0.50 + (textAscent() - textDescent())*1.5);
        fill(0);
        menuDrawn = false;
    }
}

private void drawChoosePlayersScreen() { 
    image(newGameBackground, 0, 0, width, height);
    PShape left = createShape();
    PShape right = createShape();
    left.beginShape();
    left.fill(255, 255, 0);
    left.stroke(5);
    left.vertex(width/25, height/2);
    left.vertex(width/12, height*0.55);
    left.vertex(width/12, height*0.45);
    left.endShape(CLOSE);
    shape(left);
    right.beginShape();
    right.fill(255, 220, 0);
    right.stroke(5);
    right.vertex(24*width/25, height/2);
    right.vertex(11*width/12, height*0.55);
    right.vertex(11*width/12, height*0.45);
    right.endShape(CLOSE);
    shape(right);
    
    textFont(menuFontBold);
    fill(200, 0, 0);
    textSize(height/10);
    float textWidth = textWidth("Odaberite broj igraca:");
    text("Odaberite broj igraca:", (width - textWidth)/2, height/4);
    
    int buttonRadius = width/10;
    btn2Players = new GButton(this, width/2 - 2*buttonRadius, height/2, buttonRadius, buttonRadius, "2"); 
    btn3Players = new GButton(this, (width - buttonRadius)/2, height/2, buttonRadius, buttonRadius, "3");
    btn4Players = new GButton(this, width/2 + buttonRadius, height/2, buttonRadius, buttonRadius, "4");
    btn2Players.setLocalColor(4, color(255, 0, 0));
    btn3Players.setLocalColor(4, color(255, 0, 0));
    btn4Players.setLocalColor(4, color(255, 0, 0));
    btn2Players.setLocalColor(3, color(0, 0, 255));
    btn3Players.setLocalColor(3, color(0, 0, 255));
    btn4Players.setLocalColor(3, color(0, 0, 255));
    
    textSize(width/35);
    fill(80, 255, 0);
    textWidth = textWidth("Pravila: Upravljati svojom zmijicom i izgjegavati tragove koje ostavljaju druge zmijice.");
    float textHeight = textAscent() - textDescent();
    text("Pravila: Upravljati svojom zmijicom i izgjegavati tragove koje ostavljaju druge zmijice.", (width - textWidth)/2, height*0.85);
    textWidth = textWidth("Pobjednik runde je igrac koji prezivi. Pobjednik igre je igrac koji prvi postigne 10 bodova.");
    text("Pobjednik runde je igrac koji prezivi. Pobjednik igre je igrac koji prvi postigne 10 bodova.", (width - textWidth)/2, height*0.85 + 2*textHeight);
}

private void drawScreenPlayer(int i) {
    image(newGameBackground, 0, 0, width, height);
    PShape left = createShape();
    PShape right = createShape();
    left.beginShape();
    left.fill(255, 255, 0);
    left.stroke(5);
    left.vertex(width/25, height/2);
    left.vertex(width/12, height*0.55);
    left.vertex(width/12, height*0.45);
    left.endShape(CLOSE);
    shape(left);
    textFont(menuFontBold);
    textSize(height/10);
        
    if(i != numOfPlayers) {
        right.beginShape();
        right.fill(255, 220, 0);
        right.stroke(5);
        right.vertex(24*width/25, height/2);
        right.vertex(11*width/12, height*0.55);
        right.vertex(11*width/12, height*0.45);
        right.endShape(CLOSE);
        shape(right);
    } else {
        right.beginShape();
        right.fill(255, 255, 1);
        right.stroke(5);
        right.vertex(24*width/25, height*0.53);
        right.vertex(24*width/25, height*0.46);
        right.vertex(0.9*width, height*0.42);
        right.vertex(5*width/6, height*0.46);
        right.vertex(5*width/6, height*0.53);
        right.vertex(0.9*width, height*0.57);
        right.endShape(CLOSE);
        shape(right);
        fill(200, 0, 1);
        textSize(height/15);
        text("IGRAJ!", 0.9*width - textWidth("IGRAJ!")/2, height/2 + (textAscent() - textDescent())/2); 

    }
        textSize(height/10);
        fill(200, 0, 0);
        text("Igrac " + i + ":", (width - textWidth("Igrač 1:"))/2, height*0.3);
        text("Ime: ", width*0.4, height/2);
        text("Lijevo: ", width* 0.4, height/2 + 2*(textAscent() - textDescent()));
        text("Desno: ", width* 0.4, height/2 + 4*(textAscent() - textDescent()));
        
        if(i == 1) {
            nameField.setText(playerOne.getName());
            btnLeft.setText(asciiToKey(playerOne.getLeft()) + "");
            btnRight.setText(asciiToKey(playerOne.getRight()) + "");
        } else if(i == 2) {
            nameField.setText(playerTwo.getName());
            btnLeft.setText(asciiToKey(playerTwo.getLeft()) + "");
            btnRight.setText(asciiToKey(playerTwo.getRight()) + ""); 
        } else if(i == 3) {
            nameField.setText(playerThree.getName());
            btnLeft.setText(asciiToKey(playerThree.getLeft()) + "");
            btnRight.setText(asciiToKey(playerThree.getRight()) + "");
        } else if(i == 4) {
            nameField.setText(playerFour.getName());
            btnLeft.setText(asciiToKey(playerFour.getLeft()) + "");
            btnRight.setText(asciiToKey(playerFour.getRight()) + "");
        }
}

private void startGame() {
    startSound.close();
    if(soundOn){
    
    chooseBGMusicRandomly();
    currentBGMusic.loop();
    
    }
    frontScreen = false;

    initializePlayersOnStart();

    startCounter = true;  
    drawSideBar();
    chooseBackgroundRandomly();
    image(currentBackground, 0, 0, 5*width/6, height);
    chooseTextureRandomly();
    drawTexture();
    fill(127, 0, 0);        
    startTime = millis();
    startInterval = secondsToStart;
    text(str(startInterval), 5*width/12, (height - textWidth("0"))/2);  
}

/*
* Draw a booster in a shape of a star
*/
void drawStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  strokeWeight(3);
  stroke(0);
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  strokeWeight(1);
  }
  endShape(CLOSE);
}
