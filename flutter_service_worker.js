'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/img/tiao_1.png": "00bb0c73a9ceca1fbaf9e01714242627",
"assets/assets/img/wan_9.png": "6cbdd25595606b3c4ba82d0b3e61ea58",
"assets/assets/img/wan_3.png": "d866dec3ea6f7c549b386bc731ba690c",
"assets/assets/img/tiao_4.png": "11f6c97d83642eb62ad71ffab46984a5",
"assets/assets/img/wan_5.png": "2e1a19e0ca4c37609a0aee748ab6c8eb",
"assets/assets/img/ton_6.png": "7d3659da4242ef5942ff19363f3c6ef5",
"assets/assets/img/south.png": "94cbdb86e303d7e2967e11ff37fa2945",
"assets/assets/img/tiao_7.png": "ec77f9f30ac35e3891ab2416756923d5",
"assets/assets/img/tiao/tiao_1x/tiao_1.png": "00bb0c73a9ceca1fbaf9e01714242627",
"assets/assets/img/tiao/tiao_1x/tiao_4.png": "11f6c97d83642eb62ad71ffab46984a5",
"assets/assets/img/tiao/tiao_1x/tiao_7.png": "ec77f9f30ac35e3891ab2416756923d5",
"assets/assets/img/tiao/tiao_1x/tiao_9.png": "4bd3d61aeff8d36a0fd4ffdfabbd5504",
"assets/assets/img/tiao/tiao_1x/tiao_8.png": "80645a73cc6cbd90be47e019b9bb995e",
"assets/assets/img/tiao/tiao_1x/tiao_5.png": "4379009b68bb5b5828c14535ebe679b2",
"assets/assets/img/tiao/tiao_1x/tiao_2.png": "05991a50a812dafbe5284d355fb1cac7",
"assets/assets/img/tiao/tiao_1x/tiao_6.png": "d93b6af80f22012e8e05a1462409b03a",
"assets/assets/img/tiao/tiao_1x/tiao_3.png": "465a92ebd5874baf77b563eba3cbcc1f",
"assets/assets/img/tiao_9.png": "4bd3d61aeff8d36a0fd4ffdfabbd5504",
"assets/assets/img/wan_8.png": "13c2bd1da244511a32d9053b1b460b10",
"assets/assets/img/wan_6.png": "39770241741e5e8c12e879b94865f55c",
"assets/assets/img/ton_1.png": "79376291e847bc769e5af25b3dabd2d9",
"assets/assets/img/ton/ton_1x/ton_6.png": "7d3659da4242ef5942ff19363f3c6ef5",
"assets/assets/img/ton/ton_1x/ton_1.png": "79376291e847bc769e5af25b3dabd2d9",
"assets/assets/img/ton/ton_1x/ton_4.png": "6ddacf05c2e02920f2dc3a8bc4226cbe",
"assets/assets/img/ton/ton_1x/ton_9.png": "f2f8aa19765e7b9f5b593cecc15a8bc3",
"assets/assets/img/ton/ton_1x/ton_7.png": "f5f2b74ed9994048f4d623f982c56085",
"assets/assets/img/ton/ton_1x/ton_2.png": "555e37439863d97ad99fdd4aecb5d795",
"assets/assets/img/ton/ton_1x/ton_5.png": "2ed072447019628cba31251fa7422e52",
"assets/assets/img/ton/ton_1x/ton_3.png": "fcebe35f1212640c836397e47035e854",
"assets/assets/img/ton/ton_1x/ton_8.png": "6576f94e1511f260edec8cd73e2dae41",
"assets/assets/img/ton_4.png": "6ddacf05c2e02920f2dc3a8bc4226cbe",
"assets/assets/img/north.png": "b4a9567327ce46db9b3648c1383b380c",
"assets/assets/img/green.png": "496c5256c6a715aa9422620089cefc8e",
"assets/assets/img/wan_2.png": "43a73f82656845f816beef47c233b1ed",
"assets/assets/img/ton_9.png": "f2f8aa19765e7b9f5b593cecc15a8bc3",
"assets/assets/img/ton_7.png": "f5f2b74ed9994048f4d623f982c56085",
"assets/assets/img/ton_2.png": "555e37439863d97ad99fdd4aecb5d795",
"assets/assets/img/ton_5.png": "2ed072447019628cba31251fa7422e52",
"assets/assets/img/east.png": "0fa5ee68a59bc59b04b3751c48942fbe",
"assets/assets/img/wan/wan_1x/wan_9.png": "6cbdd25595606b3c4ba82d0b3e61ea58",
"assets/assets/img/wan/wan_1x/wan_3.png": "d866dec3ea6f7c549b386bc731ba690c",
"assets/assets/img/wan/wan_1x/wan_5.png": "2e1a19e0ca4c37609a0aee748ab6c8eb",
"assets/assets/img/wan/wan_1x/wan_8.png": "13c2bd1da244511a32d9053b1b460b10",
"assets/assets/img/wan/wan_1x/wan_6.png": "39770241741e5e8c12e879b94865f55c",
"assets/assets/img/wan/wan_1x/wan_2.png": "43a73f82656845f816beef47c233b1ed",
"assets/assets/img/wan/wan_1x/wan_4.png": "ee838f1dc669cb2315dc9384fadf8655",
"assets/assets/img/wan/wan_1x/wan_7.png": "e63355a1a7a98c7218fda4449917d382",
"assets/assets/img/wan/wan_1x/wan_1.png": "580f03abb14c6053322368abdb3dee3c",
"assets/assets/img/wan_4.png": "ee838f1dc669cb2315dc9384fadf8655",
"assets/assets/img/red.png": "d880209cc78dbd028f5615bf88bbc705",
"assets/assets/img/white.png": "f142411379db07e8b536630919319865",
"assets/assets/img/tiao_8.png": "80645a73cc6cbd90be47e019b9bb995e",
"assets/assets/img/west.png": "0cd9caed3e794438346de448ff53914c",
"assets/assets/img/tiao_5.png": "4379009b68bb5b5828c14535ebe679b2",
"assets/assets/img/tiao_2.png": "05991a50a812dafbe5284d355fb1cac7",
"assets/assets/img/wan_7.png": "e63355a1a7a98c7218fda4449917d382",
"assets/assets/img/gameIcon/mahjong.png": "9b14795d53c1819939fc06dde03d7bfb",
"assets/assets/img/gameIcon/bomb.png": "63ce4aa7ed590521a25719906764888b",
"assets/assets/img/ton_3.png": "fcebe35f1212640c836397e47035e854",
"assets/assets/img/wan_1.png": "580f03abb14c6053322368abdb3dee3c",
"assets/assets/img/words/words_1x/south.png": "94cbdb86e303d7e2967e11ff37fa2945",
"assets/assets/img/words/words_1x/north.png": "b4a9567327ce46db9b3648c1383b380c",
"assets/assets/img/words/words_1x/green.png": "496c5256c6a715aa9422620089cefc8e",
"assets/assets/img/words/words_1x/east.png": "0fa5ee68a59bc59b04b3751c48942fbe",
"assets/assets/img/words/words_1x/red.png": "d880209cc78dbd028f5615bf88bbc705",
"assets/assets/img/words/words_1x/white.png": "f142411379db07e8b536630919319865",
"assets/assets/img/words/words_1x/west.png": "0cd9caed3e794438346de448ff53914c",
"assets/assets/img/tiao_6.png": "d93b6af80f22012e8e05a1462409b03a",
"assets/assets/img/tiao_3.png": "465a92ebd5874baf77b563eba3cbcc1f",
"assets/assets/img/ton_8.png": "6576f94e1511f260edec8cd73e2dae41",
"assets/assets/bomb.jpg": "c69c13523b9a813608eabcb492a00193",
"assets/assets/audio/8002.mp3": "2b20f087c09a6f65ec27e4636e015971",
"assets/assets/audio/shuffle.mp3": "b418d062c08d0bd1ec884ba79c9ab818",
"assets/NOTICES": "1eda4bf6eae70e5484e3a365f096abb7",
"assets/AssetManifest.json": "f403b9d87c5d11859bf8bcee49868e58",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"version.json": "ecb7f4fdfd7b7603cd571873c4e8f519",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"index.html": "4bcb073ad2d327c6c681acc8d9812c50",
"/": "4bcb073ad2d327c6c681acc8d9812c50",
"main.dart.js": "fa12e652abc5d0499af413218d41905c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
