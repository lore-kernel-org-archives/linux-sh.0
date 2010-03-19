From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 19 Mar 2010 05:23:44 +0000
Subject: Re: Trouble with embedding initial root fs into the kernel
Message-Id: <201003190623.45053.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161222.05067.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Ok I understand.
But now I'd like to test first as init the hello world program.
Do you use uclibc for userspace building applications?



In data venerd=EC 19 marzo 2010 05:58:25, Magnus Damm ha scritto:
: > On Fri, Mar 19, 2010 at 6:07 AM, Fabio Giovagnini
>=20
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Wher do I have to include the script creating the nodes?
>=20
> It depends on your user space setup.
>=20
> I'm using busybox with init enabled together with the following line
>=20
> in my /etc/inittab:
> ::sysinit:/etc/init.d/rcS
>=20
> The file /etc/init.d/rcS looks like this:
> #!/bin/sh
>=20
> # sysfs is mandatory
> mount -t sysfs none /sys
>=20
> # optional filesystem support
> mount -t proc none /proc
> mount -t tmpfs none /tmp
>=20
> # use tmpfs for /dev
> mount -t tmpfs -o sizedk,mode=0755 tmpfs /dev
>=20
> # optional /dev/pts filesystem support
> mkdir -p /dev/pts
> mount -t devpts none /dev/pts
>=20
> # setup mdev as hotplug handler
> if [ -f /proc/sys/kernel/hotplug ]; then
>   echo /sbin/mdev > /proc/sys/kernel/hotplug
> else
>   /sbin/sysctl -w kernel.hotplug=3D/sbin/mdev
> fi
>=20
> # udev replacement
> mdev -s
>=20
> # setup local network interface
> ifconfig lo 127.0.0.1 up
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
