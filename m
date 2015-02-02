From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 11:24:42 +0000
Subject: Re: [RFC 0/5] r8a7790: lager: add support for RCLK watchdog
Message-Id: <20150202112442.GC3311@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="z4+8/lEcDcG5Ke9S"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Geert,

> Thanks for your series!

And thanks for your input!

> no avail. Hence I went with the DA9063 instead. Note that I plan to look =
into
> the DA9063 interrupt storm issue soon.

Cool.

> I've just tried your series on Koelsch, and it suffers from the same prob=
lem.
> Does it work on Lager for both CONFIG_SMP=3Dy and CONFIG_SMP=3Dn?

I didn't. And what a surprise, it fails with SMP=3Dy :( I'll having a
look...

> From the limited information available about the SWDT, it may be compatib=
le
> with the RWDT. Or not. U-Boot disables both the RWDT and the SWDT on star=
tup,
> using identical operations.

Well, the block diagram looks the same, the register layout in U-Boot
looks the same. And the bits I use are easy to be verified once I know
the IP core is there. Good enough, I'd say. And maybe we get
confirmation from the HW team via Morimoto-san.

> The RWDT exists on various shmobile SoCs.
> From digging into the datasheets, I had discovered two variants:
>   1. 32-bit registers
>        a. R-Car Gen2: using RST for restarting
>        b. R-Mobile APE6: using SYSC for restarting

Those should be handled with this driver.

>   2. 8-bit registers (SH-Mobile AP4/AG5, R-Mobile A1)
>=20
> The differences are small: the variant with 8-bit registers has a smaller
> maximum timeout, and no magic value to be stored in the upper bits.

Do they also have 32kHz as input clock? Then they do need a ping every
8ms! Those should use the shwdt driver then which pings the device
frequently and runs a software watchdog on top to cope with the usual
watchdog granularity which is in the second range.

Thanks,

   Wolfram


--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz156AAoJEBQN5MwUoCm24B4P/ApKuba82Ex2PdxCveLMx8cD
jJViYfgTucFb22vjgZ6dNuOjqa/WapPa6r4mz5f1nlDglsUv9kOvtiwMJdSmw7KO
+onu1PGJgUFrWr0URY/O3sZEavkge9nDczw4nNPR1rPRgvDIOZVauunkfJqnBVN8
XsWwgmmWQjsujfkzoCO5xwKOBFj+664bV1LASGFppHUnTlMrJ1vz2+UFJspuNvq5
mI7fcNLcQosu7tAt4CdxgGrsM3h89ffZJUd4WzibmOU2QRtSJr/OKYitrij8jMsc
O5wI3ZCSC/CM9yR3q4qZ4pm5qOx0FYtoXkUwoiXjAm1NHBuhICHGea51fje1qvvq
xh8bLdv1CLQSpWmouJE7v8dSv9Z+Y+GLO3McnnBD6unhUJN6zpLfhLdMEU/R8Yk4
YpKLbm0IYmx9EdSAFoOyIPr9zGRr9wxgiS+Gxae6YIPker8lftHTEFVNJzsL+RrX
omT2fFRGNPpq3CDcHrU3jVNkvsEAebB+WWWyL95PBPxvfv1nOv9lt6S67Fpevi/L
kD6WqVYkxkgWUivT2FW8upYtRxUAwEtIOEIWHwtzRlta+WguAjd42f1kdYjxf5Km
7gHbiRL49/vf+NCXv/KImZ0Wz1sfi+jLRrcLrSZhk7vtRvSK+GfLpJOrIU3TmlxO
k2Fc9UYeZRLnTDtUD3Tj
=muSy
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
