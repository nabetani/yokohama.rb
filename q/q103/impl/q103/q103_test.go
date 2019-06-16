package q103

// `go test -args data.json` で実行する

import (
	"encoding/json"
	"os"
	"testing"
)

type testUnitType struct {
	Number   int    `json:"number"`
	Src      string `json:"src"`
	Expected string `json:"expected"`
}

type dataType struct {
	EventID   string         `json:"event_id"`
	EventURL  string         `json:"event_url"`
	TestUnits []testUnitType `json:"test_data"`
}

func testUnits() []testUnitType {
	f, err := os.Open(os.Args[1])
	if err != nil {
		panic(err)
	}
	fileinfo, err := f.Stat()
	if err != nil {
		panic(err)
	}
	bytes := make([]byte, fileinfo.Size())

	f.Read(bytes)
	data := dataType{}
	json.Unmarshal(bytes, &data)
	return data.TestUnits
}

func Test(t *testing.T) {
	for _, u := range testUnits() {
		actual := solve(u.Src)
		if actual != u.Expected {
			t.Errorf("solve(%v) = %v, want %v", u.Src, actual, u.Expected)
		}
	}
}
