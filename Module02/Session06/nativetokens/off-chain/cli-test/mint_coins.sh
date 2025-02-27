utxoin1="e49e71a1f2d3b848113215354712d7d7f4820076a659b271963fb74cd66201ca#1"
policyid=$(cat ../compiled/ea_coins.pid)
output="120000000"
tokenMintedamount="330"
tokenAmount="165"
tokenname="$(echo -n "WoWcoin-λ-🐦😍" | xxd -ps | tr -d '\n')"
mintingScript="../compiled/ea_coins.uplc"
collateral="4cbf990857530696a12b0062546a4b123ad0bef21c67562e32d03e3288bdcd7b#0"
ownerPKH=$(cat $HOME/Dev/Wallets/Bob.pkh)
notneeded="--invalid-hereafter 10962786"

cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin1 \
  --required-signer-hash $ownerPKH \
  --tx-in-collateral $collateral \
  --tx-out $nami3+$output+"$tokenAmount $policyid.$tokenname" \
  --tx-out $nami3+$output+"$tokenAmount $policyid.$tokenname" \
  --change-address $nami3 \
  --mint "$tokenMintedamount $policyid.$tokenname" \
  --mint-script-file $mintingScript \
  --mint-redeemer-file ../values/redeemer.json \
  --invalid-hereafter 69439705 \
  --out-file mintTx.unsigned

cardano-cli conway transaction sign \
    --tx-body-file mintTx.unsigned \
    --signing-key-file $HOME/Dev/Wallets/Bob.skey \
    --signing-key-file $HOME/Dev/Wallets/Adr07.skey \
    $PREVIEW \
    --out-file mintTx.signed

cardano-cli conway transaction submit \
    $PREVIEW \
    --tx-file mintTx.signed