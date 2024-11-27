/*
  Warnings:

  - Made the column `dateEnd` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `dateStart` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE `User` MODIFY `dateEnd` DATETIME(3) NOT NULL,
    MODIFY `dateStart` DATETIME(3) NOT NULL;
