for f in wrfchemi_d01_*; do
  suf=${f#wrfchemi_d01_}
  ln -sv "$f" "wrfchemi_gocart_bg_d01_${suf}"
done
