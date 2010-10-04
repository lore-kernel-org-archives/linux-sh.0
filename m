From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 04 Oct 2010 03:35:54 +0000
Subject: Re: [PATCH 1/2] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support
Message-Id: <AANLkTi=wMbexitHZqSBOL1ump1muFv-kWVxw1OdRmvh8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sat, Oct 2, 2010 at 1:21 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 1 Oct 2010, Kuninori Morimoto wrote:
>
>>
>> This patch add late_main_clks clock array,
>> because these clock needs div6 clocks for use
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>> =A0arch/arm/mach-shmobile/clock-sh7372.c =A0 =A0 =A0 =A0| =A0132 +++++++=
+++++++++++++++++++
>> =A0arch/arm/mach-shmobile/include/mach/sh7372.h | =A0 =A02 +
>> =A02 files changed, 134 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmob=
ile/clock-sh7372.c
>> index 8b9f50a..6f8eabe 100644
>> --- a/arch/arm/mach-shmobile/clock-sh7372.c
>> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
>> @@ -50,6 +50,9 @@
>> =A0#define SMSTPCR3 =A0 =A0 0xe615013c
>> =A0#define SMSTPCR4 =A0 =A0 0xe6150140
>>
>> +#define FSIDIVA =A0 =A0 =A0 =A0 =A0 =A0 =A00xFE1F8000
>> +#define FSIDIVB =A0 =A0 =A0 =A0 =A0 =A0 =A00xFE1F8008
>> +
>> =A0/* Platforms must set frequency on their DV_CLKI pin */
>> =A0struct clk sh7372_dv_clki_clk =3D {
>> =A0};
>> @@ -417,6 +420,132 @@ static struct clk div6_reparent_clks[DIV6_REPARENT=
_NR] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
fsibckcr_parent, ARRAY_SIZE(fsibckcr_parent), 6, 2),
>> =A0};
>>
>> +/* FSI DIV */
>> +
>> +static void fsidiv_init(struct clk *clk)
>> +{
>> + =A0 =A0 clk->enable_reg =3D ioremap_nocache((unsigned long)clk->enable=
_reg, 8);
>
> What happens, if ioremap() fails? On the whole, for some reason I don't
> really like this

Perhaps ->init should have a return value?

But I recall Paul disliking that idea?

> void x_init(struct foo *x)
> {
> =A0 =A0 =A0 =A0x->reg =3D ioremap(x->reg, N);
> }
>
> approach very much... But maybe it's just me. Why not just add the ioremap
> to this loop
>
>> @@ -582,6 +711,9 @@ void __init sh7372_clock_init(void)
>> =A0 =A0 =A0 if (!ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D sh_clk_mstp32_register(mstp_clks, MS=
TP_NR);
>>
>> + =A0 =A0 for (k =3D 0; !ret && (k < ARRAY_SIZE(late_main_clks)); k++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_register(late_main_clks[k]);
>> +
>> =A0 =A0 =A0 clkdev_add_table(lookups, ARRAY_SIZE(lookups));
>>
>> =A0 =A0 =A0 if (!ret)
>
> and only register the respective clock, if it succeeds?

If so then we need to move out the per-clock type init code from all
the clock callbacks to the common per-cpu init routine. I'd rather see
the per-clock type code kept together.

/ magnus
