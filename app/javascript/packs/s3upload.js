// document.addEventListener("DOMContentLoaded", function() {
//   $("#nichts-btn").click(function() {
//   console.log("hallo")
//  });
// });
document.addEventListener("DOMContentLoaded", function() {
  $("#nichts-btn").click(function(){

    //blob bauen
    const dataURL = editor.toDataURL();
    // convert base64 to raw binary data held in a string
    var byteString = atob(dataURL.split(',')[1]);

    // separate out the mime component
    var mimeString = dataURL.split(',')[0].split(':')[1].split(';')[0];

    // write the bytes of the string to an ArrayBuffer
    var arrayBuffer = new ArrayBuffer(byteString.length);
    var _ia = new Uint8Array(arrayBuffer);
    for (var i = 0; i < byteString.length; i++) {
        _ia[i] = byteString.charCodeAt(i);
    }

    var dataView = new DataView(arrayBuffer);
    var blob = new Blob([dataView], { type: mimeString });
    console.log(blob)

    //s3 fileupload
    $('.directUpload').find("input:file").each(function() {
      debugger
      $("#updated_img").val(blob);
      var fileInput =  $("#updated_img").val();
      console.log(fileInput);
      var form         = $($(fileInput).parents('form:first'));
      // var submitButton = form.find('input[type="submit"]');
      fileInput.fileupload({
        fileInput:       fileInput,
        url:             form.data('url'),
        type:            'POST',
        formData:         form.data('form-data'),
        paramName:        'file', // S3 does not like nested name fields i.e. name="user[avatar_url]"
        dataType:         'XML',  // S3 returns XML if success_action_status is set to 201
        replaceFileInput: false,
        // progressall: function (e, data) {
        //   var progress = parseInt(data.loaded / data.total * 100, 10);
        //   progressBar.css('width', progress + '%')
        // },
        // start: function (e) {
          
          // submitButton.prop('disabled', true);
  
          // progressBar.
          //   css('background', 'green').
          //   css('display', 'block').
          //   css('width', '0%').
          //   text("Loading...");
        // },
        done: function(e, data) {
          // submitButton.prop('disabled', false);
          // progressBar.text("Uploading done");
  
          // extract key and generate URL from response
          var key   = $(data.jqXHR.responseXML).find("Key").text();
          var url   = '//' + form.data('host') + '/' + key;
  
          // create hidden field
          var input = $("<input />", { type:'hidden', name: fileInput.attr('name'), value: url, id:'img_url' })
          form.append(input);
          var elementSelect = document.querySelector('#img_url');
          var valueSelected = elementSelect.value;
  
          var hiddenfield = document.getElementById('hiddenfield');
          hiddenfield.value = valueSelected;
        }
        // fail: function(e, data) {
        //   submitButton.prop('disabled', false);
  
        //   progressBar.
        //     css("background", "red").
        //     text("Failed");
        // }
      });
    });
  });
});