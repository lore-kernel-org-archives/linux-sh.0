From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Feb 2015 13:56:49 +0000
Subject: Re: ARM: shmobile: koelsch: da9210/da9063 interrupt storm (was: Re: [PATCH 3/4] ARM: shmobile: koels
Message-Id: <20150217135649.GU9110@finisterre.sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Q43QQdzFtqSKgsg+"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUasUmnHRi5t3GStrt-WKw0Das4noTmZPNtcbqA7nmDvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Watchdog Mailing List <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--Q43QQdzFtqSKgsg+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2015 at 01:05:07PM +0100, Geert Uytterhoeven wrote:

> However, as soon as the da9210 driver will get interrupt support (I wrote
> something, based on the da9211 driver) and the da9210 will have an interr=
upts
> property in DTS, the interrupt storm will reappear, irrespectively of the=
 order
> in which the two drivers are initialized.

Well, there's another problem there - unless things changed since I last
looked we don't support shared threaded IRQs.

> So far I see only two solutions:
>   - Add platform code that matches against "renesas,koelsch" (and
>     "renesas,lager"), and mask the interrupts in both the da9210 and da90=
63.
>     This code has to run after the i2c master driver has been initialized,
>     but before the i2c slave drivers are initialized.
>   - Handle the masking in the bootloader (u-boot), which already knows ho=
w to
>     reset the board by kicking the da9063. This requires everybody to upg=
rade
>     his bootloader, though.

> Does anyone have a better solution?

We could try to make the code that masks interrupts on error handle
screaming shared interrupts a bit more gracefully during bootstrap by
shutting things up a bit more aggressively and retrying when something
else registers but that just feels like it's going to open up a
particularly messy rabbit hole. =20

Of the options you list above the platform code sounds the most
palatable.

> Question: Is it really the default state of the regulator to not mask
> any interrupts?
> Or could this have been changed by the bootloader? I couldn't find code r=
elated
> to that in U-Boot, but as I didn't compile the bootloader myself, I can't=
 be
> 100% certain about the source code.

It wouldn't surprise me, having talked with designers of analogue chips
they can at times have some innovative ideas about interaction with the
processor and interrupts in particular.  It's also possible that there's
some transient condition that occurs during startup that causes the
interrupts to be flagged.

--Q43QQdzFtqSKgsg+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU40icAAoJECTWi3JdVIfQaqMH/A+XEE0puUZvRgRzYukFQoCM
J0zLRFq2WaIMykXpVnZ7RZTB0vSG4OkWoEZFlydE/cUxq9HmffXkTUFh0JSxuu44
tLHw4crwegcQ/FvnaCIiENEKEkMc783Xw9TSUPC5pOGawXZVWhzAxcP4WP1vvStD
9H/MLVzm0G6F1e3S0+rDFbDgSPeGqfuWa6QfIXLAZEJqXRWauPvT+k+sYbU+bjql
XaJU/G2KizCCRom6b/U0LA0Hptsox/WmT+XelSMQi7DJJYJaXlMzOcjE5YdHaa/O
Zv05Q5rCgDQFQtMcEMl3uXnJX9mOaqGQSV6qGk6S70ZneJu6dqLSTR7dum+Karg=
=DxLE
-----END PGP SIGNATURE-----

--Q43QQdzFtqSKgsg+--
