From: Pierre Ossman <drzeus@drzeus.cx>
Date: Sat, 19 Jul 2008 12:02:05 +0000
Subject: Re: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <20080719140205.05eac25e@mjolnir.drzeus.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_freyr.drzeus.cx-30376-1216468930-0001-2"
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-30376-1216468930-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 19 Jul 2008 09:04:09 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> Pierre Ossman wrote:
> >=20
> > Seems more likely that this flag should be set on any stop command.
>=20
> There are other stop commands?

In theory. :)

I don't think there's any (publicly at least) defined stop command
besides CMD12, but the MMC layer has been designed on the assumption
that any future unbounded transfers will follow the same principle
(which would seem reasonable as that's how the hardware is built).

--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-30376-1216468930-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiB18AACgkQ7b8eESbyJLgy9QCeJPw9E30JjhzcpNT2+XO3RlRO
DXwAoN4n9E+O+P7zx8IKaUHSvYPVyjML
=Oekq
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-30376-1216468930-0001-2--
