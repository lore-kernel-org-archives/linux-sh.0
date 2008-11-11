From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 11 Nov 2008 10:27:10 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081111122700.79906a33.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__11_Nov_2008_12_27_00_+0100_nIZAVZhAHwts_4x0"
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
In-Reply-To: <20081111141335.3c869c26.yoshii.takashi@gmail.com>
To: yoshii.takashi@gmail.com
Cc: qemu-devel@nongnu.org, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Signature=_Tue__11_Nov_2008_12_27_00_+0100_nIZAVZhAHwts_4x0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Nov 2008 14:13:35 +0900
yoshii.takashi@gmail.com wrote:

> Hi,
> > My best guess is that id for whatever reason is tooo
> > high, but thats just my #1 attempt at qemu debugging.
> Yes, but wrong code is in hw/r2d.c. I should not have called mmio_ide_ini=
t()
> if no HDD image given. I fixed it but haven't posted the new one yet.
> My code is now like the following,
>     if ((i =3D drive_get_index(IF_IDE, 0, 0)) !=3D -1)
>         mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
>                      drives_table[i].bdrv, NULL);
> # I think these mails should go to qemu ML, though.
> /yoshii

I'm still getting segmentation fault at exact same
location. Have you made additional patches?


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Tue__11_Nov_2008_12_27_00_+0100_nIZAVZhAHwts_4x0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkZbAQACgkQPQls10ERAGfhBgCgqLy+bk5s76xUvlZEmExVz+Ks
iDMAoNKcEQ867v92hhUK6YRI9/HKlGCA
=Bbgh
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Nov_2008_12_27_00_+0100_nIZAVZhAHwts_4x0--
