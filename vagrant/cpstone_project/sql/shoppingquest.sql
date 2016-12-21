CREATE TABLE "shop" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "address" TEXT NOT NULL
);

CREATE TABLE "discount" (
  "id" SERIAL PRIMARY KEY,
  "description" TEXT NOT NULL,
  "percent" INTEGER NOT NULL,
  "cost" INTEGER NOT NULL,
  "inform" INTEGER NOT NULL,
  "shop" INTEGER NOT NULL
);

CREATE INDEX "idx_discount__shop" ON "discount" ("shop");

ALTER TABLE "discount" ADD CONSTRAINT "fk_discount__shop" FOREIGN KEY ("shop") REFERENCES "shop" ("id");

CREATE TABLE "quest" (
  "id" SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "description" TEXT NOT NULL,
  "expire_date" DATE NOT NULL,
  "is_expire" BOOLEAN NOT NULL,
  "image" TEXT NOT NULL,
  "shop" INTEGER NOT NULL
);

CREATE INDEX "idx_quest__shop" ON "quest" ("shop");

ALTER TABLE "quest" ADD CONSTRAINT "fk_quest__shop" FOREIGN KEY ("shop") REFERENCES "shop" ("id");

CREATE TABLE "task" (
  "id" SERIAL PRIMARY KEY,
  "description" TEXT NOT NULL,
  "image" TEXT NOT NULL,
  "expire_date" DATE NOT NULL,
  "quest" INTEGER NOT NULL
);

CREATE INDEX "idx_task__quest" ON "task" ("quest");

ALTER TABLE "task" ADD CONSTRAINT "fk_task__quest" FOREIGN KEY ("quest") REFERENCES "quest" ("id");

CREATE TABLE "user" (
  "id" INTEGER PRIMARY KEY,
  "login" TEXT NOT NULL,
  "password" TEXT NOT NULL,
  "date_joined" DATE NOT NULL,
  "phone_number" TEXT,
  "email" TEXT,
  "is_superuser" BOOLEAN NOT NULL,
  "device_id" INTEGER NOT NULL,
  "points" INTEGER NOT NULL
);

CREATE TABLE "user_discount" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "discount_id" INTEGER NOT NULL
);

CREATE INDEX "idx_user_discount__discount_id" ON "user_discount" ("discount_id");

CREATE INDEX "idx_user_discount__user_id" ON "user_discount" ("user_id");

ALTER TABLE "user_discount" ADD CONSTRAINT "fk_user_discount__discount_id" FOREIGN KEY ("discount_id") REFERENCES "discount" ("id");

ALTER TABLE "user_discount" ADD CONSTRAINT "fk_user_discount__user_id" FOREIGN KEY ("user_id") REFERENCES "user" ("id");

CREATE TABLE "user_quest" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "quest_id" INTEGER NOT NULL,
  "task_id" INTEGER NOT NULL
);

CREATE INDEX "idx_user_quest__quest_id" ON "user_quest" ("quest_id");

CREATE INDEX "idx_user_quest__task_id" ON "user_quest" ("task_id");

CREATE INDEX "idx_user_quest__user_id" ON "user_quest" ("user_id");

ALTER TABLE "user_quest" ADD CONSTRAINT "fk_user_quest__quest_id" FOREIGN KEY ("quest_id") REFERENCES "quest" ("id");

ALTER TABLE "user_quest" ADD CONSTRAINT "fk_user_quest__task_id" FOREIGN KEY ("task_id") REFERENCES "task" ("id");

ALTER TABLE "user_quest" ADD CONSTRAINT "fk_user_quest__user_id" FOREIGN KEY ("user_id") REFERENCES "user" ("id");

CREATE TABLE "user_shops" (
  "id" SERIAL PRIMARY KEY,
  "user_id" INTEGER NOT NULL,
  "shop_id" INTEGER NOT NULL
);

CREATE INDEX "idx_user_shops__shop_id" ON "user_shops" ("shop_id");

CREATE INDEX "idx_user_shops__user_id" ON "user_shops" ("user_id");

ALTER TABLE "user_shops" ADD CONSTRAINT "fk_user_shops__shop_id" FOREIGN KEY ("shop_id") REFERENCES "shop" ("id");

ALTER TABLE "user_shops" ADD CONSTRAINT "fk_user_shops__user_id" FOREIGN KEY ("user_id") REFERENCES "user" ("id");

CREATE TABLE "winners" (
  "id" SERIAL PRIMARY KEY,
  "quest_iq" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL
);

CREATE INDEX "idx_winners__quest_iq" ON "winners" ("quest_iq");

CREATE INDEX "idx_winners__user_id" ON "winners" ("user_id");

ALTER TABLE "winners" ADD CONSTRAINT "fk_winners__quest_iq" FOREIGN KEY ("quest_iq") REFERENCES "quest" ("id");

ALTER TABLE "winners" ADD CONSTRAINT "fk_winners__user_id" FOREIGN KEY ("user_id") REFERENCES "user" ("id")