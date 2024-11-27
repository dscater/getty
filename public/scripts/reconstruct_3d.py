import sys
import os
import cv2
import numpy as np
def reconstruct_3d(image_paths, output_path,modelo):
    images = [cv2.imread(img_path) for img_path in image_paths]

    # Inicializa el detector SIFT (puedes usar otros detectores)
    sift = cv2.SIFT_create()
    keypoints = []
    descriptors = []

    for img in images:
        kp, des = sift.detectAndCompute(img, None)
        keypoints.append(kp)
        descriptors.append(des)

    # Emparejamiento de características
    matcher = cv2.BFMatcher()
    matches = matcher.knnMatch(descriptors[0], descriptors[1], k=2)

    # Filtrar los emparejamientos
    good_matches = []
    for m, n in matches:
        if m.distance < 0.75 * n.distance:
            good_matches.append(m)

    # Reconstrucción 3D simple (estructura desde el movimiento)
    points_3d = []
    for match in good_matches:
        pt1 = keypoints[0][match.queryIdx].pt
        pt2 = keypoints[1][match.trainIdx].pt
        points_3d.append(pt1 + pt2)

    # Guarda el modelo 3D en formato .OBJ
    with open(os.path.join(output_path, modelo), 'w') as f:
        f.write('ply\n')
        f.write('format ascii 1.0\n')
        f.write(f'element vertex {len(points_3d)}\n')
        f.write('property float x\nproperty float y\nproperty float z\n')
        f.write('end_header\n')
        for pt in points_3d:
            f.write(f'{pt[0]} {pt[1]} 0.0\n')  # Coordenada Z fija

if __name__ == "__main__":
    image_paths = sys.argv[1:-1]
    output_path = sys.argv[-1]

    if not os.path.exists(output_path):
        os.makedirs(output_path)

    reconstruct_3d(image_paths, output_path)
