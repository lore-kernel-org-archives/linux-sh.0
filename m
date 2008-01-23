From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 23 Jan 2008 12:16:43 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <200801230716.44071.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1646709.E1ejBXX6th"
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
To: linux-sh@vger.kernel.org

--nextPart1646709.E1ejBXX6th
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 January 2008, Adrian McMenamin wrote:
> On Wed, January 23, 2008 9:53 am, Paul Mundt wrote:
> > In 16MB you will always be bordering on thrashing just trying to do _an=
y_
> > basic tasks. Your options are realistically limited to busybox or
> > throwing the damn thing out (the recommended option). Doing anything mo=
re
> > involved than that was pretty questionable back when the kernel used a
> > lot less memory, and trying to do builds in that environment is well pa=
st
> > absurdity these days. 64MB is painful, but at least workable.
>
> You really are like the Kerryman who, when asked how to get to Dublin said
> "well, I wouldn't start from here." :)
>
> I don't mind the thrashing if it gets me something that works and which
> can later be used as the basis of a "distro" - which is my aim here.
>
> Anyone know how stable swap over nfs is these days? Speed is a secondary
> consideration.
>
> NB: CF or similar isn't an option. In theory you could put a very small
> swap partition on the Dreamcast's VMUs but access to that is likely to be
> much slower even than NFS - as it would be rationed to 60 times per
> second.

i used to build on the dreamcast, but the swapping was terrible so i gave u=
p=20
and just bought a lantank as it has 64megs ;)
=2Dmike

--nextPart1646709.E1ejBXX6th
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQIVAwUAR5cwLEFjO5/oN/WBAQK7Lg//dHgn3J/B1+BurO2V1KeH6Gde8tIgzQP3
HKe3TUIP0+3BHDS66sl5R0WUouqx0w3wixD8G3rlTUB/YZ7NXtPMEJSBRVvDFuvw
ARiXe4uVVjdOQ9pEEnqd10pa6iXHyQmecvEGWJGzEYkZyN6r+x5GUlVRmkuZle+a
G0huM5HtCaGv+jw7S+JNoAUeRK0Ar+j/3is7YGEWWoVUpx/AAImbDDqVfQ9Ltet7
0OspRWNsDGYpc7+ZOQChTygz/CJAleopS6lazZ7+497ppQl+s8XocXztz84QZnSz
5VttmjpBOymUJxmZsVpaiwMwnieV1jR/wqc8Zsc/gHXBAeVIJZE8VIZcZOa4DQl/
A0NNvnaI797I7mtgLefsaQJBINSHgChvHMZRVYwrNDqnVQvo5b79PxBbBsISRHgV
5HYv2DnF+44hdE8zf2PM9Y1ZLyJuXzaJUmbZ9Km8xkHhHaWdod4Lw9gRDSpuZs+x
YX1l2QIdFb3dlaGzek2UUsAgQgmtJYL0EJEhJwQdMfF8VWPN+Pd7kSELlehhJhZl
hs6B0l8SQux7ngB7oy4Duv++epNVeHq5cgeYJDUyvF4jsGdZbbCSsig3VaaRXRb7
rFYx3Sc6H3kxfhFs1gyWH+zvQv69GebVpC+z8+lRQ6Wf+hjPSKUvIeIP6SU6U1Hz
DBOF7uTQVWs=
=OeJ7
-----END PGP SIGNATURE-----

--nextPart1646709.E1ejBXX6th--
