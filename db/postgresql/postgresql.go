package postgresql

import (
	"database/sql"
	"time"

	"github.com/M0rdovorot/avito/configs"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/pgx/v5"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

type IDatabase interface {
	Connect() error
	Close() error
	GetDB() *sql.DB
	MigrateUp() error
	MigrateDown() error
	getMigrateInstance() error
}

type Database struct {
	db *sql.DB
}

func (database *Database) Connect() error {
	var err error
	database.db, err = sql.Open(configs.DriverSQL, configs.DatabaseURL)
	if err != nil {
		return err
	}
	database.db.SetConnMaxLifetime(1 * time.Second)
	database.db.SetConnMaxIdleTime(1 * time.Second)
	database.db.SetMaxIdleConns(10)
	return nil
}

func (database *Database) Close() error {
	err := database.db.Close()
	if err != nil {
		return err
	}
	return nil
}

func (database *Database) GetDB() *sql.DB {
	return database.db
}

func (database *Database) getMigrateInstance() (*migrate.Migrate, error) {
	driver, err := pgx.WithInstance(database.db, &pgx.Config{})
	if err != nil {
		return nil, err
	}
	m, err := migrate.NewWithDatabaseInstance(
		configs.SourceDriver+configs.MigrationsPath,
		configs.DatabaseName,
		driver,
	)
	if err != nil {
		return nil, err
	}
	return m, nil
}

func (database *Database) MigrateUp() error {
	m, err := database.getMigrateInstance()
	if err != nil {
		return err
	}
	err = m.Up()
	if err != nil {
		return err
	}
	return nil
}

func (database *Database) MigrateDown() error {
	m, err := database.getMigrateInstance()
	if err != nil {
		return err
	}
	err = m.Down()
	if err != nil {
		return err
	}
	return nil
}