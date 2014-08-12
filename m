From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 12 Aug 2014 21:43:43 +0000
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <20140812214339.GA2898@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
In-Reply-To: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2014 at 03:11:18PM +0200, Geert Uytterhoeven wrote:
> Hi,
>=20
> On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.
>=20
> In light of the proliferation of other members of the R-Car Gen 2 familie=
s, is
> there a plan to make this consistent?

The 'i2c'-prefix describes the IP core handled by the rcar driver. This
core is named i2c in the datasheets.

The 'iic'-prefix describes the IP core handled by the sh-mobile-driver.
This core is named iic(b) in the datasheets.


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT6oqKAAoJEBQN5MwUoCm2WisQAKa8q8Bx2JMJJuk4cRrVdqit
NYKWQPcisdxxG/esbo+5NGECnsKK0NqIjkHH4eDTCc5+nL10Sr8FEbh2SLCKLr8e
JQjrZhVkS0GGvRwOKeYWcOdnJlHzZUVHZt84wz6/yX7kyfXu6GTzE9TVoPX4lYFL
IUWUcAXjI1VZ6hGO557VfDxoElo+uv2f0jZj78fG96Yb9n/lg/ppToFX+UulAcc1
xQl73i6FKVwY0LL6fHDMmVo15xlTwa/SS4gI+Nr1OKcnsdNfQB6XsfbiSvTOomam
3QFPT1YgPPLnPmCuaztE2/Zl6+drXPpoRul/SBAbgdN7Y3yfQDG5KTIiWHuTsCf0
TXXRTe7MiG2VuzzuLWR8+fQXajTxS5odq08aRX7FaCpCN1T90QvEBlPLE7S2hGZ7
BVQb3qI6cUDaizTtHHm4KPSeJIgv0cnDTu4jNVeWuF27lb4FtvnUIpz7u2MxRTdJ
EIMN4AZrg8XPxb3jFiD72EDleyy+UFRqHui9NDX68YoCIviw/9i4XWEFHs621L+o
T0DKexovRcgWqDAt66ia/VyBcphlqJ8xkjmMP1UMyjML8AQ0WTpLcCt0+nwopCAT
0+swCmXUrPRKAI3SPb0a+3XbttXlK7ksYQI4hFtUw201h3VMdbMjdpSmf4jebyOx
2lUbq2e08ZE/uzNFx6cU
=cMim
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
