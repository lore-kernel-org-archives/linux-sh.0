From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 03 Mar 2014 10:58:39 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: r7s72100: use workaround for non DT-clocks
Message-Id: <8879891.pRJJJrkMnR@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart5222293.XM1Q0a0t9X"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1712106.fu6iC2mT2W@avalon> <20140303092200.GB6531@katana>
In-Reply-To: <20140303092200.GB6531@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart5222293.XM1Q0a0t9X
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Monday 03 March 2014 10:22:00 Wolfram Sang wrote:
> On Sun, Mar 02, 2014 at 11:21:40PM +0100, Laurent Pinchart wrote:
> > Hi Wolfram,
> >=20
> > Thank you for the patch.
> >=20
> > On Friday 28 February 2014 22:09:28 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa@sang-engineering.com>
> > >=20
> > > SCIF2 and MTU2 are not yet prepared for DT usage, so use the comm=
on
> > > workaround via clkdev for now.
> >=20
> > What about adding a DT node for the serial port instead ? :-)
>=20
> Yes, done in V2 already. Yet, I'd like to keep SCIF in here because i=
t
> is the least intrusive way to get the system to boot. When the SCIF
> nodes are added later incrementally, I remove the sh-sci.2 workaround=
,
> but the whole mechanism is still needed for MTU2 anyhow.

True. I'm working on MTU2 DT support, but that will take a bit more tim=
e.

=2D-=20
Regards,

Laurent Pinchart

--nextPart5222293.XM1Q0a0t9X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTFGCyAAoJEIkPb2GL7hl1iMAH/Ro+G6EStYehwQ61eIrNAg34
UqZjHqMZ3V5O4Yc5WYdhDkngpD83ACHQoYZDqtJzAR4hYG4z+ZFiixNGpPMkl+i3
3t9cKcelHiMNwTYooUdQ1SdJNRoqaVparJ7IxrMoHGEbfSf7WuKucAuyItMeHahf
zidPpXFD4MLBk3RV5CXLUFAHQc9jLEqwOWbJyLYHX0H9Iup3sH7XDq4AnkmnkFi6
HLnvqHMFORCUowrRoOnA8D8O+4cv/g+LeAoi1ZB++yseNjvrPRMl6qymX/uYO2lp
MKRDiifyo86AjOHE4NTwptccBYKYpJbGIVVgSluyv9b0dokwwLeAutCHT6iF/88=
=izwl
-----END PGP SIGNATURE-----

--nextPart5222293.XM1Q0a0t9X--

