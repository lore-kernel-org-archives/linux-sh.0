From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Dec 2015 09:25:03 +0000
Subject: Re: arm64: renesas: r8a7795: porting SDHI/eMMC to renesas-drivers-2015-12-08-v4.4-rc4?
Message-Id: <20151214092503.GB1733@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uZ3hkaAS1mZxFaxD"
List-Id: <linux-sh.vger.kernel.org>
References: <5669BBFA.1020909@gmail.com>
In-Reply-To: <5669BBFA.1020909@gmail.com>
To: linux-sh@vger.kernel.org


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dirk, Simon,

On Fri, Dec 11, 2015 at 10:15:55AM +0900, Simon Horman wrote:
> On Thu, Dec 10, 2015 at 06:52:58PM +0100, Dirk Behme wrote:
> > Hi,
> >=20
> > I've started to look at porting the r8a7795/Salvator-X SDHI/eMMC patches
> > from v4.2/rcar-3.0.x [1] to renesas-drivers-2015-12-08-v4.4-rc4:
> >=20
> > https://github.com/dirkbehme/linux-renesas-rcar-gen3/commits/dirk/gen3-=
latest-update
> >=20
> > Anybody else working on this?
>=20
> On the SDHI side, yes I believe so.
> I'm not sure of the details of the status of that work.

Chances are good that I start working on it beginning of next year. Most
likely with upstreaming the DMA support.

Regards,

   Wolfram


--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWborvAAoJEBQN5MwUoCm2bGIP/03Pazz1BA6RfPwJaVrY1bjG
FX0LApPff0rxYNXlxwGZPzX3HD7S4nVpEdYPUrCXMq7evC4Jd+fr3/2PWnO8CTqH
FCOZmXtExwWqh69WS89c6jf/+g2nXFfVGKtI+loS+u+c7pl8ZuMB/GmrHkd6mKUZ
FBVtOxzG8lBTzc2zLN8zexpKiFNopoPicEi5645zD7Mty1QHDus2urGG06EXtN+Z
79jo0zXGDLXvo9aSMFPyuNgL4Td+J++jpR6PLLeJSOAj9a+zn6nDBMRuH6QMj0/7
XQzFqWfe5Pb9MO8/8REiZsj/xE0XkUUsO6IlsCmrBAP1nyZNdtnik/mNHFx7aFzE
kHZIIhNIlkJ0FcUxCt88jf2kB+q9Rt5YTcuOgJA/l63DDu6lftXLwQBBF80e297M
1FrF8/wRKvYVCMNqxNP+kgDYs3XSpTkEvDD0mIC2FrH6gNSJbStj1ze/zXFkefl+
h1N2FXVwhABrzRqaRHB9dAIlmiC1/QxQLa6jgNQ9mJ/SH6UG7belYxZLvQiwTzEP
cYey0pRGNkbc38wv6LPF+D3f3BMyVZOY7AnvV1p/+SY47wKYVxi505yd72q5NYAn
Yv0JYBXFBftFw1UoAg37ZHlEqfxriBMDokbwR38IyprBO8fEsaBrCsOQkSKtXUDO
dR4yLlKIIRmwrDY+EUVo
=jMi8
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
