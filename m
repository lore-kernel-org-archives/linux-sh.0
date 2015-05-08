From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 May 2015 14:38:26 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150508143826.GA1513@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
 <20150507220812.3776bb83@endymion.delvare>
 <20150508105401.223a8598@endymion.delvare>
In-Reply-To: <20150508105401.223a8598@endymion.delvare>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Having slept over it, I came up with a 3rd proposal:
>=20
> # i2ctransfer 0 w0x11@0x50 0xc0 0xbd=3D r1@0x51
>=20
> That is, combining the slave address, direction and length into a
> single parameter. The advantage is that this is all more explicit and
> the risk of mixing up values is close to zero. Whether it is more or
> less readable than the previous proposals is probably a matter of
> taste. Also I suspect it would make the parsing and state machine more
> simple, but that's only a nice side effect.
>=20
> Wolfram (and others), please tell me what you think. I am not trying to
> force my views here, just suggesting alternatives for your
> consideration.

I liked your proposal, so thanks for this input. I agree that the risk
of mixing something up is high, I was okay with the printout of the
messages to be sent, but a better syntax is very welcome, too. I need to
think about the flags a little bit, though. Although this isn't
implemented yet, PEC and 10-bit flags might be added in the future?
Handling R/W as "just another" flag made this option extremly simple.
But we probably can work something out.

So much for the quick response, I'll have a closer look later.


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVTMpiAAoJEBQN5MwUoCm2jbUQALPzlEHZunli6Uc7mh2Fi+8n
lj9eiWmLA/k/4mzeOQXewmyVW9M7y0kORr4Wpzrsv1VmIoXBfcrRuVySZEuTpdCi
+KFRDbIFYCarloqqxjRO5VKGCOcj/znp0QrE8rZQoUU8yW0BHv7ey2ef081tLNfq
1i2BvagYfQQSImJFub8wVIGtp2QJtCHJe5vPzIB2GCKMbxvYrFhlVp14MiQ2jvS4
prKAITePZHI3TLI+JH++3VNHivNnJhLPa7Inm5RXG/shMYGMX9jspXZtnN80JLk0
pqrrlN61gRBZf7FJTNC7GNIWXl85JDHeAB80BJo0+dAElHHOCDnwBtaxOJqYjN9M
vSgTCuMEvw/IJ+/g6zb526sJxCGyAmznFYWQ6xPqzbKd5nrcjkK7QXnhKhTXHkBE
EzTUYhFypeuFZ0e0L+2H1RL3YMrUse7Ea4io+Mqk/a8fXhcj5i6VVbwHdrPe4wHB
Gj3ykVo/NL79F202sitDDaiwCyKyz6c5RKQa/beXfNiaAWiLwk8Lkn8hRTmOOcOe
6HSYZxxn7JsZhudeUO9LQ5SWh/B+klcFzzTMd6swurziU2tVznOf7LiJkgccsApv
QQa9gScOIL0qbEYgVrR7V/llcuep06N16O9yj3MPF/0pb0juKYCVl/6DPRP4KHd4
M8cKcJrDBJSEAb7BJa38
=m294
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
