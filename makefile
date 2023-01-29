compile:
	protoc api/v1/*.proto \
			--go_out=. \
			--go-grpc_out=. \
			--go_opt=paths=source_relative \
			--go-grpc_opt=paths=source_relative \
			--proto_path=.
test:
	go test -race ./...

protoc-install:
	echo "https://grpc.io/docs/protoc-installation/"
	# cd ~
	# curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v21.12/protoc-21.12-linux-x86_64.zip
	# unzip unzip protoc-21.12-linux-x86_64.zip -d $HOME/.local
	# export PATH="$PATH:$HOME/.local/bin"

grpc-install:
	read -p "Press enter to continue"
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	export PATH="$PATH:/home/tema/go/bin"

cloudflare-cli:
	echo "https://github.com/cloudflare/cfssl#installation"
	read -p "Press enter to continue"
	go install github.com/cloudflare/cfssl/cmd/...@latest
	go install github.com/cloudflare/cfssl/cmd/cfssljson@latest
	export PATH="$PATH:/home/tema/go/bin"


# START: begin
CONFIG_PATH=${HOME}/.proglog/

.PHONY: gencert
gencert:
	cfssl gencert \
		-initca test/ca-csr.json | cfssljson -bare ca

	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=test/ca-config.json \
		-profile=server \
		test/server-csr.json | cfssljson -bare server
# END: begin

# START: client
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=test/ca-config.json \
		-profile=client \
		test/client-csr.json | cfssljson -bare client
# # END: client

# START: multi_client
	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=test/ca-config.json \
		-profile=client \
		-cn="root" \
		test/client-csr.json | cfssljson -bare root-client

	cfssl gencert \
		-ca=ca.pem \
		-ca-key=ca-key.pem \
		-config=test/ca-config.json \
		-profile=client \
		-cn="nobody" \
		test/client-csr.json | cfssljson -bare nobody-client
# # END: multi_client

# START: begin
#	mkdir -p ${CONFIG_PATH}
#	mv *.pem *.csr ${CONFIG_PATH}
	mv *.pem *.csr test/certs
# END: begin

# for project update in gith
push:
	git push origin
	git push gitlab

test-observability:
	go test ./internal/server/ -v -debug=true