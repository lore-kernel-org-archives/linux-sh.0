From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 22 Jan 2016 08:54:08 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <20160122085408.GA3967@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dirk,

> First, regarding the clocks, if anybody from the experts could advise me =
how
> we'd like to interface dynamic clocks to the existing Gen3 clock code, th=
at
> would be really welcome:

I am not the clock expert, but I try to have a look next week.

> Second, I'm mainly interested in eMMC support for the Salvator-X. Therefo=
re

OK, nice to know. I have eMMC running now, without DMA and HS200, of
course. My patches need some refactoring, though.

> I picked (hopefully) all patches from the Renesas BSP to
> renesas-drivers-2016-01-13-v4.4

Yes, that's where I picked your clock patches from :)

> so I'd suspect some memory overwriting. But what confuses me is that the
> same code works fine on the the 4.2 based Renesas BSP. I have no idea
> regarding this, yet.

I usually don't have high hopes that putting more than a trivial amount
of any BSP code on top of upstream will result in success ;)

My obviuos plan is to work incrementally. First basic support, then DMA,
then UHS-I/HS200. Review, refactor existing patches. Upstream first, etc
pp... You know all this, I guess.

> And third, from reading the r8a7795 manual I think the manual talks about
>=20
> https://github.com/dirkbehme/linux-renesas-rcar-gen3/commit/f2a727c859916=
d59dca85dbb72c1b61da3fd6da0
>=20
> But testing this it doesn't work. So either the manual is wrong, or I mis=
sed
> anything else.

I have seen this patch and my gut feeling is that it won't make a
difference? SCLKDIVEN is like CBUSY plus some more cycles AFAIU. But I
am not working on DMA issues now, this has to wait.

Kind regards,

   Wolfram


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWoe4wAAoJEBQN5MwUoCm2KKgP+gNJ2wMnrFrKs1vj5+d1+XdA
GGrk2H8jK/8ARRYydXsVORIzTxswb7fW8CypCaI438T5hEz/9w4BcwwaCR4NONaq
Cj0PvV3+2DFhHhQJ+sFNNCKHAFqBrBF6rfZxWt/+SasV2b6Q4qQxv/3VwzPn4R3i
9P3LT5yhFYTblVA+3QTKKsWZxl17xROyhILl87tx1ANqNyZKLLmHhwvwl5+2/pDf
jtUqwszHL25EmER8rw0/0FETrk6lFy3efXVnO/NnX83tK9vGc1u6Np0spqXGuC9r
bGJl7G6VlNZJkFjb3iihd/6PaK5sgbo7oUD1PtaTWWlhNZFGi3pcEQ73PUYh18bw
CiMOhEcGAbJd40rXl668UwaPUVJEpAmuW9pyNrV+ri13GHvCl2KEIWD6au95dSb6
a+XpYp9Ac9Wrn5bF/4I+AmQ8LLq1RSYNMjdP9pwkUIflJPwpBJK91aQtv7u9WejX
ZChnQRo8oKAsioj+EhOJ66LBZ6KPpO8TzQLf3hPtFZX4SqXJQMsH3T5cygtCSG27
o++Zli2s8jFBHGNbmJK8cX//r0bpgJsWxX0mfVoSiVR/MWY9Tc3dANcLhaV/cLXB
tv1f/CVhFE4GB2MRnyzs+Qj+T/OPQbgvW1tt2cQ+gvIn60+1Xfeh68TSVCjd9gov
tPk3qLQurk9lGcsBfqtA
=zB9X
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
