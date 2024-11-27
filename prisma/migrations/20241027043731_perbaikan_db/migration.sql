/*
  Warnings:

  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Profile` DROP FOREIGN KEY `Profile_userId_fkey`;

-- DropTable
DROP TABLE `Profile`;

-- CreateTable
CREATE TABLE `_ServiceToUser` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_ServiceToUser_AB_unique`(`A`, `B`),
    INDEX `_ServiceToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `_ServiceToUser` ADD CONSTRAINT `_ServiceToUser_A_fkey` FOREIGN KEY (`A`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ServiceToUser` ADD CONSTRAINT `_ServiceToUser_B_fkey` FOREIGN KEY (`B`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
