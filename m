From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 20 Mar 2015 07:15:04 +0000
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Message-Id: <20150320071504.GA906@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
 <20150319201751.GZ10068@pengutronix.de>
In-Reply-To: <20150319201751.GZ10068@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2015 at 09:17:51PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Thu, Mar 12, 2015 at 01:42:01PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > After more discussion, brave users, and additional datasheet evaluation,
> > some API updates for the new I2C slave framework became imminent. The
> > slave events now get some easier to understand naming. Also, the event
> > handling has been simplified to only send one event per interrupt.
> what is an interrupt here? An event where the bus driver needs feedback
> from the backend?

More the other way around: when the bus driver needs to notify the
backend. I wasn't 100% sure about the word 'interrupt', but then decided
a HW slave support without interrupts would be so rare and adventurous
that it is okay to use the term :)

> Other than that the patch looks fine. Thanks for working on my feedback!
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks,

   Wolfram


--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC8j4AAoJEBQN5MwUoCm29rIQAKWYF/7gKcz9tb5ZB+6qhHP5
vrLs0pf9iAQF6V1BMKYln5HIe7bOgamSNYNzEXA5XxU5MvmM18y/gf7pHu9LIwGm
HWduCHPUDhqZF2ZYuwtz5BoIp5+sKVateGBYgsYZ5OTZh2rI1Sq67L8RMiM/FBWO
5f+VPM3biq4mCFAhKWKyKQZZE2qFeuqDysjlXtxO+JNN2B5FUiu3LsXO9MWBKub6
imPWYnCqTJBCUGb72FGfJRtg5r6NEtArfFVCqJpSrbDvPfS7NqPB4604MYUUhOsp
5HrHBf3FUPP2z2AJKlkOCoBEWW+IYDbDyN3WcYhDLuGrCW6F1oH8ZhptHaR7ACPH
nW14CPokG3qEcIxyLME3DDIbjUn87UQmom90i70WnKl3h7iGmbmjpf23hNOpYlgK
m4BR+C1CQKiUhhL/aFYfoK8HwQfS7V/mfrWP8+lQO+SVCrR6eoFEL+a4d0R+S8Ag
e9DHYdMRtViPXYvhTnGGIYXvcpdxj3vvQrcMOMOc1vwmQtEJIBWL2YuORkk7o+nl
G4IsgyS5nej5IWSSUdF9n3hYQ6GbC/1otIPQgcB++/scH481a0CVJ6MS5z+ns9bl
gcKpikwYewKoiuNyxhOJH3f7MV33bCb1xP+jmTAFI/DqgpVNPxpbUuEDv1ZoIWD5
7xX/p9gwdRHH54SWOKXd
=qHh1
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
