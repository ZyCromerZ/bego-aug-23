git reset --hard
stop="n"
for asu in q-oss-base-release q-oss-base-release-uv
do
    [[ "$stop" == "y" ]] && break
    git checkout $asu && git pull . new-q-oss-up --signoff --no-commit || stop="y"
    git commit -sm "Merge Branch 'new-q-oss-up' into $asu"
    git pull . q-oss-base --signoff --no-commit || stop="y"
    git commit -sm "Merge Branch 'q-oss-base' into $asu"
    [[ "$stop" == "y" ]] && break
    git checkout $asu-ALMK && git pull . $asu --signoff --no-ff --no-commit || stop="y"
    git commit -sm "Merge Branch '$asu' into $asu-ALMK"
    [[ "$stop" == "y" ]] && break
    git checkout $asu-SLMK && git pull . $asu --signoff --no-ff --no-commit || stop="y"
    git commit -sm "Merge Branch '$asu' into $asu-SLMK"
    git pull . new-q-oss-up-SLMK --signoff  --no-ff --no-commit || stop="y"
    git commit -sm "Merge Branch 'new-q-oss-up-SLMK' into $asu-SLMK"
done

DoUpNow()
{
    git push --all origin -f || DoUpNow
}
if [[ "$stop" == "n" ]];then
    DoUpNow
fi