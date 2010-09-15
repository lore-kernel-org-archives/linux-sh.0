From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Sep 2010 08:31:23 +0000
Subject: Re: [PATCH 2/2][RFC] ARM: mach-shmobile: clock-sh7372: FSI parent
Message-Id: <AANLkTimdAsv62BPYODTGe0sKQ2ojqX3UYmeMotW2tXcW@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3sfwlxm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3sfwlxm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wed, Sep 15, 2010 at 3:38 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Thanks for your work on this.

> I need some comment/advice

Sure, I'll try to help! =3D)

> @@ -818,6 +797,38 @@ out:
>
> =A0device_initcall(hdmi_init_pm_clock);
>
> +static int __init fsi_init_pm_clock(void)
> +{
> + =A0 =A0 =A0 struct clk *fsia_ick =3D clk_get(&fsi_device.dev, "icka");
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 /* change parent of FSI A */
> +
> + =A0 =A0 =A0 if (IS_ERR(fsia_ick)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(fsia_ick);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot get FSI ICK: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* select FSIACK for AK4642 */
> + =A0 =A0 =A0 ret =3D clk_set_parent(fsia_ick, &fsiack_clk);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot set FSI-A parent: %d\n", ret=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* no divide */
> + =A0 =A0 =A0 ret =3D clk_set_rate(fsia_ick, 0);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Cannot set FSI-A rate: %d\n", ret);

This rate setting looks a bit strange to me. It looks like you select
the external pin as parent, and then you try to set the rate to zero.
What is the clock rate of the external pin?

> diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobi=
le/clock-sh7372.c
> index ea384e1..0a22648 100644
> --- a/arch/arm/mach-shmobile/clock-sh7372.c
> +++ b/arch/arm/mach-shmobile/clock-sh7372.c
> @@ -59,6 +59,13 @@ static struct clk r_clk =3D {
> =A0 =A0 =A0 =A0.rate =A0 =A0 =A0 =A0 =A0 =3D 32768,
> =A0};
>
> +/* External input clock (pin name: FSIACK/FSIBCK ) */
> +struct clk fsiack_clk =3D {
> +};
> +
> +struct clk fsibck_clk =3D {
> +};
> +
> =A0/*
> =A0* 26MHz default rate for the EXTAL1 root input clock.
> =A0* If needed, reset this with clk_set_rate() from the platform code.
> @@ -295,6 +302,8 @@ struct clk pllc2_clk =3D {
> =A0static struct clk *main_clks[] =3D {
> =A0 =A0 =A0 =A0&dv_clki_clk,
> =A0 =A0 =A0 =A0&r_clk,
> + =A0 =A0 =A0 &fsiack_clk,
> + =A0 =A0 =A0 &fsibck_clk,
> =A0 =A0 =A0 =A0&sh7372_extal1_clk,
> =A0 =A0 =A0 =A0&sh7372_extal2_clk,
> =A0 =A0 =A0 =A0&dv_clki_div2_clk,

I'd prefer to keep r_clk and extal clocks together since they are the
main inputs to the cpu. Put the new clocks at the end of the list
please.

> diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach=
-shmobile/include/mach/sh7372.h
> index 33e9700..4d93c17 100644
> --- a/arch/arm/mach-shmobile/include/mach/sh7372.h
> +++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
> @@ -460,5 +460,7 @@ enum {
> =A0extern struct clk dv_clki_clk;
> =A0extern struct clk dv_clki_div2_clk;
> =A0extern struct clk pllc2_clk;
> +extern struct clk fsiack_clk;
> +extern struct clk fsibck_clk;

I would prefer that the global clocks came with a sh7372 prefix,
please add "sh7372_" before the variable names.

Thanks,

/ magnus
