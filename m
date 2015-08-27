From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 27 Aug 2015 12:46:45 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <20150827124645.GC4326@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
To: linux-sh@vger.kernel.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2015 at 01:59:32PM +0200, Geert Uytterhoeven wrote:
> On Thu, Aug 27, 2015 at 1:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Thu, Aug 27, 2015 at 06:24:10PM +0900, Simon Horman wrote:
> >> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >>
> >> This is a work-around for limitations in the driver implementation.
> >
> > I know this is marked "local: hack:", still: If this is a driver
> > limitation, shouldn't it rather be in the dtsi then?
>=20
> You mean, in the driver?
>=20
> DT decribes the hardware, not driver limitations.

I wanted to ensure that this workaround goes into all dts files
including the r8a7795 dtsi, even custom ones for testing. This is rather
SoC than board specific, no? And yes, still a hack :)


--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3wa1AAoJEBQN5MwUoCm2VVgP/1MwXJ9KuyQOzquKEvBk1JVz
DAoSvCkGrSRjRuNMYtBPAEq6jGpk5o3Ie+AF7Qd9jJx46JsahO729CP++ppjC6yS
k6xYat5rmMp6v6bMbLVafDCseuIetbxAKZeQvia+InCJRU6EDCGoPrmSk2N/HXRJ
U4SK82TBtyiRV+gWf7pi3e74islFagfHISugA3ep1uUmFi7ejywCtxADm2BH87Ub
3icgZSUh0t7tXZbE79TCj3NieEbO0zSsFK8Ye+gXcbd+iI5wKrs8vcKHBDNWkgsB
3eSJAhl+o8YTehLnHcmQtQPRdEYIArK5KysO9iaaU8wZRDRMk5bcRtpvYouYlFpi
V0ihPadWYNos5cqs1b6G5Mtlh03xWKrCPngoLUi3bPVn8H/t8fHEPgx4t9SHReLG
20Uo6Bp2NkW9ReGeBw046xnnwx/9Vb7r2L6KEwH5ESWDf965R0514bd73gnnnaNJ
1cyXfGHduNkL6pmeVci+k6cqo3VIoPjDdaYvBLHG5Ejs2kr0tZNcz4M2ZmJrF9dP
1uTGlUhr1YhpXdzrFk/hrsBDBU84VFm2FajYSLLFhiuYwWhCxprsq5Ur0H8QWQZF
F2ixjz05InyX64TcsYtyaIhHtFZF2g7uoiAW34ebeXZPqcQRLXcYnhBX08fGo1Yo
WckfjvsvLpoBfg3FXIo0
=iKav
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
