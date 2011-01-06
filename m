From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 04:12:28 +0000
Subject: Re: [PATCH 4/6 v3] sh: sh7724 Enable SDIO IRQs
Message-Id: <20110106041228.GM23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-7-git-send-email-arnd@arndnet.de> <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-6-git-send-email-arnd@arndnet.de> <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-5-git-send-email-arnd@arndnet.de>
In-Reply-To: <1293574956-30035-7-git-send-email-arnd@arndnet.de> <1293574956-30035-6-git-send-email-arnd@arndnet.de> <1293574956-30035-5-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Dec 28, 2010 at 11:22:34PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure interrupt
> are handled announce the MMC_CAP_SDIO_IRQ capability
> on ecovec, kfr2r09 and se7724.
> 
> Tested with a b43-based SDIO wireless card on ecovec.

On Tue, Dec 28, 2010 at 11:22:35PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure SDIO IRQs
> are used, announce the MMC_CAP_SDIO_IRQ capability
> on migor.

On Tue, Dec 28, 2010 at 11:22:36PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure SDIO IRQs
> are used announce the MMC_CAP_SDIO_IRQ capability
> on ap325rxa.

All applied to sh/sdio, thanks.
