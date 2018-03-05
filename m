From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 05 Mar 2018 09:22:59 +0000
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Message-Id: <20180305092259.bcpfbzvvoqxsfomf@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="otjtt6lvg234ipuq"
List-Id: <linux-sh.vger.kernel.org>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <20180304224248.mzhsvl4ccmtzg5am@ninjato>
 <CAPDyKFq_1mR=b3iu6o4ZJQeAjRnWf_tzb=__7SxvZYqDNCo2bg@mail.gmail.com>
In-Reply-To: <CAPDyKFq_1mR=b3iu6o4ZJQeAjRnWf_tzb=__7SxvZYqDNCo2bg@mail.gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>


--otjtt6lvg234ipuq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I have added Wolframs tags to the already applied patches and applied
> that last two, 15 and 16.

Thanks. Please note that patch 14 misses my Rev tag. (I gave it
yesterday but the patch was accidently applied before. One round too
early, so to say).

> They are all present in my next branch. The fix that Wolfram sent on
> top, is added immediately after the commit it fixes.

Could we also squash it, then?


--otjtt6lvg234ipuq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqdDGsACgkQFA3kzBSg
KbY17A/+IDT0E3zqsrKQG3Gv9dXc2OBuEEOpjyQGn2WLSiFUW/YNY+HfZO9af/MF
YRqPBeqWVdUYsB4S4d++HqHYipQYF2Mngi5o7oC1qRoVauoWwJuc4pSY7yujQ7Ux
c3aEt+HEWcU1gR/3vsnAwGMjoWNyRtONl6W2NRUwM6sj+dLjHubSDVuE8hJ6/MUD
jmmuhLFC6NkXhhbz2lN3i2QVlI1B9LX5Hj7vWTm7D4afWykuxLI/+tY5ycGuC0in
S33YCD7iHdWw1C5A6TlVwSlmAsVOCPtL87FQABOlhkeaJcJWTlhncgkTstqoYDyd
c5thdAH2vtMIuhmb6+RK4G8yQdKK7HGzUl7Of6/y8wIn4eKKoyJ3b4WDMKewy6EL
96DJlj2eaCCK+EV64o0Eq+MC50OSkL5OSuWhEUSX7oaB6twVF7Mmjo8hxYYvRLqM
rGOcaGua4Zzj2iS1Cx5GB7o4cAq/2btqeR9V1KZsQzsyHXC9g25LEQnnvmt/n3cM
E7BK+9RnEc2JcvrVFXzevNhWgGNTzHttmXyzHl4s783o79f5liLAK2NG+mM1hwTR
sPIUI8TwEqVg3lJxIoRUWPWKka7sqlDZ5C79gNZbc0QwC9FKHvGFyRQqWq/xXs0K
ela9XXc607vVX9VismHS3GKF0koS8LmZLhXYSv3eZm+2l9dlGVk=
=DgLh
-----END PGP SIGNATURE-----

--otjtt6lvg234ipuq--
