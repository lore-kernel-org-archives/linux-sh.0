From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 08 Jan 2014 11:23:59 +0000
Subject: Re: [PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <20140108112359.GA2669@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
List-Id: <linux-sh.vger.kernel.org>
References: <20131217050232.727.9552.sendpatchset@w520>
 <20131217050324.727.61701.sendpatchset@w520>
 <20131217163435.GC7071@katana> <20140108004157.GH5136@verge.net.au>
In-Reply-To: <20140108004157.GH5136@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> could you clarify the status of this patch for me?
>=20
> I believe it is reverted by "[PATCH V2 4/5] arm: shmobile: genmai: adapt
> dts to use native i2c driver".
>=20
> I'm fine with applying both patches at some point. But perhaps
> we can skip some dependencies by just applying a squashed version?

If we keep this patch and my one on top of it, we need the PFC series.
If we skip this patch and use my native I2C right from the beginning, we
can skip the PFC series and have i2c support right away. I'd prefer the
latter. I am about to push a branch to my tree that does the latter
these minutes.


--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSzTVPAAoJEBQN5MwUoCm2yioP/2LgNaFxRRS8Ryix+FxYmalh
PCZJPAvDYZxVBAJPn/inXrgq5nzclQ81CBKF710naIFxyG8k+qGih/DPvS45BZhj
6TBRCHwXfDsBzyQ8Fa58dDpO0Yvp9it5jU98Jicin+rK07pR48rRufrdEOersaOY
nzu94x2Z7ARplWLQ8NAnLcbYI+LeVKX5xOV8BfHgb6qPJMq8Gq+ohJb79RIudIHU
mdLPIwaE5JOGOYb4Y/nZ87k+FXDadpWMlok+dQEMyx9LedB+Xq2B/BpaSB3yTCWB
tFAGdrJtQwf6ksOAQ5j/EJ9ZRPAanTjdllwoi37RHvZDKmF5du1+sTQPot2zql6K
2DOn8ylK0OCac46CoxOWwhfIWZ4qTaQ14apPdhQHK1N0fWwYjb56QD8PCJw3F5pz
6FJ35UYK9IY/49pObwCjp2kTyeYiCGaVpSQF3fpEiF2x7OO9Po+jNRuTNtEqxFrc
cvvBGWNaF19VaIbCG54mWpo0NkGgkB5GxJW4kveu0vcv0Wf4IMieIODLFCsQJ5Jm
uZNsQTCRkIU0h2Z0ccheNEfiPe4Hr0Mp6nkisvWzyX1NFA8W0F7edRESBl6b2kFt
FkEG6sSV5xuKNTn79ObBkNkx1QOSPnKCcOsVEUA6c4s+PdsbSo05HTtQ9J9fxun9
yhW/4mmryVbdLZL270Ik
=poj2
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
