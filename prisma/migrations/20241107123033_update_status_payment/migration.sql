/*
  Warnings:

  - You are about to drop the column `transactionStatus` on the `Transactions` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Transactions` DROP COLUMN `transactionStatus`,
    ADD COLUMN `transactionStatusPayment` ENUM('NONE', 'REJECT', 'PAID', 'PENDING') NOT NULL DEFAULT 'NONE',
    ADD COLUMN `transactionStatusUser` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE';
