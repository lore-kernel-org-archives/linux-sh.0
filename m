From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 02 May 2008 01:22:16 +0000
Subject: Re: initramfs /init freeze
Message-Id: <200805012122.17186.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5494074.7ogSmHIMG5"
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
In-Reply-To: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
To: linux-sh@vger.kernel.org

--nextPart5494074.7ogSmHIMG5
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 28 April 2008, Kristoffer Ericson wrote:
> On Mon, 28 Apr 2008 21:04:49 "Roni Feldman" wrote:
> > I'm experiencing odd behavior on an SH4 setup: I have an embedded
> > initramfs in the kernel image.
> > The kernel boots fine but the sequence freezes after
> > run_init_process("/init") is executed.
> >
> > I say "freeze" because I tried code that only does "return 0;" and I
> > even wrote an init.s with
> > a _start function that jmp's to address 0 (and was supposed to cause
> > an exception, but nothing
> > appeared in ttySC1, not even a panic for the exit of the init process).
> >
> > All the printk()'s are visible, and the console handover from sercon0
> > to ttySC1 seems to work
> > fine (I have no trouble doing printk's before the call to kernel_execve=
).
> >
> > I also tried both static and dynamic linking when I wrote the empty
> > main().
>
> I believe the dynamic linking issue was in pre glibc 2.3.4 (atleast on SH=
3)
> so shouldn't be an issue atm.

and static seems to fail the same way ...

you could try enabling magic sysrq on your system.  otherwise, jtag/kgdb wo=
uld=20
be very useful just to see where the processor is stuck.

> > Busybox as a shell and an /init shell script seems to suffer from the
> > same symptoms.
> >
> > My setup:
> > cpu: SH7751R LE configuration
> > kernel: 2.6.25-rc8
> > gcc: Gentoo 4.1.2 p1.0.2 with glibc 2.7
> >
> > I started to suspect my too-new glibc, so now I'm struggling with
> > crossdev to compile a uclibc
> > toolchain.
>
> I know glibc 2.3.x / 2.4.x / 2.5.x works well, but never tried 2.7. Usual=
ly
> though its gcc thats causing the issues. But you should step back and bui=
ld
> it with older gcc/glibc just to make sure.
>
> For reference I usually use gcc 3.4.5 & glibc 2.3.6 for kernel builds.

glibc-2.7 seems to work fine on my systems ...
=2Dmike

--nextPart5494074.7ogSmHIMG5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUASBpsyUFjO5/oN/WBAQKeWxAAqrXqVtgyOhm6FLCv3BZYX5rDXCgeJws1
c/13/dtEjjnW3f55DB69wgXY1jiDCdg2UbMuLfjBX4qRSynm8LLNdnvv1kApThrV
o6mzcS2dt1mMU79+UtZYq7O9FetcRyHBFK5VyNJPOM+40+vdFiG1H64B3yDif6V8
CBcRjoFqylDeotJBR0iWAiHoVFi9jV1yggnqF7gBC9Ym238CP1pBO3ynRNwtGmFv
q/2VsYmBIDkhYvAPo5s7BmnjaFvZ4OiYpELRmU0i1vX/x6tIYCQomdxWczUf+Cvm
BwXJmRmMdHZ+Xl9uMTvp6FkUZVFNIDlb1MPtATrsPS9ouWOd/ey+5G1M+3FTU/yY
oBOFPnN5neV5Sl+jgmYqbRmgSF00vJbl3qJfwjhGVfE0DFcOfnnmDibwxXRnGgH1
cr19IqMyzmAxhQ4jXcqvkbUiZJWxQLEw3JWxsLBszXbGDMN9wpX7G2JFvURKD7yb
Sn071c4DIk190khAynmt9hjmR9qayta3DcoBEsVg/HyjEOh6Dt/YiD38qVM/vGQ9
dEn/o5+iU2OvYLbP1aH2qNWNK1Qp8mErSF4EQ8dc9lXUhzSAV3XaxmLEz4KIZ9Pq
/v6cAqUSaV3UDLfgENbJJsdygLZzuW5HPdLtdTKDefFdskHx2FUA+/ifTww2clP6
DgSqCGx2Yrk=
=rp3T
-----END PGP SIGNATURE-----

--nextPart5494074.7ogSmHIMG5--
