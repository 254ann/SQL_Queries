-- CreateTable
CREATE TABLE `Events` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `imageUrl` VARCHAR(255) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `price` INTEGER NOT NULL,
    `date` VARCHAR(255) NOT NULL,
    `location` VARCHAR(191) NOT NULL,
    `Company` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Events_title_key`(`title`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
