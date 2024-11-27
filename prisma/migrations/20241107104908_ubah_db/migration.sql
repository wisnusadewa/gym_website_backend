/*
  Warnings:

  - You are about to drop the `TransactionStatus` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `TransactionStatus` DROP FOREIGN KEY `TransactionStatus_serviceId_fkey`;

-- AlterTable
ALTER TABLE `Service` ADD COLUMN `transactionStatus` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE';

-- DropTable
DROP TABLE `TransactionStatus`;
