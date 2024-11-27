/*
  Warnings:

  - You are about to drop the column `description` on the `Service` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Service` DROP COLUMN `description`;

-- CreateTable
CREATE TABLE `Description` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `text` VARCHAR(191) NOT NULL,
    `descId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Description` ADD CONSTRAINT `Description_descId_fkey` FOREIGN KEY (`descId`) REFERENCES `Service`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
