From: Luis Henriques <luis.henriques@canonical.com>
Date: Mon, 03 Nov 2014 10:53:08 +0000
Subject: Re: [PATCH] PM / clock_ops: Fix crash in clocks management code if !CONFIG_PM_RUNTIME
Message-Id: <20141103105308.GF6874@hercules>
List-Id: <linux-sh.vger.kernel.org>
References: <1412188697-15317-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412188697-15317-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Oct 30, 2014 at 10:06:25AM +0100, Geert Uytterhoeven wrote:
> Upstream commit a968bed78b549b4c61d4a46e59161fc1f60f96a6
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Wed Oct 1 20:38:17 2014 +0200
>=20
>     PM / clk: Fix crash in clocks management code if !CONFIG_PM_RUNTIME
>=20
>=20
> Simon tried it on mackerel. It did not crash, but caused a warning and
> backtrace:
>=20
>     WARNING: CPU: 0 PID: 1420 at drivers/sh/clk/core.c:240
> __clk_disable+0x80/0x90()
>     Trying to disable clock c04bd4d8 with 0 usecount
>=20
> which got fixed by the patch. So I think it should be applied to
> -stable (v3.14 and up).
>=20

Thanks,  I'm queuing it for the 3.16.

Cheers,
--
Lu=EDs

> Thanks!
>=20
> On Wed, Oct 1, 2014 at 8:38 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > Unlike the clocks management code for runtime PM, the code used for
> > system suspend does not check the pm_clock_entry.status field.
> > If pm_clk_acquire() failed, ce->status will be PCE_STATUS_ERROR, and
> > ce->clk will be a negative error code (e.g. 0xfffffffe =3D -2 =3D -ENOE=
NT).
> >
> > Depending on the clock implementation, suspend or resume may crash with:
> >
> >     Unable to handle kernel NULL pointer dereference at virtual address=
 00000026
> >
> > (CCF clk_disable() has an IS_ERR_OR_NULL() check, while CCF clk_enable()
> >  only has a NULL check; pre-CCF implementations may behave differently)
> >
> > While just checking for PCE_STATUS_ERROR would be sufficient, it doesn't
> > hurt to use the same state machine as is done for runtime PM, as this
> > makes the two versions more similar, and eligible for a future
> > consolidation.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > This crash started to happen on armadillo-legacy during s2ram if
> > CONFIG_PM_RUNTIME is not set after applying "[PATCH v2 07/11] ARM:
> > shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support"
> > (http://www.spinics.net/linux/lists/arm-kernel/msg365438.html), as
> > there's no NULL clock for the HDMI device.
> >
> > Most existing code calling pm_clk_suspend()/pm_clk_resume() is protected
> > by a check for CONFIG_PM_RUNTIME (davinci, keystone, omap1,
> > drivers/sh/pm_runtime.c), so it was not affected by this bug.
> >
> > Exceptions are:
> >   - arch/arm/mach-shmobile/pm-r8a7779.c (marzen),
> >   - arch/arm/mach-shmobile/pm-rmobile.c (r8a7740/armadillo and
> >     sh7372/mackerel),
> > but it's difficult to assess from the code whether the bug is really
> > triggered on these platforms.
> >
> > Grygorii Strashko's "[PATCH v1 2/4] ARM: keystone: pm: switch to use
> > generic pm domains" is not affected, as pm_clk_add_clk() is only called
> > for existing clocks.
> >
> > If it crashes on marzen or mackerel, I think this fix needs to be
> > applied to stable, too. I don't have access to marzen or mackerel board=
s,
> > though.
> >
> > How to test:
> >   - Build a kernel with CONFIG_PM_SLEEP/CONFIG_SUSPEND enabled, but
> >     CONFIG_PM_RUNTIME disabled,
> >   - echo 0 > /sys/module/printk/parameters/console_suspend,
> >   - echo mem > /sys/power/state,
> >   - wake up using e.g. gpio-keys or serial console activity.
> > ---
> >  drivers/base/power/clock_ops.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_=
ops.c
> > index b99e6c06ee678ecb..78369305e0698109 100644
> > --- a/drivers/base/power/clock_ops.c
> > +++ b/drivers/base/power/clock_ops.c
> > @@ -368,8 +368,13 @@ int pm_clk_suspend(struct device *dev)
> >
> >         spin_lock_irqsave(&psd->lock, flags);
> >
> > -       list_for_each_entry_reverse(ce, &psd->clock_list, node)
> > -               clk_disable(ce->clk);
> > +       list_for_each_entry_reverse(ce, &psd->clock_list, node) {
> > +               if (ce->status < PCE_STATUS_ERROR) {
> > +                       if (ce->status =3D PCE_STATUS_ENABLED)
> > +                               clk_disable(ce->clk);
> > +                       ce->status =3D PCE_STATUS_ACQUIRED;
> > +               }
> > +       }
> >
> >         spin_unlock_irqrestore(&psd->lock, flags);
> >
> > @@ -385,6 +390,7 @@ int pm_clk_resume(struct device *dev)
> >         struct pm_subsys_data *psd =3D dev_to_psd(dev);
> >         struct pm_clock_entry *ce;
> >         unsigned long flags;
> > +       int ret;
> >
> >         dev_dbg(dev, "%s()\n", __func__);
> >
> > @@ -394,8 +400,13 @@ int pm_clk_resume(struct device *dev)
> >
> >         spin_lock_irqsave(&psd->lock, flags);
> >
> > -       list_for_each_entry(ce, &psd->clock_list, node)
> > -               __pm_clk_enable(dev, ce->clk);
> > +       list_for_each_entry(ce, &psd->clock_list, node) {
> > +               if (ce->status < PCE_STATUS_ERROR) {
> > +                       ret =3D __pm_clk_enable(dev, ce->clk);
> > +                       if (!ret)
> > +                               ce->status =3D PCE_STATUS_ENABLED;
> > +               }
> > +       }
> >
> >         spin_unlock_irqrestore(&psd->lock, flags);
> >
> > --
> > 1.9.1
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe stable" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
