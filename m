From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Sep 2015 10:48:52 +0000
Subject: Re: [PATCH v4 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CANqRtoS-67gnsx+TWbmJTKqQnKeWKy3PZ2V_QQAkXwx26c_70w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150829091323.28546.28287.sendpatchset@little-apple>
	<20150829091346.28546.42552.sendpatchset@little-apple>
	<CAMuHMdUR7gYXoJMRGXdcReZ4fX+2SQDvTsK8Jny67GcW995_9Q@mail.gmail.com>
	<CANqRtoSKNBxQRkF5FKXwHTDgfLpvq6U98KqZ_QCH4G9VdMbNAg@mail.gmail.com>
	<CAMuHMdW1OJXmT1KS_Ju4KGp6uwSVB-i-pLBGvPCLKd_FaNNN5A@mail.gmail.com>
In-Reply-To: <CAMuHMdW1OJXmT1KS_Ju4KGp6uwSVB-i-pLBGvPCLKd_FaNNN5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert,

On Mon, Aug 31, 2015 at 10:03 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Aug 31, 2015 at 1:58 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> --- /dev/null
>>>> +++ work/drivers/clk/shmobile/clk-rcar-gen3.c   2015-08-29 16:30:59.032366518 +0900
>>>> @@ -0,0 +1,249 @@
>>>
>>>> +#define RCAR_GEN3_CLK_MAIN     0
>>>> +#define RCAR_GEN3_CLK_PLL0     1
>>>> +#define RCAR_GEN3_CLK_PLL1     2
>>>> +#define RCAR_GEN3_CLK_PLL2     3
>>>> +#define RCAR_GEN3_CLK_PLL3     4
>>>> +#define RCAR_GEN3_CLK_PLL4     5
>>>
>>> These values are intimately tied to R8A7795_CLK_* in
>>> include/dt-bindings/clock/r8a7795-clock.h.
>>> Perhaps we can use these instead?
>>
>> You are right that they are connected together, but I'm not sure if I
>> prefer to include that file. If we start sharing files between the CPG
>> and the integration code then a dependency hell breaks loose when it
>> comes to merge order. If we want to share the #defines then I propose
>> that we handle that incrementally once all pieces are merged.
>
> OK, we can move them to include/dt-bindings/clock/rcar-gen3-clock.h
> later.

So in the future we may then want to change r8a7795-clock.h into:

#define R8A7795_CLK_MAIN RCAR_GEN3_CLK_MAIN

?

>> On R-Car Gen2 we have a single CPG driver that is potentially shared
>> across multiple SoCs in the same generation / family. In that case we
>> use strings and the clock-output-names as part of the ABI if I'm not
>> mistaken. On this driver we use clock index numbers instead, so I'd
>> like to see these defines as part of a shared DT binding ABI where new
>> SoCs can simply add new clocks at the end.
>
> OK, so rcar_gen3_cpg.clks[] is really intended to be variable-sized.
>
> Hence I suggest to write it that way:
>
>     struct rcar_gen3_cpg {
>             struct clk_onecell_data data;
>             spinlock_t lock;
>             void __iomem *reg;
>             struct clk *clks[0];
>     };
>
> Then you can allocate it with
>
>    kzalloc(sizeof(*cpg) + num_clks * sizeof(rcar_gen3_cpg.clks[0], ...)
>
> and kill RCAR_GEN3_CLK_NR (one less definition that can go out of sync).

I see RCAR_GEN3_CLK_NR as the number of different clocks that the Gen3
CPG driver can support. Exactly which one that the SoC specific DTS
wants to use depends on each SoC. So for future SoCs we may want to
keep on adding new clocks at the end. And the clock-indices list may
be sparsely populated in DTS.

I am not 100% sure about how to handle error cases. Say a new DTS is
booted on an old kernel then some clocks may not be supported by the
CPG driver. For those cases the switch/case statement in the driver
will simply return errors for the unsupported clocks. And the rest of
the kernel has to figure out how to deal with that. That seems sane,
right?

Thanks,

/ magnus
