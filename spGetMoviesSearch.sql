USE [Titles]
GO

/****** Object:  StoredProcedure [dbo].[spGetMoviesSearch]    Script Date: 5/14/2021 4:08:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetMoviesSearch]
	-- Add the parameters for the stored procedure here
	@SearchString varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct T.TitleId, T.TitleName, T.TitleNameSortable, T.TitleTypeId, T.ReleaseYear, T.ProcessedDateTimeUTC
	from Title T
	inner join OtherName O on T.TitleId = O.TitleId
	where @SearchString = '' or T.TitleName Like '%' + @SearchString + '%' or O.TitleName like '%' + @SearchString + '%'

END
GO

