From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 08 Dec 2015 21:51:03 +0000
Subject: Re: [PATCH v2 2/9] i2c: add generic routine to parse DT for timing information
Message-Id: <20151208215103.GA1601@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
List-Id: <linux-sh.vger.kernel.org>
References: <1449567473-2084-1-git-send-email-wsa@the-dreams.de>
 <1449567473-2084-3-git-send-email-wsa@the-dreams.de>
 <1449572085.30729.28.camel@linux.intel.com>
 <20151208130323.GB3359@katana>
In-Reply-To: <20151208130323.GB3359@katana>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-rockchip@lists.infradead.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2015 at 02:03:23PM +0100, Wolfram Sang wrote:
>=20
> > Too many && use_defaults. What about
> >=20
> > memset(t, 0, sizeof(*t));
> >=20
> > device_property_read_u32(dev, "i2c-scl-internal-delay-ns", &t-
> > >scl_int_delay_ns);
> >=20
> > if (!use_defaults)
> > =C2=A0return;
>=20
> I like this! Thanks for the input.

Oops, too enthusiastic. This skips parsing all the other properties...
The defaults should only be applied if reading the properties fails.


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZ1DHAAoJEBQN5MwUoCm205QQAIAcu4hOGoYSXAVySnE6QDW8
FBMvu6A0E1HKj3eppDV32HN2bO19tkzLofLn9gTnEbhIrSTn8lxRQgVbr+r0XxO4
jjN/GAvn/OyZPEaGrAObpwA1tkDij+Kjvyh2gorqp3xNJ+5/MfFardniMSyyjPuj
LcTQo5vjD1Saf76HltKLWpSFgXTvQ0WMGYdLny0tOvO7YsekN/e/PEmqYGjBXEgy
dUN0YiVNk5ma1eOmc9Q8gMieuG1ShkorvwplW23py3Gd/HJ/PzBxrv9Kenewe07g
BgM7kED+Wl4HkxlVL1oL0sNzzs2LZZYSui48f0DVAGgNidefyvsC7gF4vz7RoqHv
BMJD+lX8SDfheR2ydypsgsFxjJSQ6i07rH/0NucpBY3RKGwqQlUrCAoxo+DPKfgB
e4orimnI/ZFSbMQ3QZSOAnnYNymQgKXN9Tad5VLfBm+1sf3jHVdWos/beUDeg8F8
vVXZvsTY2m2APnnE7hmV2tMXSBvCVr7yXZLWQBXTUNylnWBspHT/oXw5Iul3/MRQ
4oay4zH36C0aNPX2Yn8CvxivGtckKp+O8oTj/t7P8bGEGW3HtbvJ9hKDy9CUb6Uy
Wx6A27rSM1fMtnolD9wJOFRLwippFtZ+cBLADwd923+N+rmHpMNn1fnzIKFqopO4
hWo88aJ2n96ZiGEbDweU
=ITRi
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
