From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 14 Dec 2018 16:14:22 +0000
Subject: Re: [PATCH v4 3/4] serial: sh-sci: Resume PIO in sci_rx_interrupt() on DMA failure
Message-Id: <20181214161422.GB4236@kunai>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
 <20181213184444.21904-4-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-4-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 07:44:43PM +0100, Geert Uytterhoeven wrote:
> On (H)SCIF, sci_submit_rx() is called in the receive interrupt handler.
> Hence if DMA submission fails, the interrupt handler should resume
> handling reception using PIO, else no more data is received.
>=20
> Make sci_submit_rx() return an error indicator, so the receive interrupt
> handler can act appropriately.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwT1t4ACgkQFA3kzBSg
Kbbdnw/7BCXNyz4hhWDj3pPv0kGSp0BETt2k8U6FdLksxBp/Sf3JugLqYE543aPI
Jk3h2baedFiERJRt54ajq2tUTxt8ZoBN+tf6k+63Z+/Wni8VWtQf8M2KYxmmqZIK
U9PVbjoKe95VbAXQDs/QObbOTL2qZnroGOGi33mXiwsGndrjFy/hCjLnd5PJOC46
ZcuMnqai4f25TR4ca9MiJ5zE3OzuAfTI+o/+MLNwXJfjMyOShf4fZfxol9Sc1Zdc
kEp2ITne/nPgll1PLgLD/525TmMPYouaeaSdvNwC9Ie+dmWM446zB5wgRwakv55R
n7BNk3u9wsn5O4StFXhc32oliOMQ9rVPaNgxRJcgJGKyBLP4qYhEL9BUs5497FcL
c+eS6llS2XDXj4dVQho9ANKS8Pykr/hNAZ7LsMGVPff1z+f2bHIk8AWLJx0Qf7he
REsNvEN4XIkxnMIKJlz7PkdmLGOIzxn/cvTJJhNtB/hMXkRdQ1Vppw2s1kypxqzO
JCDBVKbfneL8jUNDuWSs6yfDlyPyT0IGl0rZuLykmWJpSsltY9ehZP8HXf3vDNV1
7RqF/pk8wRQD72yvBDuDlrW1OUqczuGhPreg+BWeBbu+YPl5bEs7yIuA5D2c+T+s
FqVzjjNMV1/TQBy2Pr++9BmpVTiUTDfpcJnWtLNlleXS6OHMhiQ=
=wzjE
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
