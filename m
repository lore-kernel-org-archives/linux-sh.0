From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 May 2010 10:50:46 +0000
Subject: Re: [PATCH] sh_tmu: compute mult and shift before registration
Message-Id: <AANLkTimQ6rvDdFHZ99DjifjSdtRGDvMINPL2z7UxIhfo@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Aurelien,

Thanks for your patch!

On Mon, May 31, 2010 at 6:09 PM, Aurelien Jarno <aurelien@aurel32.net> wrot=
e:
> Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
> clocksource wrapping during idle"), the CPU of an R2D board never goes
> to idle. This commit assumes that mult and shift are assigned before
> the clocksource is registered. As a consequence the safe maximum sleep
> time is negative and the CPU never goes into idle.
>
> This patch fixes the problem by moving mult and shift initialization
> from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().
>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
> =A0drivers/clocksource/sh_tmu.c | =A0 14 +++++---------
> =A01 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 8e44e14..e9e35aa 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -199,16 +199,8 @@ static cycle_t sh_tmu_clocksource_read(struct clocks=
ource *cs)
> =A0static int sh_tmu_clocksource_enable(struct clocksource *cs)
> =A0{
> =A0 =A0 =A0 =A0struct sh_tmu_priv *p =3D cs_to_sh_tmu(cs);
> - =A0 =A0 =A0 int ret;
> -
> - =A0 =A0 =A0 ret =3D sh_tmu_enable(p);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>
> - =A0 =A0 =A0 /* TODO: calculate good shift from rate and counter bit wid=
th */
> - =A0 =A0 =A0 cs->shift =3D 10;
> - =A0 =A0 =A0 cs->mult =3D clocksource_hz2mult(p->rate, cs->shift);
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return sh_tmu_enable(p);
> =A0}
>
> =A0static void sh_tmu_clocksource_disable(struct clocksource *cs)
> @@ -228,6 +220,10 @@ static int sh_tmu_register_clocksource(struct sh_tmu=
_priv *p,
> =A0 =A0 =A0 =A0cs->disable =3D sh_tmu_clocksource_disable;
> =A0 =A0 =A0 =A0cs->mask =3D CLOCKSOURCE_MASK(32);
> =A0 =A0 =A0 =A0cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
> + =A0 =A0 =A0 /* TODO: calculate good shift from rate and counter bit wid=
th */
> + =A0 =A0 =A0 cs->shift =3D 10;
> + =A0 =A0 =A0 /* channel will be configured at parent clock / 4 */
> + =A0 =A0 =A0 cs->mult =3D clocksource_hz2mult(clk_get_rate(p->clk) / 4, =
cs->shift);
> =A0 =A0 =A0 =A0dev_info(&p->pdev->dev, "used as clock source\n");
> =A0 =A0 =A0 =A0clocksource_register(cs);
> =A0 =A0 =A0 =A0return 0;

Hm, are you sure the clock is enabled at this point?

The file include/linux/clk.h says that the clock has to be enabled
before clk_get_rate() is called.

/ magnus
