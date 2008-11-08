From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sat, 08 Nov 2008 00:01:48 +0000
Subject: Concerning Qemu SH4
Message-Id: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sat__8_Nov_2008_02_02_02_+0100_J_9DD7406cl+8MmY"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Sat__8_Nov_2008_02_02_02_+0100_J_9DD7406cl+8MmY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

Oki, gotten it to work now. Whats left is putting some sort=20
of harddrive file there. I've created an loop file but
can't seem to get it going.
As any sh kernel it uses scsi emulation (hda->sda) while
qemu expects harddrives on hda/b/c.

I'm also missing something with the initrd as it
constantly claims that the initrd expands beyond
the memory boundry.

--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Sat__8_Nov_2008_02_02_02_+0100_J_9DD7406cl+8MmY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkU5QoACgkQPQls10ERAGeUvACeOhv64m9ftl3PIf+mBCiLakk1
7GMAoNe+gd2REUeq6PrwuPBeubZCYHCT
=Czfj
-----END PGP SIGNATURE-----

--Signature=_Sat__8_Nov_2008_02_02_02_+0100_J_9DD7406cl+8MmY--
