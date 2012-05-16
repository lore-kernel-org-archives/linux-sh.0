From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 May 2012 09:49:05 +0000
Subject: Re: [PATCH 01/08] mach-shmobile: Emma Mobile EV2 SoC base support V3
Message-Id: <CANqRtoSYQozRE5uayBz4YYt7G4=ma72YVQjMJBKYSvkwENf8cg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120516064449.32286.77941.sendpatchset@w520>
 <20120516064458.32286.37948.sendpatchset@w520>
 <20120516065625.GM7988@linux-sh.org>
In-Reply-To: <20120516065625.GM7988@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, May 16, 2012 at 3:56 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, May 16, 2012 at 03:44:58PM +0900, Magnus Damm wrote:
>> +static int emev2_gclk_enable(struct clk *clk)
>> +{
>> + =A0 =A0 iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->mapped_reg);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void emev2_gclk_disable(struct clk *clk)
>> +{
>> + =A0 =A0 iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk->mapped_reg);
>> +}
>> +
>> +static struct sh_clk_ops emev2_gclk_clk_ops =3D {
>> + =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D emev2_gclk_enable,
>> + =A0 =A0 .disable =A0 =A0 =A0 =A0=3D emev2_gclk_disable,
>> + =A0 =A0 .recalc =A0 =A0 =A0 =A0 =3D followparent_recalc,
>> +};
>> +
>> +static int __init emev2_gclk_register(struct clk *clks, int nr)
>> +{
>> + =A0 =A0 struct clk *clkp;
>> + =A0 =A0 int ret =3D 0;
>> + =A0 =A0 int k;
>> +
>> + =A0 =A0 for (k =3D 0; !ret && (k < nr); k++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkp =3D clks + k;
>> + =A0 =A0 =A0 =A0 =A0 =A0 clkp->ops =3D &emev2_gclk_clk_ops;
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D clk_register(clkp);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
> This all looks like a pointless abstraction. This is basically a verbatim
> copy of the sh_clk_mstp32 routines.

At a first glance maybe, but the operation is inverted compared to MSTP32.

So, at disable time gclk clears the bit. MSTP32 sets the bit.

> I suppose this is a case where you want to use the mstp32 routines but
> don't specifically have div4/div6 clocks to manage so you aren't setting
> SH_CLK_CPG. Perhaps we should just move the sh_clk_mstp32 stuff out so
> it's provided regardless of the CPG setting and rename it to drop the
> mstp32 connotations. It's really only the div4/div6 stuff that has any
> CPG-specific behaviour at this point anyways.

Perhaps we could base this code on MSTP32 and CPG, but I believe it is
better just to move to common clocks directly. So in this case for
gclk we can instead use code in drivers/clk/clk-gate.c.

Cheers,

/ magnus
