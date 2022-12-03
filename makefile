
dss.zip: clean
	zip -r dss.zip customize.sh META-INF module.prop system

clean:
	rm -f dss.zip
