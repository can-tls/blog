document.addEventListener("DOMContentLoaded", function() {
    // code...
    var ImageEditor = require('tui-image-editor');
    //var blackTheme = require('./js/theme/black-theme.js');
    window.editor = new ImageEditor(document.querySelector('#tui'), {
        includeUI: {
            loadImage: {
                path: 'https://ruby-profile-picture.s3.eu-central-1.amazonaws.com/uploads/00450588-f6d5-489b-97b5-a4db27b0c3c4/fp_sign_blogbeitrag_kw_34_V2.jpg',
                name: 'SampleImage'
            },
            //locale: locale_ru_RU,
            //theme: blackTheme, // or whiteTheme
            initMenu: 'filter',
            menuBarPosition: 'bottom'
        }
    });
});

// function dataURLtoBlob(dataurl) {
//     var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
//         bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
//     while(n--){
//         u8arr[n] = bstr.charCodeAt(n);
//     }
//     return new Blob([u8arr], {type:mime});
// }

// document.addEventListener("DOMContentLoaded", function() {
//     // code...
//     ImageEditor = require('tui-image-editor');
//     //var blackTheme = require('./js/theme/black-theme.js');
//     window.editor = new ImageEditor(document.querySelector('#tui'), {
//         includeUI: {
//             loadImage: {
//                 path: 'https://ruby-profile-picture.s3.eu-central-1.amazonaws.com/uploads/00450588-f6d5-489b-97b5-a4db27b0c3c4/fp_sign_blogbeitrag_kw_34_V2.jpg',
//                 name: 'SampleImage'
//             },
//             //locale: locale_ru_RU,
//             //theme: blackTheme, // or whiteTheme
//             initMenu: 'filter',
//             menuBarPosition: 'bottom'
//         }
//     });
//     $('#theForm').on('click', function (e) {
//         const blob = dataURLtoBlob(window.editor.toDataURL());
//         const formData = this.parentElement
//         debugger
//           $.ajax({
//             type: 'PUT',
//             url: this.form.dataset.url,
//             // Content type must much with the parameter you signed your URL with
//             contentType: 'binary/octet-stream',
//             // this flag is important, if not set, it will try to send data as a form
//             processData: false,
//             // the actual file is sent raw
//             data: blob
//         });

//         return false;
//     });
  // https://gist.github.com/guumaster/9f18204aca2bd6c71a24
// });
