From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 14 Jul 2015 11:18:58 +0000
Subject: Re: [PATCH v2 0/5] enable I2C on Renesas EMEV2 and KZM9D board
Message-Id: <20150714111857.GC1517@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
List-Id: <linux-sh.vger.kernel.org>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ian Molton <ian.molton@codethink.co.uk>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 11, 2015 at 09:46:21AM +0200, Wolfram Sang wrote:
> So, I picked up the old series from Ian and reworked it significantly. Wh=
ile
> his series was already an improvement from the driver found in the BSP, i=
t was
> still not ready for upstream. It should be now :) My idea was to start si=
mple
> and improve incrementally, so e.g. clock handling was broken, so clocks a=
re
> always on for starters. Major changes include:
>=20
> * clock handling simplified and adapted to current EMEV clock handling
> * switch from wait_event to completion mechanism. The old one was basical=
ly
>   some kind of completion with custom code around wait_events
> * dropped using signals; they always cause trouble with I2C
> * simplified the bus free logic. If it turns out to be too simple, we'd n=
eed
>   to switch to the bus_recovery infrastructure probably. But we'd need a =
test
>   case for that
> * error handling improved to match subsystem standards
> * removed some BSP angst code
> * lots of refactoring to make code simpler, more readable...
> * bugfixes
>=20
> I also added all the glue code to add clocks, disable reset etc which was
> missing before. I'd prefer to take the first three patches via i2c myself,
> and the latter two via Simon's tree.
>=20
> Since V1, there are minor updates fixing issues found in reviews. Thanks!
>=20
> A branch for testing can be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/emma-=
i2c
>=20
> Please test, comment...
>=20
> Thanks!
>=20
>    Wolfram
>=20
> Wolfram Sang (5):
>   clk: shmobile: emev2: deassert reset for IIC0/1
>   i2c: emev2: add binding documentation
>   i2c: emev2: add driver

Those patches applied to for-next...


>   ARM: shmobile: emev2: add IIC cores to dtsi
>   ARM: shmobile: emev2: kzm9d: enable IIC busses

=2E.. so Simon, you can pick up these, I'd say.

Thanks,

   Wolfram


--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPAhAAoJEBQN5MwUoCm2Fv8P/i8eAl9eqjGeprEKdmKed15U
8vY0wlX59G+wMj0w81fanOgwbIpiQWJUZ7lcgFZG6kY98ZnBbzjzkFrN5zTFQmKo
z8h5Pn0bCykFPH0sYDFNeGieCfnyYtzpurY3NvhaI5YM8CElRey0RhIbBNC2tsKV
5Pzy/DWrgMAZto6QB04yEMA7HIvu41UeLh45Z9guGEOqF9TuMBcq6rk8clgyxkP/
1SSKyVOQO2f/wAP8+0tLGT4Sm/l9cPFi9vuPplnygxkWcAZ8H43PkKQyV1pAz57k
+owRPI6T/K/LVqkw3GmYeyM5c4ZnEdPobitQt9+OmdZ0l8aAD6zDMihY6/IM/6w7
Zs15V9CfsvGDOE3L69D3J94ymBd5KdLPUE9sw0wNisv9c908U/bPFo7cylDaaF/O
98xtElFAxhZ0WCL8kl+CYEFIljGphr4tgrZda/ZOalvwN7gbnjM2oypO9hhXd7L+
I/a7F5PEHkYCiW4K4vMngVf5J4oqKWO9RuVixTDyraFWQLrmAZrLteJw+827Leuk
7WbRwmULMvd69TzrZMvBy3ZcUPjJ7+JHICCTMEYncGgv+JVciBIkege4QrSSuFPF
NZnsRgKEvai+Qgq5x5Rjf8XkN36zHBicS8fDEqlPNTgeZwZvnktZnwkxytyn5iC/
TC0CJCcQ0ZAZwGWmgYvm
=vU41
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
