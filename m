From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Dec 2015 10:59:00 +0000
Subject: Re: [RFC 5/9] i2c: rcar: honor additional i2c timings from DT
Message-Id: <20151203105900.GC1545@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E13BgyNx05feLLmH"
List-Id: <linux-sh.vger.kernel.org>
References: <1448578757-12613-1-git-send-email-wsa@the-dreams.de>
 <1448578757-12613-6-git-send-email-wsa@the-dreams.de>
 <CAMuHMdU1fWjH2Lv00W2uxRW7-XGp1YaEoA4Ftq5o6yk6WamCBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU1fWjH2Lv00W2uxRW7-XGp1YaEoA4Ftq5o6yk6WamCBQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > -       round =3D (ick + 500000) / 1000000 * 285;
> > +       sum =3D t->scl_fall_ns + t->scl_rise_ns + t->scl_int_delay_ns;
> > +       round =3D (ick + 500000) / 1000000 * sum;
>=20
> If you're sure it cannot overflow, doing the "* sum" before the division
> improves accuracy.

Thanks for the input. In this patch, however, I intentionally did not
change the formula but only replaced the constants with the now user
supplied values. Everything else should be a separate patch IMO.


--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWYCB0AAoJEBQN5MwUoCm2OmMP/ixyleN7YiG/VR8YM0b6fCrs
goF09EwDh/QR7ylG0S4AVY4VHeZWM7djiei86VuxRjH86LmwU5RhiyklcRNrrtKV
OpnDRbPn3CcZDG6xev1FY8A7tvQFI6NT11ZEliVibuWPFd+7CcY3ZDuMEUAgGyt6
FGnR1lLo91umSmqIyTss9G0EypJyKu9A/aFxGoWYaa6EzsZlNEHtRCndeyK2lGQl
RqtSsjgOBxs4WTe0nbFm+0nmW6HAb3oOxuV86egCnZlRfaT4acLzlP1jaTHZm+4i
67SbTmqKT40Z31CfpQljjCeb4jiQkpVXzUcWLGT5Oq0LvAJ1uQ0Qb63tgQfO99XD
TwWLjMPCE12SKXQfu9JOLqP2d3aRW5IflGAOvr6gq3CsfdTcvB56YN1meD/n4D84
5phhHym2GqVW45VihDe1r6xBRD6TmmnCNPd6+JucXXhfTJRoWEZvq/HZ9aeCWQjS
hl49LSIinUCDABUWq1SAx9n3fVS26DOSXDgLeby0Ta2cbmweTjXFfw/9S3dBXF9a
PU85o1Ct3ujZW3b3pwC519lErPBwmAfZmApRStdAD1v1xlcb8uv9WXS1uPlbu/42
2YE+O9HUMSI7xdhMqevPSD/RhSfX1H07d3kmJ599rV2UUB43uUVcB9QiyHQ9yiLI
zvA9BeeTWCzZvnRrU23U
=s73a
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
