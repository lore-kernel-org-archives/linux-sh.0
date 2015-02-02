From: Mark Brown <broonie@kernel.org>
Date: Mon, 02 Feb 2015 20:03:56 +0000
Subject: Re: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Message-Id: <20150202200356.GE21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="F99ASOl9IwBV9fq7"
List-Id: <linux-sh.vger.kernel.org>
References: <1422598314-6889-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1422598314-6889-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, geert@glider.be


--F99ASOl9IwBV9fq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2015 at 03:11:54PM +0900, Nobuhiro Iwamatsu wrote:
> sh-msiof of frequency dividing does not perform the calculation, driver have
> to manage setting value in the table. It is not possible to set frequency
> dividing value close to the actual data in this way. This changes from
> frequency dividing of table management to setting by calculation.
> This driver is able to set a value close to the actual data.

Applied, thanks.

--F99ASOl9IwBV9fq7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUz9gsAAoJECTWi3JdVIfQkdcH/A64aprG4ZaToI39iLV13qca
JD2vffAlCV+ZpJQ8Xb1//0CYVRkE6c+OBO8iZIAN52blESZAVPLHrafnz9feLozI
dNVF6XnF6vt1Lgo3QBy+lfUZ3M7LUBOgBqq1DXfCaurG8pO8RFvDo/QoAo1rdYum
FspSHeHBasWYB7veZHJTgM/sd8bDnMmAjBmYh30i0k8Pv7zl8VicerpW+Ai8KpiG
uScNgwerVJ/XHarZX0WRe/tfy8Gx0SLMCZdGPpd/X9i/HBBJKZbfGZVgBoWzOE6b
CFSliVXn/XfZNGxJAmIOCAwJTg37Tme3SybsaxFF4tpzzTWmoHhnZV5OJRAZk68=
=nQN0
-----END PGP SIGNATURE-----

--F99ASOl9IwBV9fq7--
