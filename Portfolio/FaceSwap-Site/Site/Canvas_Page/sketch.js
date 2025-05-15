let video;
let faceMesh;
let faces = [];
let triangles;
let uvCoords;
let img;
let maskImages = ["../Imagens/DanielMask.png", "../Imagens/RafaMask.png", "../Imagens/JoaoMask.png"];
let currentMaskIndex;

function preload() {
  faceMesh = ml5.faceMesh({ maxFaces: 1 });
  currentMaskIndex = int(random(maskImages.length));
  img = loadImage(maskImages[currentMaskIndex]); 
}

function mousePressed() {
  console.log(faces);
}

function gotFaces(results) {
  faces = results;
}

function setup() {
  createCanvas(960, 600, WEBGL);
  video = createCapture(VIDEO);
  video.size(960, 600);
  video.hide();

  faceMesh.detectStart(video, gotFaces);

  triangles = faceMesh.getTriangles();
  uvCoords = faceMesh.getUVCoords();
}

function draw() {
  background(0);


  push();
  translate(-width / 2, -height / 2);
  scale(-1, 1);
  image(video, -width, 0, width, height);
  pop();

  if (faces.length > 0) {
    let face = faces[0];


    texture(img);
    textureMode(NORMAL);
    noStroke();
    beginShape(TRIANGLES);

    for (let i = 0; i < triangles.length; i++) {
      let [a, b, c] = triangles[i];

      let pointA = face.keypoints[a];
      let pointB = face.keypoints[b];
      let pointC = face.keypoints[c];

      let uvA = uvCoords[a];
      let uvB = uvCoords[b];
      let uvC = uvCoords[c];


      vertex(-pointA.x + width / 2, pointA.y - height / 2, uvA[0], uvA[1]);
      vertex(-pointB.x + width / 2, pointB.y - height / 2, uvB[0], uvB[1]);
      vertex(-pointC.x + width / 2, pointC.y - height / 2, uvC[0], uvC[1]);
    }

    endShape();
  }
}
function keyPressed() {
  if (key === ' ') { 
    currentMaskIndex = (currentMaskIndex + 1) % maskImages.length; 
    img = loadImage(maskImages[currentMaskIndex]);
  }
}




