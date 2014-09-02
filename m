From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 02 Sep 2014 17:18:35 +0000
Subject: Re: [PATCH v2] Revert "i2c: rcar: remove spinlock"
Message-Id: <20140902171835.GA10355@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
List-Id: <linux-sh.vger.kernel.org>
References: <1642788.pEhrsPDp4u@wasted.cogentembedded.com>
 <20140824064520.GA2578@katana>
 <53F9CCE7.3010006@cogentembedded.com>
 <20140825034009.GA2795@katana>
 <53FB1F90.6080704@cogentembedded.com>
 <20140825143316.GA1285@katana>
 <5405FAD3.90403@cogentembedded.com>
In-Reply-To: <5405FAD3.90403@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >As I understood from your previous mail, a plain revert is less broken
> >but still broken. Applying a correct fix is my preferred way.
>=20
>    Actually, from the -stable kernel perspective, a single patch would
> complicate backporting. So could you please reconsider?

I don't see why. If we have two patches, the state inbetween them is
broken. And we don't have two patches yet, just the revert. So, the
result is broken anyhow.

Can you elaborate?


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBfvrAAoJEBQN5MwUoCm2gV8P/AjBcGwUYSEdWWlNvmAIrRMf
8iIU/seiDFd5GAfCxcF4I2kUvg3+0im+MtAPB/PoTMNi5AZ9l1o1C00K4FjDojza
W3mzlBVsj1dNSP51PK0GwLtF9Q/fGsHDyMMlqv18u4dGQvJGTVI2IQvPxTRRFluD
hDkw1k/0Gqq65xitYTwPo56fvsp2fRzsW31oszBSkfLieoIfSIeBlrEyM+meJjAh
qTxt0FbyDBBqjFQ/NQmLNSjh8RJsBjhAhVgF0gwtFzbGWwHFayPQMIQBW11nEBNY
7uBjoDAxN+bNSA8cY/8bPOStCMLlaZDKfNzAN0recvTdBRwhdqsflHXrjg4VNL1n
sbf95W9ycERy4kt7CPxqfMd0D1U40od7rZXtBF8C50YBtGLcxktk3iPor+OXc0by
j6WakAfYVOa+wV9i8mznlarDoKvgvNPP8pa/KHPPXBNvjzPjt5icJr4xwpIY8Xvf
teKVEcIUEJb1fP95MBRE40yKx2Vs/mCCxec8Nmb1dVdIYH9Ct5bpT/3bszsGb19I
L/3gEi8DMIfpXnAceWE/zDRexX/tTccmMIRwBWbjjvT+UWwxsF7dPZzkADN++Asp
Qtp5vLQrc/3K/t278o5tt+eF0eURWiMf/+dUQLrCazsI9Vo3ikSJMGZ7VSCAJpSw
UoBdvSWyl8FTg7uGo9G9
=bNzy
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
