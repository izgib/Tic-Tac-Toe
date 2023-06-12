NAMESPACE=transport
PKGNAMEP=com.example
#TMPDIR := $(shell mktemp -d)
ANDR_PATH := $(realpath ../tttandroid/transport/)

# 1 arg: input file
define change_namespace
	sed -i '/namespace/s/ $(NAMESPACE)/ $(PKGNAMEP).$(NAMESPACE)/g' $(1)
endef

#1 arg: input file path, must be relative to copy directory
define copy_change_namespace
	cp $1 $(TMPDIR)
	$(call change_namespace,$(TMPDIR)/$1)
endef

all:	android	server

androidEntities:
#	$(call copy_change_namespace,base.fbs)
#	flatc --java --gen-nullable -o ../tttandroid/transport/entities/src/main/java $(TMPDIR)/base.fbs
	protoc --java_out=lite:$(ANDR_PATH)/entities/src/main/java --kotlin_out=$(ANDR_PATH)/entities/src/main/kotlin base.proto
#	protoc --pbandk_out=$(ANDR_PATH)/entities/src/main/kotlin base.proto

androidNetwork:
#	$(call copy_change_namespace,base.fbs)
#	$(call copy_change_namespace,network.fbs)
#	flatc --java --grpc --gen-nullable -I $(TMPDIR) -o ../tttandroid/transport/network/src/main/java $(TMPDIR)/network.fbs
#	find ../tttandroid/transport/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE) -maxdepth 1 -name "*Grpc*.java" -exec sed -i 's/"$(PKGNAMEP).$(NAMESPACE)/"$(NAMESPACE)/g' {} \;
	protoc --java_out=lite:$(ANDR_PATH)/network/src/main/java --kotlin_out=$(ANDR_PATH)/network/src/main/kotlin \
      --proto_path=. --grpckt_out=$(ANDR_PATH)/network/src/main/kotlin \
      --grpc-java_out=lite:$(ANDR_PATH)/network/src/main/java network.proto
#	protoc --pbandk_out=$(ANDR_PATH)/network/src/main/kotlin \
#      --grpckt_out=$(ANDR_PATH)/network/src/main/kotlin network.proto
#	protoc --proto_path=. --plugin=protoc-gen-grpckt=protoc-gen-grpc-kotlin.sh \
       network.proto
#	flatc --java --grpc --gen-nullable -I $(TMPDIR) -o ../tttandroid/transport/network/src/main/java $(TMPDIR)/network.fbs

#androidErrs:
#	protoc --java_out ../tttandroid/transport/network/src/main/java error_details.proto

androidBluetooth:
#	protoc --pbandk_out=kotlin_package=com.example.transport:$(ANDR_PATH)/bluetooth/src/jvmShared/kotlin --proto_path=. bluetooth.proto
#	protoc --pbandk_out=$(ANDR_PATH)/bluetooth/src/jvmShared/kotlin bluetooth.proto
#	protoc --java_out=$(ANDR_PATH)/bluetooth/src/jvmShared/java --kotlin_out=$(ANDR_PATH)/bluetooth/src/jvmShared/kotlin \
#          bluetooth.proto
	protoc --java_out=lite:$(ANDR_PATH)/bluetooth-proto/src/main/java --kotlin_out=$(ANDR_PATH)/bluetooth-proto/src/main/kotlin \
        bluetooth.proto
#	$(call copy_change_namespace,base.fbs)
#	cp bluetooth.fbs $(TMPDIR)
#	flatc --kotlin -I $(TMPDIR) -o ../tttandroid/transport/bluetooth/src/jvmShared/kotlin $(TMPDIR)/bluetooth.fbs

#android: androidEntities androidNetwork androidErrs androidBluetooth
android: androidEntities androidNetwork androidBluetooth

cleanAndroidEntities:
	rm -f $(ANDR_PATH)/entities/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
	rm -f $(ANDR_PATH)/entities/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt
#	rm -f $(ANDR_PATH)/entities/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/base.kt

cleanAndroidNetwork:
#	rm -f $(ANDR_PATH)/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
#	rm -f $(ANDR_PATH)/network/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
	rm -f $(ANDR_PATH)/network/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt
	rm -f $(ANDR_PATH)/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java

cleanAndroidErrs:
	rm $(ANDR_PATH)/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/errors/ErrorDetails.java

cleanAndroidBluetooth:
#	rm $(ANDR_PATH)/bluetooth-proto/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/data/*.kt
	rm -f $(ANDR_PATH)/bluetooth-proto/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
	rm -f $(ANDR_PATH)/bluetooth-proto/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt

#cleanAndroid: cleanAndroidEntities cleanAndroidNetwork cleanAndroidErrs cleanAndroidBluetooth
cleanAndroid: cleanAndroidEntities cleanAndroidNetwork cleanAndroidBluetooth

serverData:
	protoc --proto_path=. --go_out=../tttserver/rpc_service/transport --go_opt=paths=source_relative base.proto
	protoc --proto_path=. --go_out=../tttserver/rpc_service/transport --go_opt=paths=source_relative --go-grpc_out=../tttserver/rpc_service/transport --go-grpc_opt=paths=source_relative network.proto
#	flatc --go --go-namespace transport --grpc --gen-all -o ../tttserver/rpc_service network.fbs
#	flatc --go --go-namespace --grpc -o ../tttserver/rpc_service network.fbs
#	find ../tttserver/rpc_service/$(NAMESPACE) -maxdepth 1 -name "*_grpc*.go" -exec go fix {} \;

serverErrs:
#	protoc --go_out /tmp/tttserver/rpc_service error_details.proto
	protoc --go_out ../tttserver/rpc_service error_details.proto


#server: serverData serverErrs
server: serverData

cleanServerData:
	rm -r ../tttserver/rpc_service/$(NAMESPACE)/*.go

cleanServerErrs:
	rm ../tttserver/rpc_service/error_details.pb.go

#cleanServer: cleanServerData cleanServerErrs
cleanServer: cleanServerData

clean: 	cleanServer cleanAndroid
