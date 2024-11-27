/*
  Warnings:

  - You are about to alter the column `price` on the `Profile` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Double`.
  - You are about to alter the column `price` on the `Service` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Double`.
  - A unique constraint covering the columns `[userId]` on the table `Comment` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId]` on the table `Profile` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[userId]` on the table `Service` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `userId` to the `Service` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `Profile` MODIFY `price` DOUBLE NOT NULL,
    MODIFY `status` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NULL DEFAULT 'NONE';

-- AlterTable
ALTER TABLE `Service` ADD COLUMN `userId` VARCHAR(191) NOT NULL,
    MODIFY `price` DOUBLE NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Comment_userId_key` ON `Comment`(`userId`);

-- CreateIndex
CREATE UNIQUE INDEX `Profile_userId_key` ON `Profile`(`userId`);

-- CreateIndex
CREATE UNIQUE INDEX `Service_userId_key` ON `Service`(`userId`);

-- AddForeignKey
ALTER TABLE `Service` ADD CONSTRAINT `Service_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
