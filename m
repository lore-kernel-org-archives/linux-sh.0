From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 06 Aug 2015 08:37:23 +0000
Subject: RE: [PATCH 03/13 v4][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <SG2PR06MB091903A75C962DCEFA80F0C7D8740@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87si7wyhde.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87si7wyhde.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch!

> Sent: Thursday, August 06, 2015 5:06 PM
> 
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
> 
>  - use simple-bus topology
>  - remove IRDA from clock.h
>  - RCAR_GEN3_CLK_xxxx -> RCAR_R8A7795_CLK_xxxx

I prefer R8A7795_CLK_xxxx than RCAR_R8A7795_CLK_xxxx :)
After that, it is the same style as previous SoCs like R8A7790_CLK_xxxx.

Best regards,
Yoshihiro Shimoda

