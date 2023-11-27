100 REM TIC-TAC-TOE. YOU (X) VS. THE COMPUTER (O)
110 GOTO 200
rem BOARD IS IN MEMORY LOCATIONS 0007-000F
rem .  0 IS EMPTY, 1 IS X. 3 TS O
rem I HAS CURRENT POSITION
rem G IS PEEK ROUTINE ADDRESS
rem P IS POKE ROUTINE ADDRESS
rem F=1 IF YOU PLAY FIRST
rem U IS NUMBER OF UNPLAYED SQUARES
rem Z=1 IF SOMEONE WON
200 REM
210 PRINT "TIC-TAC-TOE. YOU AGAINST TINY BASIC"
220 PRINT "YOU ARE X. I AM O."
230 PRINT "YOU PLAY YOUR TURN BY TYPING THE NUMBER OF A SQUARE."
240 A=0
250 B=0
260 C=0
270 D=0
280 E=0
290 F=O
300 PRINT
310 PRINT "FIRST, ";
320 PRINT "PLEASE TELL ME WHERE THE COLD START IS."
330 PRINT "IN DECIMAL";
340 INPUT I
350 IF I/256*256=I GOTO 400
360 IF I/100*100=I GOTO 330
370 PRINT "NO. NOT HEX.  ";
380 GOTO 330
400 P=I+24
410 G=I+20
420 PRINT "THAT IS ";I/4096;(I-I/4096*4096)/256;
430 PRINT "00 IN HEX.  THANKS."
440 GOTO 500
450 TO CONSERVE MEMORY, LINES 100-500 MAY BE RUN ONCE
460 THEN DELETED (CLEAR) BEFORE LOADING THE REST OF THE PROGRAM
500 REM---ON WITH THE SHOW...
1000 LET F=1
1010 PRINT
1020 PRINT "NEW GAME."
1100 LET I=7
1110 LET I=USR(P,I,0)*0+I+1
1120 IF I<16 GOTO 1110
1130 LET U=9
1140 LET Z=0
1150 IF F=0 THEN GOTO 4010
1160 GOTO 2010
1500 REM X WON.
1510 LET Z=1
1520 LET F=0
2000 REM PRINT GAME STATE
2010 LET I=6
2100 PRINT
2110 LET I=I+1
2120 PRINT " ";
2130 GOTO USR (G,I)*20+2200
2200 PRINT I-6;
2210 GOTO 2300
2220 PRINT "X";
2230 GOTO 2300
2260 PRINT "O";
2300 IF I/3*3==I GOTO 2400
2310 PRINT " |";
2320 GOTO 2110
2400 PRINT
2420 IF I==15 GOTO 3000
2430 PRINT "---+---+---"
2440 GOTO 2110
3000 IF Z=0 GOTO 3100
3010 REM THE GAME IS OVER.
3020 IF F=1 GOTO 3050
3030 PRINT "YOU WIN."
3040 GOTO 1010
3050 PRINT "I WIN."
3060 GOTO 1010
3100 IF U>0 GOTO 3210
3110 PRINT "CAT'S GAME."
3120 LET F=1-F
3130 GOTO 1010
3200 REM INPUT NEXT PLAY.
3210 PRINT "YOUR PLAY";
3220 INPUT I
3230 IF I>0 IF I<10 GOTO 3270
3240 PRINT "PLEASE TYPE A NUMBER BETWEEN 1 AND 9"
3250 PRINT WHERE YOU WISH TO PLAY YOUR X'
3260 GOTO 3210
3270 IF USR (G,I+6)=0 GOTO 3310
3280 PRINT "THAT SQUARE IS ALREADY TAKEN."
3290 GOTO 3210
3300 REM CHECK IF X WON.
3310 LET U=USR(P,I+6,1)*0+U-1
3320 LET W=6100
3330 GOSUB W
3340 IF J>0 IF L*M*N=1 GOTO 1510
3350 LET W=W+100
3360 IF W<6500 GOTO 3330
3400 REM CHECK IF CATS GAME
3410 IF U==0 GOTO 2010
4000 REM FIND BEST O PLAY
4010 LET I=1
4020 LET T=-1
4290 REM EVALUATE I'TH SQUARE
4300 LET S=0
4310 IF USR(G,I+6)>0 GOTO 4480
4320 LET W=6100
4330 GOSUB W
4340 IF J==0 GOTO 4410
4350 LET J=L+M+N
4360 IF J==4 THEN GOTO 4410
4370 IF J==2 THEN LET S=S+20
4380 IF J==6 THEN LET S=S+100
4390 IF J==0 THEN LET S=S+2
4400 LET S=S+J
4410 LET W=W+100
4420 IF W<6500 GOTO 4330
4430 IF S<T THEN GOTO 4470
4440 LET T=S
4450 LET B=I
4460 REM SAY SOMETHING, SO IT WONT SEEN SO LONG.
4470 PRINT ".";
4480 LET I=I+1
4490 IF I<10 GOTO 4300
4500 PRINT "I PLAY ";B
4510 PRINT
4520 LET J=USR(P,B+6,3)
4530 LET U=U-1
4540 IF T<100 THEN GOTO 2010
4550 REM I WON I WON I WON
4560 F=1
4570 Z=1
4580 GOTO 2010
6000 REM SUBROUTINR TO LOOK AT ONE ROW, COL, OR DIAG
6010 REM I IS THE POSITION OF REFERENCE
6020 REM L,M,N ARE RETURNED WITH CONTENTS OF THE THREE SOUARES
6030 REM ENTER AT 6100,6200,6300, OR 6400...
6040 REM TO EXAMINE ROW,COLUMN,DOWN DIAGONAL OR UP DIAGONAL
6090 REM W=HORIZONTAL
6100 LET J=(I-1)/3*3+8
6110 LET D=1
6120 GOTO 6500
6190 REM W=VERTICAL
6200 LET J=I-(I-1)/3*3+9
6210 LET D=3
6220 GOTO 6500
6290 REM W=DOWN DIAGONAL
6300 IF I-1<>(I-1)/4*4 GOTO 6440
6310 LET D=4
6320 REM BOTH DIAGONALS GO THRU CENTER
6330 LET J=11
6340 GOTO 6500
6390 REM W=UP DIAGONAL
6400 LET D=2
6410 IF I>1 IF I<9 IF I=I/2*2+1 GOTO 6330
6430 REM A DIAGONAL DOES NOT GO THRU THIS SQUARE
6440 LET J=0
6450 RETURN
6490 REM NOW WE KNOW CENTER OF THIS THREE AND +/- OFFSET
6500 LET L=USR(G,J-D)
6510 LET M=USR(G,J)
6520 LET N=USR(G,J+D)
6530 RETURN 
