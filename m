From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 17 Mar 2010 08:43:29 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <201003170943.29907.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I have downloaded the sourceryg++-4.4-46-sh-linux-gnu.bin
I received an email telling me that the evaluation copy will expire in apri=
l.
I'll lose the available support or the toolchail will stop to work?

This is the first time for me with codesurgery

Thanks a lot




In data mercoled=EC 17 marzo 2010 07:41:59, Magnus Damm ha scritto:
: > Hi Fabio,
>=20
> On Wed, Mar 17, 2010 at 3:15 PM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > I'm tring to build the new 2.6-git kernel
> > I'm using gcc-3.4.6 based toolchain;
>=20
> For the kernel please use the latest codesourcery toolchain. Actually,
> in general, please try the latest version of any software before you
> report any issues.
>=20
> > Which toolchian I have to use?
>=20
> For sh2a user space I'm not sure.
>=20
> The kernel builds just fine for me:
>=20
> damm@t400s ~/kernel/sh-2.6 $ _gcc --version
> sh-linux-gnu-gcc (Sourcery G++ Lite 4.4-45) 4.4.1
> Copyright (C) 2009 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>=20
> damm@t400s ~/kernel/sh-2.6 $ make -j 3 ARCH=3Dsh CROSS_COMPILE=3D_
>  rsk7203_defconfig [snip]
> damm@t400s ~/kernel/sh-2.6 $ make -j 3 ARCH=3Dsh CROSS_COMPILE=3D_ uImage
> [snip]
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   OBJCOPY arch/sh/boot/vmlinux.bin
>   GZIP    arch/sh/boot/vmlinux.bin.gz
>   UIMAGE  arch/sh/boot/uImage.gz
> Image Name:   Linux-2.6.34-rc1
> Created:      Wed Mar 17 15:31:35 2010
> Image Type:   SuperH Linux Kernel Image (gzip compressed)
> Data Size:    1362130 Bytes =3D 1330.21 kB =3D 1.30 MB
> Load Address: 0c001000
> Entry Point:  0c002000
>   Image arch/sh/boot/uImage is ready
> damm@t400s ~/kernel/sh-2.6 $
>=20
> Cheers,
>=20
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
