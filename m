From: Mark Brown <broonie@kernel.org>
Date: Mon, 14 Jul 2014 18:58:30 +0000
Subject: Re: [PATCH 1/2] spi: rspi: Fix leaking of unused DMA descriptors
Message-Id: <20140714185830.GE6800@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="oSWi0jal9INzEBQ4"
List-Id: <linux-sh.vger.kernel.org>
References: <1405094802-14401-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1405094802-14401-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--oSWi0jal9INzEBQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 11, 2014 at 06:06:41PM +0200, Geert Uytterhoeven wrote:
> If dmaengine_prep_slave_sg() or dmaengine_submit() fail, we may leak
> unused DMA descriptors.

This doesn't apply, I guess it may depend on some of your other DMA
related patches but it's not immediately obvious and it's not been sent
as part of a series.  Can you please check and/or clarify?

--oSWi0jal9INzEBQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTxChTAAoJELSic+t+oim9g7EQAJeYMuasQqoVvgP1S8Z2xupD
nvaMENfzBMTpl7vUQqUQvQhc7focMqUmRh1xI7CpiptNcjRF7Dli2n87AnXBAk9R
1FpggZ7PEy7Q58ey+LkgEJyj53XRWcqc6LhybYzqJfjxUXnInZr3Eu5nUwrImNGL
faKVpIHzMD3f9FVkOkT5YMM/k3ZfS2QKCP067MLF89UN4Ppka12bKbMAJN3d95U1
6GrZ0ctqBuSAPqfyvz0mRp1TX02knUexH56aCXx1bccPfyiNCjDMW4MH2ctSVchJ
BcLQhCtC4lb1/61VFo4PfUUX5t3MY2yt0Z8sQwJPcvrHezSk0wxP9hjNWZBTi6Pm
fyDK2b3a79uoanwUttJubfNwC1eImv3hiyPD7ke5SpbprnNhinYOq4BN2Ru69V2j
TR5DopUoIeNCoUi7BGPUK1/c1hZVtDsxgDxm43e7sZg0nTIcVDlC/rqRd2KlwDc/
GrK3UWk0fJJLh3yndyhdcPBuqFcU5eJKjmgbmt/wRb0XJg5iq0rjnIzuHAcoEr5C
zVIenZOCHOrxIkvrVR9CgmtLXGplg73vMN28xZdJB+9ZEbXhXCr3nYRLpBsIHbIz
6shIolz9T81idMKV1PIN8Lu11ZkCZdH8I3NgKrhe3J8LX8EHffOnT4pIAXoy7ZVN
Fe9CLKeUnb+7AmfDXANd
=hKt0
-----END PGP SIGNATURE-----

--oSWi0jal9INzEBQ4--
