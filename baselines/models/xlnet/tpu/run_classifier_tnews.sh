CURRENT_DIR=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
CURRENT_TIME=$(date "+%Y%m%d-%H%M%S")
TASK_NAME="tnews"
export ALBERT_XLARGE_DIR=gs://models_zxw/prev_trained_models/nlp/xlnet-base/chinese_xlnet_base_L-12_H-768_A-12/
export DATA_DIR=gs://data_zxw/nlp/chineseGLUEdatasets.v0.0.1/$TASK_NAME
export OUTPUT_DIR=gs://models_zxw/fine_tuning_models/nlp/xlnet-base/chinese_xlnet_base_L-12_H-768_A-12/tpu/$TASK_NAME/$CURRENT_TIME

python $CURRENT_DIR/../run_classifier.py \
  --task_name=$TASK_NAME \
  --do_train=true \
  --do_eval=true \
  --data_dir=$DATA_DIR \
  --vocab_file=$ALBERT_XLARGE_DIR/vocab.txt \
  --bert_config_file=$ALBERT_XLARGE_DIR/albert_config_xlarge.json \
  --init_checkpoint=$ALBERT_XLARGE_DIR/albert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=32 \
  --learning_rate=6e-5 \
  --num_train_epochs=9.0 \
  --output_dir=$OUTPUT_DIR \
  --num_tpu_cores=8 --use_tpu=True --tpu_name=grpc://10.240.1.2:8470