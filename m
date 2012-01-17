From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 17 Jan 2012 10:53:50 +0000
Subject: Re: [PATCH] sh: fix the sh_mmcif_plat_data in board-sh7757lcr
Message-Id: <20120117105349.GC8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F153622.3090701@renesas.com>
In-Reply-To: <4F153622.3090701@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 17, 2012 at 05:49:38PM +0900, Shimoda, Yoshihiro wrote:
> The board has an eMMC chip, so we cannot remove the chip.
> In this case, we have to set the MMC_CAP_NONREMOVABLE to the caps
> parameter.
> 
> Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.
