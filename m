From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 09 Jan 2008 00:38:02 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <200801081938.02872.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1857243.bSXeMAMWjj"
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
To: linux-sh@vger.kernel.org

--nextPart1857243.bSXeMAMWjj
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 08 January 2008, Adrian McMenamin wrote:
> On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:
> > On Friday 04 January 2008, Adrian McMenamin wrote:
> > > I am struggling to get alsa (userland) to work on my Dreamcast - the
> > > kernel side works nicely when using oss emulation but I cannot get the
> > > pure alsa stuff - which relies on the alsa-lib - to work at all.
> > >
> > > I *think* this is due to not being able to configure the modules
> > > automatically and I cannot figureout any way to get Busybox to do this
> > > - eg neither /etc/modules or /etc/modules.conf appear to be handled.
> > >
> > > I suppose I could hack the init in some way to fix this, but I wonder
> > > if someone here has had this problem and knows how to get round it?
> >
> > you still having troubles with the userspace alsa stuff ?
>
> Yes. I think I've more or less convinced people I am building the thing
> properly now, but it still won't work as alsa.

are you generating the device nodes by hand or relying on something else ? =
=20
mdev currently will not place the device nodes in a subdir as would be=20
required by alsa-lib.

> Maybe something wrong with my driver, (though oss emulation works very
> well), but nobody is being very communicative. I don't think there is
> much cross compiling of alsa going on out there!

are you using uClibc or glibc ?  we're cross-compiling alsa-lib for=20
Blackfin/uClibc and it seems to be working for us.  our drivers are varying=
=20
degrees of working, but that is a driver problem ;)

> I could try to debug alsa-lib but even its creators admit it's pretty
> hard to digest.

so it is
=2Dmike

--nextPart1857243.bSXeMAMWjj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.8 (GNU/Linux)

iQIcBAABAgAGBQJHhBdqAAoJEEFjO5/oN/WBXoUP/RsRDqJAN9ggK7AYIGPBjGah
c6sCd1zWSDvHX2RK+8Wb1BWgRcZMDLpRiWx48/sjcuvT8GbaLCjWs1qGQxr8gyMc
U5kvlV8kXGrVMSLtcbUVn5Tg3EITlPFWFQ5PsKrHGcduLDRfYFeGGcpc3UuXoC8C
B57eVw5w64uRWA7nbDK9QqKlThxGPISMm9x+DsJC+L08YKqiVuprHhArsooAsWAO
5cdRf6VvUhsKjevww9IyvecdmXh20opI32fMd9unMegH+OyDQk0ntsUOpWvClQp1
BO/lKUdpx/TbPn4qP2U0X0jTzfTopRJ86Hy9eP7NAQrgja2cypVL6B3pco1S3Sld
/e7HL5nKShbErERiVsa+oPVUmiQTcDFn4TTmttCBY4W4fVdOmjm9cbSDr0loCrrL
Wd/sOMqWfpufKEYdQaRarUCHKI9WdF9pmjTaSwtxfQoRsO5bfZRL4bTzGE1/ik17
BMpmnC0S1UHcIvv/5gllRNBFczFKo7Um3LH5XS5ffm2tD89/dR52k6QgJsjgfqsk
plRMAF0FnQG3KSOXvjedltTzg1BVveuEWVaWkidnkXRQnxVonoEerjKzoYfFh0vR
UnQ4DbT+HbjjEK/H7yZifzJgSmNR7aDkrwrMmE68WvWjV4Mx3hOs8lqZA/AFQjo0
3MBMqAOaCNYuIy96+jiY
=GTtS
-----END PGP SIGNATURE-----

--nextPart1857243.bSXeMAMWjj--
