USE [padhyaso_CoreTemplate]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRoleMapping]') AND type in (N'U'))
DROP TABLE [dbo].[UserRoleMapping]
GO
/****** Object:  Table [dbo].[UserMenuAccess]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserMenuAccess]') AND type in (N'U'))
DROP TABLE [dbo].[UserMenuAccess]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Roles]') AND type in (N'U'))
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[RoleMenuAccess]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMenuAccess]') AND type in (N'U'))
DROP TABLE [dbo].[RoleMenuAccess]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Menu]') AND type in (N'U'))
DROP TABLE [dbo].[Menu]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
DROP TABLE [dbo].[Employee]
GO
/****** Object:  Table [dbo].[EC_Unit]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Unit]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Unit]
GO
/****** Object:  Table [dbo].[EC_Tags]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Tags]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Tags]
GO
/****** Object:  Table [dbo].[EC_Stock]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Stock]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Stock]
GO
/****** Object:  Table [dbo].[EC_Product_Variant]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Variant]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Variant]
GO
/****** Object:  Table [dbo].[EC_Product_Dtls]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Dtls]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Dtls]
GO
/****** Object:  Table [dbo].[EC_Product_Attributes]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Attributes]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Attributes]
GO
/****** Object:  Table [dbo].[EC_Product_Attribute_Value]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Attribute_Value]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Attribute_Value]
GO
/****** Object:  Table [dbo].[EC_Product]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product]
GO
/****** Object:  Table [dbo].[EC_Category]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Category]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Category]
GO
/****** Object:  Table [dbo].[Contact]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Contact]') AND type in (N'U'))
DROP TABLE [dbo].[Contact]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Company]') AND type in (N'U'))
DROP TABLE [dbo].[Company]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Branch]') AND type in (N'U'))
DROP TABLE [dbo].[Branch]
GO
/****** Object:  Table [dbo].[Attachments]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attachments]') AND type in (N'U'))
DROP TABLE [dbo].[Attachments]
GO
/****** Object:  Table [dbo].[About]    Script Date: 13-12-2023 04:45:00 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[About]') AND type in (N'U'))
DROP TABLE [dbo].[About]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 13-12-2023 04:45:00 PM ******/
DROP FUNCTION [dbo].[SplitString]
GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[About]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Attachments]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attachments](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Extension] [nvarchar](max) NOT NULL,
	[Size] [bigint] NOT NULL,
	[Type] [nvarchar](max) NULL,
	[Path] [nvarchar](max) NOT NULL,
	[Remarks] [nvarchar](max) NULL,
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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Company]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Contact]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[EC_Category]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Category](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[ParentId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Desc] [nvarchar](max) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[CategoryId] [bigint] NOT NULL,
	[BrandId] [bigint] NOT NULL,
	[UnitId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Primary_Desc] [nvarchar](max) NULL,
	[Secondary_Desc] [nvarchar](max) NULL,
	[BasePrice] [decimal](18, 2) NOT NULL,
	[SalePrice] [decimal](18, 2) NOT NULL,
	[Primary_Images] [nvarchar](max) NULL,
	[Secondary_Images] [nvarchar](max) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[CategoryId] ASC,
	[BrandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Attribute_Value]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Attribute_Value](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[AttributeId] [bigint] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Display_Value] [nvarchar](max) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Attribute_Value] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[AttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Attributes]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Attributes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Attributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Dtls]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Dtls](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[VariantId] [bigint] NOT NULL,
	[BasePrice] [decimal](18, 2) NOT NULL,
	[SalePrice] [decimal](18, 2) NOT NULL,
	[Primary_Desc] [nvarchar](max) NULL,
	[Secondary_Desc] [nvarchar](max) NULL,
	[Primary_Images] [nvarchar](max) NULL,
	[Secondary_Images] [nvarchar](max) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Dtls] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[ProductId] ASC,
	[VariantId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Variant]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Variant](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[VariantId] [bigint] NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[AttributeId] [bigint] NOT NULL,
	[AttributeValueId] [bigint] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ProductVariant] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[ProductId] ASC,
	[AttributeId] ASC,
	[AttributeValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Stock]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Stock](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[CategoryId] [bigint] NOT NULL,
	[VariantId] [bigint] NOT NULL,
	[BrandId] [bigint] NOT NULL,
	[UnitId] [bigint] NOT NULL,
	[Quantity] [numeric](18, 2) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Stock] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Tags]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Tags](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Desc] [nvarchar](max) NULL,
	[Products] [nvarchar](max) NULL,
	[Categories] [nvarchar](max) NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[CompanyId] ASC,
	[BranchId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Unit]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Unit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Code] [nvarchar](max) NULL,
	[Multiplier] [decimal](18, 3) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 13-12-2023 04:45:00 PM ******/
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
	[IsSuperAdmin] [bit] NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleMenuAccess]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Roles]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[UserMenuAccess]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[UserRoleMapping]    Script Date: 13-12-2023 04:45:00 PM ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 13-12-2023 04:45:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyId] [bigint] NOT NULL,
	[BranchId] [bigint] NOT NULL,
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
 CONSTRAINT [PK_Users_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Company] ON 
