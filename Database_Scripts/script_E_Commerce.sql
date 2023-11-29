USE [padhyaso_CoreTemplate]
GO
/****** Object:  Table [dbo].[EC_Unit]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Unit]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Unit]
GO
/****** Object:  Table [dbo].[EC_Product_Variant]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Variant]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Variant]
GO
/****** Object:  Table [dbo].[EC_Product_Dtls]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Dtls]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Dtls]
GO
/****** Object:  Table [dbo].[EC_Product_Attributes]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Attributes]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Attributes]
GO
/****** Object:  Table [dbo].[EC_Product_Attribute_Value]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product_Attribute_Value]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product_Attribute_Value]
GO
/****** Object:  Table [dbo].[EC_Product]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Product]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Product]
GO
/****** Object:  Table [dbo].[EC_Category]    Script Date: 29-11-2023 12:25:05 PM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EC_Category]') AND type in (N'U'))
DROP TABLE [dbo].[EC_Category]
GO
/****** Object:  Table [dbo].[EC_Category]    Script Date: 29-11-2023 12:25:05 PM ******/
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
/****** Object:  Table [dbo].[EC_Product]    Script Date: 29-11-2023 12:25:05 PM ******/
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
	[Name] [nvarchar](max) NOT NULL,
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
/****** Object:  Table [dbo].[EC_Product_Attribute_Value]    Script Date: 29-11-2023 12:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Attribute_Value](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[AttributeId] [bigint] NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
	[Display_Value] [nvarchar](max) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Attribute_Value] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Attributes]    Script Date: 29-11-2023 12:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Attributes](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[CreatedDate] [datetime2](7) NULL,
	[LastModifiedBy] [bigint] NOT NULL,
	[LastModifiedDate] [datetime2](7) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Product_Attributes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Product_Dtls]    Script Date: 29-11-2023 12:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Dtls](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[VariantId] [bigint] NOT NULL,
	[UnitId] [bigint] NOT NULL,
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
/****** Object:  Table [dbo].[EC_Product_Variant]    Script Date: 29-11-2023 12:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Product_Variant](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
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
	[ProductId] ASC,
	[AttributeId] ASC,
	[AttributeValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EC_Unit]    Script Date: 29-11-2023 12:25:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EC_Unit](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
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
