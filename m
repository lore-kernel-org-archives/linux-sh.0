From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 04 Mar 2014 11:02:31 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <2207635.bd10VfTU6U@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1602428.iOa8tDQv8V"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1722697.3h0GnbWuD3@avalon> <20140303162731.GA3732@katana>
In-Reply-To: <20140303162731.GA3732@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart1602428.iOa8tDQv8V
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Monday 03 March 2014 17:27:31 Wolfram Sang wrote:
> > While the parent is indeed selected at boot time only, and only one=
 parent
> > is thus needed, parent selection could be performed by a DIP switch=

> > connected to MD_CLK on the board for instance. In that case both pa=
rents
> > should be available in DT, as selection will be done by the kernel =
at
> > boot time, not at DT compile time.
>=20
> OK, I understand the case. I still wonder about specifying two parent=
s,
> though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
> clock (or an empty one), just because USB_X1 is enumerated as second
> entry?

That's a good question. Mike, would it be possible to support "holes" i=
n the=20
DT clocks lists, like the GPIO DT bindings do ?

> > > Again, now that I already coded it, what is the gain to remove it=
? The
> > > drawback is that other people might get encouraged to find reason=
s to
> > > allow them sloppy practices.
> >=20
> > It will make the kernel binary smaller by removing code that is not=
 needed
> > in practice.
>=20
> Sounds like a micro-optimazation to me. If you insist, we should BUG(=
)
> right away in that case, to make the code comprehensible. Returning w=
ith
> a leak and saying "we will probably fail somewhere" should really be
> avoided IMO.

It's a micro-optimization indeed, but a simple one, so I believe it mak=
es=20
sense. I'll leave it up to you in the end.

=2D-=20
Regards,

Laurent Pinchart

--nextPart1602428.iOa8tDQv8V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTFbLHAAoJEIkPb2GL7hl1w4IIAIZKA2R8z7sfOn/OHSoBekXT
aEa19lYQzRmjrQd2BCsC50Hv4zJVJm8Zhrdve0ayV1yJsdHRT6c89JtT/X+r1Wbd
CCbkuV/YZhfz6H/NG44pSSpie+yYSfijvwR0eiPj6qrNMm0+vTTuFQLgqN07QwNv
5ZnmlEiRMdn4PNwPqeGKocowVXjpX5I7LZwuddIKyhlkZRWVng6i99VEKmCcvm/d
eNneKAWlyMFlBMV36/48PkxYigGplbaBvYJeea9HGx6wOupvDUfTlvKAOZBoNYR0
7TGyt0eGBLD3OpiyBZhGfOeq7ysov9M1RnxswQuindGai5Unl+9x7ot62rwYNE0=
=JdMG
-----END PGP SIGNATURE-----

--nextPart1602428.iOa8tDQv8V--

