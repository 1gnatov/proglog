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
