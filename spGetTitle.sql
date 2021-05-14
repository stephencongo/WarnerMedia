USE [Titles]
GO

/****** Object:  StoredProcedure [dbo].[spGetTitle]    Script Date: 5/14/2021 4:08:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGetTitle] 
	-- Add the parameters for the stored procedure here
	@TitleId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT distinct T.TitleId, 
	T.TitleName, 
	T.TitleNameSortable, 
	T.TitleTypeId, 
	T.ReleaseYear,
	T.ProcessedDateTimeUTC
	from Title T
	where T.TitleId = @TitleId

	Select
	G.Id as GenreId,
	G.[Name] as GenreName
	from TitleGenre TG
	inner join Genre G on TG.GenreId = G.Id
	where TG.TitleId = @TitleId

	Select
	P.Id as ParticipantId,
	P.Name as ParticipantName,
	P.ParticipantType
	from TitleParticipant TP
	inner join Participant P on P.Id = TP.ParticipantId
	where TP.TitleId = @TitleId

	Select
	S.Id as StoryLineId,
	S.Type as StoryType, 
	S.Language as StoryLanguage
	from StoryLine S 
	where S.TitleId = @TitleId

	Select 
	O.Id as OtherNameId,
	O.TitleNameLanguage, 
	O.TitleNameType,
	O.TitleName,
	O.Id as OtherNameId
	from OtherName O where O.TitleId = @TitleId

	Select
	A.Id as AwardId, 
	A.AwardWon, 
	A.AwardYear, 
	A.Award as AwardDescription, 
	A.AwardCompany
	
	from Award A where A.TitleId = @TitleId
END
GO

