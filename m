From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 09 Dec 2010 17:32:29 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <201012091232.31577.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2992409.M0Rllbr6RV"
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012091107.51911.vapier@gentoo.org> <4D0107AA.2020909@st.com>
In-Reply-To: <4D0107AA.2020909@st.com>
To: linux-arm-kernel@lists.infradead.org

--nextPart2992409.M0Rllbr6RV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday, December 09, 2010 11:45:30 Carmelo AMOROSO wrote:
> On 12/9/2010 5:07 PM, Mike Frysinger wrote:
> > On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> >> I agree with you that the Kconfig and Makefile changes are not arch
> >> specific, so these changes can be moved to a common code (even if I
> >> don't know if other archs do support SSP).
> >> In the current kernel, only x86 and ARM added this support, so I'm
> >> wondering if, moving SSP to the common Makefile, it needs to depend on
> >> x86, ARM, SH being configured ?
> >=20
> > i'm not sure it does.  ssp is designed to be arch independent, so really
> > you only need a new enough gcc version.  which means i dont think it
> > needs to depend on any arch code and you can simply add to the Makefile
> > a compiler check.
>=20
> agreed, but if arch wants to implement the per-task canary feature, some
> change into arch specific code is required.

yes, but that doesnt mean the common symbol definition needs to be duplicat=
ed

> >> Regarding the __stack_chk_guard symbol defined in process[_32].c, I
> >> don't know if all archs need to define this global variable to impleme=
nt
> >> SSP. For sure x86 does not need it. It depends on how the gcc implemen=
ts
> >> this feature. This was mainly the reason for which we defined it
> >> specifically in an arch specific code.
> >=20
> > the common gcc code too outputs __stack_chk_guard references.  none of
> > that is in arch-specific places.
>=20
> a simple test on x86 just prints reference to __stack_chk_fail only (not
> reference to the global variable guard)
>=20
> gcc is 4.3.0-8 (Fedora C9)

gcc will reference both __stack_chk_fail and __stack_chk_guard depending on=
=20
the code.  i think you only need to test that gcc accepts -fstack-protector=
=20
and then assume the rest ... i dont think you need to come up with random=20
pieces of code and cajole the symbol references out of gcc.

along those lines, i see your patch adding __stack_chk_guard, but where is=
=20
__stack_chk_fail ?
=2Dmike

--nextPart2992409.M0Rllbr6RV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNARKvAAoJEEFjO5/oN/WB5CUP/RZ/tO3THFFBGbi6n/GavnIN
ZF4MlnWO/V0NJ6UitmqpBlOCV7Fpcp3Sm10s17gSI4DbIauB9QlfBerfMW1op8c4
O9LtFQjEwB5/D+ZOxc40omrUJfZ0y0ZLyVWI9wfAu/k0FWwZD4jqGUpYnkzQMNsD
vjnuN3cttvg5usOwgJm140NrSq7WR/ofn9rFMslSnFDRu6mCtVDNW3S+qPqVVtOc
Hb2YvBstp057FLQ/KjsrKpi0JEPK1LBwfRzE5EiHeKbpaQQnSZSDdTdCVLcgAOsZ
V1c+q9W7PBmDufPKp7VDf0fKaNkrn38ZaoER3obcKgHddGxeuLLcyJPdobskLylT
NU/xPkNe/7RwhJrg3T+4HO3W0KRdEonK2IQUdoCFOa31fi/VePY+fC4rymDZQj+B
H9LUDl6nK5AFOHtylt0MTcY0fYTh2UkyNFnneBqfBwt+XOnajiWV/ISfSRYKCZVd
mb1WmvoviBMy19b+V+z9ll/zeze8IfZpnIN9jYr8/eic5fls4qDh/ehu+CrqbHnj
MxyAYLKtwOLqUdzv21DeHoGJ72rYqU/6Is56y4dPBZUCCecEVhx6KMvPH9ESnxhJ
6zeCu7xN6/tJuRzhs1fxRTtSSW+Pu62TThtpa/KN/g6JTpk0KJnARBBXWhPgOv0p
SYims1I22ruCjWqzlLLy
=yPUy
-----END PGP SIGNATURE-----

--nextPart2992409.M0Rllbr6RV--
