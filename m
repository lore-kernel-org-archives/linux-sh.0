From: Mark Brown <broonie@kernel.org>
Date: Tue, 07 Oct 2014 16:36:54 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <20141007163654.GJ4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gVeFDRGtAQ0W7qcm"
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
 <20141002155350.GU4273@sirena.org.uk>
 <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
 <20141007123856.GF4609@sirena.org.uk>
 <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dylan Reid <dgreid@chromium.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jay.xu@rock-chips.com, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, sonnyrao@chromium.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 03:10:01PM +0200, Geert Uytterhoeven wrote:
> On Tue, Oct 7, 2014 at 2:38 PM, Mark Brown <broonie@kernel.org> wrote:

> > The fix here is to not allow 0 as a GPIO in the core code (which
> > should've been there already).

> Unfortunately it's not there.

> And it's not as simple as changing the definition of gpio_is_valid()
> (crash in gpio_get_value()):

>     gpiochip_add: GPIOs 0..211 (r8a7740_pfc) failed to register
>     sh-pfc pfc-r8a7740: failed to init GPIO chip, ignoring...
>     sh-pfc pfc-r8a7740: r8a7740_pfc support registered
>     Unable to handle kernel NULL pointer dereference at virtual address 0000004c

Right, obviously it's not going to work if the platform actually uses 0
as a valid GPIO.

> Quoting Linus (https://lkml.org/lkml/2014/9/4/464):
> "Fixing the old global GPIO numberspace API is a waste of time IMO".

> Hence I've just sent a patch to initialize the GPIO numbers with -ENOENT.

I do think it's worth renumbering the platforms since it's *relatively*
little work per platform compared to completing the gpiod transition.

--gVeFDRGtAQ0W7qcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNBalAAoJECTWi3JdVIfQ50UH/jlCUwuw+qpYsFxnMr6HgFWm
o56BLqUOI12FQpV7cZbOVwDFcXXZJ+VWfl1oJbcPcLcmR8M830I2BVrtPg4jNud2
2kZRaPrpt4m2kLeLsQ2e1pUUlWNrlfgwv8mXDrQL2OKdvY+c95J0x7Z7ZBJNPbAB
569Qx53AicNeRZH9s2jm9lPh9EtseSL51p5VBlRjvMTESSUgMdz+uzGsi1fwEbgU
Uxk0EsBbQ2zwvDAVicTtdgR4jawavgz9+YOF7iFmo+GCfSm+Z3N9VNQPG6FjoB89
wRqGwrn2NoV2tJKXdAjIIY+JmaRm+LIfgWRC3N4Yn59A5EPsW/oczRnbBSs/qXk=
=FKzE
-----END PGP SIGNATURE-----

--gVeFDRGtAQ0W7qcm--
