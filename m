From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 05 Jan 2008 01:24:59 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <200801042025.00435.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1690911.jtT1zqyxs9"
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart1690911.jtT1zqyxs9
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 04 January 2008, Adrian McMenamin wrote:
> I am struggling to get alsa (userland) to work on my Dreamcast - the
> kernel side works nicely when using oss emulation but I cannot get the
> pure alsa stuff - which relies on the alsa-lib - to work at all.
>
> I *think* this is due to not being able to configure the modules
> automatically and I cannot figureout any way to get Busybox to do this -
> eg neither /etc/modules or /etc/modules.conf appear to be handled.
>
> I suppose I could hack the init in some way to fix this, but I wonder if
> someone here has had this problem and knows how to get round it?

it isnt busybox's job to load modules automatically and thus there is nothi=
ng=20
in there for it.  then again, i dont see why it would matter ... just do=20
`modprobe <the alsa driver>` and there's nothing else to be done.
=2Dmike

--nextPart1690911.jtT1zqyxs9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHftxsAAoJEEFjO5/oN/WB0F8P/3eWjGkVezKucnd0d0tsFy2k
P1agT0PIoYxC+p5lGR6KPAhIbUG6n+cO/Ampoq361ke8H/uPwC7Ad9eRBRHHAzQU
V1ycqQwLNOGae3/yOOzEGVQU0sDwVN1Uv3Yr3LFoK0w14lysqz4YRxzmv8xzpu/q
ZDhBZuk3fkMvtTzVVmPATGomwuNX/5L6Xh5k3O8L9Bc/wEV/MA0QD6WNgoRf3Xjw
/fwp3IgyBj2cMuNzuaSo2wojY9eF/X7IUFNcFzjWhG3+PBHjGr6VO3tDiM36K6D0
K8mVtLOdrV7k8zAMLM1r7l72ufnKUY8WlGHFHz/CoOld7Z3P6wyOEOPLL/0rKPQV
Ullir7dWgIA9sGYgEqv6skzTa2aJLzL8exLx1UNBZxecqf5DpESW8HsiczY4JyyH
fcwLU3J3l75NX7v+uD0uLSpxLNZRV6ca55PSrVCOtH+Ufx/YAwbZ2vz0r00P7TdF
mFTqK2r59GUIyqEVUjKruKj1V/bm3uys3dXxKEJ/6mB9fKhO03qiEaT5gp+dQE3q
Bips5nrDcssza004cd1NomHM9D4V4Hnz/kjhuY0KZZZ6sntmt6u563eDCikNdDf6
1AuiBND72cyLvjDuZeU9LlLEIjyjr1JrqhtMC3lQwGKxKz0S8mJwotoZvFw1yJH0
N3XBTzoaiIVlA+OO4gSU
=jHxr
-----END PGP SIGNATURE-----

--nextPart1690911.jtT1zqyxs9--
