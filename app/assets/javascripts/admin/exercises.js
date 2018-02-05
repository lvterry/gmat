$(function(){
  $('.delete-exercise').on('click', function(e){
    e.preventDefault();
    if(window.confirm('确认删除吗？')){
      $(this).parents('tr').remove();
      $.ajax({
        url: $(this).attr('href'),
        method: 'delete'
      });
      return false;
    }
  });


  $('#exercise_video_url').on('blur', function(e){
    var input = $(e.currentTarget);
    var videoId = input.val();
    $('#ployv').remove();

    var div = document.createElement('div');
    div.id = 'ployv';

    input.after(div);
    
    player = polyvObject(div).videoPlayer({
      'width': '500',
      'height': '373',
      'vid': videoId
    });
  });
    
    
})
  
  
  