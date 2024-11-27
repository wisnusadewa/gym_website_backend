/*
  Warnings:

  - You are about to drop the `Description` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `description` to the `Service` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Description` DROP FOREIGN KEY `Description_descId_fkey`;

-- AlterTable
ALTER TABLE `Service` ADD COLUMN `description` JSON NOT NULL;

-- DropTable
DROP TABLE `Description`;
