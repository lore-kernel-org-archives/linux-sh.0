From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Aug 2015 07:29:01 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <CAMuHMdXhroy4BVRyeeu2uEnPvVehXNjac09RKWr49LA=0Yk=0g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhcz7u2i.wl%kuninori.morimoto.gx@renesas.com>
	<87k2sj7tzs.wl%kuninori.morimoto.gx@renesas.com>
	<20150825224638.GL19120@codeaurora.org>
In-Reply-To: <20150825224638.GL19120@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Michael Turquette <mturquette@baylibre.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk@vger.kernel.org

Hi Stephen,

On Wed, Aug 26, 2015 at 12:46 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> --- /dev/null
>> +++ b/drivers/clk/shmobile/clk-rcar-gen3.c

>> +
>> +/*
>> + * Reset register definitions.
>> + */
>> +#define MODEMR 0xe6160060
>> +
>> +static u32 rcar_gen3_read_mode_pins(void)
>> +{
>> +     static u32 mode;
>> +     static bool mode_valid;
>> +
>> +     if (!mode_valid) {
>> +             void __iomem *modemr = ioremap_nocache(MODEMR, 4);
>> +
>> +             BUG_ON(!modemr);
>> +             mode = ioread32(modemr);
>> +             iounmap(modemr);
>> +             mode_valid = true;
>> +     }
>> +
>> +     return mode;
>> +}
>
> Perhaps this should be read using a syscon?

Like "[PATCH/RFC 00/11] ARM: shmobile: Let CPG use syscon for MD pin values"
(http://www.spinics.net/lists/linux-clk/msg01478.html)?

It wasn't so well received...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
