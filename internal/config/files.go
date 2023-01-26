package config

import (
	"fmt"
	"os"
	"path/filepath"
)

// look at Makefile gencert
var (
	CAFile               = testConfigFile("ca.pem")
	ServerCertFile       = testConfigFile("server.pem")
	ServerKeyFile        = testConfigFile("server-key.pem")
	RootClientCertFile   = testConfigFile("root-client.pem")
	RootClientKeyFile    = testConfigFile("root-client-key.pem")
	NobodyClientCertFile = testConfigFile("nobody-client.pem")
	NobodyClientKeyFile  = testConfigFile("nobody-client-key.pem")
	ACLModelFile         = testConfigFile("model.conf")
	ACLPolicyFile        = testConfigFile("policy.csv")
)

// func configFile(filename string) string {
// 	if dir := os.Getenv("CONFIG_DIR"); dir != "" {
// 		return filepath.Join(dir, filename)
// 	}
// 	homeDir, err := os.UserHomeDir()
// 	if err != nil {
// 		panic(err)
// 	}
// 	return filepath.Join(homeDir, ".proglog", filename)
// }

func testConfigFile(filename string) string {
	fmt.Printf(os.Getwd())
	return filepath.Join("../../test/certs", filename)
}
