/*
  Warnings:

  - You are about to drop the `Transactions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `TransactionsItem` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Transactions` DROP FOREIGN KEY `Transactions_userId_fkey`;

-- DropForeignKey
ALTER TABLE `TransactionsItem` DROP FOREIGN KEY `TransactionsItem_serviceId_fkey`;

-- DropForeignKey
ALTER TABLE `TransactionsItem` DROP FOREIGN KEY `TransactionsItem_transactionId_fkey`;

-- DropTable
DROP TABLE `Transactions`;

-- DropTable
DROP TABLE `TransactionsItem`;

-- CreateTable
CREATE TABLE `transaction` (
    `id` VARCHAR(110) NOT NULL,
    `transactionStatusUser` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE',
    `transactionStatusPayment` ENUM('NONE', 'REJECT', 'PAID', 'PENDING') NOT NULL DEFAULT 'NONE',
    `dateStart` DATETIME(3) NULL,
    `dateEnd` DATETIME(3) NULL,
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transactionItem` (
    `id` VARCHAR(110) NOT NULL,
    `transactionId` VARCHAR(191) NOT NULL,
    `serviceId` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `transactionItem_transactionId_key`(`transactionId`),
    UNIQUE INDEX `transactionItem_serviceId_key`(`serviceId`),
    INDEX `transactionId`(`transactionId`),
    INDEX `serviceId`(`serviceId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transaction` ADD CONSTRAINT `transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactionItem` ADD CONSTRAINT `transactionItem_transactionId_fkey` FOREIGN KEY (`transactionId`) REFERENCES `transaction`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `transactionItem` ADD CONSTRAINT `transactionItem_serviceId_fkey` FOREIGN KEY (`serviceId`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
