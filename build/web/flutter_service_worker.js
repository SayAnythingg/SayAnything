'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "61678f34c73e3b879e511974cd4ae9f0",
"version.json": "f0eb9aa26e80bde3a0c1ca12d79dd1fc",
"splash/img/light-2x.png": "c81c736dc9ac8b9f910e8cc9085a90dd",
"splash/img/dark-4x.png": "7d6d427380a80b25156a8809aaa9c333",
"splash/img/light-3x.png": "5a026f7e94ca09ffbc08d2a9584d7822",
"splash/img/dark-3x.png": "5a026f7e94ca09ffbc08d2a9584d7822",
"splash/img/light-4x.png": "7d6d427380a80b25156a8809aaa9c333",
"splash/img/dark-2x.png": "c81c736dc9ac8b9f910e8cc9085a90dd",
"splash/img/dark-1x.png": "341589238cbbcdd130dfcdfeb4436493",
"splash/img/light-1x.png": "341589238cbbcdd130dfcdfeb4436493",
"index.html": "24b67f238dee8af18fb80afbd80575b0",
"/": "24b67f238dee8af18fb80afbd80575b0",
"main.dart.js": "c1ef9a61a147f88171d5608d4274a13b",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "f79a7c11d0dab05cf642f068da8871a4",
"assets/AssetManifest.json": "39850aa96064802c09d922e54f534eb4",
"assets/NOTICES": "26633b8ee71c5b61abce8c1e9910c33f",
"assets/FontManifest.json": "615d84ba9472fd172aa7fe1a2f28ea33",
"assets/AssetManifest.bin.json": "85bc37559486ee94005e127cd19c770a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_3d_controller/assets/model-viewer.min.js": "da8ab9e8570d09c7a44ba234786d34f7",
"assets/packages/flutter_3d_controller/assets/template.html": "24a1f29951029adea5122572451138fc",
"assets/packages/iconly/fonts/IconlyBold.ttf": "128714c5bf5b14842f735ecf709ca0d1",
"assets/packages/iconly/fonts/IconlyLight.ttf": "5f376412227e6f8450fe79aec1c2a800",
"assets/packages/iconly/fonts/IconlyBroken.ttf": "6fbd555150d4f77e91c345e125c4ecb6",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "17ee8e30dde24e349e70ffcdc0073fb0",
"assets/packages/syncfusion_flutter_pdfviewer/assets/squiggly.png": "c9602bfd4aa99590ca66ce212099885f",
"assets/packages/syncfusion_flutter_pdfviewer/assets/strikethrough.png": "cb39da11cd936bd01d1c5a911e429799",
"assets/packages/syncfusion_flutter_pdfviewer/assets/highlight.png": "7384946432b51b56b0990dca1a735169",
"assets/packages/syncfusion_flutter_pdfviewer/assets/underline.png": "c94a4441e753e4744e2857f0c4359bf0",
"assets/packages/syncfusion_flutter_pdfviewer/assets/fonts/RobotoMono-Regular.ttf": "5b04fdfec4c8c36e8ca574e40b7148bb",
"assets/packages/quickalert/assets/confirm.gif": "bdc3e511c73e97fbc5cfb0c2b5f78e00",
"assets/packages/quickalert/assets/error.gif": "c307db003cf53e131f1c704bb16fb9bf",
"assets/packages/quickalert/assets/success.gif": "dcede9f3064fe66b69f7bbe7b6e3849f",
"assets/packages/quickalert/assets/loading.gif": "ac70f280e4a1b90065fe981eafe8ae13",
"assets/packages/quickalert/assets/info.gif": "90d7fface6e2d52554f8614a1f5deb6b",
"assets/packages/quickalert/assets/warning.gif": "f45dfa3b5857b812e0c8227211635cc4",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/flutter_chat_ui/assets/icon-seen.png": "b9d597e29ff2802fd7e74c5086dfb106",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-seen.png": "10c256cc3c194125f8fffa25de5d6b8a",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-attachment.png": "9c8f255d58a0a4b634009e19d4f182fa",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-error.png": "5a59dc97f28a33691ff92d0a128c2b7f",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-arrow.png": "8efbd753127a917b4dc02bf856d32a47",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-send.png": "2a7d5341fd021e6b75842f6dadb623dd",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-document.png": "e61ec1c2da405db33bff22f774fb8307",
"assets/packages/flutter_chat_ui/assets/2.0x/icon-delivered.png": "b6b5d85c3270a5cad19b74651d78c507",
"assets/packages/flutter_chat_ui/assets/icon-attachment.png": "17fc0472816ace725b2411c7e1450cdd",
"assets/packages/flutter_chat_ui/assets/icon-error.png": "4fceef32b6b0fd8782c5298ee463ea56",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-seen.png": "684348b596f7960e59e95cff5475b2f8",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-attachment.png": "fcf6bfd600820e85f90a846af94783f4",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-error.png": "872d7d57b8fff12c1a416867d6c1bc02",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-arrow.png": "3ea423a6ae14f8f6cf1e4c39618d3e4b",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-send.png": "8e7e62d5bc4a0e37e3f953fb8af23d97",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-document.png": "4578cb3d3f316ef952cd2cf52f003df2",
"assets/packages/flutter_chat_ui/assets/3.0x/icon-delivered.png": "28f141c87a74838fc20082e9dea44436",
"assets/packages/flutter_chat_ui/assets/icon-arrow.png": "678ebcc99d8f105210139b30755944d6",
"assets/packages/flutter_chat_ui/assets/icon-send.png": "34e43bc8840ecb609e14d622569cda6a",
"assets/packages/flutter_chat_ui/assets/icon-document.png": "b4477562d9152716c062b6018805d10b",
"assets/packages/flutter_chat_ui/assets/icon-delivered.png": "b064b7cf3e436d196193258848eae910",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "cf52ddc438857460dab75080a5c99bc9",
"assets/fonts/MaterialIcons-Regular.otf": "f6840344983e9405999d7efbec55b44a",
"assets/assets/3D/file.obj": "031465aa97204803d14995b4ab6c75ec",
"assets/assets/3D/bunny.obj": "8b8089bd99609c69c9cef99f0e21d287",
"assets/assets/3D/Anna_OBJ.obj": "4048385f7d681e9d59981d383afd1bbc",
"assets/assets/3D/cube.obj": "21b9ebf392fe8f16137e64cfe00ec85f",
"assets/assets/3D/business_man.glb": "78d2e69fe34399d5361c78e86c7eea99",
"assets/assets/images/george.png": "2b7c6d2acb43cb67a74e01912134dc40",
"assets/assets/images/chat2.png": "1310c9467a42007549a23fdb66d8a1f0",
"assets/assets/images/title_logo_logo.png": "d0334bd9e4630332f9f59c17d7465377",
"assets/assets/images/ticker.json": "bb3aafb0c330c51202d099fd56436b8a",
"assets/assets/images/chung.jpeg": "e87a630f8f4f0d0eced1ff2ef31c443c",
"assets/assets/images/chat3.png": "2e57ee1e6ec7ef99578ec7596221d7b0",
"assets/assets/images/nknu_logo_02.png": "e552dfa2c872d53c290855173a382cf4",
"assets/assets/images/multiMedia.png": "1e2bba99c8f41179338732f5e7dbe3fb",
"assets/assets/images/logo_word.png": "74758b9b42f3229bb19b7393f311c719",
"assets/assets/images/slogan.png": "63147fb16338bd279d280a073065acd2",
"assets/assets/images/logo_all700.png": "1a9015f067c1f6648644cd4539d276af",
"assets/assets/images/ticker.png": "b503a05e1d2cf09507626af90972b949",
"assets/assets/images/logo700.png": "478c91b6a8399ed12ec0735627dd44a7",
"assets/assets/images/logo_all.png": "03b83eab0a02dc80880d52320dff4990",
"assets/assets/images/google_ic-1.svg": "01115e151bea117c2788c99057a4afad",
"assets/assets/images/MultiMedia2.png": "3757cb0023a03a3e247d217a5f9a1c3b",
"assets/assets/images/back-1.png": "6f174a7d7321313151e16e8de6c35e97",
"assets/assets/images/MultiMedia3.png": "a32203c16cd32cc4df89b2288c6ead85",
"assets/assets/images/AAA.jpg": "a7dd67bde25fd9a9f18acc1d49649695",
"assets/assets/images/logo_all1000.png": "a05934634ef4ef5039bd34499ab5f300",
"assets/assets/images/back-3.png": "6f174a7d7321313151e16e8de6c35e97",
"assets/assets/images/back-2.png": "6f174a7d7321313151e16e8de6c35e97",
"assets/assets/images/logo.png": "b3b8aa1e348659751ab06519b56bd75c",
"assets/assets/images/back-4.png": "6f174a7d7321313151e16e8de6c35e97",
"assets/assets/images/google_ic.svg": "e97f33b74aec3e57353ecaab0c096280",
"assets/assets/images/ting.png": "8582c0d1c6caad866911143804da1d21",
"assets/assets/images/T.png": "4149b1236f9d8f70ab4cb8f6d81d5768",
"assets/assets/images/B3.png": "eca823920a26231847f4ce69e95e2696",
"assets/assets/images/chat.png": "9165f894f7b67cbb1838eb23f5a53fe4",
"assets/assets/images/B2.png": "396dfd405e2f23b10b25f2eb93eb31e4",
"assets/assets/images/back.png": "4aa1b9d79964e115fdc90916c5277d58",
"assets/assets/messages.json": "30b557efd4481772ee6ff00e6c733941",
"assets/assets/animation/hand.riv": "397d230fd0bbdd1ddf8574e0220f4c4c",
"assets/assets/animation/3.riv": "a19fcd6e4d5ffe66011f9712bc484a49",
"assets/assets/animation/setting.riv": "87ebfd6d25d6172ad4f6e98dd11cf644",
"assets/assets/animation/buttoncta.riv": "dbd634559310307c52d78724cedd11be",
"assets/assets/animation/2.riv": "7f483193e2677812317bb95e1477db38",
"assets/assets/animation/spiral.riv": "15014c41471ef7b43c694d03c2601eb2",
"assets/assets/animation/switch.riv": "3435befa1467d1df18ffd09c33f20bfe",
"assets/assets/animation/Man.riv": "6be5e2065d5f53b0dcc2bdae5bdc5705",
"assets/assets/animation/character.riv": "6704d9f86eb37fdfdbd537a275bb1380",
"assets/assets/animation/click.riv": "f93394b2c08dd7938a0f3209b80e397a",
"assets/assets/animation/cat.riv": "0a42a94e14fc2e6c3f2f4f2a17fcadd4",
"assets/assets/fonts/Urbanist-Bold.ttf": "1ffe51e22e7841c65481a727515e2198",
"assets/assets/fonts/Urbanist-SemiBold.ttf": "ae731014b8aa4267df78b8e854d006ef",
"assets/assets/fonts/Urbanist-Medium.ttf": "9ffbd4b23b829ddd499aaf5eb925a86c",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
