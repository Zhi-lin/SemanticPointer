#!/usr/bin/env bash
log_file=$1/log.txt
if [ ! -f "$log_file" ]; then
  touch "$log_file"
  chmod 777 "$log_file"
fi

CUDA_VISIBLE_DEVICES=0 \
python scripts/L2RParser.py --mode FastLSTM --num_epochs 1000 --batch_size 64 \
--decoder_input_size 256 --hidden_size 512 --encoder_layers 3 --decoder_layers 1 \
 --pos_dim 100 --char_dim 100 --lemma_dim 100 --num_filters 100 --arc_space 512 --type_space 128 \
 --opt adam --learning_rate 0.001 --decay_rate 0.75 --epsilon 1e-4 --coverage 0.0 --gamma 0.0 --clip 5.0 \
 --schedule 20 --double_schedule_decay 5 \
 --p_in 0.33 --p_out 0.33 --p_rnn 0.33 0.33 --unk_replace 0.5 --label_smooth 1.0 --pos --char \
 --word_embedding glove --word_path \
 "/users2/yxwang/work/data/embeddings/glove/glove.6B.100d.txt.gz" --char_embedding random \
  --train "data/$2/en_$2_train.dag" \
   --dev "data/$2/en_$2_dev.dag" \
    --test "data/$2/en_id_$2.dag" \
    --test2 "data/$2/en_ood_$2.dag" \
   --model_path $1 --model_name 'models/network.pt'    --grandPar --lemma \
   --beam 5 >$log_file



