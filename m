From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 05:26:16 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: r8a73a4 dtsi: Add SoC-specific IIC compatible properties
Message-Id: <20141107052616.GC1278@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eHhjakXzOLJAF9wJ"
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-6-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-6-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:52:10PM +0100, Geert Uytterhoeven wrote:
> The IIC nodes used the generic compatible properties only.
> This may cause the driver to fail when using Standard Speed on IIC
> masters where the operational clock is driven by the 130 MHz HP clock.
>=20
> Add the SoC-specific compatible property to fix this.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXFf4AAoJEBQN5MwUoCm22uMP/2574bStl0HXV/Bov1+H9cyN
b//44WOHH+I0o2vExRS/v916frRWGJ3nHGfaPSLHRSj2EIUXgEJcFccx35WJssmO
8lPBvrSs8cAbhx4KumnVNmrcKNHpQzaYBDh2NCvS5V7RANFEgYgmQDMk3TUyjCD8
QG3wH6IfszacB/oc7Jj30aT/W20ksShSVK7kY9I+lte7KkFfsT7hHvguaRwJtXaC
HiDUixn/aY3n5N98jVC98FpIcwqyeKjmRg6Ixp6ux6nCN8pn8tw7giLI4LBlFkBy
tdMqMS6EV/L/0phpzYgxUSgCR6ZT3i32JsmDemWelfG0CcbfKDjI0DIm/SeW4Z/v
RXZE6XzLxsLDT8gvm//i5HsbTfVCAYfUwrWgcDV2KZjMQNfl4B9A70REPm+34vhs
5cum5kZYBRVH72ycHVm/XDhg9OlxYlzxweN5tZK8Pw3GvBiaZany1HajwaB5uTOM
jICe42LaejbJAqyebGN7h26fNCe7VFJCvWOTVGQpgDm2vCf+zjhvDezDtg3areKp
ZI2Q7RVSPMA30kLXe/IqvXyo47PUdwr2lLT10Atf5yBKu2voNrhUg6j6G+2bf1hd
MbvVX7x0RHLYpr3t1NmmmCag1k50zfqxvdp7Svzy942jKNCiKQppEJ1VaS63yJJc
U8s/YT/N8DKasYV+3tTJ
=1kke
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
