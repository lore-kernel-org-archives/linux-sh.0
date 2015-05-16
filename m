From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 16 May 2015 10:09:09 +0000
Subject: Re: [PATCH 1/4] i2c: add FUNC flag for slave capabilities
Message-Id: <20150516100909.GA1617@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
 <1431607205-2316-2-git-send-email-wsa@the-dreams.de>
 <20150515113744.GS28888@pengutronix.de>
 <20150516082216.GA4014@schokonusskuchen.bad>
 <20150516092731.GU28888@pengutronix.de>
In-Reply-To: <20150516092731.GU28888@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Does the framework check for the slave support flag before binding a
> slave to the controler? I assume that not, but wonder if it should.

I think this nails it: Currently, the core doesn't use any I2C_FUNC_*
flags for checking anything. It is solely for exposing information to
users. I'd like to have FUNC_SLAVE in line with that for now.

If we are going to change that, it should be a seperate thread and not
limited to FUNC_SLAVE. I might note that for me this is not a priority
issue, so don't expect patches from me ;)


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVxdFAAoJEBQN5MwUoCm2tOEP/ierYwTrIMMoJVACDgMGdBxk
v/Hpdf8iVQKo56QFXY15r1Wdht8fEy0ZisodyYnnwDBooVoqNeUz63SA27bco7X3
ZFWUIzorNgYe1+LA5xai2jvJR9wbBV12iCUYPyxstQBhw04zb4xt4yzx2q0QulXr
m6auw+kd0yJMHpiBwYdX1akKXSTUz/R4mnPvrs8EpSnxPXHDqebuYPzbdLnfbMQZ
53vfcptW13AFZcbIhT79fx11gCJ+KwroW+QlXloZYz5ksfN6OqgI6rQfE/3Mji9K
vaNxtV1v4WFtbvIMKpRhC8PrOCJTcYSHyiM8Ji/l3I7K9iwQegEx8sLx83yTCohK
mmD0/FT//9Yu1XlmVha+FJJ47S/LKOr6+CaJKy47zmoWYOMCmM0SrXJyudg77t3O
wCJC0RCcjK8iYiqf+cos9bZshn2ISxVRVak83Ev5+3nnoeb3Y92ZWEGLOwjj4vH2
fh9fZD+T2UEYAWcwaGCVdHZrKE81C1yLkaRwas/s32QgC+w0crgYfjSYEQ8dWRmH
rjt/jlXwWRKI972TJwa51P5OR1cMPTlJpOgtuC/7QC8NgEDb+lpIYlI83/OWfRlJ
zKX6iZQa0qo6paGu04n2J4cR/hZEZMFhyCn+cPXZwSG0juOG/4OKhLdZKl/XPVmN
CEMYvMZNfIIimlFDqmNu
=Onfd
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
