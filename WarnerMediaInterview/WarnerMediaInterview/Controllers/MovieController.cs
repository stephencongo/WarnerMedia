using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WarnerMediaBackend = WarnerMediaInterview.Backend;
using ViewModels = WarnerMediaInterview.API.ViewModels;

using AutoMapper;

namespace WarnerMediaInterview.API.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class MovieController : ControllerBase
    {
        WarnerMediaBackend.IMovieService _movieService;
        IMapper _iMapper;
        public MovieController(WarnerMediaBackend.IMovieService movieService)
        {
            _movieService = movieService;

            //using automapper to convert data objects to view model objects.
            var config = new MapperConfiguration(cfg => {
                cfg.CreateMap<WarnerMediaBackend.DataObjects.Award, ViewModels.Award>();
                cfg.CreateMap<WarnerMediaBackend.DataObjects.Genre, ViewModels.Genre>();
                cfg.CreateMap<WarnerMediaBackend.DataObjects.OtherName, ViewModels.OtherName>();
                cfg.CreateMap<WarnerMediaBackend.DataObjects.Participant, ViewModels.Participant>();
                cfg.CreateMap<WarnerMediaBackend.DataObjects.StoryLine, ViewModels.StoryLine>();
                cfg.CreateMap<WarnerMediaBackend.DataObjects.Title, ViewModels.Title>();
            });
            _iMapper = config.CreateMapper();
        }

        [HttpGet]
        public ActionResult Get()
        {
            return Ok("");
        }

        [HttpGet]
        [Route("search")]
        public async Task<ActionResult> GetAllMovieTitlesAsync()
        {
            var titles = await _movieService.GetMovieTitleSearchAsync("");
            return Ok(_iMapper.Map<List<WarnerMediaBackend.DataObjects.Title>, List<ViewModels.Title>>(titles));
        }

        [HttpGet]
        [Route("search/{searchString}")]
        public async Task<ActionResult> GetMovieTitleSearchAsync(string searchString)
        {
           var titles = await _movieService.GetMovieTitleSearchAsync(searchString);
            return Ok(_iMapper.Map<List<WarnerMediaBackend.DataObjects.Title>, List<ViewModels.Title>>(titles));
        }

        [HttpGet]
        [Route("{titleId:int}")]
        public async Task<ActionResult> GetTitleAsync(int titleId)
        {
            var title = await _movieService.GetTitleAsync(titleId);
            return Ok(_iMapper.Map<WarnerMediaBackend.DataObjects.Title, ViewModels.Title>(title));
        }
    }
}
