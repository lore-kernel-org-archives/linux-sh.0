From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 01:55:17 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7367 Enable SDIO IRQs
Message-Id: <20110107015517.GF22477@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110106103847.7691.38739.sendpatchset@t400s>
In-Reply-To: <20110106103847.7691.38739.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 06, 2011 at 07:38:47PM +0900, Magnus Damm wrote:
> This patch enables interrupt generation for SDIO IRQs
> of the SDHI block on the sh7367 aka G3 processor. Use
> together with a recent SDHI driver using TMIO_MMC_SDIO_IRQ
> and with the MMC_CAP_SDIO_IRQ flag in the board code.

On Thu, Jan 06, 2011 at 07:41:09PM +0900, Magnus Damm wrote:
> This patch enables interrupt generation for SDIO IRQs
> of the SDHI block on the sh7377 aka G4 processor. Use
> together with a recent SDHI driver using TMIO_MMC_SDIO_IRQ
> and with the MMC_CAP_SDIO_IRQ flag in the board code.
> 
> The G4EVM specific SDHI platform data is also updated to
> flag SDIO capabilities.

I've merged these in to rmobile/sdio, thanks.
