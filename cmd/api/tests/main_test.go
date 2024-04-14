package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"testing"

	"github.com/M0rdovorot/avito/configs"
	"github.com/stretchr/testify/assert"
)

const (
	user_token = "user_token"
	admin_token = "admin_token"
	userBannerMethodAPI = "user_banner"
	variableTagID = "tag_id"
	variableFeatureID = "feature_id"
	variableUseLastRevision = "use_last_revision"
)


type TestCase struct {
	Response map[string]interface{}
	StatusCode int
	Token string
	TagId string
	FeatureId string
	UseLastRevision bool
}

func Unmarshal(content string) map[string]interface{} {
	var data map[string]interface{} 
	err := json.Unmarshal([]byte(content), &data)
	if err != nil {
		return map[string]interface{}{}
	}
	return data
}

var TestCases = map[string]TestCase{
	"get active banner from user": {
		Response: Unmarshal(`{"field":"some_field","title":"some_title"}`),
		StatusCode: http.StatusOK,
		Token: user_token,
		TagId: "14",
		FeatureId: "13",
		UseLastRevision: false,
	},
	"get active banner from admin": {
		Response: Unmarshal(`{"field":"some_field","title":"some_title"}`),
		StatusCode: http.StatusOK,
		Token: admin_token,
		TagId: "14",
		FeatureId: "13",
		UseLastRevision: false,
	},
	"get unactive banner from user": {
		Response: Unmarshal(`{"error": "forbidden"}`),
		StatusCode: http.StatusForbidden,
		Token: user_token,
		TagId: "11",
		FeatureId: "10",
		UseLastRevision: false,
	},
	"get unactive banner from admin": {
		Response: Unmarshal(`{"field":"some_field","title":"some_title"}`),
		StatusCode: http.StatusOK,
		Token: admin_token,
		TagId: "11",
		FeatureId: "10",
		UseLastRevision: false,
	},
	"get banner with wrong data": {
		Response: Unmarshal(`{"error": "bad tag id"}`),
		StatusCode: http.StatusBadRequest,
		Token: user_token,
		TagId: "10ba",
		FeatureId: "10",
		UseLastRevision: false,
	},
	"get active banner with last revision": {
		Response: Unmarshal(`{"field":"some_field","title":"some_title"}`),
		StatusCode: http.StatusOK,
		Token: admin_token,
		TagId: "14",
		FeatureId: "13",
		UseLastRevision: true,
	},
	"get unexisted banner": {
		Response: Unmarshal(`{"error": "not found"}`),
		StatusCode: http.StatusNotFound,
		Token: admin_token,
		TagId: "140",
		FeatureId: "123",
		UseLastRevision: false,
	},
}

func TestMain(t *testing.T) {
	for caseName, testCase := range TestCases {
		testCase := testCase
		caseName := caseName
		t.Run(caseName, func(t *testing.T) {
			t.Parallel()
			req, _ := http.NewRequest(http.MethodGet, 
				fmt.Sprintf("%s/%s?%s=%s&&%s=%s&&%s=%t", configs.APIURL, userBannerMethodAPI, 
				variableTagID, testCase.TagId, variableFeatureID, testCase.FeatureId, 
				variableUseLastRevision, testCase.UseLastRevision), nil)
			req.Header.Set("token", testCase.Token)
			client := &http.Client{}
			resp, err := client.Do(req)
			if err != nil {
				t.Fatal()
			}
			defer resp.Body.Close()
	
			assert.Equal(t, testCase.StatusCode, resp.StatusCode)
			
			body, _ := io.ReadAll(resp.Body)
			assert.Equal(t, Unmarshal(string(body)), testCase.Response)
		})
	}
}