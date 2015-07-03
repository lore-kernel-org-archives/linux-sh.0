From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 03 Jul 2015 11:41:29 +0000
Subject: Re: Possible regression due to "tick: broadcast: Prevent livelock from event handler"
Message-Id: <20150703114129.GA10368@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
List-Id: <linux-sh.vger.kernel.org>
References: <20150703024044.GB24695@verge.net.au>
 <20150703105441.GF1521@katana>
 <20150703110249.GV7557@n2100.arm.linux.org.uk>
 <20150703110730.GG1521@katana>
 <20150703111358.GW7557@n2100.arm.linux.org.uk>
In-Reply-To: <20150703111358.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2015 at 12:13:58PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jul 03, 2015 at 01:07:31PM +0200, Wolfram Sang wrote:
> > > Please share your .config file for this case.  Thanks.
> >=20
> > Here it goes...
>=20
> Please try:
>=20
> sed -i s/IRQSOFF_TRACER/TRACE_IRQFLAGS/ arch/arm/kernel/entry-armv.S

Yes, this fixes the lockdep issue with HRTIMERS.

For completeness, it does not fix the freeze without HRTIMERS.

Thanks Russell!

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlnTpAAoJEBQN5MwUoCm25hoP/2aWnaYWSvgZ7Wu78ns05ARX
bvaKCtq550YZmwmBAiY/bapulbMHoU4qi6zpTFcntUCGaaaozNK9kaLWRx/Z2fjE
1GBa0mkbkesvgVoIAOUCxdiUYRVcgIQQkKWYT1W7ivpbv/cMe2tm4Ve9+LSlGeeP
kJVhc2PU+A/+W+JzXJVA35x7zUJn4se4ihm6ltAtNOwv7G/cW5b41Koz8l5VZO+7
/cqb864sYJ7JTg3sU8I7628Oc7TjFJP4kMmVk/wDhJ8qAu/awYHn4etCo/QY6TzW
q8VzLVIFa4BhF1V6AmYL8sL0SOfxkpd5aYgyDRkucDUhUkj/71jfum/yixxEVGcd
T1XAeIHg0Oy/Bay6T0/bCPcqbO475eoYG+urksKgRPYiZYMKe+F9aW/IGiIlMtdy
V7EdnP9m6l9GWCAhqwOM1wmlZLB6JhipQdUjKPoogvokPO20NVtbLOPqunCHj1iU
1RpozDxeWuw49G8pAexuDHFa1v3uK4wu3m1Tvr4X+AlR29nn1G5TZ7Y5CAP5iagl
x2vDo4/00vA9vFCgj0IIWkHXelTV7x2qUhgF3s3YQy540QmI27uc+GlbMnhZdKtJ
4KmFF/qp7a27+yLHmnwyoL2Z1Be1NrUH7xTzIkZLBrhoUeMk6j0dUrOrKJnryyxJ
4pG+N6TBz+NO9UJURyF8
=/v9J
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
