From: Chris Ball <cjb@laptop.org>
Date: Thu, 26 Sep 2013 01:29:43 +0000
Subject: Re: [PATCH][resend] sh: ecovec: fixup compile error on sdhi
Message-Id: <87mwn04bg8.fsf@octavius.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjr1ll6g.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjr1ll6g.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Sep 24 2013, Kuninori Morimoto wrote:
> afa2c9407f8908e2269b243773cbb0997c553804
> (sh: ecovec24: Use MMC/SDHI CD and RO GPIO)
> added .tmio_flags = TMIO_MMC_USE_GPIO_CD
> on sh_mobile_sdhi_info, but it needs
> <linux/mfd/tmio.h> header.
> This patch adds it
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
