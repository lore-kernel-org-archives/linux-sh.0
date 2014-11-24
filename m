From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2014 13:31:09 +0000
Subject: Re: [PATCH v6 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdXu8PvAdr+itPrXvDp4STHkFmbo7yKdSBrVEk7EF48=Ug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500463-20965-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500463-20965-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Looking at other clock rates in /sys/kernel/debug/clk/*/clk_rate, it seems
there are more that do not match the values in the CPG block diagram in the
sh73a0 datasheet. Some of these may be due to genuine different divider values,
but at least the value of the Z clock for the Cortex A9 (598 instead of 1196
MHz) seems to be wrong.

for i in /sys/kernel/debug/clk/*/clk_rate; do echo -n "$(basename $(dirname
$i)) : "; cat $i; done | sed -e 's/$/ Hz/g' -e 's/000000 Hz$/ MHz/g' -e 's/000
Hz$/ kHz/g'

hsi : 178285714 Hz (datasheet: 208 MHz)
m1 : 208 MHz (datasheet: 312 MHz)
msu : 9750 kHz (datasheet: 124.8 MHz)
sdhi0 : 69333333 Hz (datasheet: 96 MHz)
sdhi1 : 69333333 Hz (datasheet: 96 MHz)
sdhi2 : 69333333 Hz (datasheet: 96 MHz)
spua : 52 MHz (datasheet: 208 MHz)
spuv : 52 MHz (datasheet: 208 MHz)
zb : 208 MHz (datasheet: 104 MHz)
z : 598 MHz (datasheet: 1196 MHz)
zg : 299 MHz (datasheet: 201.5 MHz)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
