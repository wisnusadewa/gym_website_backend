/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Comment` DROP FOREIGN KEY `Comment_userId_fkey`;

-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `transaction_userId_fkey`;

-- DropTable
DROP TABLE `User`;

-- CreateTable
CREATE TABLE `user` (
    `id` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `jwt` VARCHAR(500) NULL,
    `role` ENUM('ADMIN', 'CLIENT') NOT NULL DEFAULT 'CLIENT',
    `photo` VARCHAR(191) NULL,
    `memberName` VARCHAR(191) NULL,

    UNIQUE INDEX `user_email_key`(`email`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `transaction` ADD CONSTRAINT `transaction_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
