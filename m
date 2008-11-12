From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 12 Nov 2008 18:41:17 +0000
Subject: SH4 kernel and diskimage
Message-Id: <20081112204128.a15c8d3a.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__12_Nov_2008_20_41_28_+0100_g.MTc=fL9gGjmN74"
List-Id: <linux-sh.vger.kernel.org>
To: yoshii.takashi@gmail.com, lethal@linux-sh.org
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Signature=_Wed__12_Nov_2008_20_41_28_+0100_g.MTc=fL9gGjmN74
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

After applying your patches and some time
spent fiddling with image file it actually works
nicely.

I'm using current linux-2.6.git (vanilla v2.6.27 didn't work).
And an image I created based on the minimal image from
jlime (sh3 based). I can bootup and logon just like on my=20
jornada with no apparent problems.

I get the IRQ_NOBODY_CARED error at bootup and
the keyboard is overly sensitive otherwise it's
fine.

I've put the disk and kernel image here:
http://jlime.com/downloads/development/qemu/sh4-7751-qemu.zImage
http://jlime.com/downloads/development/qemu/disk_small.img

user=3Droot, password (just press enter).

--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Wed__12_Nov_2008_20_41_28_+0100_g.MTc=fL9gGjmN74
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkbMWgACgkQPQls10ERAGebJQCgux5E2OYR0RqixRIXX9/Ny1yt
xXAAoOU7TKd5BRT7XBrMlVQg2sxBrogn
=qqIf
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Nov_2008_20_41_28_+0100_g.MTc=fL9gGjmN74--
