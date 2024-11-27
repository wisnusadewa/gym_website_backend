/*
  Warnings:

  - The primary key for the `Transactions` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Transactions` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(110)`.
  - You are about to alter the column `A` on the `_TransactionsToUser` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(110)`.

*/
-- DropForeignKey
ALTER TABLE `_TransactionsToUser` DROP FOREIGN KEY `_TransactionsToUser_A_fkey`;

-- AlterTable
ALTER TABLE `Transactions` DROP PRIMARY KEY,
    MODIFY `id` VARCHAR(110) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `_TransactionsToUser` MODIFY `A` VARCHAR(110) NOT NULL;

-- AddForeignKey
ALTER TABLE `_TransactionsToUser` ADD CONSTRAINT `_TransactionsToUser_A_fkey` FOREIGN KEY (`A`) REFERENCES `Transactions`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