GO
INSERT [dbo].[Company] ([Id], [Name], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, N'VK Jewellers', 1, CAST(N'2023-11-28T11:30:40.5959994' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.5959994' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Company] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Category] ON 
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, 0, N'Clothings & Apparels
', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (8, 1, 0, 1, N'Women', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (9, 1, 0, 1, N'Men', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10, 1, 0, 1, N'Boys', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (11, 1, 0, 1, N'Girls', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (12, 1, 0, 0, N'Baby Care', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (13, 1, 0, 12, N'Diapers', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (14, 1, 0, 12, N'Tshirts', NULL, 1, NULL, 1, NULL, 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (15, 1, 0, 1, N'Socks', NULL, 1, NULL, 1, CAST(N'2023-11-29T15:19:32.1269527' AS DateTime2), 0, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10002, 1, 0, 0, N'Electronics', NULL, 2, CAST(N'2023-12-07T08:42:43.2553267' AS DateTime2), 2, CAST(N'2023-12-07T08:43:05.1799101' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Category] ([Id], [CompanyId], [BranchId], [ParentId], [Name], [Desc], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10003, 1, 0, 10002, N'E1', NULL, 2, CAST(N'2023-12-07T08:43:17.6380701' AS DateTime2), 2, CAST(N'2023-12-07T08:43:17.6380701' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Category] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Product] ON 
GO
INSERT [dbo].[EC_Product] ([Id], [CompanyId], [BranchId], [CategoryId], [BrandId], [UnitId], [Name], [Primary_Desc], [Secondary_Desc], [BasePrice], [SalePrice], [Primary_Images], [Secondary_Images], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, 1, 0, 6, N'P1', NULL, NULL, CAST(100.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), N'11', NULL, 2, CAST(N'2023-12-07T15:48:07.2472993' AS DateTime2), 2, CAST(N'2023-12-07T15:52:28.1481142' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Product] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Attribute_Value] ON 
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (6, 1, 0, 1, N'White', NULL, 2, CAST(N'2023-11-30T14:23:20.0908254' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.6405902' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (7, 1, 0, 1, N'Blue', NULL, 2, CAST(N'2023-11-30T14:23:42.9197512' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.6808412' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (8, 1, 0, 1, N'Green', NULL, 2, CAST(N'2023-11-30T14:24:05.9452787' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.7167320' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (9, 1, 0, 1, N'Yellow', NULL, 2, CAST(N'2023-11-30T14:24:20.8291467' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.7516371' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10, 1, 0, 1, N'Black', NULL, 2, CAST(N'2023-11-30T14:24:20.9192852' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.7855452' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10002, 1, 0, 2, N'1 KG', NULL, 2, CAST(N'2023-12-01T10:10:03.7109450' AS DateTime2), 2, CAST(N'2023-12-01T10:10:03.7109450' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10003, 1, 0, 2, N'5 KG', NULL, 2, CAST(N'2023-12-01T10:10:03.7948016' AS DateTime2), 2, CAST(N'2023-12-01T10:10:03.7948016' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10004, 1, 0, 2, N'10 KG', NULL, 2, CAST(N'2023-12-01T10:10:03.8333899' AS DateTime2), 2, CAST(N'2023-12-01T10:10:03.8333899' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10005, 1, 0, 3, N'Small', NULL, 2, CAST(N'2023-12-01T10:10:20.5351613' AS DateTime2), 2, CAST(N'2023-12-01T10:10:20.5351613' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10006, 1, 0, 3, N'Medium', NULL, 2, CAST(N'2023-12-01T10:10:20.5760893' AS DateTime2), 2, CAST(N'2023-12-01T10:10:20.5760893' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10007, 1, 0, 3, N'Large', NULL, 2, CAST(N'2023-12-01T10:10:20.6149189' AS DateTime2), 2, CAST(N'2023-12-01T10:10:20.6149189' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attribute_Value] ([Id], [CompanyId], [BranchId], [AttributeId], [Value], [Display_Value], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10008, 1, 0, 1, N'Purpul', NULL, 2, CAST(N'2023-12-07T08:38:48.8224437' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.8224437' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Attribute_Value] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Attributes] ON 
GO
INSERT [dbo].[EC_Product_Attributes] ([Id], [CompanyId], [BranchId], [Name], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, N'Color', 2, CAST(N'2023-11-30T13:45:16.8700496' AS DateTime2), 2, CAST(N'2023-12-07T08:38:48.4904099' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attributes] ([Id], [CompanyId], [BranchId], [Name], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 1, 0, N'Weight', 2, CAST(N'2023-11-30T13:45:36.6259183' AS DateTime2), 2, CAST(N'2023-12-01T10:10:03.5670242' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Attributes] ([Id], [CompanyId], [BranchId], [Name], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (3, 1, 0, N'Size', 2, CAST(N'2023-11-30T13:45:46.1616151' AS DateTime2), 2, CAST(N'2023-12-01T10:10:20.4632995' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Attributes] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Dtls] ON 
GO
INSERT [dbo].[EC_Product_Dtls] ([Id], [ProductId], [VariantId], [BasePrice], [SalePrice], [Primary_Desc], [Secondary_Desc], [Primary_Images], [Secondary_Images], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 7, CAST(100.00 AS Decimal(18, 2)), CAST(101.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 2, CAST(N'2023-12-07T15:48:07.5077325' AS DateTime2), 2, CAST(N'2023-12-07T15:52:52.5231606' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Dtls] ([Id], [ProductId], [VariantId], [BasePrice], [SalePrice], [Primary_Desc], [Secondary_Desc], [Primary_Images], [Secondary_Images], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 1, 8, CAST(100.00 AS Decimal(18, 2)), CAST(100.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, 2, CAST(N'2023-12-07T15:49:19.0992787' AS DateTime2), 2, CAST(N'2023-12-07T15:52:52.5909769' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Dtls] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Variant] ON 
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (99, 1, 0, 4, 2, 1, 10, 2, CAST(N'2023-12-07T08:59:52.5684984' AS DateTime2), 2, CAST(N'2023-12-07T08:59:52.5684984' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (100, 1, 0, 4, 2, 3, 10007, 2, CAST(N'2023-12-07T08:59:54.2980623' AS DateTime2), 2, CAST(N'2023-12-07T08:59:54.2980623' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (101, 1, 0, 5, 2, 0, 0, 2, CAST(N'2023-12-07T08:59:54.7012356' AS DateTime2), 2, CAST(N'2023-12-07T08:59:54.7012356' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (108, 1, 0, 6, 3, 0, 0, 2, CAST(N'2023-12-07T09:06:36.1120120' AS DateTime2), 2, CAST(N'2023-12-07T09:06:36.1120120' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (114, 1, 0, 7, 1, 1, 10, 2, CAST(N'2023-12-07T15:52:28.3745188' AS DateTime2), 2, CAST(N'2023-12-07T15:52:28.3745188' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (115, 1, 0, 7, 1, 3, 10007, 2, CAST(N'2023-12-07T15:52:28.4183936' AS DateTime2), 2, CAST(N'2023-12-07T15:52:28.4183936' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Product_Variant] ([Id], [CompanyId], [BranchId], [VariantId], [ProductId], [AttributeId], [AttributeValueId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (116, 1, 0, 8, 1, 0, 0, 2, CAST(N'2023-12-07T15:52:28.4742378' AS DateTime2), 2, CAST(N'2023-12-07T15:52:28.4742378' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Product_Variant] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Tags] ON 
GO
INSERT [dbo].[EC_Tags] ([Id], [CompanyId], [BranchId], [Name], [Desc], [Products], [Categories], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, N'Diwali Offer', NULL, N'1', N'1#8#9#10#12#13#14#10003', 2, CAST(N'2023-12-07T16:36:01.0881365' AS DateTime2), 2, CAST(N'2023-12-07T16:54:38.7390086' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Tags] ([Id], [CompanyId], [BranchId], [Name], [Desc], [Products], [Categories], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, 1, 0, N'Winter Offer', NULL, NULL, NULL, 2, CAST(N'2023-12-07T16:36:16.3739847' AS DateTime2), 2, CAST(N'2023-12-07T16:36:16.3739847' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Tags] OFF
GO
SET IDENTITY_INSERT [dbo].[EC_Unit] ON 
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, N'Liter', N'L', CAST(1.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:45:37.7812223' AS DateTime2), 2, CAST(N'2023-11-30T14:56:12.7129939' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (2, N'Unit', N'U', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:45:56.5206385' AS DateTime2), 2, CAST(N'2023-11-30T14:45:56.5206385' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (3, N'Gram', N'G', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:46:12.7392723' AS DateTime2), 2, CAST(N'2023-11-30T14:46:12.7392723' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (4, N'Inches', N'In', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:49:35.6505696' AS DateTime2), 2, CAST(N'2023-11-30T14:49:35.6505696' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (5, N'Meter', N'M', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:49:51.4647862' AS DateTime2), 2, CAST(N'2023-11-30T14:49:51.4647862' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (6, N'Piece', N'PC', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:50:16.7853611' AS DateTime2), 2, CAST(N'2023-11-30T14:50:16.7853611' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (7, N'Set', N'SET', CAST(0.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:50:42.4325689' AS DateTime2), 2, CAST(N'2023-11-30T14:50:42.4325689' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (8, N'Dozen', N'DZ', CAST(12.000 AS Decimal(18, 3)), 2, CAST(N'2023-11-30T14:51:02.2849392' AS DateTime2), 2, CAST(N'2023-11-30T14:55:38.8566908' AS DateTime2), 1, 0)
GO
INSERT [dbo].[EC_Unit] ([Id], [Name], [Code], [Multiplier], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (10002, N'Set of 3', N'SET3', CAST(3.000 AS Decimal(18, 3)), 2, CAST(N'2023-12-07T08:57:07.0204890' AS DateTime2), 2, CAST(N'2023-12-07T08:57:07.0204890' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[EC_Unit] OFF
GO
SET IDENTITY_INSERT [dbo].[Menu] ON 
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (1, 0, N'', N'', N'Company Master', NULL, 1, 1, CAST(N'2023-11-28T11:30:41.1762907' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.1762907' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (2, 1, N'Admin', N'Company', N'Company', NULL, 1, 1, CAST(N'2023-11-28T11:30:41.2907295' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.2907295' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (3, 1, N'Admin', N'Branch', N'Branch', NULL, 2, 1, CAST(N'2023-11-28T11:30:41.3402758' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.3402758' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (4, 1, N'Admin', N'User', N'User', NULL, 3, 1, CAST(N'2023-11-28T11:30:41.3874713' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.3874713' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (5, 1, N'Admin', N'Role', N'Role', NULL, 4, 1, CAST(N'2023-11-28T11:30:41.4397717' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.4397717' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (6, 1, N'Admin', N'Access', N'User Access', NULL, 5, 1, CAST(N'2023-11-28T11:30:41.4930159' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.4930159' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (7, 1, N'Admin', N'Menu', N'Menu', NULL, 6, 1, CAST(N'2023-11-28T11:30:41.5580413' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.5580413' AS DateTime2), 1, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (8, 0, N'', N'Employee', N'Employee', NULL, 2, 1, CAST(N'2023-11-28T11:30:41.6219168' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.6219168' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (9, 0, N'', N'Contact', N'Contact Us', NULL, 3, 1, CAST(N'2023-11-28T11:30:41.6758431' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.6758431' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (10, 0, N'', N'About', N'About Us', NULL, 4, 1, CAST(N'2023-11-28T11:30:41.7320640' AS DateTime2), 1, CAST(N'2023-11-28T11:30:41.7320640' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (11, 0, N'-', N'-', N'E-Commerce', NULL, 1, 1, CAST(N'2023-11-29T14:36:56.7739562' AS DateTime2), 1, CAST(N'2023-11-29T14:36:56.7739562' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (12, 11, N'Admin', N'Category', N'Category', NULL, 1, 1, CAST(N'2023-11-29T14:37:17.0514202' AS DateTime2), 1, CAST(N'2023-11-29T14:38:34.6837058' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (13, 11, N'Admin', N'Product', N'Product', NULL, 1, 1, CAST(N'2023-11-29T16:31:10.5061160' AS DateTime2), 1, CAST(N'2023-11-29T16:31:10.5061160' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (14, 11, N'Admin', N'Attribute', N'Product Attribute', NULL, 1, 1, CAST(N'2023-11-30T10:53:32.1857303' AS DateTime2), 1, CAST(N'2023-11-30T10:53:32.1857303' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (15, 11, N'Admin', N'Unit', N'Product Unit (UOM)', NULL, 1, 1, CAST(N'2023-11-30T14:38:41.7382670' AS DateTime2), 1, CAST(N'2023-11-30T14:38:41.7382670' AS DateTime2), 0, 1, 1, 0)
GO
INSERT [dbo].[Menu] ([Id], [ParentId], [Area], [Controller], [Name], [Icon], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsSuperAdmin], [IsAdmin], [IsActive], [IsDeleted]) VALUES (10002, 11, N'Admin', N'Tags', N'Tags', NULL, 1, 1, CAST(N'2023-12-07T16:34:19.1382322' AS DateTime2), 1, CAST(N'2023-12-07T16:34:19.1382322' AS DateTime2), 0, 1, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Menu] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 
GO
INSERT [dbo].[Roles] ([Id], [Name], [DisplayOrder], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted], [IsAdmin]) VALUES (1, N'Super Admin', NULL, 1, CAST(N'2023-11-28T11:30:40.9101116' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.9101116' AS DateTime2), 1, 0, 1)
GO
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] ON 
GO
INSERT [dbo].[UserRoleMapping] ([Id], [CompanyId], [BranchId], [UserId], [RoleId], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, 1, 1, 1, NULL, 1, NULL, 1, 0)
GO
SET IDENTITY_INSERT [dbo].[UserRoleMapping] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [CompanyId], [BranchId], [UserName], [Password], [No_Of_Wrong_Password_Attempts], [Next_Change_Password_Date], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate], [IsActive], [IsDeleted]) VALUES (1, 1, 0, N'Adnin', N'oiuEbYZr5ezZLZ8DTDyCUA==', NULL, NULL, 1, CAST(N'2023-11-28T11:30:40.8442570' AS DateTime2), 1, CAST(N'2023-11-28T11:30:40.8442570' AS DateTime2), 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
