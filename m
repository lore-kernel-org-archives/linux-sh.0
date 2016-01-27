From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 27 Jan 2016 07:14:17 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <20160127071417.GA1521@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-sh@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 01:26:26PM +0100, Dirk Behme wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>=20
> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>=20
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

So, I tested this patch and it basically works. I say basically because
the SDHI code currently does not change the clock rate, only
en-/disables it. UHS support will need to change the clock later.

One thing I noticed: SD0-2 are 50MHz like the docs say. SD3 is 200MHz
and I couldn't find a reason for that when having a glimpse. Dirk, can
you check?

> +		if (i >=3D clock->div_num) {
> +			pr_err("%s: 0x%4x is not support of division ratio.\n",
> +				__func__, sd_fc);
> +			return -ENODATA;
> +		}
=2E..
> +	if (i >=3D clock->div_num) {
> +		pr_err("%s: 0x%4x is not support of division ratio.\n",
> +			__func__, sd_fc);
> +		return 0;
> +	}
=2E..
> +	if (i >=3D clock->div_num) {
> +		pr_err("%s: Not support divider range : div=3D%d (%lu/%lu).\n",
> +			__func__, div, parent_rate, rate);
> +		return -EINVAL;
> +	}

For the above code blocks:

a) I'd think that a consistent -EINVAL would be a proper return value.

b) The driver doesn't do much error printouts, so I wonder if those
messages above are favourable. If so, they should probably print which
sd clock is affected?

Thanks,

   Wolfram


--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWqG5JAAoJEBQN5MwUoCm2iTAQAINHnZdbLuvtzd806+cOjAdg
AcXVgo+fMXjb1G0ohYpQapg7ZBhDZd8jW/xUjiUR8ZmSVMcVQLZXaT5MoOYyEbEL
hNekoxB6THrP0gIBH8SS3zi2toKakFC4Ewv4ci3ROCQW5r+Ks66SYUp03ivmUgyO
mulqJ0dX8J3CiUh+nhJymWG9xpmrNpWitlqvux1C9y7Vif8UkHImBR504URUILGK
bSJ9nc13RQ4bPXPMd8x6WIc/Z3921T8g49a+nwCC35Df2oncYxJnmkBNUF/TfMbo
VkX4rGh4L+Bf2p1IvmYlM995m+yDe8m+JtYJ1BCvNERZ+btVPvS5hnr/LrC+rBK8
xJPjJt7aJAmQMxJKg60y4LtF2SOzJTbk6BjVi0yqsMQOo6cY1LQ06JR7dGBA4fJM
15+j1f5q1ln0bfwutm9yKMuuPV5MnRfov5Co5IsA46vK3507aYiJYssOflUbQzM7
1F9TPRvq4nEuppfr+cX+59N64Fsv40U+JlTW966i8tDTC0Aq2dl3TjM1ZYvmXDxE
U26wrc9ZJOR5dcyNF2R0D0SCu7JrHQ+FVS/2r6BOqJHxipsnJcmlD+MthMQXYjNW
Ex2VGm+jRcf25mvThpOa696KpYkkiwHjnZiOihvvZTRjjFsWCaZA34ob96aE84or
CPDN57EgCp1H8vOkiRBg
=sNHF
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
