From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 30 Apr 2013 10:33:17 +0000
Subject: Re: [PATCH v8 1/2] dma: sh: add Kconfig
Message-Id: <20130430102117.GC1960@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <517669B6.7040801@renesas.com>
In-Reply-To: <517669B6.7040801@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 23, 2013 at 08:00:06PM +0900, Shimoda, Yoshihiro wrote:
> This patch adds Kconfig in the drivers/dma/sh. This patch also adds
> a new config "SH_DMAE_BASE" and the "config SH_DMAE" depends on it.
> Since some drivers (e.g. sh_mmcif.c) depends on shdma-base.c if
> CONFIG_DMA_ENGINE=y, the "config SH_DMAE_BASE" is set as "bool".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Applied, both with checkpath fix for
WARNING: please, no space before tabs
#661: FILE: drivers/dma/sh/sudmac.c:416:
+^I.driver ^I= {$

You _should_ run checkpatch _always_ before sending the patches

--
~Vinod
