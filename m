From: Mark Brown <broonie@kernel.org>
Date: Wed, 08 Oct 2014 11:40:24 +0000
Subject: Re: [PATCH] ASoC: simple-card: Add mic and hp detect gpios.
Message-Id: <20141008114024.GW4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="HRz4dlJa0zmFsB3a"
List-Id: <linux-sh.vger.kernel.org>
References: <1412198720-2326-1-git-send-email-dgreid@chromium.org>
 <20141002155350.GU4273@sirena.org.uk>
 <CAMuHMdWh=sXAD59T1T=gvROX+fbF6=gFo6C0nkJdfnCrdNrwYg@mail.gmail.com>
 <20141007123856.GF4609@sirena.org.uk>
 <CAMuHMdV39fM_TCa+WSvswij6dxD2vwfJT+FueBtxndpsymP9CQ@mail.gmail.com>
 <20141007163654.GJ4609@sirena.org.uk>
 <CAAVeFuJB=bF3g2czT1ed1UX85R_hBXqFAKdeLJcASRcXQujFJw@mail.gmail.com>
 <CACRpkdY+KQ1OMh565desoqVP-AUJL-VjFx-D5LiaNpXs5oOsnA@mail.gmail.com>
In-Reply-To: <CACRpkdY+KQ1OMh565desoqVP-AUJL-VjFx-D5LiaNpXs5oOsnA@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Dylan Reid <dgreid@chromium.org>, jay.xu@rock-chips.com, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--HRz4dlJa0zmFsB3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 10:50:00AM +0200, Linus Walleij wrote:
> On Wed, Oct 8, 2014 at 9:05 AM, Alexandre Courbot <gnurou@gmail.com> wrote:

> > But transition to gpiod is the way to ultimately fix this issue, as
> > well as many others. Not to mention that renumbering GPIOs will
> > certainly make a few users of the GPIO sysfs (another abomination,
> > agreed) unhappy. I can only recommend switching drivers to gpiod when
> > such issues are spotted.

> Yeah that is another issue ... we end up in catch 22 situations like
> that, renumber the GPIOs, OK, then we break the ABI.

> Admittedly that "ABI" is something people break all the time,
> /sys/*gpioN just isnt what it should be, not stable at all.

> I'm not against renumbering GPIO if it's minor effort, but if it
> start to consume hundreds of hours and regressions and what not,
> that time is better spent focusing on the gpiod transition.

My guess is that it's relatively little work for most platforms - with
the systems I've done enough work on to notice everything is keyed off a
few defines in the header file.  Things tend to be worse in out of tree
code but mainline's generally been pretty good.

--HRz4dlJa0zmFsB3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNSKnAAoJECTWi3JdVIfQUC4IAIIKAItpa7qYGixEZO6V2j+v
DO22WyxAr59ZyS+dRaPwsWC/gtBFYdGs8QtiawoXRec1LqYH6ZxyJSCXBFFMRb1I
H+ddDAB4JtKJGYv9Ci0kvW19C0gnVwDICaAb5a0KcA8vT7gh9WmPOlnJqceU6Glv
tZUb3TyW8PVHeJBvHAPF3o/wGPHcao/RPeeIEZArJVbGZCcnVJKlR90AtMXx/WgV
8bWp4DHr8ki+L9kWi7JePf1r/xy2Dq70RJhnQsiJqhF0cj0eQHgsEt/yx5tIlKni
EhWrsU3awr0E8sNAJ7/G2e9Dv24HsjdjKogWzQ84CjEk8NT6EFPIFO6jpQ2B2fM=
=ZYo0
-----END PGP SIGNATURE-----

--HRz4dlJa0zmFsB3a--
