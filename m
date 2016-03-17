From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Mar 2016 09:34:33 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <20160317093433.GB1402@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +Required properties:
> > +- compatible : Should be "renesas,rwdt-r8a7795";
>=20
> "renesas,r8a7795-rwdt", and "renesas,rcar-gen3-rwdt" as a fallback, to ma=
tch
> current best practices?

What about "renesas,rcar-gen2-rwdt" since Gen2 and Gen3 are identical?
But why "r8a7795-rwdt" with SoC first? Looking at the r8a7795.dtsi,
"<ip_core>-<soc_type>" seems to be more dominant than
"<soc_type>-<ip_core>"? Ah, confusing again...

> > +Optional properties:
> > +- timeout-sec : Contains the watchdog timeout in seconds
>=20
> Isn't this a software configuration thingy? I.e. does it belong it DT?

This is a generic watchdog binding handled by the watchdog core.

> > +#define RWDT_DEFAULT_TIMEOUT 60
>=20
> "60U", so no more (hidden) casts needed.

Ah, yes, I can do this now since the module parameter is gone \o/

> > +static int rwdt_start(struct watchdog_device *wdev)
> > +{
> > +       struct rwdt_priv *priv =3D watchdog_get_drvdata(wdev);
> > +
> > +       clk_prepare_enable(priv->clk);
>=20
> pm_runtime_get_sync()?
>=20
> You also have to call pm_runtime_enable() etc. in probe()/remove().

I'd prefer putting those into probe/remove as well. The restart handler
also accesses the registers, so IMO the clock should be always on.

> > +       clk_prepare_enable(priv->clk);
> > +       rate =3D clk_get_rate(priv->clk);
> > +       clk_disable_unprepare(priv->clk);
>=20
> I think the clk enablement was needed in v2, because you wanted to read t=
he
> RWTCSRA register, but that was already removed in v3?

Aha, clk_get_rate doesn't need the clock prepared? Didn't know that.

> > +       if (!rate)
> > +               return -ENOENT;
>=20
> -EINVAL?

Too generic.

> > +       for (i =3D ARRAY_SIZE(clk_divs); i >=3D 0; i--) {
> > +               clks_per_sec =3D rate / clk_divs[i];
> > +               if (clks_per_sec) {
> > +                       priv->clks_per_sec =3D clks_per_sec;
> > +                       priv->cks =3D i;
> > +                       break;
> > +               }
> > +       }
> > +
> > +       if (!clks_per_sec) {
> > +               dev_err(&pdev->dev, "Can't find suitable clock divider!=
\n");
> > +               return -ERANGE;
>=20
> -EINVAL?

Ditto.

> > + * to work there, one also needs a RESET (RST) driver which does not e=
xist yet
> > + * due to HW issues. This needs to be solved before adding compatibles=
 here.
>=20
> Isn't there some setup needed on R-Car Gen3, too?

Good news. The latest bootloader update made the Watchdog work on Gen3!
It sets WDTRSTCR (chapter 11.2.4) to 0x8002. Clearing bit 0 unmasks the
reset signal from the RWDT watchdog. Setting bit 15 enforces
initializing BARs on WDT reset. This is the bit we are missing badly on
Gen2 for proper WDT reset AFAICT.

This register can only be changed in secure mode. I recall that those
register are left to the firmware to be setup, or am I wrong? At least
this explains why the BSP team could test my driver without changing
kernel code. They had early access to the new bootloader ;)

However, while testing I found a glitch to be fixed. I hope to have this
tackled today, so I can resend the series.

Thanks,

   Wolfram


--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6nopAAoJEBQN5MwUoCm2GawP/iT+ekFT7AHx9VXecJfV1zYp
oZZuZYI/HO1///g1VWsR1mv2LEtAgyWUZgmafUcoqhlS5piWngpKbf0ufaf1Y40r
KXgAQKDl5zeR+UkAu+rtEg+gE9JilMqnTGRhiixrtDh6xyjtLvcjgMqxJqioIAAk
zHxDJM5YypgDhdd1o5leFHgQDFSklKi1Zpv9ahZ7KcyPwsb+z0mcfgy3kZbdJQ9/
ABNFA9HQ34aj53z5pXq+hbyMmqDT4tKX/6BrveH6usG8jii0dkxHsIAyNN14WOVo
ZRyzdUxBvRBke53YO2uxvOa6IoNlCFun5e0AZs/nkzYWZYDOxT3AB9k5uZMdk5Oy
PRZT2Ba+7Uqmz2Z63OZ849uY0pLJXBPpWsO3pHAIlgSexKdJwA1jLClR+sXDo89P
7y9Zqj2+QR9Gw1q6CsLVC4Qja+oL8Nk5wudMT4ViuyqnNITU/UOX7gb70TPGuFBP
l6FaGN0SlBz4iBfg/9B3Fym9FrG1uy1Ps9IWSgXtn04ZgaTY2z4+NmaJcc32lkny
mw4qM56tnksfebxgfLgOgyWyCtnUNGFAgRB4+6npRPYdicjebOpbu7WLyG47i3Me
i6hLx0tvNm1vbWLTmfde1fYM3IW3I5xHDOmOFI4LMt/Ks8sKUTUNrfsqAc0X94FI
zdX3B9yQx3S+Dl7gcJ6x
=JdI4
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
