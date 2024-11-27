/*
  Warnings:

  - You are about to drop the `_ServiceToUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_TransactionsToUser` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `userId` to the `Service` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Transactions` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `_ServiceToUser` DROP FOREIGN KEY `_ServiceToUser_A_fkey`;

-- DropForeignKey
ALTER TABLE `_ServiceToUser` DROP FOREIGN KEY `_ServiceToUser_B_fkey`;

-- DropForeignKey
ALTER TABLE `_TransactionsToUser` DROP FOREIGN KEY `_TransactionsToUser_A_fkey`;

-- DropForeignKey
ALTER TABLE `_TransactionsToUser` DROP FOREIGN KEY `_TransactionsToUser_B_fkey`;

-- AlterTable
ALTER TABLE `Service` ADD COLUMN `userId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `Transactions` ADD COLUMN `userId` VARCHAR(191) NOT NULL;

-- DropTable
DROP TABLE `_ServiceToUser`;

-- DropTable
DROP TABLE `_TransactionsToUser`;

-- AddForeignKey
ALTER TABLE `Service` ADD CONSTRAINT `Service_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transactions` ADD CONSTRAINT `Transactions_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
