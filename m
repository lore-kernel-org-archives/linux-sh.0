From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sat, 08 Nov 2008 19:42:38 +0000
Subject: Re: Concerning Qemu SH4
Message-Id: <20081108214256.e777070b.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sat__8_Nov_2008_21_42_56_+0100_M/WQy0RCay.BIvG2"
List-Id: <linux-sh.vger.kernel.org>
References: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
In-Reply-To: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Sat__8_Nov_2008_21_42_56_+0100_M/WQy0RCay.BIvG2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Still getting segmentation fault, so I'm missing something. Either I've rew=
ritten
the patch incorrectly or it's been broken upstreams.

On Sun, 9 Nov 2008 00:28:35 +0900 (JST)
takasi-y@ops.dti.ne.jp wrote:

> Hi,
>=20
> > Oki, gotten it to work now. Whats left is putting some sort=20
> > of harddrive file there. I've created an loop file but
> > can't seem to get it going.
> Have you applied all patches on ML?
> Otherwise it doesn't support hard disk.
> QEMU repository is being maintained very slowly.
> There always many patches left on ML waiting for being merged.
>=20
> Now, following patches are pending.
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg00970.html
>  This must be applied. Otherwise it will be crashed frequently.
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01246.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01247.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01248.html
>  These three are needed use to use HDD.
> http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00118.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00119.html
>  These two are needed to use network.
>=20
> Some of them can't be applied cleanly, because other patch has been
>  applied after I posted them. Please edit them manually.
>=20
> > I'm also missing something with the initrd as it
> > constantly claims that the initrd expands beyond
> > the memory boundry.
> Current code doesn't support --initrd nor --append.
> Only --kernel works. Use initramfs and initial command line.
>=20
> /yoshii


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Sat__8_Nov_2008_21_42_56_+0100_M/WQy0RCay.BIvG2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkV+dAACgkQPQls10ERAGeqAQCfXt98z36mrvoD7UH8qB2cJBzo
ftYAoMyJqe8z6GgjU/HYwSCJeeEJbQKf
=3bom
-----END PGP SIGNATURE-----

--Signature=_Sat__8_Nov_2008_21_42_56_+0100_M/WQy0RCay.BIvG2--
