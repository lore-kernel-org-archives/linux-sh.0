From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 01 Mar 2016 13:49:45 +0000
Subject: Re: [RFC v4 0/4] watchdog: add driver for RWDT watchdog
Message-Id: <20160301134945.GB1514@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CdrF4e02JqNVZeln"
List-Id: <linux-sh.vger.kernel.org>
References: <1452287553-18895-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452287553-18895-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> I tested this on Lager with my hacky patches enabling RWDT in UP mode.=
 For this
> >> series, I picked and updated the integration patches for Gen3 from the=
 BSP.
> >> Note that this driver also needs a RESET module driver to work on Gen3=
=2E Since
> >> we don't have that yet (couldn't even find it in the BSP), it is untes=
ted on
> >> Gen3. Since it works on Gen2 and the datasheet doesn't specify any dif=
ference,
> >> my proposal would be that I mark this task as done and leave the integ=
ration
> >> with the reset module to the core group. If any problems with this dri=
ver show
> >> up, I'll be there, of course. Would that be okay with the core group?
> >
> > Just wondering: can't you test it on Gen3 the same way as on Gen2?
> > Or does the firmware interfere?
>=20
> Have you tried this on Gen3?

I tried clearing the bit in WDTRSTCR like with Gen2, but without success
:( I heard that Ben Dooks tried as well and did not succeed. I was
hoping that the new BSP might bring some light into this since they
patched my RWDT driver, so I assume they got it to work.


--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW1Z35AAoJEBQN5MwUoCm2lmkQAI5yb/H3qMJTfyspSCE0tQ6C
BM/e4e/E8ipF1ZyPprcl6CxM83XM4qtQlJdt3RIovqzpM+odTCZZm3xEK7SYQ8t5
+a8OUTyZoWndqCbsxMS06mj8ih8e4Y2sOm2cnYyHPZnKDcO4F2LFiVKwqrvdZOOu
gE2FTMvAlNIxzSzbDmFWeriOOCWphGwbb1dmOL9VkdwBPx1PWo0tSTLfkSGvuXz3
8GLMkwjoLyU1et2LKZ+8w7K4QM8wCEAz2icFkyh8dXT4ISjF6IzIxSlr8dhy3deZ
DKXRlR0lv3Mk0EiQDax+ZCxrzz8cSgIRjqjBZkgKdFNh3Go71lz28KK4I/xAcRt0
DzKsDOdeDsIjbZ9bPPZZfWiGBow/sgra0uHI3Vp+s4On9TIXydCMmWD2Io39hM9n
O9w70V2Lk8nBmnRWspH7SdqeHYB6t0Xv+XIjJ8TVe+M6baITegbQD1k+z8PEOFXt
CXBA+mJjhdYW7kj2lj15g5BT3pohqZEhxbjmwEetsYGNSpxT2ajkGpcBriCXI5nv
qjkhVIr8hBeGGZx9SsLmaUkmk0CPn4MnqdyJd9iDo7Q0pEU7oZT/2JD4KfTIJ24B
7uG/C5KOT1cs7Y+ahMqG/1ZxYsYA0Tdm1IfYie18lQrLtt6I6xEJ29Ym4u1dENrY
FKnLJlTsdgow6CH3GC7b
=gzeK
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
