NAMESPACE=transport
PKGNAMEP=com.example
ANDR_PATH := $(realpath ../tttandroid/transport/)

all:	android	server

androidEntities:
	protoc --java_out=lite:$(ANDR_PATH)/entities/src/main/java --kotlin_out=$(ANDR_PATH)/entities/src/main/kotlin base.proto
#	protoc --pbandk_out=$(ANDR_PATH)/entities/src/main/kotlin base.proto

androidNetwork:
	protoc --java_out=lite:$(ANDR_PATH)/network/src/main/java --kotlin_out=$(ANDR_PATH)/network/src/main/kotlin \
      --proto_path=. --grpckt_out=$(ANDR_PATH)/network/src/main/kotlin \
      --grpc-java_out=lite:$(ANDR_PATH)/network/src/main/java network.proto
#	protoc --pbandk_out=$(ANDR_PATH)/network/src/main/kotlin \
#      --grpckt_out=$(ANDR_PATH)/network/src/main/kotlin network.proto

androidBluetooth:
#	protoc --pbandk_out=$(ANDR_PATH)/bluetooth/src/jvmShared/kotlin bluetooth.proto
	protoc --java_out=lite:$(ANDR_PATH)/bluetooth-proto/src/main/java --kotlin_out=$(ANDR_PATH)/bluetooth-proto/src/main/kotlin \
        bluetooth.proto

android: androidEntities androidNetwork androidBluetooth

cleanAndroidEntities:
	rm -f $(ANDR_PATH)/entities/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
	rm -f $(ANDR_PATH)/entities/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt

cleanAndroidNetwork:
	rm -f $(ANDR_PATH)/network/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt
	rm -f $(ANDR_PATH)/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java

cleanAndroidErrs:
	rm $(ANDR_PATH)/network/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/errors/ErrorDetails.java

cleanAndroidBluetooth:
	rm -f $(ANDR_PATH)/bluetooth-proto/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java
	rm -f $(ANDR_PATH)/bluetooth-proto/src/main/kotlin/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.kt

cleanAndroid: cleanAndroidEntities cleanAndroidNetwork cleanAndroidBluetooth

serverData:
	protoc --proto_path=. --go_out=../tttserver/rpc_service/transport --go_opt=paths=source_relative base.proto
	protoc --proto_path=. --go_out=../tttserver/rpc_service/transport --go_opt=paths=source_relative --go-grpc_out=../tttserver/rpc_service/transport --go-grpc_opt=paths=source_relative network.proto

server: serverData

cleanServerData:
	rm -r ../tttserver/rpc_service/$(NAMESPACE)/*.go

cleanServer: cleanServerData

clean: 	cleanServer cleanAndroid
