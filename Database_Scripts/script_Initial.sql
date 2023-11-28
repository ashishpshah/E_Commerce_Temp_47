USE [padhyaso_CoreTemplate]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleMapping]') AND type in (N'U'))
DROP TABLE [dbo].[UserRoleMapping]
GO
/****** Object:  Table [dbo].[UserMenuAccess]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserMenuAccess]') AND type in (N'U'))
DROP TABLE [dbo].[UserMenuAccess]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[RoleMenuAccess]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMenuAccess]') AND type in (N'U'))
DROP TABLE [dbo].[RoleMenuAccess]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Menu]') AND type in (N'U'))
DROP TABLE [dbo].[Menu]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
DROP TABLE [dbo].[Employee]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND type in (N'U'))
DROP TABLE [dbo].[Contact]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND type in (N'U'))
DROP TABLE [dbo].[Company]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Branch]') AND type in (N'U'))
DROP TABLE [dbo].[Branch]
GO
/****** Object:  Table [dbo].[Attachments]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attachments]') AND type in (N'U'))
DROP TABLE [dbo].[Attachments]
GO
/****** Object:  Table [dbo].[About]    Script Date: 28-11-2023 02:44:15 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[About]') AND type in (N'U'))
DROP TABLE [dbo].[About]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 28-11-2023 02:44:15 PM ******/
DROP FUNCTION [dbo].[SplitString]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
    @Input NVARCHAR(MAX),
    @Character CHAR(1),
    @OutType CHAR(1)
)
RETURNS @Output TABLE (
    ItemStr NVARCHAR(MAX),
    ItemNum BIGINT
)
AS
BEGIN
    DECLARE @StartIndex INT, @EndIndex INT
 
    SET @StartIndex = 1
    IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
    BEGIN
        SET @Input = @Input + @Character
    END
 
    WHILE CHARINDEX(@Character, @Input) > 0
    BEGIN
        SET @EndIndex = CHARINDEX(@Character, @Input)
         
		IF(@OutType = 'S')
		BEGIN
		
			INSERT INTO @Output(ItemStr)
			SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
         
		END
		ELSE 
		BEGIN
		
			INSERT INTO @Output(ItemNum)
			SELECT CONVERT(BIGINT, SUBSTRING(@Input, @StartIndex, @EndIndex - 1))
         
		END

        SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
    END
 
    RETURN
