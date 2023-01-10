# recreate zip release for the module

dss.zip: clean
	zip -r dss.zip customize.sh META-INF module.prop system.prop system

clean:
	rm -f dss.zip
