From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 09 Dec 2010 16:07:49 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <201012091107.51911.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2133389.RkiuSe2jgR"
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<20101208044052.GA31508@linux-sh.org> <4D00FC2A.8040309@st.com>
In-Reply-To: <4D00FC2A.8040309@st.com>
To: linux-arm-kernel@lists.infradead.org

--nextPart2133389.RkiuSe2jgR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> I agree with you that the Kconfig and Makefile changes are not arch
> specific, so these changes can be moved to a common code (even if I
> don't know if other archs do support SSP).
> In the current kernel, only x86 and ARM added this support, so I'm
> wondering if, moving SSP to the common Makefile, it needs to depend on
> x86, ARM, SH being configured ?

i'm not sure it does.  ssp is designed to be arch independent, so really yo=
u=20
only need a new enough gcc version.  which means i dont think it needs to=20
depend on any arch code and you can simply add to the Makefile a compiler=20
check.

> Regarding the __stack_chk_guard symbol defined in process[_32].c, I
> don't know if all archs need to define this global variable to implement
> SSP. For sure x86 does not need it. It depends on how the gcc implements
> this feature. This was mainly the reason for which we defined it
> specifically in an arch specific code.

the common gcc code too outputs __stack_chk_guard references.  none of that=
 is=20
in arch-specific places.
=2Dmike

--nextPart2133389.RkiuSe2jgR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNAP7XAAoJEEFjO5/oN/WB6IkP/0I6vCNHOJYXqmr7iARhP/nA
GfDfDiRmDYOCHFCD8ZUc0Q9URPNh5lrd9JcCvY7JomQU7nV4FkXUzmPn/PMSXnkx
d0Fb5VIAUcCiwZq8sthbxhSix7tC8A1WOm8nEMkucOXPSo1tHACCaemM+cDEWa1w
D4eKjh0aMoIcef9jfhD4FlFP4y5Hq23NnIkylfJxnLVTypfVu94wkoQFjihntMXP
30NRFXJymfnXQ8OnyDRHLBguRzaQWMI94ew+SZ9M3pDodKHBXH/47GmFRnKxGPa+
rCFJyxokjxFDrGv86XFZnSu6+1v57RTzbubtGYgC6uFhqEkxJ8trs386wWfbAkWR
63KyCoumAOB6MgdeXKnsUM16X1OBBFfhMvLRAoNUymEU7uJej+AzfAuRvw3tvPpo
HvBm/pj/b8+ezKc8dr1G8MVZwDqPBiYh8n9a/fjHkBVTlXFscQ0pUOH9iW9GQ54o
QcfGR0jmwlhGIYdvJDsASB6AMfM6iBMIGvS1u8Bq9EkPK2WgcqHw9MkYJog3MaKL
kTtiKjw1vAN5HrJ3EPSTD9br8jQEVa4JMAuKQMgSvPWKVNpURMxqNtItnOZmms97
NlDSuufksPmkLrQnA9b6ejRrLNlx9fKNjfyn8CEI8rjQJJnohP6A4v1PAH4zZOrh
e/4aZjSEzqzDq3kdVYWq
=c11x
-----END PGP SIGNATURE-----

--nextPart2133389.RkiuSe2jgR--
