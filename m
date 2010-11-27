From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Sat, 27 Nov 2010 11:54:41 +0000
Subject: Re: [PATCH 3/3 v2] sh, mmc: Use defines when setting CE_CLK_CTRL
Message-Id: <AANLkTi=zKbNhVz=Bh7ytRezobsnxeWE49mJcAS=rJ4Oq@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1290812579-20410-1-git-send-email-horms@verge.net.au>
	<1290812579-20410-3-git-send-email-horms@verge.net.au>
	<20101127000109.GA29427@verge.net.au>
	<20101127001155.GA30946@verge.net.au>
In-Reply-To: <20101127001155.GA30946@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>

2010/11/27 Simon Horman <horms@verge.net.au>:
> The 16-19th bits of CE_CLK_CTRL set the
> MMC clock frequency.
>
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
> =A0include/linux/mmc/sh_mmcif.h | =A0 17 +++++++++--------
> =A01 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
> index 519a2cd..44fc534 100644
> --- a/include/linux/mmc/sh_mmcif.h
> +++ b/include/linux/mmc/sh_mmcif.h
> @@ -77,6 +77,9 @@ struct sh_mmcif_plat_data {
> =A0#define CLK_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 24) /* 1: output mmc =
clock */
> =A0#define CLK_CLEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0((1 << 19) | (1 << 18) | =
(1 << 17) | (1 << 16))
> =A0#define CLK_SUP_PCLK =A0 =A0 =A0 =A0 =A0 ((1 << 19) | (1 << 18) | (1 <=
< 17) | (1 << 16))
> +#define CLKDIV_4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1<<16) /* mmc clock freque=
ncy.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0* n: bus clock/(2^(n+1)) */
> +#define CLKDIV_256 =A0 =A0 =A0 =A0 =A0 =A0 (7<<16) /* mmc clock frequenc=
y. (see above) */
> =A0#define SRSPTO_256 =A0 =A0 =A0 =A0 =A0 =A0 ((1 << 13) | (0 << 12)) /* =
resp timeout */
> =A0#define SRBSYTO_29 =A0 =A0 =A0 =A0 =A0 =A0 ((1 << 11) | (1 << 10) | =
=A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 9) =
| (1 << 8)) /* resp busy timeout */
[...]

Maybe zero is a valid value here meaning CLKDIV =3D 2.

Best Regards,
Micha=B3 Miros=B3aw
