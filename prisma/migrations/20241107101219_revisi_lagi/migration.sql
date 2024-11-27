/*
  Warnings:

  - You are about to drop the column `userId` on the `TransactionStatus` table. All the data in the column will be lost.
  - Added the required column `serviceId` to the `TransactionStatus` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `TransactionStatus` DROP FOREIGN KEY `TransactionStatus_userId_fkey`;

-- AlterTable
ALTER TABLE `TransactionStatus` DROP COLUMN `userId`,
    ADD COLUMN `serviceId` VARCHAR(191) NOT NULL;

-- AddForeignKey
ALTER TABLE `TransactionStatus` ADD CONSTRAINT `TransactionStatus_serviceId_fkey` FOREIGN KEY (`serviceId`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
