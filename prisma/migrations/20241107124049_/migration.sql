/*
  Warnings:

  - You are about to drop the column `userId` on the `Transactions` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `Transactions` DROP FOREIGN KEY `Transactions_userId_fkey`;

-- AlterTable
ALTER TABLE `Transactions` DROP COLUMN `userId`;

-- CreateTable
CREATE TABLE `_TransactionsToUser` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_TransactionsToUser_AB_unique`(`A`, `B`),
    INDEX `_TransactionsToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_TransactionsToUser` ADD CONSTRAINT `_TransactionsToUser_A_fkey` FOREIGN KEY (`A`) REFERENCES `Transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_TransactionsToUser` ADD CONSTRAINT `_TransactionsToUser_B_fkey` FOREIGN KEY (`B`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
