From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Aug 2015 10:52:43 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: add Renesas R-Car Gen3 CPG support
Message-Id: <CANqRtoTtAoDs72mQACf=0H2DZGSC=ejcECOcjBwYNzNrHxHevg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhcz7u2i.wl%kuninori.morimoto.gx@renesas.com>
	<87k2sj7tzs.wl%kuninori.morimoto.gx@renesas.com>
	<20150825224638.GL19120@codeaurora.org>
	<CAMuHMdXhroy4BVRyeeu2uEnPvVehXNjac09RKWr49LA=0Yk=0g@mail.gmail.com>
In-Reply-To: <CAMuHMdXhroy4BVRyeeu2uEnPvVehXNjac09RKWr49LA=0Yk=0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Michael Turquette <mturquette@baylibre.com>, Simon Horman <horms+renesas@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-clk <linux-clk@vger.kernel.org>

Hi Geert,

On Wed, Aug 26, 2015 at 4:29 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Stephen,
>
> On Wed, Aug 26, 2015 at 12:46 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>>> --- /dev/null
>>> +++ b/drivers/clk/shmobile/clk-rcar-gen3.c
>
>>> +
>>> +/*
>>> + * Reset register definitions.
>>> + */
>>> +#define MODEMR 0xe6160060
>>> +
>>> +static u32 rcar_gen3_read_mode_pins(void)
>>> +{
>>> +     static u32 mode;
>>> +     static bool mode_valid;
>>> +
>>> +     if (!mode_valid) {
>>> +             void __iomem *modemr = ioremap_nocache(MODEMR, 4);
>>> +
>>> +             BUG_ON(!modemr);
>>> +             mode = ioread32(modemr);
>>> +             iounmap(modemr);
>>> +             mode_valid = true;
>>> +     }
>>> +
>>> +     return mode;
>>> +}
>>
>> Perhaps this should be read using a syscon?
>
> Like "[PATCH/RFC 00/11] ARM: shmobile: Let CPG use syscon for MD pin values"
> (http://www.spinics.net/lists/linux-clk/msg01478.html)?
>
> It wasn't so well received...

I happen to think it is a great idea. At the same time I'm too lazy to
step up. =)

Shall we reconsider making it mandatory for R-Car Gen3?

Cheers,

/ magnus
