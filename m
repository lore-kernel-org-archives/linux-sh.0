From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 27 Apr 2009 17:56:20 +0000
Subject: Re: [RFC][patch] filesystem: Vmufat filesystem, version 4
Message-Id: <200904271356.21684.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2305589.77ey5eX2D7"
List-Id: <linux-sh.vger.kernel.org>
References: <1239654768.6542.10.camel@localhost.localdomain> <20090424221455.GB5342@elf.ucw.cz>
In-Reply-To: <20090424221455.GB5342@elf.ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

--nextPart2305589.77ey5eX2D7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 April 2009 18:14:55 Pavel Machek wrote:
> On Mon 2009-04-13 21:32:48, Adrian McMenamin wrote:
> > --- /dev/null
> > +++ b/fs/vmufat/Kconfig
> > @@ -0,0 +1,14 @@
> > +config VMUFAT_FS
> > +	tristate "Dreamcast VMU FAT filesystem"
> > +	depends on BLOCK
> > +	help
> > +	  This implements the simple FAT type filesystem found on SEGA
> > +	  Dreamcast visual memory units.
> > +
> > +	  Dreamcast users who want to mount their VMUs to view the native
> > +	  filesystem will say 'Y' here. The filesystem is hardware independent
> > +	  but is not recommended for any serious use in other circumstances, =
so
> > +	  just about everyone else should say 'N'.
> > +
> > +	  To compile this as a module say 'M' here. The module will be called
> > +	  vmufat
>
> "vmufat.ko." ?

no, the standard is to name it without extension.  there should be a period=
=20
there though as it's the end of the sentence ...
=2Dmike

--nextPart2305589.77ey5eX2D7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJJ9fHFAAoJEEFjO5/oN/WBQPoQALWFu3NwPebakare1Sc/9Yvs
89SQrKXYtdFGgTiUj4iukaYg46XNzBHR8mN+oIQbJFnkA9GoyWZmpmEuFSsKVepD
sEIuP0035ncHfIo+oCzQ7zFnJoGh5vqNXQ5eJsUjV4RGVuOYs4l74P8FeAGPQZUu
wjzQqkACg/kiG8GzK1pgbp8W8uhacBIbWo7U3cX+TpXTT5g6DMw2TKfBxhIJ44CO
9G5L4ylVv3/wbV/1TFYoIG6/fhZSwIrCe/1afC46NzDlgLX9BHTLmXR1gqNnswGk
CxTpJhsHlmqFvxxowuv2XhRWLDBK9JX19q0wgIgNj7ZZUgnFgNG77OEGxhVIfXci
2cjq582f+gBYHIM6hy2ONLUo3Mm695fISiM927UXc+Fq9jGIIEFaiPKaTsFMAUoK
wmXWU10LjS55JoWSiXrfX2BARgxBGCr7vziLCw69VGSelMerIfmGmVbUkhKN2TTb
lH0l5ui8mLGIGyAxk6212KKGI/PoQWpJ6E78xK7ctbPwPcPgcrpdOc9HfNGs/C21
U+GWIbePMRLeDJzLPuQ+e/MjRstStnENJCuTLnUiOCXGbC5kmxEhU+uVb5zK+w10
XFjh/3YHnwX8gFNCnKMr2hPqdZKQASs2lJgvvAuuKE+XOBHp277O+uqX1OMkAmLA
Tf3K3TGyryPFKfdiNXxC
=j2r7
-----END PGP SIGNATURE-----

--nextPart2305589.77ey5eX2D7--
