From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 22 Sep 2014 13:00:26 +0000
Subject: Re: [PATCH][resend] of: Add vendor 2nd prefix for Asahi Kasei Corp
Message-Id: <20140922130026.GK3290@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
 <539815E6.2050304@codethink.co.uk>
 <20140611165410.GK5099@sirena.org.uk>
 <CAMuHMdUT0hEBGbN+W-Oz5zJ0N8S2VDMndqtDO=EtWF3jG2MEew@mail.gmail.com>
 <20140611170233.GL5099@sirena.org.uk>
 <5398A53D.3020706@wwwdotorg.org>
 <20140611190444.GN5099@sirena.org.uk>
 <5398AB07.4040304@wwwdotorg.org>
 <87sinbdk44.wl%kuninori.morimoto.gx@renesas.com>
 <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <878ulzx6hr.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, olof@lixom.net, Stephen Warren <swarren@wwwdotorg.org>, robh@kernel.org
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, grant.likely@linaro.org

On Thu, Sep 04, 2014 at 07:08:37AM +0100, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current vendor-prefixes.txt already has
> "ak" prefix for Asahi Kasei Corp by
> ae8c4209af2cec065fef15d200a42a04130799f7
> (of: Add vendor prefix for Asahi Kasei Corp.)
> 
> But, almost all Asahi Kasei chip driver is
> using "asahi-kasei" prefix today.
> 
> This patch adds "asahi-kasei" to vendor-prefixes.txt.
> checkpatch.pl will report WARNING without this patch.
> (DT compatible string vendor "asahi-kasei" appears un-documented)

If we're adding a new string, we should figure out what's happening with
the old one. We want some consistency here.

From a quick grep, it looks like the only use of "ak" is "ak,ak8975" in
arch/arm/boot/dts/tegra20-seaboard.dts. There are instances of
"asahi-kasei,ak8975" in other dts files.

Olof added "asahi-kasei,ak8975" to the ak8975 driver in February 2012
(see 54461c3067b2), and the "asahi-kasei" prefix is currently far more
common. This was only documented in May 2013 (see f4b7f751c6fd).

Stephen added the "ak" vendor-refix was added later in November 2012
(see ae8c4209af2c), and the only instance seems to work due to the i2c
subsystem doing something dehind the scenes with the compatible string.
So I think we made a mistake there.

Given all that, I think we should get rid of the "ak" prefix entirely,
fix up the seaboard dts, and leave the legacy matching for "ak,ak8975"
up to the i2c framework. However, that would imply deleting from
vendor-prefixes.txt (if we want people to be warned on use of "ak"), and
that's not a good precedent to set.

Thoughts?

Mark.

> OTOH, Asahi Kasei is usually referred to as "AKM",
> but this patch doesn't care about it.
> Because no DT is using it today.
> 
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index abc3080..7e4bb83 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -17,6 +17,7 @@ amstaos	AMS-Taos Inc.
>  apm	Applied Micro Circuits Corporation (APM)
>  arm	ARM Ltd.
>  armadeus	ARMadeus Systems SARL
> +asahi-kasei	Asahi Kasei Corp.
>  atmel	Atmel Corporation
>  auo	AU Optronics Corporation
>  avago	Avago Technologies
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
