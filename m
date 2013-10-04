From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Oct 2013 10:08:55 +0000
Subject: Re: [PATCH v3 1/3] ARM: shmobile: r8a7790: add CPUFreq clock support
Message-Id: <Pine.LNX.4.64.1310041144040.26975@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372652755-16948-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1372652755-16948-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus

On Fri, 4 Oct 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> Thanks for your updated patch. Please see my comments below.
> 
> On Fri, Oct 4, 2013 at 4:20 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > Add support for the Z clock on r8a7790, driving the four SoC's CA15 cores,
> > and its parent - PLL0. This is required for CPUFreq support on this SoC,
> > when running with only CA15 cores.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > v3: Only register the Z-clock lookup entry, when booting on a CA15.
> >
> >  arch/arm/mach-shmobile/Kconfig         |    2 +
> >  arch/arm/mach-shmobile/clock-r8a7790.c |  152 ++++++++++++++++++++++++++++++++
> >  2 files changed, 154 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> > index eda2857..7f08bca 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -100,6 +100,8 @@ config ARCH_R8A7790
> >         select CPU_V7
> >         select SH_CLK_CPG
> >         select RENESAS_IRQC
> > +       select ARCH_HAS_CPUFREQ
> > +       select ARCH_HAS_OPP
> >
> >  config ARCH_R8A7791
> >         bool "R-Car M2 (R8A77910)"
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> > index a64f965..35d3402 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> > @@ -54,9 +54,12 @@
> >  #define SMSTPCR8 0xe6150990
> >  #define SMSTPCR9 0xe6150994
> >
> > +#define FRQCRB         0xE6150004
> >  #define SDCKCR         0xE6150074
> >  #define SD2CKCR                0xE6150078
> >  #define SD3CKCR                0xE615007C
> > +#define FRQCRC         0xE61500E0
> > +#define PLLECR         0xE61500D0
> >  #define MMC0CKCR       0xE6150240
> >  #define MMC1CKCR       0xE6150244
> >  #define SSPCKCR                0xE6150248
> > @@ -85,6 +88,7 @@ static struct clk main_clk = {
> >   * clock ratio of these clock will be updated
> >   * on r8a7790_clock_init()
> >   */
> > +SH_FIXED_RATIO_CLK_SET(pll0_clk,               main_clk,       1, 1);
> >  SH_FIXED_RATIO_CLK_SET(pll1_clk,               main_clk,       1, 1);
> >  SH_FIXED_RATIO_CLK_SET(pll3_clk,               main_clk,       1, 1);
> >  SH_FIXED_RATIO_CLK_SET(lb_clk,                 pll1_clk,       1, 1);
> > @@ -113,15 +117,155 @@ SH_FIXED_RATIO_CLK_SET(zb3d2_clk,                pll3_clk,       1, 8);
> >  SH_FIXED_RATIO_CLK_SET(ddr_clk,                        pll3_clk,       1, 8);
> >  SH_FIXED_RATIO_CLK_SET(mp_clk,                 pll1_div2_clk,  1, 15);
> >
> > +/* Locking not needed yet, only one clock is using FRQCR[BC] divisors so far */
> > +static atomic_t frqcr_lock;
> 
> If it's not needed then why do you include it?

I think it would be nice to have it in place already now to have it 
implemented uniformly with r8a73a4. As soon as other FRQCR* clocks are 
added on r8a7790 locking will be needed. But as the comment says - 
functionally it isn't needed yet, so, if you prefer, it can be removed, 
yes.

> > +#define CPG_MAP(o) ((o) - CPG_BASE + cpg_mapping.base)
> > +
> > +/* Several clocks need to access FRQCRB, have to lock */
> > +static bool frqcr_kick_check(struct clk *clk)
> > +{
> > +       return !(ioread32(CPG_MAP(FRQCRB)) & BIT(31));
> > +}
> > +
> > +static int frqcr_kick_do(struct clk *clk)
> > +{
> > +       int i;
> > +
> > +       /* set KICK bit in FRQCRB to update hardware setting, check success */
> > +       iowrite32(ioread32(CPG_MAP(FRQCRB)) | BIT(31), CPG_MAP(FRQCRB));
> > +       for (i = 1000; i; i--)
> > +               if (ioread32(CPG_MAP(FRQCRB)) & BIT(31))
> > +                       cpu_relax();
> > +               else
> > +                       return 0;
> > +
> > +       return -ETIMEDOUT;
> > +}
> > +
> > +static int zclk_set_rate(struct clk *clk, unsigned long rate)
> > +{
> > +       void __iomem *frqcrc;
> > +       int ret;
> > +       unsigned long step, p_rate;
> > +       u32 val;
> > +
> > +       if (!clk->parent || !__clk_get(clk->parent))
> > +               return -ENODEV;
> > +
> > +       if (!atomic_inc_and_test(&frqcr_lock) || !frqcr_kick_check(clk)) {
> > +               ret = -EBUSY;
> > +               goto done;
> > +       }
> > +
> > +       /*
> > +        * Users are supposed to first call clk_set_rate() only with
> > +        * clk_round_rate() results. So, we don't fix wrong rates here, but
> > +        * guard against them anyway
> > +        */
> > +
> > +       p_rate = clk_get_rate(clk->parent);
> > +       if (rate = p_rate) {
> > +               val = 0;
> > +       } else {
> > +               step = DIV_ROUND_CLOSEST(p_rate, 32);
> > +
> > +               if (rate > p_rate || rate < step) {
> > +                       ret = -EINVAL;
> > +                       goto done;
> > +               }
> > +
> > +               val = 32 - rate / step;
> > +       }
> > +
> > +       frqcrc = clk->mapped_reg + (FRQCRC - (u32)clk->enable_reg);
> > +
> > +       iowrite32((ioread32(frqcrc) & ~(clk->div_mask << clk->enable_bit)) |
> > +                 (val << clk->enable_bit), frqcrc);
> > +
> > +       ret = frqcr_kick_do(clk);
> > +
> > +done:
> > +       atomic_dec(&frqcr_lock);
> > +       __clk_put(clk->parent);
> > +       return ret;
> > +}
> > +
> > +static long zclk_round_rate(struct clk *clk, unsigned long rate)
> > +{
> > +       /*
> > +        * theoretical rate = parent rate * multiplier / 32,
> > +        * where 1 <= multiplier <= 32. Therefore we should do
> > +        * multiplier = rate * 32 / parent rate
> > +        * rounded rate = parent rate * multiplier / 32.
> > +        * However, multiplication before division won't fit in 32 bits, so
> > +        * we sacrifice some precision by first dividing and then multiplying.
> > +        * To find the nearest divisor we calculate both and pick up the best
> > +        * one. This avoids 64-bit arithmetics.
> > +        */
> > +       unsigned long step, mul_min, mul_max, rate_min, rate_max;
> > +
> > +       rate_max = clk_get_rate(clk->parent);
> > +
> > +       /* output freq <= parent */
> > +       if (rate >= rate_max)
> > +               return rate_max;
> > +
> > +       step = DIV_ROUND_CLOSEST(rate_max, 32);
> > +       /* output freq >= parent / 32 */
> > +       if (step >= rate)
> > +               return step;
> > +
> > +       mul_min = rate / step;
> > +       mul_max = DIV_ROUND_UP(rate, step);
> > +       rate_min = step * mul_min;
> > +       if (mul_max = mul_min)
> > +               return rate_min;
> > +
> > +       rate_max = step * mul_max;
> > +
> > +       if (rate_max - rate <  rate - rate_min)
> > +               return rate_max;
> > +
> > +       return rate_min;
> > +}
> > +
> > +static unsigned long zclk_recalc(struct clk *clk)
> > +{
> > +       void __iomem *frqcrc = FRQCRC - (u32)clk->enable_reg + clk->mapped_reg;
> > +       unsigned int max = clk->div_mask + 1;
> > +       unsigned long val = ((ioread32(frqcrc) >> clk->enable_bit) &
> > +                            clk->div_mask);
> > +
> > +       return DIV_ROUND_CLOSEST(clk_get_rate(clk->parent), max) *
> > +               (max - val);
> > +}
> > +
> > +static struct sh_clk_ops zclk_ops = {
> > +       .recalc = zclk_recalc,
> > +       .set_rate = zclk_set_rate,
> > +       .round_rate = zclk_round_rate,
> > +};
> > +
> > +static struct clk z_clk = {
> > +       .parent = &pll0_clk,
> > +       .div_mask = 0x1f,
> > +       .enable_bit = 8,
> > +       /* We'll need to access FRQCRB and FRQCRC */
> > +       .enable_reg = (void __iomem *)FRQCRB,
> > +       .ops = &zclk_ops,
> > +};
> > +
> >  static struct clk *main_clks[] = {
> >         &extal_clk,
> >         &extal_div2_clk,
> >         &main_clk,
> > +       &pll0_clk,
> >         &pll1_clk,
> >         &pll1_div2_clk,
> >         &pll3_clk,
> >         &lb_clk,
> >         &qspi_clk,
> > +       &z_clk,
> >         &zg_clk,
> >         &zx_clk,
> >         &zs_clk,
> > @@ -298,9 +442,13 @@ static struct clk_lookup lookups[] = {
> >         CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> >  };
> >
> > +/* CA15 clock - it cannot be used if booting on a CA7 */
> > +static struct clk_lookup lookup_z = CLKDEV_DEV_ID("cpu0", &z_clk);
> > +
> 
> This comment seems really odd to me. I'm quite sure you can use z_clk
> regardless of boot mode, it's just a matter of associating the clock
> with the appropriate cluster.

Exactly. This comment refers not to the clock itself, but to a lookup 
entry - a clock association to a CPU. And it's that association, that 
cannot be used, when booting on a CA7, in which case that one will become 
cpu0. Maybe the comment should be made even a bit more explicit like

/* CA15 clock lookup - it cannot be used if booting on a CA7 */

Would that help?

> The z_clk isn't always associated with cpu0,

Exactly, that's why this lookup shouldn't be registered in those cases.

> so this looks like it needs some further work abstraction wise.
> Any plans?

The only idea that I had in this regard was, that the hard assignment of 
logical number 0 to the boot CPU isn't always very helpful. IIUC, after 
booting on the boot CPU, any further CPUs can be assigned logical IDs in 
an arbitrary order. So, on a big.LITTLE system we can boot on a CA15 core 
and bring up further 3 CA15 cores, which will get indices 1-3. If we boot 
from a CA7 and bring up further 3 CA7 cores, they'll get indices 5-7, 
which is convenient. But the boot core is in both cases #0. But I don't 
think changing this could fit in the scope of this work.

Another option would be to change the lookup, i.e. the device, to which 
the clock is attached. But that would be CPUFreq-driver specific and I'm 
not sure investing additional work in the cpufreq-cpu0 driver would make 
much sense, since we anyway want to use all 8 cores eventually and that 
driver is unsuitable for that mode.

> >  #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)             \
> >         extal_clk.rate  = e * 1000 * 1000;                      \
> >         main_clk.parent = m;                                    \
> > +       SH_CLK_SET_RATIO(&pll0_clk_ratio, p0 / 2, 1);           \
> >         SH_CLK_SET_RATIO(&pll1_clk_ratio, p1 / 2, 1);           \
> >         if (mode & MD(19))                                      \
> >                 SH_CLK_SET_RATIO(&pll3_clk_ratio, p31, 1);      \
> > @@ -313,6 +461,8 @@ void __init r8a7790_clock_init(void)
> >         u32 mode = rcar_gen2_read_mode_pins();
> >         int k, ret = 0;
> >
> > +       atomic_set(&frqcr_lock, -1);
> > +
> >         switch (mode & (MD(14) | MD(13))) {
> >         case 0:
> >                 R8A7790_CLOCK_ROOT(15, &extal_clk, 172, 208, 106, 88);
> > @@ -351,6 +501,8 @@ void __init r8a7790_clock_init(void)
> >                 ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
> >
> >         clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> > +       if (!(mode & (MD(6) | MD(7))))
> > +               clkdev_add(&lookup_z);
> 
> Here it would be nice to have a comment to explain what's going on.

Sure, can add.

Thanks
Guennadi

> 
> Thanks,
> 
> / magnus
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
