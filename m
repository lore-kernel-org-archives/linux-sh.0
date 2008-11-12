From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 12 Nov 2008 09:55:51 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081112115608.af656fee.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Wed__12_Nov_2008_11_56_08_+0100_0NGAzQGS3_Mh1_X."
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
	<20081111122700.79906a33.kristoffer.ericson@gmail.com>
	<20081112133313.967c82e2.yoshii.takashi@gmail.com>
In-Reply-To: <20081112133313.967c82e2.yoshii.takashi@gmail.com>
To: yoshii.takashi@gmail.com
Cc: qemu-devel@nongnu.org, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

--Signature=_Wed__12_Nov_2008_11_56_08_+0100_0NGAzQGS3_Mh1_X.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2008 13:33:13 +0900
yoshii.takashi@gmail.com wrote:

> Hi,
>=20
> > I'm still getting segmentation fault at exact same
> > location. Have you made additional patches?
> Please find attached file "qemu081111.diff".
> Basically, this is an aggregate of patches found on qemu-devel ML,
>  with some conflicts against current svn source being resolved,
>  and some small fix are added, which are scheduled to be posted after
>  I finished with my pending patches.
>=20
> I post this to share information between qemu and linux/sh people,
>  and hopefully accelerate debugging with linux people's help.
>=20

I will give it a try later today. Big thx!

> Another file "linuxconfig_r2d_qemu.diff" is diff for linux kernel
>  configuretion. It changes following parameters from r2d+'s defconfig.
> - Cache -> off (qemu has no cache)
> - commandline change (for debugging)
> - 8139too -> 8139cp (qemu's default is c+, still thinking how to switch)
> - SH SPI -> off (sci emulation is not mature enough to handle it)
>=20
> Build procedure is as follows,
> Configure kernel:
>  make ARCH=3Dsh rts7751r2dplus_defconfig
>  patch .config < linuxconfig_r2d_qemu.diff
>  (and build)
>=20
> Configure Qemu:
>  ./configure --disable-system --target-list=3Dsh4-softmmu \
>   --disable-linux-user --disable-kqemu
>=20
> Execute:
>  sh4-softmmu/qemu-system-sh4 -M r2d --serial vc --serial /dev/tty \
>   --kernel zImage --append "console=3Dtty0 root=3D/dev/sda" \
>   -usb --usbdevice keyboard --usbdevice mouse disk.img
>=20
> I've tested it on qemu svn head this morning.
> You will see penguin logo, and fbcon input/output working.
> For debugging purpose, console=3DttySC0,115200 might help.
> /yoshii
>=20


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Wed__12_Nov_2008_11_56_08_+0100_0NGAzQGS3_Mh1_X.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkatkgACgkQPQls10ERAGci7wCfTRDRup1Bz2C7cOpcN0CiVMyv
Gz8AoJsewr192puvDFmgNJRovqUkhdpr
=Xjwe
-----END PGP SIGNATURE-----

--Signature=_Wed__12_Nov_2008_11_56_08_+0100_0NGAzQGS3_Mh1_X.--
