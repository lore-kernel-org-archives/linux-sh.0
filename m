From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 16 Feb 2014 09:46:56 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <20140216094655.GA2644@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk>
 <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Simon Horman <horms+renesas@verge.net.au>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 04:05:34PM +0000, Ben Dooks wrote:
> The i2c-rcar driver currently prints an error message if the master_xfer
> callback fails. However if the bus is being probed then lots of NAKs
> will be generated, causing the output of a number of errors printed.
>=20
> To solve this, disable the print if the error is not -EREMOTEIO.
>=20
> An example of running i2cdetect:

So, after this patch i2cdetect runs fine for you? I assume you are
working with the lager/r8a7790 board? With koelsch/r8a7791, it stalls
the bus :(


--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAIkPAAoJEBQN5MwUoCm26N0P/0gFvdCruIGrjAFzGCiuB/CE
vjmMbe6UpzfXg7Wn58nj8gRkWMqIbymAcAp4Q61Gz4tpbCdCSkA4L9QxtDC6Z1vf
bcQ0Ct27crq49Mz30V08naeEUYz8X/j7Z3ZJtJgFPRHV49g/k7xbn0853xfIBxTh
umcMS741mtx0XZQUUJaWH8dUdD1LIKI3hAAnZaKr8jySTsviz3Ng1IUANrtx1piX
pYXg2aM6rGbuBE/DvbRsxX2J9Rkv6Au3cM5tEouEOV0eGYwY9iO5IANPb8v/Brj8
kDgwWwjs/T0cmKtMrCtFtfmIY2B1QBK7p9XVGBVJ4QF7CHVZxhZwxI6vpUzKeCI7
fGNR/Ag4fzOq6Q3yG6EVkG8aSVsQn4RHYID4nuIvwf0muHaxXimXaXutjzAWxnDM
51jY/XUzVehJE+U6+XBlKY3ZbUGCQOPf7HiFfrVqRWJYlZH0p0DLcKNzXMRNvZF8
+1775YaD1mWkTssB7chcSR0E/HvKbkAT3WePl9Hbx2c9aTaUeq2RuWO5DL/vRgac
E040hJA/zdsUqxLOSL7BGEON9swGqzvYBNhIFQL4MSRD5/mqZcFMtVDZTsgf4h7n
RecFZJOpmJiCEHqcK+qoRaXDowwna1sHXMVFyIGFjqt3oIEpcfvtxQwb6Vo3sf/i
N4BZinRepZLLjQEYDAjy
=Qh5Y
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
