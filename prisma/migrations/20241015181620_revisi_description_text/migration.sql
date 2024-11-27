/*
  Warnings:

  - You are about to alter the column `text` on the `Description` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Json`.

*/
-- AlterTable
ALTER TABLE `Description` MODIFY `text` JSON NOT NULL;
