-- AlterTable
ALTER TABLE `User` ADD COLUMN `photo` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `Comment` (
    `id` VARCHAR(191) NOT NULL,
    `text` VARCHAR(191) NOT NULL,
    `createAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `userId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profile` (
    `id` VARCHAR(191) NOT NULL,
    `pax` VARCHAR(191) NOT NULL,
    `price` VARCHAR(191) NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `membersName` VARCHAR(191) NOT NULL,
    `start` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `end` VARCHAR(191) NOT NULL,
    `status` ENUM('NONE', 'ACTIVE', 'EXPIRED', 'PENDING') NOT NULL DEFAULT 'NONE',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Service` (
    `id` VARCHAR(191) NOT NULL,
    `pax` VARCHAR(191) NOT NULL,
    `price` VARCHAR(191) NOT NULL,
    `month` VARCHAR(191) NOT NULL,
    `tags` VARCHAR(191) NOT NULL,
    `description` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Comment` ADD CONSTRAINT `Comment_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
