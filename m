From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 11:58:08 +0000
Subject: Re: [PATCH v4 02/05] clk: shmobile: Add Renesas R-Car Gen3 CPG support
Message-Id: <CANqRtoSKNBxQRkF5FKXwHTDgfLpvq6U98KqZ_QCH4G9VdMbNAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150829091323.28546.28287.sendpatchset@little-apple>
	<20150829091346.28546.42552.sendpatchset@little-apple>
	<CAMuHMdUR7gYXoJMRGXdcReZ4fX+2SQDvTsK8Jny67GcW995_9Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUR7gYXoJMRGXdcReZ4fX+2SQDvTsK8Jny67GcW995_9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Geert,

On Mon, Aug 31, 2015 at 5:45 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Sat, Aug 29, 2015 at 11:13 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>>
>> This patch adds initial CPG support for R-Car Generation 3 and in
>> particular the R8A7795 SoC.
>>
>> The R-Car Gen3 clock hardware has a register write protection feature that
>> needs to be shared between the CPG function needs to be shared between
>> the CPG and MSTP hardware somehow. So far this feature is simply ignored.
>>
>> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  Changes since V3: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Reworked driver to incorporate most feedback from Stephen Boyd - thanks!!
>>  - Major things like syscon and driver model require more discussion.
>>  - Added hunk to build drivers/clk/shmobile if ARCH_RENESAS is set.
>
> Thanks for the updates!
>
>>  Changes since V2: (Magnus Damm <damm+renesas@opensource.se>)
>>  - Reworked driver to rely on clock index instead of strings.
>
> I had completely missed this part in the previous version...

No worries, perhaps not so well documented. And there are many changes
floating around...

>>  - Dropped use of "clock-output-names".
>
>
>> --- /dev/null
>> +++ work/drivers/clk/shmobile/clk-rcar-gen3.c   2015-08-29 16:30:59.032366518 +0900
>> @@ -0,0 +1,249 @@
>
>> +#define RCAR_GEN3_CLK_MAIN     0
>> +#define RCAR_GEN3_CLK_PLL0     1
>> +#define RCAR_GEN3_CLK_PLL1     2
>> +#define RCAR_GEN3_CLK_PLL2     3
>> +#define RCAR_GEN3_CLK_PLL3     4
>> +#define RCAR_GEN3_CLK_PLL4     5
>
> These values are intimately tied to R8A7795_CLK_* in
> include/dt-bindings/clock/r8a7795-clock.h.
> Perhaps we can use these instead?

You are right that they are connected together, but I'm not sure if I
prefer to include that file. If we start sharing files between the CPG
and the integration code then a dependency hell breaks loose when it
comes to merge order. If we want to share the #defines then I propose
that we handle that incrementally once all pieces are merged.

On R-Car Gen2 we have a single CPG driver that is potentially shared
across multiple SoCs in the same generation / family. In that case we
use strings and the clock-output-names as part of the ABI if I'm not
mistaken. On this driver we use clock index numbers instead, so I'd
like to see these defines as part of a shared DT binding ABI where new
SoCs can simply add new clocks at the end.

> If we ever have a Gen3 SoC with more clocks, we have to update
> this anyway.

That's right!

>> +struct rcar_gen3_cpg {
>> +       struct clk_onecell_data data;
>> +       spinlock_t lock;
>> +       void __iomem *reg;
>
> If you add the clocks here, you don't have to allocate them separately
> later:
>
>         struct clk clocks[...];
>
>> +static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
>> +{
>> +       const struct cpg_pll_config *config;
>> +       struct rcar_gen3_cpg *cpg;
>> +       struct clk **clks;
>> +       u32 cpg_mode;
>> +       unsigned int i;
>> +       int num_clks;
>> +
>> +       cpg_mode = rcar_gen3_read_mode_pins();
>> +
>> +       num_clks = of_property_count_strings(np, "clock-indices");
>> +       if (num_clks < 0) {
>> +               pr_err("%s: failed to count clocks\n", __func__);
>> +               return;
>> +       }
>> +
>> +       cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
>> +       clks = kcalloc(num_clks, sizeof(*clks), GFP_KERNEL);
>
> I.e. these 2 allocation can be combined by embedding the struct clks in
> struct rcar_gen3_cpg...
>
>> +       if (cpg = NULL || clks = NULL) {
>> +               kfree(cpg);
>> +               kfree(clks);
>
> ... and there's no longer a need to kfree() anything.

Good idea. I'll give it a shot.

>> +               pr_err("%s: failed to allocate cpg\n", __func__);
>
> There's no need to print an error on allocation failures. The system
> will scream anyway (if there's already a console ;-).

Ok, will make it silent!

Thanks for your comments!!

Cheers,

/ magnus
