#Get the versions for the programs to be built from the src code
FREEROUTE_VER := $(shell python get_version.py ../../src/gui/MainApplication.java)

OUTPUT_ROOT_PATH = output

#We no long build the Linux binaries 
#using cxfreeze as they suffer from 
#lib dependancy issues.
all: freeroute

#Remove all the output files
clean:
	rm -rf $(OUTPUT_ROOT_PATH)
	rm -rf $(OUTPUT_ROOT_PATH)/freeroute/linux
	rm -rf tmp

#Build the freeroute package.	
freeroute:
	mkdir -p $(OUTPUT_ROOT_PATH)/freeroute/linux/DEBIAN
	mkdir -p $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/bin
	mkdir -p $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/local/bin/freeroute_files
	mkdir -p $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/share/applications
	cp ../../freeroute.jar $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/local/bin/freeroute_files
	ln -s $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/local/bin/freeroute_files/freeroute.jar $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/bin/freeroute.jar
	#unity desktop and icon files
	cp freeroute_desktop/freeroute.png $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/local/bin/freeroute_files
	cp freeroute_desktop/freeroute.desktop $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/share/applications
	#This debian control file should not contain the Version: line
	cp freeroute.control $(OUTPUT_ROOT_PATH)/freeroute/linux/DEBIAN/control
	cp freeroute.postinst $(OUTPUT_ROOT_PATH)/freeroute/linux/DEBIAN/postinst
	cp freeroute.prerm $(OUTPUT_ROOT_PATH)/freeroute/linux/DEBIAN/prerm
	cp freeroute.startup $(OUTPUT_ROOT_PATH)/freeroute/linux/usr/local/bin/freeroute
	#Add the version to the debian control file
	echo 'Version: $(FREEROUTE_VER)' >> $(OUTPUT_ROOT_PATH)/freeroute/linux/DEBIAN/control
	dpkg-deb -Zgzip -b $(OUTPUT_ROOT_PATH)/freeroute/linux $(OUTPUT_ROOT_PATH)/freeroute/freeroute-$(FREEROUTE_VER).deb
	rm -rf $(OUTPUT_ROOT_PATH)/freeroute/linux
	#Create rpm from deb file
	cd $(OUTPUT_ROOT_PATH)/freeroute/ && sudo alien --to-rpm --scripts freeroute-$(FREEROUTE_VER).deb
	#Make tarball containing install files
	dpkg -x $(OUTPUT_ROOT_PATH)/freeroute/freeroute-$(FREEROUTE_VER).deb ./tmp
	cd tmp && tar czvf ../$(OUTPUT_ROOT_PATH)/freeroute/freeroute-$(FREEROUTE_VER).tgz *
	rm -rf tmp
	rm -rf $(OUTPUT_ROOT_PATH)/freeroute/linux
