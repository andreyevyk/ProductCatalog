IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

GO

CREATE TABLE [Categories] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
);

GO

CREATE TABLE [Products] (
    [Id] int NOT NULL IDENTITY,
    [Tittle] nvarchar(max) NULL,
    [Description] nvarchar(max) NULL,
    [Price] decimal(18,2) NOT NULL,
    [Image] nvarchar(max) NULL,
    [CreateDate] datetime2 NOT NULL,
    [LastUpdateDate] datetime2 NOT NULL,
    [CategoryId] int NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Products_Categories_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE
);

GO

CREATE INDEX [IX_Products_CategoryId] ON [Products] ([CategoryId]);

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190903125956_initial', N'2.2.6-servicing-10079');

GO

ALTER TABLE [Products] DROP CONSTRAINT [FK_Products_Categories_CategoryId];

GO

ALTER TABLE [Products] DROP CONSTRAINT [PK_Products];

GO

ALTER TABLE [Categories] DROP CONSTRAINT [PK_Categories];

GO

EXEC sp_rename N'[Products]', N'Product';

GO

EXEC sp_rename N'[Categories]', N'Category';

GO

EXEC sp_rename N'[Product].[IX_Products_CategoryId]', N'IX_Product_CategoryId', N'INDEX';

GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Tittle');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Product] ALTER COLUMN [Tittle] varchar NOT NULL;

GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Price');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Product] ALTER COLUMN [Price] money NOT NULL;

GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Image');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Product] ALTER COLUMN [Image] varchar NOT NULL;

GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Description');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Product] ALTER COLUMN [Description] nvarchar(max) NOT NULL;

GO

ALTER TABLE [Product] ADD [Quantity] int NOT NULL DEFAULT 0;

GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Category]') AND [c].[name] = N'Title');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Category] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Category] ALTER COLUMN [Title] varchar NOT NULL;

GO

ALTER TABLE [Product] ADD CONSTRAINT [PK_Product] PRIMARY KEY ([Id]);

GO

ALTER TABLE [Category] ADD CONSTRAINT [PK_Category] PRIMARY KEY ([Id]);

GO

ALTER TABLE [Product] ADD CONSTRAINT [FK_Product_Category_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) ON DELETE CASCADE;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190905135625_v1', N'2.2.6-servicing-10079');

GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Tittle');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Product] ALTER COLUMN [Tittle] varchar(120) NOT NULL;

GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Image');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [Product] ALTER COLUMN [Image] varchar(1024) NOT NULL;

GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Product]') AND [c].[name] = N'Description');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Product] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [Product] ALTER COLUMN [Description] varchar(120) NOT NULL;

GO

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Category]') AND [c].[name] = N'Title');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [Category] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [Category] ALTER COLUMN [Title] varchar(120) NOT NULL;

GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20190905135857_v1.1', N'2.2.6-servicing-10079');

GO

