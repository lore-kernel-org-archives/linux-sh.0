From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 11:13:52 +0000
Subject: Re: [RFC 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <20150202111352.GB3311@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7ZAtKRhVyVSsbBD2"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-5-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +void __init rcar_gen2_wdt_rst_init(void)
> > +{
> > +#if defined(CONFIG_WATCHDOG)
> > +       void __iomem *p =3D ioremap_nocache(WDTRSTCR, 4);
> > +       BUG_ON(!p);
> > +       iowrite32(0xa55a0000, p);
>=20
> This is dangerous. If the xWDT was left running, the system will be
> restarted soon.

Agreed, that might be the case.

> I think clearing the xWDT reset mask should be handled in the WDT driver
> itself, when enabling the watchdog.

Yes, and masked again if WDT is disabled.

> It's slightly more complicated there, as we already have a driver for the
> SYSC on R-Mobile (rmobile-reset), and a device node can't be bound
> by both the syscon and the rmobile-reset driver.

Is it just complicated or is it an open issue how to handle that?

> Do you have a better idea?

Nope. I also thought that something like syscon must be used if the
initialization in arch-code won't work. Still, I tried first with the
least intrusive version :)


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz1vvAAoJEBQN5MwUoCm22JUP/ju5pfdRkfUnWMqpSSFiLVGd
2JJw4sW64pEcwBkGAML1puSn0yXCNNnNsaNk3GkWyQKd9oNHizY3Uy/nvdlOH3y7
nSLPz+7ah0RR/pJXiJhUaAtnsKzAvDHJQAa9UUYLIHdu5PVxqewpgC4Dj8UCw/dm
3WZfxv2IP94f1tmwJtpQza7A4gXP+IRv/QAtDtX4THQ++abotWVQVUBp1P78jYAT
zcGGJxd7CVbgGLR7BHmTRs3c3ckhA1dyt73lfNnxS8diRmzxM6VrqTeS5Mv1m9bE
5hEGfJRrER48XLMzdRM8OB45jGIM8yon8kJ48WuaLsdoArmJOe/oiMl2HC0jPz8u
4yJLI2SmxcEjHbP+QW5Gn/qwkeWWpiIXEIagnuzNv8aOOELjR31r2Rzo40zxUYUm
zGIKkP8oU4DJRS7ahzuZLcB8pk00BSmUkhJNxu8GdXkC3ZvGkRcjUqqXwRxvUCSg
TeFX2JzagnPi8N+Fe8dO19raSkdg2GmuYFcUog1Wz7V+88Im+wnBq0DlRYP7PWJK
Cu5ue24iW2j/HKH0sJlVx24NpTMMkpY3ISvRHmoY5/VuQBMFlmLHhyK1s4DZr2s2
Lc1HZUnzaua/SDFWHXNkaIQ90ZT+eKPGSXkuoJGKUWt/kFazBlmnRp3DXwqzhgos
x7UJsP3NQoK2gNKtEvW9
=nGzC
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
