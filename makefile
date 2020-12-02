CC=dmd
CFLAGS=-w
DAYS=`ls | grep '^[0-2][0-9]$$'`

all:
	@for DAY in $(DAYS); do \
		$(CC) $(CFLAGS) -od=$$DAY/ -of=$$DAY/d$$DAY $$DAY/d$$DAY.d; \
	done

clean:
	@for DAY in $(DAYS); do \
	   rm -f $$DAY/d$$DAY $$DAY/d$$DAY.o; \
	done
