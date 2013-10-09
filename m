From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 09 Oct 2013 22:43:17 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791 PFC support
Message-Id: <17712286.HDNRip2xPu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008040824.3480.69707.sendpatchset@w520>
In-Reply-To: <20131008040824.3480.69707.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

On Tuesday 08 October 2013 13:08:24 Magnus Damm wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Add PFC support for the r8a7791 SoC including pin groups for
> on-chip devices such as MSIOF, SCIF, USB, MMC, VIN, SDHI, DU.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [damm@opensource.se: Forward ported to upstream, reused existing sh-pfc
> macros] Signed-off-by: Magnus Damm <damm@opensource.se>

BTW, the patch was too big and didn't make it to the list :-/

-- 
Regards,

Laurent Pinchart

