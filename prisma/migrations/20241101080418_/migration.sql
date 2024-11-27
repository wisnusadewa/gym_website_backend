/*
  Warnings:

  - You are about to drop the column `member1` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `member2` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `User` DROP COLUMN `member1`,
    DROP COLUMN `member2`,
    ADD COLUMN `memberName` VARCHAR(191) NULL;
