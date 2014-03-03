From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 03 Mar 2014 09:22:00 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: r7s72100: use workaround for non DT-clocks
Message-Id: <20140303092200.GB6531@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
List-Id: <linux-sh.vger.kernel.org>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1393621768-12568-5-git-send-email-wsa@the-dreams.de>
 <1712106.fu6iC2mT2W@avalon>
In-Reply-To: <1712106.fu6iC2mT2W@avalon>
To: linux-arm-kernel@lists.infradead.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2014 at 11:21:40PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> Thank you for the patch.
>=20
> On Friday 28 February 2014 22:09:28 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >=20
> > SCIF2 and MTU2 are not yet prepared for DT usage, so use the common
> > workaround via clkdev for now.
>=20
> What about adding a DT node for the serial port instead ? :-)

Yes, done in V2 already. Yet, I'd like to keep SCIF in here because it
is the least intrusive way to get the system to boot. When the SCIF
nodes are added later incrementally, I remove the sh-sci.2 workaround,
but the whole mechanism is still needed for MTU2 anyhow.

Thanks,

   Wolfram


--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTFEm3AAoJEBQN5MwUoCm2+y4P/2d2n1gv44xGKyvUqGfTVriT
gEkuGXTEEooXQIwVpNU+rGKAgc7j2lVmWr2dOOksVokb5y+uYr41gzYBHIv5+zn3
YlkX040rIHNEr5J8Jbq0cA3pmZ+yjQXaOr6VUDodszcyWSQG9+xIBO7WoICdPq33
/bqcn0mSmxeknSa89OxDwUaVuL+oQtP2SfhIWTj0BTleM2KJYuStoTc9ElwGLfOX
afzXX0eX+ikxHPy3JXw3V5tdknZm6ZpRNgr+jfA8aJonMGf6+GLHh34ENbJA7Fhl
jFhha/z2ANeUqTlrgh7kat8Uv6VQVd23sEqvjKeA7+Q6Td7yuLswudyFbxPn5zxI
m4kxAriUuHomIWbg5ieVfWpbxZg8eoiC2qm5Y8qm4rgT74L3WrBM7miX9/38mFOC
KZ8RhKXzHRZf/S++MdzSp8s65yf1dCFn3qMf6PNZHgR1P4TwcBcrDt/qkTsm5aez
1rL2oeRgXqM3kgw+MT96l+PUu5JdqcMIEqngWXg8b+oZa5TxzmMIk0DkRcGMBorC
knkxX7i5i8wRQ7iex1YJO/un62WdhM+OX2pmy+tgcOHrl+H4ojVY2fyzbjkT9G9Y
RynXZehLNH7SjIzWr6bQkhCCWBmnO4R//lwuG4EY5LgbBarYrnvWcYtqAryTdRfu
qYPhmZTQzu8ypOfB4xzn
=JlRF
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
