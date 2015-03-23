From: Mark Brown <broonie@kernel.org>
Date: Mon, 23 Mar 2015 16:27:44 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <20150323162744.GC14954@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bKyqfOwhbdpXa4YI"
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
To: linux-sh@vger.kernel.org


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 07:02:18PM +0900, Cao Minh Hiep wrote:

> "fc9e0f7 spi: Only idle the message pump in the worker kthread
> 0461a41 spi: Pump transfers inside calling context for spi_sync()
> 983aee5 spi: Check to see if the device is processing a message before we
> idle
> 5424d43 spi: Move queue data structure initialisation to main master init"

> when we tried to revert fc9e0f7 and 0461a41 then re-build image for Lager,
> This problem has disappeared on Lager.
> I attached the image building history and test logs files.
> File: qspi_v4.0-rc2_after_reverting_patches_test_logs_on_lager.txt

Interesting...  nobody else has reported any problems.  Can you collect
traces from the failing and successful systems with ftrace (turn on
/sys/kernel/debug/tracing/events/spi/enable to get all the SPI logging)
please?

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVED76AAoJECTWi3JdVIfQEHYH/jGYaabOUuZx9Gb0E905jrPm
wjCtVLqfGe32gU4NSRAdm0q57BZwA2cfqFwKvWrnxKhBhxVJ7+LDNGtv6UEApnuQ
avRFbyWKRjgEFEhJjEo7rUzRm2cD6ZIoZ6Vt4roWu/ENh3svPzolA289Iso8w/bf
x9TDrgda6sI8ryzCCNFls8YUp4fcC6AHkNJrambPeYpMNACHaNQkVKYOBIsmUzx1
L+pY+2JjLBF1szVtZFE+efJf5BZ2qivvoOGCx+eeCR0qOASXZFxj2ipdQr5FnYrp
++uUuFgkvqcxXXvsDGrLql7PnlV9Xon7D0Sm/815+83y0IDM8/zpFFoKjb767zg=
=68rE
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
