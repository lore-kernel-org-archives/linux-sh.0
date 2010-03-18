From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 18 Mar 2010 21:07:32 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <201003182207.32323.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Wher do I have to include the script creating the nodes?=20

Thanks



In data marted=C3=AC 16 marzo 2010 13:04:54, Magnus Damm ha scritto:
: > 3. Modify your kernel configuration to point our your initramfs_data.cp=
io
>  file: CONFIG_INITRAMFS_SOURCE=3D"/path/to/your/stuff/initramfs_data.cpio"
>=20
> 4. Make sure you include a script that creates device nodes for you,
> or use udev or mdev.
>=20
> 5. I think /init is the first file that gets executed. I usually point
> it to /sbin/init from busybox.
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
