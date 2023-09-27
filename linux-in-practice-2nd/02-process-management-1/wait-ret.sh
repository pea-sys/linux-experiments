#!/bin/bash
false &
wait $!
echo "falseコマンドを終了しました: $?"
