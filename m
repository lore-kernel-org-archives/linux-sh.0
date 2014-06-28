From: Mark Brown <broonie@kernel.org>
Date: Sat, 28 Jun 2014 13:40:46 +0000
Subject: Re: [PATCH 07/10 v2] ASoC: rsnd: enable SRC setting via DT
Message-Id: <20140628134046.GW2520@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FclElvQKoGCylS3A"
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
 <8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
 <87vbrssar8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbrssar8.wl%kuninori.morimoto.gx@renesas.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org


--FclElvQKoGCylS3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 22, 2014 at 05:57:42PM -0700, Kuninori Morimoto wrote:

>  SRC subnode properties:
> -no properties at this point
> +- convert-rate			: SRC convert rate if needed

It's not clear to me why this is something that we'd control in the
device tree.  Are there some systems which can't support this, if the
hardware can do it it's hard to see why someone wouldn't want to use it
(and why it wouldn't be a runtime decision anyway).

--FclElvQKoGCylS3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTrsXbAAoJELSic+t+oim9je4P/3xoI/WUlQsITk3mdzSB/OyL
ezrq1kfEhIyoqozvE7cuZCzItcxnk5paWvQ6DRp2gBwEIGiIhPOona9ktXiehjob
aFEw8AhASjNeti9TF54tNpc5KyEpXDa7NOH/3wgbWelAFDnjJhZr1WbQkYD5v4VD
XR13+iGAmHSTZfsyvWnPTtmHu/qtquV4ILe7/PWrvkyFAB2imXZ6BbpdrHToMj/L
HoQOXvYlG2SDQoRtexeFDB2t2GAS2TlKnkWcyVtm5K6xLBAgmTng4K9EFnZVXLxx
Q/ix1aHL5DscPBwbAOn5/GDPa9x8+N6y2nLVRoHZEnowDw4d4WKvqC8YXMFZUzea
yVVtw3WqHwspgZqDq7NjgSZ3YsLnqHwNAVpitGkR0cOYC7apncwqgSAaSJv4c/1r
GIxE+8X2vQPfvNVjfQErbph7w603Yhej9pDPNfU+VJyouppJkQXye+8m8HS5Uyv6
sxhuGZYutD8g2Gtk45kdgjBUgWsXNUp/sBw6Z+hTzUglFHK5PJzW4zWh51JHHrE+
jkZ9C4G+q6vcZOAp62B8kvCG+fOOE6IFX9FdrJP8CooWjb/QxbgnVPIqcShU3YzN
g/gbTnXOrjVun5zCNpbE9SjPrirjfzBZGU2IICKzr+Ve1wUgdv7+45QnrDWFLE9P
P00PsauilS6WlBNjsw3F
=2QJu
-----END PGP SIGNATURE-----

--FclElvQKoGCylS3A--
