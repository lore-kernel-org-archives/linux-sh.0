From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 10 Jan 2016 08:40:48 +0000
Subject: Re: [PATCH 1/2] dt-bindings: move I2C eeprom descriptions to the proper file
Message-Id: <20160110084048.GF1526@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="TeJTyD9hb8KJN2Jy"
List-Id: <linux-sh.vger.kernel.org>
References: <1452199860-3601-1-git-send-email-wsa@the-dreams.de>
 <1452199860-3601-2-git-send-email-wsa@the-dreams.de>
 <20160107230012.GA15023@rob-hp-laptop>
In-Reply-To: <20160107230012.GA15023@rob-hp-laptop>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 07, 2016 at 05:00:12PM -0600, Rob Herring wrote:
> On Thu, Jan 07, 2016 at 09:50:59PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > EEPROMs can have additional properties, so they are not suitable for
> > trivial-devices.txt. Move most bindings to the designated eeprom.txt.
> > Add the missing "atmel,24c08" while doing that. Note that the remaining
> > ones in trivial-devices need to be dealt with seperately because of
>=20
> s/seperately/separately/
>=20
> > improper manufacturer names.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> >  Documentation/devicetree/bindings/eeprom/eeprom.txt   | 19 +++++++++++=
+++-----
> >  .../devicetree/bindings/i2c/trivial-devices.txt       | 13 -----------=
--
> >  2 files changed, 14 insertions(+), 18 deletions(-)
>=20
> Acked-by: Rob Herring <robh@kernel.org>
>=20
> Fine to take these thru your tree.

Fixed the typo and applied both to for-next, thanks for the acks, Rob!



--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhkQAAoJEBQN5MwUoCm26QkP/AmgYxmdorHzH0jKJiBg81Rr
Fq8k/lu+YvNywMIH/59+8dkQ6WyE+5Zp6SlaH5/89EQM9Ty7TtU2JNXoCmNO8+fq
3Hqlidi1fom+iisOSwOZHblEH0wNnj9WZMLZAWhrJdvNHr0U9javbkUiS5u/m8pK
+qmJKvTIrnUGqlBGnHn8CLQ8LB/SSdVUNL3jBaLIwS41V8PLMD2G8XoCl1GHtRY5
gi5T+OTtqC1F1qhnODMtnvSatWhMSVa+2vBIYdb7B5r693rJmpMVfpEG02iOUd4p
9Kramo48EJ+x6w6wENn1F/6xIjyDtyYkS4tTv28C2wsOqEBir6gjRfqUCtNhmKYQ
s5LLw2NguWz16Ld9xhsf8QN4mykdj8ntvrNVznWJm0kyEVh+ajfUBPrSXDnQxx0I
l+ar0M9s09DB66N45FGwP8/rGY/dFxbJ1R8AQcgZKcM40R2aLsAL6d6g7HrwT5YY
+SiwCVCUt+RtLBfJPoqobKf8r73xpK2iozokbMHL/s0GtiHJue95Vhm3rQmLgzwc
OaopQ8rjkuyCiliuXoxEMKEHYoaqVFZz5uSuociMAUxRj1zZVNjK6k4xPk+P3zx9
qWQgKfc0lU5vxas6/L1idknn9N6/zZ8nbUTSDhasfFG8FQyE2FJURZNVESKYFzNW
RomPI6Q0S50ZdXZKQxy5
=4RbI
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
