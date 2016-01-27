From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Wed, 27 Jan 2016 09:01:14 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <56A8875A.3070403@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Geert,

many thanks for looking at this!

On 27.01.2016 09:43, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Fri, Jan 22, 2016 at 1:26 PM, Dirk Behme <dirk.behme@de.bosch.com> wro=
te:
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>> ---
>> Notes:
>>
>> * This is based on https://git.kernel.org/cgit/linux/kernel/git/horms/re=
nesas-bsp.git/commit/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0=
.x&id=CD10385afc15cef6bfbaea4aa5da41193b24fe82
>>
>> * This is compile tested *only*. The intention is to get some feedback
>>    if this is the way we want to go.
>
> Thanks for your patch!
> As you want to drop the RFC state, here are some comments from me.
>
>
>> --- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>> +++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>
>> @@ -199,6 +207,243 @@ static const unsigned int r8a7795_crit_mod_clks[] =
__initconst =3D {
>>          MOD_CLK_ID(408),        /* INTC-AP (GIC) */
>>   };
>>
>> +/* --------------------------------------------------------------------=
---------
>> + * SDn Clock
>> + *
>> + */
>> +#define CPG_SD_STP_N_HCK       BIT(9)
>> +#define CPG_SD_STP_N_CK                BIT(8)
>> +#define CPG_SD_SD_N_SRCFC_MASK (0x7 << CPG_SD_SD_N_SRCFC_SHIFT)
>> +#define CPG_SD_SD_N_SRCFC_SHIFT        2
>> +#define CPG_SD_SD_N_FC_MASK    (0x3 << CPG_SD_SD_N_FC_SHIFT)
>> +#define CPG_SD_SD_N_FC_SHIFT   0
>
> The "N_" in the macro names doesn't gain us much, so I'd remove it.
>
>> +#define CPG_SD_STP_MASK                (CPG_SD_STP_N_HCK | CPG_SD_STP_N=
_CK)
>> +#define CPG_SD_FC_MASK         (CPG_SD_SD_N_SRCFC_MASK | CPG_SD_SD_N_FC=
_MASK)
>> +
>> +/* CPG_SD_DIV_TABLE_DATA(stp_n_hck, stp_n_ck, sd_n_srcfc, sd_n_fc, div)=
 */
