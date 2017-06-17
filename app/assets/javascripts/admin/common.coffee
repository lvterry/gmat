window.qiniu_domain = '7xtg0z.com2.z0.glb.clouddn.com'

window.initQiniu = (filesAdded, filesUploaded) ->
    uploader = Qiniu.uploader
      runtimes: 'html5,flash,html4'      # 上传模式，依次退化
      browse_button: 'qiniu_upload'      # 上传选择的点选按钮，必需
      uptoken_url: '/welcome/uptoken'    # Ajax请求uptoken的Url，强烈建议设置（服务端提供）
      get_new_uptoken: false             # 设置上传文件的时候是否每次都重新获取新的uptoken
      domain: qiniu_domain #bucket域名，下载资源时用到，必需
      container: 'qiniu_container'            # 上传区域DOM ID，默认是browser_button的父元素
      max_file_size: '10mb'              # 最大文件体积限制
      flash_swf_url: 'plupload/Moxie.swf' # 引入flash，相对路径
      max_retries: 3                     # 上传失败最大重试次数
      dragdrop: false                    # 开启可拖曳上传
      auto_start: true                   # 选择文件后自动上传，若关闭需要自己绑定事件触发上传
      init:
        'FilesAdded': filesAdded
        'FileUploaded': filesUploaded

$ ->
  $('#summernote').summernote()

  $('.datetime').datetimeEntry
    datetimeFormat: 'Y-O-D H:M'
    spinnerImage: ''

  $('.meeting-form').on 'click', '.delete-meeting-block', ->
    checkbox = $(@)
    tds = checkbox.parents('tr').find('td').not(':last')
    tds.css 'opacity', if checkbox.is(':checked') then 0.4 else 1

  $('.add-meeting-block').on 'click', (e)->
    e.preventDefault()
    #meetingId = $('#meeting_id').val()
    rows = $('.meeting-form tr')
    $('.meeting-form tbody').append("<tr>
                        <td>
                          <input class=\"form-control datetime is-datetimeEntry\" type=\"text\" name=\"meeting[meeting_blocks_attributes][#{rows.length}][start_time]\" id=\"meeting_meeting_blocks_attributes_#{rows.length}_start_time\">
                        </td>
                        <td>
                          <input class=\"form-control datetime is-datetimeEntry\" type=\"text\" name=\"meeting[meeting_blocks_attributes][#{rows.length}][end_time]\" id=\"meeting_meeting_blocks_attributes_#{rows.length}_end_time\">
                        </td>
                        <td>
                        </td>
                      </tr>")