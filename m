From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 09 Jan 2008 17:54:57 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <200801091254.57816.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1865793.1ZvvbKdVkD"
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart1865793.1ZvvbKdVkD
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 09 January 2008, Adrian McMenamin wrote:
> On Tue, 2008-01-08 at 19:38 -0500, Mike Frysinger wrote:
> > On Tuesday 08 January 2008, Adrian McMenamin wrote:
> > > On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:
> >
> > are you generating the device nodes by hand or relying on something else
> > ? mdev currently will not place the device nodes in a subdir as would be
> > required by alsa-lib.
>
> No, I'm using udev. The module loading stuff was not the issue I'm sure
> anyway. And the OSS emulation appears to work perfectly.

i'd just build everything into the kernel except for the module you're=20
developing ... a lot simpler that way

> > > Maybe something wrong with my driver, (though oss emulation works very
> > > well), but nobody is being very communicative. I don't think there is
> > > much cross compiling of alsa going on out there!
> >
> > are you using uClibc or glibc ?  we're cross-compiling alsa-lib for
> > Blackfin/uClibc and it seems to be working for us.  our drivers are
> > varying degrees of working, but that is a driver problem ;)
>
> uClibc. I suppose my issue might be driver related, but if so nobody can
> point me as to where. And, as I say, the OSS emulation works.
>
> Maybe you could point me to the configure script you are using?

make sure you turn off version stuff: --with-versioned=3Dno
=2Dmike

--nextPart1865793.1ZvvbKdVkD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHhQpxAAoJEEFjO5/oN/WBZo8P/ixdu5+/otpL+Wk50bqUYE4+
oS7F8af+DXrfWI6YuBHdb+qRFAq1da3lZPPhNp/hswokcfN7h8VqmXjqFROcH4hf
j8r+NfO18y8jCZVL2J++7hST/kcI8a2dMmAKyc54nslxu2Rp1BRQX0b0lqYO4N9d
n3y6ZdlZHNjECQUJb/sn+rdOfG4vksm+pW5pds2jqXjONLgFGOJnCeu9Cfj+YDch
m9VWF4ScKlEmuOCc8FGaRjh9zoHxF/NoKf6uIj31tALyThdiRfC3uGjtSPKFDg+O
Eoz7vvqJl4bAN6J+JHrDZ+Z0LSBjCtdzfiqusKe9qmhcsnhDdPtT2177nNy3/CIy
qtk4lheSPQQUbJXgz88Znq084Zb3CNXkgK+caBtWH9wSJ77qdMQ+ZxyMQJNsMkBw
jzALuX39UVsp1/LQrHxRiDVU6bfhfuyXi85oGWHHYSJadjRkR0i4aXDBb3mG9S0F
qr6U15GE9lpqOl9j8/VRcwjQmPSr0D9cOPKrLbetQnEl1PvhR4PgpLm0OSmE31yt
InlldTRi5Wq3IM7q7G8iAQin/suyEb34NSvuXmKHaMhWqlzYRAQC7206RrUPUeKt
SBizp6m5uTQuFNvtpKnETX/P24VZ0bhX7kNWkh6deOZna6FtfLoQdrV/G3LJypeV
IAirsQhsrscFRsYX9lMB
=v9R0
-----END PGP SIGNATURE-----

--nextPart1865793.1ZvvbKdVkD--
