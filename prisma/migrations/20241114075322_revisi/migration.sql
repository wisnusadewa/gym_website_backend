/*
  Warnings:

  - You are about to drop the `Service` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `transactionItem` DROP FOREIGN KEY `transactionItem_serviceId_fkey`;

-- DropTable
DROP TABLE `Service`;

-- CreateTable
CREATE TABLE `service` (
    `id` VARCHAR(191) NOT NULL,
    `pax` VARCHAR(191) NOT NULL,
    `price` DOUBLE NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `tags` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `duration` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transactionItem` ADD CONSTRAINT `transactionItem_serviceId_fkey` FOREIGN KEY (`serviceId`) REFERENCES `service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
