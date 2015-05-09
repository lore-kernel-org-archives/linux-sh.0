From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 09 May 2015 07:09:14 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150509070914.GB1511@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
 <20150507220812.3776bb83@endymion.delvare>
In-Reply-To: <20150507220812.3776bb83-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> BTW I'm curious if you actually needed the + and - suffixes in practice?
> I can easily imagine how the =3D suffix will be useful in the real
> world, but + and -...  Or maybe just for bus driver testing purpose?

Exactly for that. While you can send complex messages with my tool, it
should be clear this is mainly for testing/developing. Once you know
what you need to do to access a slave, a specfic driver is the better
option, be it in userspace or kernel space.

Those patterns are easily recognizable when fed into an EEPROM. They can
already reveal quite some problems with bus drivers, e.g. off-by-one
errors when fetching data, sending STOP etc.

> > +}
> > +	/* let Linux free malloced memory on termination */
>=20
> I don't like this. The memory allocated in i2cbusses.c is freed
> explicitly, so it is inconsistent to not free yours. Freeing the memory

Well, it is documented :)

> explicitly makes the code easier to read and debug as it documents the

I disagree about this one. Currently, we have a LOT of error paths when
parsing input fails. Getting all the error paths right with freeing
memory is usually error-prone (especially with later additions) and will
IMO make the code way less readable. Since the lifetime of those buffers
ends right before the exit(0), it seems unnecessarily complex to me.

However, I need to redo the parsing anyhow. Let's see how it looks like
in the next version. If it is easy/readable to free(), I'll do it.


--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTbKaAAoJEBQN5MwUoCm2VMYP/RnDVZ7bmSstnQ1fKnZTNWnZ
1m4DIrETfvQ0r9luWNpUNffcoH0tcJulDiKRWq6zHs5af1VS1odS+Ru6LvxgNdSY
n4EMnn5kHbxXErHEOFzJ1f8pX8/SiIeoUHXipegwjOthrQIb5e4JLmPcvIfu00lD
4HybdI+S2nv8DnBMKlLpA0Hhngjj3Vv9yrfNDxHAQ2XdWLI2WnyFet5Wp/K4nS9n
E9l5btvKQyXEh839ZJBAi4J3fXCV9QRObPF/k4ZpSPjBBWcV1rH7UyYFkAfp9Cbr
C/LOFztOO3ZaBy3dE1jlRtAsbbjyDRSVkPwpWkNhuCWi2rjkPa+RC8gSbkBW9sQt
xS530njuWSQtAxQgvEslI37W4xU3Mm7tjUEjV6hKEv5aypXA1RY7vq+GfBiGtj5H
a9Dy7YR2gltZeLPAUcGd6Nj8eQNOr+nob+uaR7ihMOQqi39OCixzOuTv0YqAXDLq
8jIaSCkzK9qh9panslbYsncdlGvo9oYGZJwai+ks4rC3+NrP+CxAXkaH1Y14CkbA
YZ4aALKRCZFo2OxdIqQLRUoseinbrwXZmGYrJ6mXGwWslNwaT9ampMGmvqzyzn4F
OOaOhBfRw6Wh9iXFdquvsqw1JRkjvhJ8jDCJWP8czbILqa2+fzSJaR0/gcI/NOkJ
A+prteXtXQcLldvc2n0G
=PH7g
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
