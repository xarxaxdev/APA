file = tsp

$(file): $(file).pl
	swipl -quiet -O -t main --stand_alone=true -o $(file) -c $(file).pl
