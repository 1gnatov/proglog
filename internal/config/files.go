package config

import (
	"fmt"
	"os"
	"path/filepath"
)

// look at Makefile gencert
var (
	CAFile         = testConfigFile("ca.pem")
	ServerCertFile = testConfigFile("server.pem")
	ServerKeyFile  = testConfigFile("server-key.pem")
	ClientCertFile = testConfigFile("client.pem")
	ClientKeyFile  = testConfigFile("client-key.pem")
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