>> +#define CPG_SD_DIV_TABLE_DATA(_a, _b, _c, _d, _e) \
>
> I would use descriptive macro parameter names, and drop the comment. E.g.
>
>      #define CPG_SD_DIV_TABLE_DATA(stp_hck, stp_ck, sd_srcfc, sd_fc, div)
>
>> +{ \
>> +       .val =3D ((_a) ? CPG_SD_STP_N_HCK : 0) | \
>> +              ((_b) ? CPG_SD_STP_N_CK : 0) | \
>> +              (((_c) << CPG_SD_SD_N_SRCFC_SHIFT) & CPG_SD_SD_N_SRCFC_MA=
SK) | \
>> +              (((_d) << CPG_SD_SD_N_FC_SHIFT) & CPG_SD_SD_N_FC_MASK), \
>
> As these are only used here, already abstracted by the macro, and the
> masks never
> really do anything giving the table values below, I would
>    - drop the "& CPG_SD_*_MASK" operations, and the CPG_SD_*_MASK definit=
ions,
>    - hardcode the shifts, and drop the CPG_SD_*_SHIFT definitions.
>
>
>> +       .div =3D (_e), \
>> +}
>> +
>> +struct sd_div_table {
>> +       u32 val;
>> +       unsigned int div;
>> +};
>> +
>> +struct sd_clock {
>> +       struct clk_hw hw;
>> +       void __iomem *reg;
>> +       const struct sd_div_table *div_table;
>> +       int div_num;
>
> unsigned int
>
>> +       unsigned int div_min;
>> +       unsigned int div_max;
>> +};
>> +
>> +/* SDn divider
>> + *                     sd_n_srcfc sd_n_fc   div
>> + * stp_n_hck stp_n_ck  (div)      (div)     =3D sd_n_srcfc x sd_n_fc
>> + *-------------------------------------------------------------------
>> + *  0         0         0 (1)      1 (4)      4
>> + *  0         0         1 (2)      1 (4)      8
>> + *  1         0         2 (4)      1 (4)     16
>> + *  1         0         3 (8)      1 (4)     32
>> + *  1         0         4 (16)     1 (4)     64
>> + *  0         0         0 (1)      0 (2)      2
>> + *  0         0         1 (2)      0 (2)      4
>> + *  1         0         2 (4)      0 (2)      8
>> + *  1         0         3 (8)      0 (2)     16
>> + *  1         0         4 (16)     0 (2)     32
>> + */
>> +static const struct sd_div_table cpg_sd_div_table[] =3D {
>> +/*     CPG_SD_DIV_TABLE_DATA(stp_n_hck, stp_n_ck, sd_n_srcfc, sd_n_fc, =
div) */
>> +       CPG_SD_DIV_TABLE_DATA(0,        0,        0,          1,        =
4),
>> +       CPG_SD_DIV_TABLE_DATA(0,        0,        1,          1,        =
8),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        2,          1,       1=
6),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        3,          1,       3=
2),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        4,          1,       6=
4),
>> +       CPG_SD_DIV_TABLE_DATA(0,        0,        0,          0,        =
2),
>> +       CPG_SD_DIV_TABLE_DATA(0,        0,        1,          0,        =
4),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        2,          0,        =
8),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        3,          0,       1=
6),
>> +       CPG_SD_DIV_TABLE_DATA(1,        0,        4,          0,       3=
2),
>> +};
>> +
>> +#define to_sd_clock(_hw) container_of(_hw, struct sd_clock, hw)
>> +
>> +static int cpg_sd_clock_endisable(struct clk_hw *hw, bool enable)
>> +{
>> +       struct sd_clock *clock =3D to_sd_clock(hw);
>> +       u32 val, sd_fc;
>> +       int i;
>
> unsigned int;
>
>> +
>> +       val =3D clk_readl(clock->reg);
>> +
>> +       if (enable) {
>> +               sd_fc =3D val & CPG_SD_FC_MASK;
>> +               for (i =3D 0; i < clock->div_num; i++)
>> +                       if (sd_fc =3D (clock->div_table[i].val & CPG_SD_=
FC_MASK))
>> +                               break;
>> +
>> +               if (i >=3D clock->div_num) {
>> +                       pr_err("%s: 0x%4x is not support of division rat=
io.\n",
>> +                               __func__, sd_fc);
>> +                       return -ENODATA;
>> +               }
>> +
>> +               val &=3D ~(CPG_SD_STP_MASK);
>> +               val |=3D clock->div_table[i].val & CPG_SD_STP_MASK;
>> +       } else
>> +               val |=3D CPG_SD_STP_MASK;
>> +
>> +       clk_writel(val, clock->reg);
>> +
>> +       return 0;
>> +}
>> +
>> +static int cpg_sd_clock_enable(struct clk_hw *hw)
>> +{
>> +       return cpg_sd_clock_endisable(hw, true);
>> +}
>> +
>> +static void cpg_sd_clock_disable(struct clk_hw *hw)
>> +{
>> +       cpg_sd_clock_endisable(hw, false);
>> +}
>
> Given there's not much similarity between the enable and disable cases,
> there's not much gained from having a common cpg_sd_clock_endisable().
> Perhaps just inline the code in cpg_sd_clock_{en,dis}able()?
>
>> +static unsigned long cpg_sd_clock_recalc_rate(struct clk_hw *hw,
>> +                                               unsigned long parent_rat=
e)
>> +{
>> +       struct sd_clock *clock =3D to_sd_clock(hw);
>> +       u32 rate =3D parent_rate;
>
> unsigned long
>
>> +       u32 val, sd_fc;
>> +       int i;
>
> unsigned int
>
>> +
>> +       val =3D clk_readl(clock->reg);
>> +
>> +       sd_fc =3D val & CPG_SD_FC_MASK;
>> +       for (i =3D 0; i < clock->div_num; i++)
>> +               if (sd_fc =3D (clock->div_table[i].val & CPG_SD_FC_MASK))
>> +                       break;
>> +
>> +       if (i >=3D clock->div_num) {
>> +               pr_err("%s: 0x%4x is not support of division ratio.\n",
>> +                       __func__, sd_fc);
>> +               return 0;
>> +       }
>> +
>> +       do_div(rate, clock->div_table[i].div);
>
> do_div() is meant for 64-by-32 division, while this is 32-by-32 on 32-bit
> platforms.
>
>      rate =3D DIV_ROUND_CLOSEST(rate, clock->div_table[i].div);
>
>> +
>> +       return rate;
>> +}
>> +
>> +static unsigned int cpg_sd_clock_calc_div(struct sd_clock *clock,
>> +                                         unsigned long rate,
>> +                                         unsigned long parent_rate)
>> +{
>> +       unsigned int div;
>> +
>> +       if (!rate)
>> +               rate =3D 1;
>> +
>> +       div =3D DIV_ROUND_CLOSEST(parent_rate, rate);
>> +
>> +       return clamp_t(unsigned int, div, clock->div_min, clock->div_max=
);
>> +}
>> +
>> +static long cpg_sd_clock_round_rate(struct clk_hw *hw, unsigned long ra=
te,
>> +                                     unsigned long *parent_rate)
>> +{
>> +       struct sd_clock *clock =3D to_sd_clock(hw);
>> +       unsigned int div =3D cpg_sd_clock_calc_div(clock, rate, *parent_=
rate);
>> +
>> +       return *parent_rate / div;
>
> DIV_ROUND_CLOSEST()?
>
>> +}
>> +
>> +static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                                  unsigned long parent_rate)
>> +{
>> +       struct sd_clock *clock =3D to_sd_clock(hw);
>> +       unsigned int div =3D cpg_sd_clock_calc_div(clock, rate, parent_r=
ate);
>> +       u32 val;
>> +       int i;
>
> unsigned int
>
>> +
>> +       for (i =3D 0; i < clock->div_num; i++)
>> +               if (div =3D clock->div_table[i].div)
>> +                       break;
>> +
>> +       if (i >=3D clock->div_num) {
>> +               pr_err("%s: Not support divider range : div=3D%d (%lu/%l=
u).\n",
>
> %u for div
>
>> +                       __func__, div, parent_rate, rate);
>> +               return -EINVAL;
>> +       }
>> +
>> +       val =3D clk_readl(clock->reg);
>> +       val &=3D ~(CPG_SD_STP_MASK | CPG_SD_FC_MASK);
>> +       val |=3D clock->div_table[i].val & (CPG_SD_STP_MASK | CPG_SD_FC_=
MASK);
>> +       clk_writel(val, clock->reg);
>> +
>> +       return 0;
>> +}
>
>> +static struct clk * __init cpg_sd_clk_register(const struct cpg_core_cl=
k *core,
>> +                                              void __iomem *base,
>> +                                              const char *parent_name)
>> +{
>> +       struct clk_init_data init;
>> +       struct sd_clock *clock;
>> +       struct clk *clk;
>> +       int i;
>
> unsigned int
>
>> +
>> +       clock =3D kzalloc(sizeof(*clock), GFP_KERNEL);
>> +       if (!clock)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       init.name =3D core->name;
>> +       init.ops =3D &cpg_sd_clock_ops;
>> +       init.flags =3D CLK_IS_BASIC | CLK_SET_RATE_PARENT;
>> +       init.parent_names =3D &parent_name;
>> +       init.num_parents =3D 1;
>> +
>> +       clock->reg =3D base + core->offset;
>> +       clock->hw.init =3D &init;
>> +       clock->div_table =3D cpg_sd_div_table;
>> +       clock->div_num =3D ARRAY_SIZE(cpg_sd_div_table);
>> +
>> +       clock->div_max =3D clock->div_table[0].div;
>> +       clock->div_min =3D clock->div_max;
>> +       for (i =3D 1; i < clock->div_num; i++) {
>> +               clock->div_max =3D max(clock->div_max, clock->div_table[=
i].div);
>> +               clock->div_min =3D min(clock->div_min, clock->div_table[=
i].div);
>> +       }
>> +
>> +       clk =3D clk_register(NULL, &clock->hw);
>> +       if (IS_ERR(clk))
>> +               kfree(clock);


I'll have a look to the topics above. Thanks!


> Shouldn't this provide the SDnH clocks, too? Or aren't they needed?


This is a very good question :)

I was thinking about this a short moment, too, and haven't a good=20
answer. The BSP this is taken from doesn't touch the SDnH explicitly.

Looking at the resulting clock tree I think I've seen that the SDnH=20
clocks are there, too.

Anybody with an idea?

Best regards

Dirk
