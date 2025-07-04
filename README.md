# RIDER-WQ.github.io
project files

https://jack10079.github.io/


code used below
<!-- adapted from https://threejs.org/examples/webgl_loader_stl and https://sbcode.net/threejs/loaders-stl/ -->

<!--
a. copy and save all of this, into your own .html, eg. fun.html
b. create an img/ folder, place 6 cubemap photos (eg of your room!)
c. edit fun.html, remove 'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/' 6 times [so you only have img/...]
d. create models/your-model.stl
e. edit fun.html, remove https://bytes.usc.edu/~saty/... in the loader.load() call, instead put in models/your-model.stl
f. load fun.html into your browser - ta-da!!
-->


<!DOCTYPE html>
<html lang="en">
   <head>
      <title>STL loader</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
      <script src="https://unpkg.com/three@0.146.0/build/three.min.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script src="https://unpkg.com/three@0.146.0/examples/js/loaders/STLLoader.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
      <script src="https://unpkg.com/three@0.146.0/examples/js/controls/OrbitControls.js" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
   </head>
   <body>
   -->

      <script>
         const scene = new THREE.Scene(); 
         scene.add(new THREE.AxesHelper(2)); // cmt this out if you like...
         
         const light = new THREE.SpotLight();
         light.position.set(20, 20, 20);
         scene.add(light);

         const ambientLight = new THREE.AmbientLight(0xffffff, 0.5); // color, intensity
        scene.add(ambientLight);

         
         const camera = new THREE.PerspectiveCamera(
             75,
             window.innerWidth / window.innerHeight,
             0.1,
             10000
         );
         camera.position.z = 3;
         
         const renderer = new THREE.WebGLRenderer();
         renderer.outputEncoding = THREE.sRGBEncoding;
         renderer.setSize(window.innerWidth, window.innerHeight);
         document.body.appendChild(renderer.domElement);
         
         const controls = new THREE.OrbitControls(camera, renderer.domElement);
         controls.enableDamping = true;
         
         const envTexture = new THREE.CubeTextureLoader().load([
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/px_50.png',
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/nx_50.png',
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/py_50.png',
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/ny_50.png',
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/pz_50.png',
             'https://bytes.usc.edu/~saty/tools/xem/x/THREE-STLLoader/img/nz_50.png'
         ]);
         envTexture.mapping = THREE.CubeReflectionMapping;

         let material;
         
         material = new THREE.MeshPhysicalMaterial({
             color: 0xFF0000,
             envMap: envTexture,
             metalness: 1,
             roughness: 1,
             opacity: 1.0,
             transparent: true,
             transmission: 0,
             clearcoat: 1.0,
             clearcoatRoughness: 0.3
         });

         
         
         const loader = new THREE.STLLoader();
         loader.load(
             'models/Lantern.stl',
             function (geometry) {
                 const mesh = new THREE.Mesh(geometry, material)
                 mesh.rotation.x = -Math.PI / 2;
                 scene.add(mesh)
             },
             (xhr) => {
                 console.log((xhr.loaded / xhr.total) * 100 + '% loaded')
             },
             (error) => {
                 console.log(error)
             }
         );
         // for fun, above, change colored.stl to CharlotteValve.stl, 
         // and also change 
         // *4 below, twice, to *120, and do globe.stl, with *10 :)
         
         window.addEventListener('resize', onWindowResize, false);
         function onWindowResize() {
             camera.aspect = window.innerWidth / window.innerHeight
             camera.updateProjectionMatrix()
             renderer.setSize(window.innerWidth, window.innerHeight)
             render()
         };
         
         //const stats = Stats()
         //document.body.appendChild(stats.dom)
         
         function animate() {
             requestAnimationFrame(animate);
             controls.update();
             render();
             //stats.update()
         }
         
         function render() {
         
         
             const timer = Date.now()*0.0005;
             camera.position.x = Math.cos(timer)*150;
             camera.position.z = Math.sin(timer)*150;
         
             renderer.render(scene, camera);
         }
         -->
         
         animate();
         	
      </script>
   </body>
</html>
