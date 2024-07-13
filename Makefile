# Docker
DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

docker-ps:
	docker ps

docker-ps-a:
	docker ps -a

docker-images:
	docker images

docker-pull:
	docker pull postgres:12-alpine

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

go-package:
	go get github.com/stretchr/testify

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go  github.com/MasaakiShigezumi/BankApp/db/sqlc Store

.PHONY: docker-ps docker-ps-a docker-images migrateup migrateup1 migratedown migratedown1 go-package sqlc test server mock
