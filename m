From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Mar 2016 10:09:49 +0000
Subject: Re: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <20160317100949.GC1402@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WplhKdTI2c8ulnbP"
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > What about "renesas,rcar-gen2-rwdt" since Gen2 and Gen3 are identical?
>=20
> Are they? :-) Yes, at the datasheet level, FWIW...

OK.

> > But why "r8a7795-rwdt" with SoC first? Looking at the r8a7795.dtsi,
> > "<ip_core>-<soc_type>" seems to be more dominant than
> > "<soc_type>-<ip_core>"? Ah, confusing again...
>=20
> For new bindings, we follow practices set by the rest of the DT crowd.

OK.

> >> > +       if (!rate)
> >> > +               return -ENOENT;
> >>
> >> -EINVAL?
> >
> > Too generic.
>=20
> A clock with a zero rate doesn't mean that the clock doesn't exist.

Using different ERRNOs, you see immediately which error path was taken
and what you need to fix (without adding printouts to the driver because
you don't know which -EINVAL triggered). I consider this more helpful
than being pedantic on the error namings (since they are only reported
by the driver core and not exposed to userspace).

So, I don't wanna change this.


--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6oJtAAoJEBQN5MwUoCm2b2MQAJF9CbgktN1+6typCMoHQAU3
wDvsobbPr4oW5mxYj2NjJcO/9HBnxW7RrV5kchF1tosITs8wXYiWvfv1Jv2HZEck
xWXrVVsnZiBIlgWeHzvTGIVFvh9x5T19xkPBmZIiKI2a5v2L1LqjVaGHcZfIYb05
hfX1Ox+RXkFnmaJ1SD2KahS7IaIDH0zW/u65VMDkelBZOLfwHcy953hDhe92GcTm
R9zbzYTLqKRZyr5NmDNrhHV6l4Q00ePt2FcOfJbe7Y5V3wgaH5KhUdvwBAj8g1un
b8p4g9fCRUy68Y3U9ha51mgGkAnDUBIZ5PJDvg4xM/oD78PNQRzZ/pD583BWUJg1
SrPdl9YdcgZyYR7RqrDf9mq1lONAGL7i8BKGl7EML3XAjSTtdcAOBcmBKVS0icVm
wpyJsx+M9Y3MPF/FlqhzC4F+wMFIDRLl1u42aJT5NsRMWDjX7vu7GE1wUg3qVjl9
7dCygPRZtDG8nHjjNWhDOZDyJSzCST/Qs3la8xRtl3Nd5I7uKcQOkhccDlPsKis0
evvkqR+9S3weBjf63fj0L9ckx/qsvpYp9xFCyptLxqRkwjNHSQYVC6jWIAr8MMGE
dI66t7dMMxviRocm3U6o+ssYPLiqwTfogYGzNYxciicrbjLN8Xd/H6D7GLDJoY2W
sXaaT6OT8HbUouE1jGpI
=tqMA
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
