lextest: driver.o lex.yy.o errormsg.o util.o
	cc -g -o lextest driver.o lex.yy.o errormsg.o util.o

driver.o: driver.c tokens.h errormsg.h util.h
	cc -g -c driver.c

errormsg.o: errormsg.c errormsg.h util.h
	cc -g -c errormsg.c

lex.yy.o: lex.yy.c tokens.h errormsg.h util.h
	cc -g -c lex.yy.c

lex.yy.c: lexer.lex
	lex lexer.lex

util.o: util.c util.h
	cc -g -c util.c

output: lextest
	for test in `ls testcases`; do \
		./$< testcases/$${test} > logs/$${test}.log; \
		diff logs/$${test}.log logs/ref$${test}.log; \
	done

clean: 
	rm -f lextest util.o driver.o lex.yy.o lex.yy.c errormsg.o
