From: Mark Brown <broonie@kernel.org>
Date: Wed, 25 Mar 2015 16:32:47 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <20150325163247.GH3572@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QDd5rp1wjxlDmy9q"
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
To: linux-sh@vger.kernel.org


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 07:01:47PM +0900, Cao Minh Hiep wrote:

> This is my trace logs file with default config (before reverting the
> patches).

OK, so at a first glance I think that trace is being obscured by the
fact that you've not got the fix I mentioned the other day for a use
after free in the trace code - please update to Linus' latest tree or
pick 391949b6f02121371e3d7d9082c6d17fd9853034 (spi: trigger trace event
for message-done before mesg->complete) into your tree.

I've had a brief look at the rspi driver code and I can't immediately
see any driver specific issues there.

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEuMvAAoJECTWi3JdVIfQHUIH/jVhhhgvjZsQWwSAQdU91yNJ
RIMlQQM3iRrvo9iK3DE8ZhLNUXivmc+vTruo4WclPfxhwZRHuFH+4i1gKdznptqf
iCgilNLjhShet2m/jVVFT75F7y6QNjMel8im0jLQlxclKdSrWp5OThGjzgbarFcT
hymUNPTpq1ajskJAL2aHflZYJUJi+bwli5eTTdZ6dDGCmuQm26l5B+G+0p1Df2bS
OAvRJNEIewFwxZ4JO1w1ib2ksZGBkJzkL4IVRf3eshhBMUGepxY5Z75ckh0u87nI
eIMg0eaF8HebU9lDodOLwA3OZDxqfxAgGla8fnao8eJy4p2KKgWcbCRxHgrazuw=
=Fhu0
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--
