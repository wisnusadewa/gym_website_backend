/*
  Warnings:

  - You are about to drop the `service` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transaction` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `transactionItem` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Comment` DROP FOREIGN KEY `Comment_userId_fkey`;

-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `transaction_userId_fkey`;

-- DropForeignKey
ALTER TABLE `transactionItem` DROP FOREIGN KEY `transactionItem_serviceId_fkey`;

-- DropForeignKey
ALTER TABLE `transactionItem` DROP FOREIGN KEY `transactionItem_transactionId_fkey`;

-- DropTable
DROP TABLE `service`;

-- DropTable
DROP TABLE `transaction`;

-- DropTable
DROP TABLE `transactionItem`;

-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `Service` (
    `id` VARCHAR(191) NOT NULL,
    `pax` VARCHAR(191) NOT NULL,
    `price` DOUBLE NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `tags` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NULL,
    `duration` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `jwt` VARCHAR(500) NULL,
    `role` ENUM('ADMIN', 'CLIENT') NOT NULL DEFAULT 'CLIENT',
    `photo` VARCHAR(191) NULL,
    `memberName` VARCHAR(191) NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transactions` (
    `id` VARCHAR(110) NOT NULL,
    `transactionStatusUser` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE',
    `transactionStatusPayment` ENUM('NONE', 'REJECT', 'PAID', 'PENDING') NOT NULL DEFAULT 'NONE',
    `dateStart` DATETIME(3) NULL,
    `dateEnd` DATETIME(3) NULL,
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `TransactionsItem` (
    `id` VARCHAR(110) NOT NULL,
    `transactionId` VARCHAR(191) NOT NULL,
    `serviceId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionsItem` ADD CONSTRAINT `TransactionsItem_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `Transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `TransactionsItem` ADD CONSTRAINT `TransactionsItem_serviceId_fkey` FOREIGN KEY (`serviceId`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
