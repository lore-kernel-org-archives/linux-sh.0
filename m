From: Thomas Schwinge <thomas@codesourcery.com>
Date: Mon, 20 Feb 2012 07:50:06 +0000
Subject: Re: Single-stepping with UBC on SH7785
Message-Id: <87y5ry9c5t.fsf@schwinge.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <87sjidcrrn.fsf@schwinge.name>
In-Reply-To: <87sjidcrrn.fsf@schwinge.name>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

Ping.

On Tue, 14 Feb 2012 17:18:52 +0100, I wrote:
> Upgrading the kernel for it, we noticed that with ``recent'' kernels,
> single-stepping is broken for our SH7785-based board.  I tracked this
> down to commit 09a072947791088b88ae15111cf68fc5aaaf758d (2009-11-09),
> ``preliminary support for the SH-4A UBC to the hw-breakpoints API''.
>=20
> After learning from the SH7785 manual how to use and program the UBC, it
> seemed obvious to me that what it implemented nowadays in
> arch/sh/kernel/cpu/sh4a/ubc.c for programming the UBC does not match how
> it used to be, so I changed that according to my interpretation of the
> manual, as well as the pre-09a072's
> arch/sh/kernel/process_32.c:__switch_to implementation.  This is the
> attached 0001-WIP-Restore-single-stepping-functionality-on-our-SH7.patch.
> Yet, it still wouldn't work.
>=20
>=20
> After several hours of grief, I came up with the additional
> 0001-Wire-the-clock-of-the-SH7785-s-UBC-as-expected-in-ub.patch -- and it
> worked!  (Meh, so simple...)
>=20
>=20
> ... and today I figured out that my first patch isn't even needed -- but
> I don't understand how the current ubc.c implementation gets away with
> not using the asid stuff, for example?  And shouldn't it respect the
> reserved value UBC_CRR_RES as well as UBC_CRR_INIT and UBC_CBR_INIT that
> I re-introduced?  Also the manual suggests a different order for
> programming the registers.
>=20
> As soon as someone starts working on adding user-space controlled
> hardware breakpoint and/or watchpoint support, this will need further
> untangling/cleanup.
>=20
>=20
> Gr=C3=BC=C3=9Fe,
>  Thomas
>=20
>=20
> From 2942691b300a14eb3751aa687165e1c00da3cedd Mon Sep 17 00:00:00 2001
> From: Thomas Schwinge <thomas@codesourcery.com>
> Date: Tue, 14 Feb 2012 16:17:47 +0100
> Subject: [PATCH] [WIP] Restore single-stepping functionality on our
>  SH7785-based board.
>=20
> Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
> ---
>  arch/sh/kernel/cpu/sh4a/ubc.c |   67 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 66 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/sh/kernel/cpu/sh4a/ubc.c b/arch/sh/kernel/cpu/sh4a/ubc.c
> index efb2745..86c54cc 100644
> --- a/arch/sh/kernel/cpu/sh4a/ubc.c
> +++ b/arch/sh/kernel/cpu/sh4a/ubc.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <asm/hw_breakpoint.h>
> +#include <asm/mmu_context.h>
>=20=20
>  #define UBC_CBR(idx)	(0xff200000 + (0x20 * idx))
>  #define UBC_CRR(idx)	(0xff200004 + (0x20 * idx))
> @@ -24,30 +25,83 @@
>  #define UBC_CBCR	0xff200620
>=20=20
>  /* CRR */
> +#define UBC_CRR_RES	(1 << 13)
>  #define UBC_CRR_PCB	(1 << 1)
>  #define UBC_CRR_BIE	(1 << 0)
> +#define UBC_CRR_INIT	0x00002000
>=20=20
>  /* CBR */
> +#define UBC_CBR_AIE	(1 << 30)
> +#define UBC_CBR_ID_INST	(1 << 4)
>  #define UBC_CBR_CE	(1 << 0)
> +#define UBC_CBR_INIT	0x20000000
> +
> +#define UBC_CBR_AIV_SET(asid)	(((asid) << UBC_CBR_AIV_SHIFT) & UBC_CBR_A=
IV_MASK)
> +#define UBC_CBR_AIV_SHIFT	16
> +#define UBC_CBR_AIV_MASK	0x00ff0000
>=20=20
>  static struct sh_ubc sh4a_ubc;
>=20=20
>  static void sh4a_ubc_enable(struct arch_hw_breakpoint *info, int idx)
>  {
> +#if 0
>  	__raw_writel(UBC_CBR_CE | info->len | info->type, UBC_CBR(idx));
> +#else
> +	int asid =3D 0;
> +	unsigned long tmp;
> +
> +	printk("0x%p\t%s for 0x%lx on channel %d\n", current, __FUNCTION__, inf=
o->address, idx);
> +
> +//#ifdef CONFIG_MMU
> +//	asid =3D cpu_asid(smp_processor_id(), current->mm);
> +	asid =3D get_asid();
> +//#endif
> +
> +	tmp =3D UBC_CBR_CE
> +		| UBC_CBR_ID_INST
> +		| UBC_CBR_AIE
> +		| UBC_CBR_AIV_SET(asid)
> +		/* | info->len */
> +		/* | info->type */ | (1 << 1);
> +	__raw_writel(tmp, UBC_CBR(idx));
> +	printk("  asid 0x%x, CBR: %lx", asid, tmp);
> +#endif
>  	__raw_writel(info->address, UBC_CAR(idx));
> +
> +	__raw_writel(0, UBC_CAMR(idx));
> +
> +//	__raw_writel(0, UBC_CBCR);
> +
> +	tmp =3D UBC_CRR_BIE
> +		| UBC_CRR_PCB
> +		| UBC_CRR_RES;
> +	__raw_writel(tmp, UBC_CRR(idx));
> +	printk(", CRR: %lx\n", tmp);
> +
> +	/* dummy read for write posting */
> +	(void) __raw_readl(UBC_CBR(idx));
> +	(void) __raw_readl(UBC_CRR(idx));
>  }
>=20=20
>  static void sh4a_ubc_disable(struct arch_hw_breakpoint *info, int idx)
>  {
> +	printk("0x%p\t%s for 0x%lx on channel %d\n", current, __FUNCTION__, inf=
o->address, idx);
> +
> +#if 0
>  	__raw_writel(0, UBC_CBR(idx));
>  	__raw_writel(0, UBC_CAR(idx));
> +#else
> +	__raw_writel(UBC_CBR_INIT, UBC_CBR(idx));
> +	__raw_writel(UBC_CRR_INIT, UBC_CRR(idx));
> +#endif
>  }
>=20=20
>  static void sh4a_ubc_enable_all(unsigned long mask)
>  {
>  	int i;
>=20=20
> +	printk("0x%p\t%s with mask 0x%lx\n", current, __FUNCTION__, mask);
> +
>  	for (i =3D 0; i < sh4a_ubc.num_events; i++)
>  		if (mask & (1 << i))
>  			__raw_writel(__raw_readl(UBC_CBR(i)) | UBC_CBR_CE,
> @@ -58,6 +112,8 @@ static void sh4a_ubc_disable_all(void)
>  {
>  	int i;
>=20=20
> +	printk("0x%p\t%s\n", current, __FUNCTION__);
> +
>  	for (i =3D 0; i < sh4a_ubc.num_events; i++)
>  		__raw_writel(__raw_readl(UBC_CBR(i)) & ~UBC_CBR_CE,
>  			     UBC_CBR(i));
> @@ -68,6 +124,8 @@ static unsigned long sh4a_ubc_active_mask(void)
>  	unsigned long active =3D 0;
>  	int i;
>=20=20
> +	printk("0x%p\t%s\n", current, __FUNCTION__);
> +
>  	for (i =3D 0; i < sh4a_ubc.num_events; i++)
>  		if (__raw_readl(UBC_CBR(i)) & UBC_CBR_CE)
>  			active |=3D (1 << i);
> @@ -77,11 +135,15 @@ static unsigned long sh4a_ubc_active_mask(void)
>=20=20
>  static unsigned long sh4a_ubc_triggered_mask(void)
>  {
> +	printk("0x%p\t%s\n", current, __FUNCTION__);
> +
>  	return __raw_readl(UBC_CCMFR);
>  }
>=20=20
>  static void sh4a_ubc_clear_triggered_mask(unsigned long mask)
>  {
> +	printk("0x%p\t%s with mask 0x%lx\n", current, __FUNCTION__, mask);
> +
>  	__raw_writel(__raw_readl(UBC_CCMFR) & ~mask, UBC_CCMFR);
>  }
>=20=20
> @@ -114,15 +176,18 @@ static int __init sh4a_ubc_init(void)
>=20=20
>  	__raw_writel(0, UBC_CBCR);
>=20=20
> +#if 0
>  	for (i =3D 0; i < sh4a_ubc.num_events; i++) {
>  		__raw_writel(0, UBC_CAMR(i));
>  		__raw_writel(0, UBC_CBR(i));
>=20=20
> -		__raw_writel(UBC_CRR_BIE | UBC_CRR_PCB, UBC_CRR(i));
> +//		__raw_writel(UBC_CRR_BIE | UBC_CRR_PCB, UBC_CRR(i));
> +		__raw_writel(UBC_CRR_BIE | UBC_CRR_PCB | UBC_CRR_RES, UBC_CRR(i));
>=20=20
>  		/* dummy read for write posting */
>  		(void)__raw_readl(UBC_CRR(i));
>  	}
> +#endif
>=20=20
>  	clk_disable(ubc_iclk);
>=20=20
> --=20
> 1.7.5.4
>=20
> From c6696f9fcffcce6739449ea681a38c30e4799017 Mon Sep 17 00:00:00 2001
> From: Thomas Schwinge <thomas@codesourcery.com>
> Date: Tue, 14 Feb 2012 16:19:49 +0100
> Subject: [PATCH] Wire the clock of the SH7785's UBC as expected in ubc.c.
>=20
> Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
> ---
>  arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/=
sh4a/clock-sh7785.c
> index e5b420c..2b31443 100644
> --- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> +++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
> @@ -156,7 +156,7 @@ static struct clk_lookup lookups[] =3D {
>  	CLKDEV_CON_ID("siof_fck", &mstp_clks[MSTP003]),
>  	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
>  	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
> -	CLKDEV_CON_ID("ubc_fck", &mstp_clks[MSTP117]),
> +	CLKDEV_CON_ID("ubc0", &mstp_clks[MSTP117]),
>  	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
>  	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
>  	CLKDEV_CON_ID("gdta_fck", &mstp_clks[MSTP100]),
> --=20
> 1.7.5.4
>=20


Gr=C3=BC=C3=9Fe,
 Thomas

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPQfsuAAoJENuKOtuXzphJXlYH/iXOdFbtYNHC4YIEyuzDo3B9
AHGu3FR3N3VKI9BMcteSyoubyq8BS4RYmvTkSO9ChnvrZi7yWgdiHepoXREkKkIq
Ufkp15BSb63wqUlLzgNGbiUctx1zocwz3o9RBot1kM4cnZMsULPilpFQYehsnLcq
PevO3fknRvASnVEiaaOC//86hPWbY0agc6bMLkaOEb8V5ralLIDQhTCm0WEfS5bM
MM2oH7dJDx3YIar/GMRP3DpbY2ASMxtCzo4uwnzg092DSZNinLbdabg1mkmXMdi5
YtdcEVgl/4DsoIC42Hn1Y5+EYllEkdR3f1BeNmOhOhJLziCNp0WyopvCayB8ako=
=K2oj
-----END PGP SIGNATURE-----
--=-=-=--
