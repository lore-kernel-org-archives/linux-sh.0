From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 11 Jun 2012 11:51:32 +0000
Subject: Re: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of open-coding
Message-Id: <20120611115131.GM11439@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j3zO+32zXj6UcJCE"
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
 <20120503153239.GN3955@opensource.wolfsonmicro.com>
 <20120518085749.GE24355@linux-sh.org>
 <20120518150417.GA4039@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111332310.29799@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1206111332310.29799@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org


--j3zO+32zXj6UcJCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2012 at 01:38:13PM +0200, Guennadi Liakhovetski wrote:
> On Fri, 18 May 2012, Mark Brown wrote:

> > This is checking the value of regulator_get(), NULL is a perfectly valid
> > regulator value to get passed back.

> Sorry, could you clarify, how it is valid? No, I'm not proposing to reviv=
e=20
> this patch, just curious, what exactly you meant by this. AFAICS NULL is=
=20
> never returned from regulator_get(). The value, that's returned by it is=
=20
> then directly dereferenced in other regulator API calls, for which you=20
> don't normally want a NULL. So, having a regulator pointer =3D=3D NULL se=
ems=20
> to be as valid to me as causing a BUG() is? :-)

The stubs return NULL and we could decide in future to use NULL for
something else (though that seems unlikely).

--j3zO+32zXj6UcJCE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1du8AAoJEBus8iNuMP3dxWAQAIm7SCZYZiZiBM24qaAiW4fY
3sHDE9JL62b74VJ+5sd3XP0fIJxRamNXg8X2aOACuPsGlZqzXt0UdBUWKN6hdN2F
TDidzli9oXnEZVhOXg3xMozmHqoOr/XhDuCTUROtcojV3tJqo5w2xL8xaEPue4Rd
0xjwYPEddxdoO8yx6iAVMqz8zarF3X2U7aEKI+993sn4ZGqDsoaLZzzNZAKmxS/B
ITBxJY9Eydtvq7QvwjMXUxby6MczS5k5k7XXcVyEqj88BvzasmpiZB3Db20msP5p
Sl6pKHQ5v/TWMlEwrwLLEkMdKmauUpV0fCXeMmjlffuBX5jcOrtYeoxuz9tDU4kv
NMnhzG/gJD3TFPrR6S3G/f2I6QOjUyjU2LTxB+mZeamGuWItFVFaL3rVVPI9gWzw
vYCdhI9mBAtzwB2L1HHdxQXPKp7eVL/gHfB/30j26QHX88iya4YC9ZNCnc2B4TRN
rYrYav+iv9XiaxKUT75SgdbJklkBVtFnMknJ6oz6p0jj9LwvkrGOu9a2Ldog9FC+
7GK6CTTypK591Ts//RpRQ/AWokGGfnEXcWEM78ObChpGW6ei0KzEfkER2qRxlD3j
DaXC4uChNJUPF43rY3btxjNvnO0OR3sAorXM+ZiNhmlu+uVVIKVhOI3TqPzrlMuM
HP5WZ8mY0mvOuQ7H1eSx
=5tEK
-----END PGP SIGNATURE-----

--j3zO+32zXj6UcJCE--
