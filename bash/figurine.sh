#!/usr/bin/bash
servername=$(hostname --fqdn)

my_array=(4Max.flf alligator3.flf Banner3-D.flf Basic.flf Computer.flf
Contrast.flf Cricket.flf Double.flf Fender.flf Georgia11.flf Jazmine.flf
Kban.flf Nancyj-Fancy.flf Nancyj.flf Nancyj-Improved.flf Nancyj-Underlined.flf
Roman.flf smpoison.flf Stacey.flf starwars.flf Thick.flf Univers.flf
"ANSI Regular.flf" "DOS Rebel.flf" "Lil Devil.flf"
"S Blood.flf" "Star Wars.flf" "Star Strips.flf" "USA Flag.flf"
)

font=$(printf "%s\n" "${my_array[@]}" | shuf -n 1)

echo ""
/usr/local/bin/figurine -f "$font" "$servername"
echo ""
