/*
  Warnings:

  - Made the column `duration` on table `Service` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `Service` MODIFY `duration` INTEGER NOT NULL;
