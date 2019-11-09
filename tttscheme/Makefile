NAMESPACE=i9e
NAMESPACEHEALTH=health
PKGNAMEP=com.example.game.tic_tac_toe
TMPDIR := $(shell mktemp -d)


all: android server

android:
	cp schema.fbs $(TMPDIR)
	sed -i '/namespace/s/ $(NAMESPACE)/ $(PKGNAMEP).$(NAMESPACE)/g' $(TMPDIR)/schema.fbs
	flatc --java --grpc --gen-nullable --gen-generated --gen-all -I $(TMPDIR) -o ../tttandroid/app/src/main/java schema_android.fbs
	find ../tttandroid/app/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE) -maxdepth 1 -name "*Grpc*.java" -exec  sed -i 's/"$(PKGNAMEP).$(NAMESPACE)/"i9e/g' {} \;
	rm -rf $(TMPDIR)

server:
	flatc --go --grpc -o ../tttserver/game/interface/rpc_service schema.fbs
	find ../tttserver/game/interface/rpc_service/$(NAMESPACE) -maxdepth 1 -name "*_grpc*.go" -exec go fix {} \;

cleanServer:
	rm -rf ../tttserver/game/interface/rpc_service/$(NAMESPACE)/*.go

cleanAndroid:
	rm -rf ../tttandroid/app/src/main/java/$(subst .,/,$(PKGNAMEP))/$(NAMESPACE)/*.java

clean: 	cleanServer cleanAndroid
