package banners

import (
	model "github.com/M0rdovorot/avito/internal/model"
)

type CashRepository interface{
	GetUserBanner(tagId int, featureId int) (string, bool, error) 
	CreateBanner(banner model.Banner, tagId int) error
}