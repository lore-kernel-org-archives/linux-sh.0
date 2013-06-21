From: Mark Brown <broonie@kernel.org>
Date: Fri, 21 Jun 2013 10:01:09 +0000
Subject: Re: [PATCH 1/2] regulators: max8973: fix multiple instance support
Message-Id: <20130621100109.GO27646@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MdEjg5WkSuUg8x46"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1306210825040.27277@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306210825040.27277@axis700.grange>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2013 at 08:30:22AM +0200, Guennadi Liakhovetski wrote:
> Currently the max8973 regulator driver uses a single static struct of
> regulator operations for all chip instances, but can overwrite some of its
> members depending on configuration. This will affect all other MAX8973
> instances on the system. This patch fixes this bug by allocating a separate
> copy of the struct for each chip instance.

Applied, thanks.

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCRiAAoJELSic+t+oim9xQgQAJSdRNzHJ0X6ciAgJIGqh3vK
S88sMEpiT7Q4lswVPjSc8n9xd8cPpHwemXzOTB7IfB28a3Yz6DE9c2T6KSesuYcH
nn4rULpVEdPKcJns9WLU5YzytlSNBuyVxYhfap9sXBPRPbUnUvM7FeE3rA99UHBP
y1cCFD5u+rkrrf13OnwpJiMPT3ofRKBYik2kNpruUjGPa6ni+zsx6/13LAuChrUY
Ej6gZbqT1JX1fCw1qi/EkkcKse75qAEfb9ndI4ufbizCux7HiVeBX5UQOPzL7AKo
agOFSLGgTStZAOytKyyowYh5fLQnLXa/Ua527HpjhWOAHfeJqrzmqvieqIgYZNuA
W3mCcmbJSmYX7/XMvaUkhVywzPJrmNKQ51LHy9+iW2i5KBVjrP4CP290qyt6KFje
CPIaKjLB9NgZj5duN60SV8LhM6VkgOlmV3o7esfVbG8qrTZBFXhCtDd1vCu5WS/7
5HfBHqfszupCIG9bJGD7I/41vhIcb43GsXoAt8+w8i1sda0u4dC6w9bAMb2pOXsy
CwxCMqXvo1uM7SKPHJhGdDwqA4dmCbwqytMCrwkUVS2jiu42JsqjtRwd2JI3GtH0
H+E6HI49gfTpO/k87+BSKTX4B3MlR7iNMk+9QAFBB8Nct8mwXpg31iHp5SeHmWNB
f6cYSv4pULYxTF62Y3Nl
=dyJV
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