END
GO
/****** Object:  Table [dbo].[About]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[About](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[Header] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NOT NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_About] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attachments]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](1000) NOT NULL,
	[Extension] [varchar](30) NOT NULL,
	[Size] [bigint] NOT NULL,
	[Type_Document] [varchar](30) NOT NULL,
	[Type_Content] [varchar](30) NOT NULL,
	[Path] [varchar](30) NOT NULL,
	[Remarks] [varchar](30) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Attachments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contact](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[Header] [nvarchar](max) NULL,
	[Body] [nvarchar](max) NOT NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[CityId] [bigint] NULL,
	[StateId] [bigint] NULL,
	[CountryId] [bigint] NULL,
	[Gender] [char](10) NULL,
	[Position] [nvarchar](50) NULL,
	[ContactNo] [nvarchar](10) NULL,
	[BloodGroup] [nvarchar](50) NULL,
	[BirthDate] [datetime2](7) NULL,
	[HireDate] [datetime2](7) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentId] [bigint] NOT NULL,
	[Area] [nvarchar](50) NULL,
	[Controller] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Icon] [nvarchar](50) NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenuAccess]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMenuAccess](
	[RoleId] [bigint] NOT NULL,
	[MenuId] [bigint] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[IsCreate] [bit] NOT NULL,
	[IsUpdate] [bit] NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_RoleMenuAccess] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[MenuId] ASC,
	[IsRead] ASC,
	[IsCreate] ASC,
	[IsUpdate] ASC,
	[IsDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DisplayOrder] [int] NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserMenuAccess]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMenuAccess](
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[MenuId] [bigint] NOT NULL,
	[IsRead] [bit] NOT NULL,
	[IsCreate] [bit] NOT NULL,
	[IsUpdate] [bit] NOT NULL,
	[IsDelete] [bit] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UserMenuAccess] PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC,
	[BranchId] ASC,
	[UserId] ASC,
	[RoleId] ASC,
	[MenuId] ASC,
	[IsRead] ASC,
	[IsCreate] ASC,
	[IsUpdate] ASC,
	[IsDelete] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoleMapping](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[UserId] [bigint] NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UserRoleMapping] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 28-11-2023 02:44:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](30) NOT NULL,
	[Password] [varchar](150) NOT NULL,
	[No_Of_Wrong_Password_Attempts] [int] NULL,
	[Next_Change_Password_Date] [datetime2](7) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Company] ON 

INSERT [dbo].[Company] ([Id], [Name], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, N'VK Jewellers', 1, CAST(N'2023-11-28T11:30:40.5959994' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.5959994' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Company] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, N'', N'', N'Company Master', NULL, 1, 1, CAST(N'2023-11-28T11:30:41.1762907' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.1762907' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 1, N'Admin', N'Company', N'Company', NULL, 1, 1, CAST(N'2023-11-28T11:30:41.2907295' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.2907295' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (3, 1, N'Admin', N'Branch', N'Branch', NULL, 2, 1, CAST(N'2023-11-28T11:30:41.3402758' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.3402758' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (4, 1, N'Admin', N'User', N'User', NULL, 3, 1, CAST(N'2023-11-28T11:30:41.3874713' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.3874713' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (5, 1, N'Admin', N'Role', N'Role', NULL, 4, 1, CAST(N'2023-11-28T11:30:41.4397717' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.4397717' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (6, 1, N'Admin', N'Access', N'User Access', NULL, 5, 1, CAST(N'2023-11-28T11:30:41.4930159' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.4930159' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (7, 1, N'Admin', N'Menu', N'Menu', NULL, 6, 1, CAST(N'2023-11-28T11:30:41.5580413' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.5580413' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (8, 0, N'', N'Employee', N'Employee', NULL, 2, 1, CAST(N'2023-11-28T11:30:41.6219168' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.6219168' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (9, 0, N'', N'Contact', N'Contact Us', NULL, 3, 1, CAST(N'2023-11-28T11:30:41.6758431' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.6758431' AS DateTime2), 1, 0)
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10, 0, N'', N'About', N'About Us', NULL, 4, 1, CAST(N'2023-11-28T11:30:41.7320640' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.7320640' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 2, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.7919673' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.7919673' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 3, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.8303380' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.8303380' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 4, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.8649269' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.8649269' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 5, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.9035514' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.9035514' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 6, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.9374263' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.9374263' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 7, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.9713490' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.9713490' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 8, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.0062374' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.0062374' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 9, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.0441331' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.0441331' AS DateTime2), 1, 0)
INSERT [dbo].[RoleMenuAccess] ([RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 10, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.0776460' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.0776460' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([Id], [Name], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted], [IsAdmin]) VALUES (1, N'Super Admin', NULL, 1, CAST(N'2023-11-28T11:30:40.9101116' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.9101116' AS DateTime2), 1, 0, 1)
INSERT [dbo].[Roles] ([Id], [Name], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted], [IsAdmin]) VALUES (2, N'Admin', NULL, 1, CAST(N'2023-11-28T11:30:41.0785451' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.0785451' AS DateTime2), 1, 0, 1)
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 1, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:41.2426137' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.2426137' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 2, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.1163763' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.1163763' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 3, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.1662194' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.1662194' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 4, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.2230628' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.2230628' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 5, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.2611118' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.2611118' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 6, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.2962062' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.2962062' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 7, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.3298248' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.3298248' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 8, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.3680950' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.3680950' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 9, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.4023070' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.4023070' AS DateTime2), 1, 0)
INSERT [dbo].[UserMenuAccess] ([CompanyId], [BranchId], [UserId], [RoleId], [MenuId], [IsRead], [IsCreate], [IsUpdate], [IsDelete], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 0, 2, 2, 10, 1, 1, 1, 1, 1, CAST(N'2023-11-28T11:30:42.4402681' AS DateTime2), 1, CAST(N'2023-11-28T11:30:42.4402681' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] ON 

INSERT [dbo].[UserRoleMapping] ([Id], [CompanyId], [BranchId], [UserId], [RoleId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, 1, 1, 1, CAST(N'2023-11-28T11:30:40.9624935' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.9624935' AS DateTime2), 1, 0)
INSERT [dbo].[UserRoleMapping] ([Id], [CompanyId], [BranchId], [UserId], [RoleId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 1, 0, 2, 2, 1, CAST(N'2023-11-28T11:30:41.1402677' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.1402677' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[UserRoleMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [UserName], [Password], [No_Of_Wrong_Password_Attempts], [Next_Change_Password_Date], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, N'Adnin', N'oiuEbYZr5ezZLZ8DTDyCUA==', NULL, NULL, 1, CAST(N'2023-11-28T11:30:40.8442570' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.8442570' AS DateTime2), 1, 0)
INSERT [dbo].[Users] ([Id], [UserName], [Password], [No_Of_Wrong_Password_Attempts], [Next_Change_Password_Date], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, N'Admin', N'LkBM2CAm3Kk=', NULL, NULL, 1, CAST(N'2023-11-28T11:30:41.0232666' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.0232666' AS DateTime2), 1, 0)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
