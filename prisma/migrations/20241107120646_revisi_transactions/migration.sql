/*
  Warnings:

  - You are about to drop the column `transactionStatus` on the `Service` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Service` DROP COLUMN `transactionStatus`;

-- CreateTable
CREATE TABLE `Transactions` (
    `id` VARCHAR(191) NOT NULL,
    `transactionStatus` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE',
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
