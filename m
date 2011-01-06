From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 04:11:55 +0000
Subject: Re: [PATCH 3/6 v3] ARM: mach-shmobile: sh7372 Enable SDIO IRQs
Message-Id: <20110106041155.GL23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-4-git-send-email-arnd@arndnet.de>
In-Reply-To: <1293574956-30035-4-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Dec 28, 2010 at 11:22:33PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure interrupts
> are handled announce the MMC_CAP_SDIO_IRQ capability
> on AP4EVB. Tested with a b43-based SDIO wireless card.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Applied to rmobile/sdio, thanks.
