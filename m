From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Mar 2014 13:59:37 +0000
Subject: Re: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <1460103.hdWs652aMT@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1484923.accpooLE97"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140305135431.GA7985@katana>
In-Reply-To: <20140305135431.GA7985@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart1484923.accpooLE97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Wednesday 05 March 2014 14:54:32 Wolfram Sang wrote:
> > > > While the parent is indeed selected at boot time only, and only=
 one
> > > > parent is thus needed, parent selection could be performed by a=
 DIP
> > > > switch connected to MD_CLK on the board for instance. In that c=
ase
> > > > both parents should be available in DT, as selection will be do=
ne by
> > > > the kernel at boot time, not at DT compile time.
> > >=20
> > > OK, I understand the case. I still wonder about specifying two pa=
rents,
> > > though. If a board uses USB_X1, it then has to spefify a dummy EX=
TAL
> > > clock (or an empty one), just because USB_X1 is enumerated as sec=
ond
> > > entry?
> >=20
> > That's a good question. Mike, would it be possible to support "hole=
s" in
> > the DT clocks lists, like the GPIO DT bindings do ?
>=20
> I talked to Magnus and we decided to start with hardcoded EXTAL for n=
ow,
> and leave USB_X1 support for in incremental patch when this is actual=
ly
> needed.

That's fine with me (although given the low complexity I would probably=
 have=20
gone directly to supporting both clocks) as long as we can ensure both =
forward=20
and backward compatibility. Should we give a name to the clock input th=
rough=20
the clock-names property for that reason ?

> Note that the devkit will most likely be the only board ever with a
> selectable root clock.

Most probably, but that's no reason not to support it :-)

=2D-=20
Regards,

Laurent Pinchart

--nextPart1484923.accpooLE97
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTFy3PAAoJEIkPb2GL7hl1opYH/3I8RdXrAKkrQ2aKl0unbDMj
hBI4cWw/wa25tJEzrrTs5YbIP/6Oi7pRB6NDUMwmaiP07X0TULhuqouRC6hlFhja
lU/6P6okijT2fIAsW+IDIDKOHMCLymAkykoNE09rLv51eg2MxX6yJs3veZ1kNTBZ
ysjk2x2P3bofU/7XGprGGgWJZCrozCM2k/Qm8R+edzJc/Sl4rEfu8YwuV85YQIji
xBKhOvw4d3IPjdTcbNcRPZ5c884XCO7/gGQiycTxq4JdM+M4w2soRR5oXxPlbc2F
9P5eVDwM/+eYEgSugcqLiM+GRqp3vDDy01p6xtjbi51NhZyROcGyEvyxqCqlkZo=
=UvNp
-----END PGP SIGNATURE-----

--nextPart1484923.accpooLE97--

