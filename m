From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Dec 2014 18:29:06 +0000
Subject: Re: [PATCH 2/2] i2c: sh_mobile: rework deferred probing
Message-Id: <20141217182905.GD3981@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Xm/fll+QQv+hsKip"
List-Id: <linux-sh.vger.kernel.org>
References: <1418733086-26324-1-git-send-email-wsa@the-dreams.de>
 <1418733086-26324-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418733086-26324-3-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>


--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2014 at 01:31:26PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> DMA is opt-in for this driver. So, we can't use deferred probing for
> requesting DMA channels in probe, because our driver would get endlessly
> deferred if DMA support is compiled in AND the DMA driver is missing.
> Because we can't know when the DMA driver might show up, we always try
> again when a DMA transfer would be possible. The downside is that there
> is more overhead for setting up PIO transfers under the above scenario.
> But well, having DMA enabled and the proper DMA driver missing looks
> like a broken or test config anyhow.
>=20
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-current, thanks!


--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkctxAAoJEBQN5MwUoCm2y2IP+wZ5bw+HGMG8Zy9F5JNPU5T2
IPmrdf2sqd5+YDOj5oiZJO3yxco+8X/oBpGKY40hN/DAg7khq0Bx8RFf6QYjAeeY
yjIzcNkK51V+3iNjv9TtESL/3R0z/lXL1Ex4xFC5AXvxDs9XKwKn1cvIYQSjXfu8
B3GmGQP2KEu7P+7ruo8/6CdkK/e03sd8v/iZQClmsYE4R6HznjlNuald2ARlID5z
4NGk+/QioidFq5vQ6GpHTYs8AIJ6R/w1xRLXG9HssCXK2Ji5JbtdoE7Mj9exDzuC
Ynr92I3LC/KCCoI4CfhGW6xhJumHnjzkpyMp8IvdkfcJWkbNZS8ZDFBFn6wZ+agC
J/xo11Fgs93p9MnT3U76mkfZryqNmMENTZypHmHoN3idWO5/fRQv8J2RK0xfgiGs
1FmXmyOiL4KpYKroEG9Kwti/+gLSvVZv6azZx2kSmRENDOr6Q/JRAdGiN5xHuOOi
bPtKQG/GrM6KGkUHwUhklTS0oETv6Y2sy1VzIg6XFUqg7Cc4A/9qo4PVKeDRB0mp
zaoQb75vnv0g0uQxG1RV70kdUVeXlVUorOr4WE4cECqpgY9oNfZWwa3QpZZ5ZR9n
46iK9J4EldRk60eYe/rH3rheJg/y3fnZe1yKJSJXdb6Hx06dvklAxSaqZQOi5fWb
tHmwvJ8ypOwsSqT9qc9s
=lDfV
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--
