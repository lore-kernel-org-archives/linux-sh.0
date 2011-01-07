From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 01:57:31 +0000
Subject: Re: [PATCH] sh: sh7343 Enable SDIO IRQs
Message-Id: <20110107015731.GH22477@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110106111009.5871.35959.sendpatchset@t400s>
In-Reply-To: <20110106111009.5871.35959.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 06, 2011 at 08:10:09PM +0900, Magnus Damm wrote:
> This patch enables interrupt generation for SDIO IRQs
> of the SDHI block on the sh7343 processor. Use together
> with a recent SDHI driver using TMIO_MMC_SDIO_IRQ and
> with the MMC_CAP_SDIO_IRQ flag in the board code.

On Thu, Jan 06, 2011 at 08:12:27PM +0900, Magnus Damm wrote:
> This patch enables interrupt generation for SDIO IRQs
> of the SDHI block on the sh7366 processor. Use together
> with a recent SDHI driver using TMIO_MMC_SDIO_IRQ and
> with the MMC_CAP_SDIO_IRQ flag in the board code.

Both applied to sh/sdio, thanks.
