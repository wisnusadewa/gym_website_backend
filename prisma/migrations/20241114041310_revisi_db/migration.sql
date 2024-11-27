/*
  Warnings:

  - You are about to drop the column `userId` on the `Service` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Service` DROP FOREIGN KEY `Service_userId_fkey`;

-- AlterTable
ALTER TABLE `Service` DROP COLUMN `userId`;

-- CreateTable
CREATE TABLE `TransactionsItem` (
    `id` VARCHAR(110) NOT NULL,
    `transactionId` VARCHAR(191) NOT NULL,
    `serviceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `TransactionsItem_transactionId_key`(`transactionId`),
    UNIQUE INDEX `TransactionsItem_serviceId_key`(`serviceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `TransactionsItem` ADD CONSTRAINT `TransactionsItem_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `Transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionsItem` ADD CONSTRAINT `TransactionsItem_serviceId_fkey` FOREIGN KEY (`serviceId`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
