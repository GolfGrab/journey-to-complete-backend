postgres:
	docker run --name postgres14 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres:14-alpine

createdb:
	docker exec -it postgres14 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres14 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:password@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	docker run --rm -v C:\Users\User\Desktop\Golf\journey-to-complete-backend:/src -w /src kjconroy/sqlc generate
	docker run --rm -v ${pwd}:/src -w /src kjconroy/sqlc generate


test:
	go test ./... -v -cover

server:
	go run main.go

mock:
	mockgen -destination db/mock/store.go  -package mockdb github.com/GolfGrab/journey-to-complete-backend/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock migrateup1 migratedown1