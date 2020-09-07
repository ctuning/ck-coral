mkdir coral && cd coral
git clone https://github.com/google-coral/tflite.git
cd tflite/python/examples/classification

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly TEST_DATA_URL=https://github.com/google-coral/edgetpu/raw/master/test_data

# Get TF Lite model and labels
MODEL_DIR="${SCRIPT_DIR}/models"
mkdir -p "${MODEL_DIR}"

(cd "${MODEL_DIR}" && \
curl -OL "${TEST_DATA_URL}/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite" \
     -OL "${TEST_DATA_URL}/mobilenet_v2_1.0_224_inat_bird_quant.tflite" \
     -OL "${TEST_DATA_URL}/inat_bird_labels.txt")

# Get example image for classification
IMAGE_DIR="${SCRIPT_DIR}/images"
mkdir -p "${IMAGE_DIR}"

(cd "${IMAGE_DIR}" && \
curl -OL "${TEST_DATA_URL}/parrot.jpg")

python3 classify_image.py --model models/mobilenet_v2_1.0_224_inat_bird_quant_edgetpu.tflite --labels models/inat_bird_labels.txt --input images/parrot.jpg
