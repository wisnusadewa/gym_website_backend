/*
  Warnings:

  - You are about to drop the column `dateEnd` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `dateStart` on the `User` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `Transactions` ADD COLUMN `dateEnd` DATETIME(3) NULL,
    ADD COLUMN `dateStart` DATETIME(3) NULL;

-- AlterTable
ALTER TABLE `User` DROP COLUMN `dateEnd`,
    DROP COLUMN `dateStart`;
