From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 26 Aug 2013 07:16:28 +0000
Subject: Re: SHMobile Compatibility String Inconsistencies
Message-Id: <20130826071628.GA9120@voom.fritz.box>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
List-Id: <linux-sh.vger.kernel.org>
References: <20130822054639.GE11086@verge.net.au>
 <20130823021111.GA2792@voom.redhat.com> <1721850.l3ebodSrXr@avalon>
In-Reply-To: <1721850.l3ebodSrXr@avalon>
To: linux-arm-kernel@lists.infradead.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 01:31:31PM +0200, Laurent Pinchart wrote:
> Hi David,
>=20
> On Friday 23 August 2013 12:11:11 David Gibson wrote:
> > On Thu, Aug 22, 2013 at 02:46:40PM +0900, Simon Horman wrote:
> > > Hi Laurent, Hi Guennadi, Hi All,
> > >=20
> > > Olof has brought to my attention that there is some inconsistency
> > > in the way that compatibility strings for SHMobile are named and he
> > > has asked us to clean things up for v3.12.
> > >=20
> > > Looking through arch/arm/boot/dts/ I see that we have:
> > >=20
> > > 1. {gpio,pfc}-r8aXXXX and;
> > > 2. r8aXXXX-sdhi
> > >=20
> > > The inconsistency that Olof has asked us to resolve is that we
> > > should either use r8aXXXX- or -r8aXXXX. Not both.
> > >=20
> > > It seems to me that neither option is inherently better than the other
> > > so we should just choose the path of least resistance to make things
> > > consistent.
> > >=20
> > > Laurent, Guennadi, do you have any opinions on if it would
> > > be easier to change the GPIO and PFC compatibility strings;
> > > or to change the SDHI compatibility strings?
> > >=20
> > > Ideally I would like you to come to some sort of consensus and send
> > > patches.
> >=20
> > So, by all means clean this up in the dts.
> >=20
> > BUT, in keeping with the recent discussions on improving the DT
> > process, the corresponding drivers must continue to recognize both
> > forms, so that old DTs will still work correctly.
>=20
> Given the early state of DT support in arm/mach-shmobile, I'm pretty sure=
 we=20
> have no DT-based systems in the wild. The old compatibility string could =
in my=20
> opinion just be dropped.

Hm, well, ok.  Just remember to always err on the side of broad
compatiblity.  We've become sloppy with incompatible DT updates and
its caused us a bunch of grief.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSGwDMAAoJEGw4ysog2bOSDPAQANDA+43iaZl/3TTWBmqAHtra
dOoZ4noFda2SAt1yRyBRKX87i6LCcciUiTC0kRtZ9OTEUGiqtFB1uo3VV2PtXryS
pKqrDLyDj2aZTod/OR4afoZq4xwQDGEyqP+2pJhZvj+2z+rpL3qwQbxcLqeL//I7
oO2a/Qz05I+lvzMidpG7Iejv5EMyLtRQMtxaJw8xfL3ETp9j0RqkPwKwTFYp+9tv
0mZIUqwAx7szq3r98FZ+MrdnvSlUxbVHkmhwIK6gmp9iFybIK2QL5V/f303K6Nfl
YxiCMNCdBRgLxRqXaem5ieZ3e/gNI/glQIxI2I1cgvcfahN2fZ2rUb2hiTSVCpBu
93JUIq/RDANx/6RniDL0NXRv5QEnFrAvZbaxoz8Wbpsp+ZTrfCSECv4zKiAG+gXt
iKICuEyD7nbId9u49mPhKUi39TFykQIWSTO6btb0Om2j5UOS0j2w5eX9ykir421f
N0ixu8cEJ1eYiObLNr2a+s96cuCdWYTU5RQiUVAcsPp1c8/iWSB7DuY9w1sNqC5B
8djwFEl5RWORhdO1T84FwaQrCvVxZGs4fkAgofNmlNy2I2d4AjJJ+T/rfRiuJYp2
/diJ3/lb4z4eKopD/2WjZLNih5fEe9b/0S0uwZnNDHR8Klj0KJ1FYGtyEA21Da5F
UXB5c+kQulOIIP+jMqVA
=YKMH
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
