/*
  Warnings:

  - You are about to drop the column `status` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `User` DROP COLUMN `status`,
    MODIFY `jwt` VARCHAR(255) NULL;

-- CreateTable
CREATE TABLE `TransactionStatus` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE',
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `TransactionStatus` ADD CONSTRAINT `TransactionStatus_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
