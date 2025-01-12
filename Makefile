Pool:
	# Example parameters for the semantic segmentation experiments
	DATASET="VOC2012"
	MODEL="dino_vits16"
	MATRIX="laplacian"
	DOWNSAMPLE=16
	N_SEG=15
	N_ERODE=2
	N_DILATE=5

	# Extract segments
	python /home/chs.rintu/Documents/chs-lab-ws02/research-cancerPathology/deep-spectral-segmentation/extract/extract.py extract_multi_region_segmentations \
		--non_adaptive_num_segments ${N_SEG} \
		--features_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/features/dino_vits16" \
		--eigs_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/eigs/laplacian_dino_vits16" \
		--output_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_segmentation/laplacian"

	# Extract bounding boxes
	python /home/chs.rintu/Documents/chs-lab-ws02/research-cancerPathology/deep-spectral-segmentation/extract/extract.py extract_bboxes \
		--features_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/features/dino_vits16" \
		--segmentations_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_segmentation/laplacian" \
		--num_erode 2 \
		--num_dilate 5 \
		--downsample_factor 16 \
		--output_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bboxes.pth"

	# Extract bounding box features
	python /home/chs.rintu/Documents/chs-lab-ws02/research-cancerPathology/deep-spectral-segmentation/extract/extract.py extract_bbox_features \
		--model_name dino_vits16 \
		--images_root "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/accepted" \
		--bbox_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bboxes.pth" \
		--output_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bbox_features.pth"

	# Extract clusters
	python /home/chs.rintu/Documents/chs-lab-ws02/research-cancerPathology/deep-spectral-segmentation/extract/extract.py extract_bbox_clusters \
		--bbox_features_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bbox_features.pth" \
		--output_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bbox_clusters.pth" 

	# Create semantic segmentations
	python /home/chs.rintu/Documents/chs-lab-ws02/research-cancerPathology/deep-spectral-segmentation/extract/extract.py extract_semantic_segmentations \
		--segmentations_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_segmentation/laplacian" \
		--bbox_clusters_file "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/multi_region_bboxes/laplacian/bbox_clusters.pth" \
		--output_dir "./data/object-segmentation/dataset/20190610_338_14-14_G-14-3526_Biopsy_TNBC_HnE_40X/L17/semantic_segmentations/patches/laplacian/segmaps" 