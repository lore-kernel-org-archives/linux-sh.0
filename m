From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Dec 2008 12:01:12 +0000
Subject: Re: [PATCH 00/06] sh: sh7343 and se7343 patches
Message-Id: <20081204120112.GA14492@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081204085946.25773.64257.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081204085946.25773.64257.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 04, 2008 at 05:59:46PM +0900, Magnus Damm wrote:
> sh7343 and se7343 patches:
> 
> [PATCH 01/06] sh: sh7343 scif configuration update
> [PATCH 02/06] sh: fix number of interrupts on se7343
> [PATCH 03/06] sh: add st16c2550 devices to se7343
> [PATCH 04/06] sh: add isp1161 usb host device to se7343
> [PATCH 05/06] sh: remove ioport cruft and smc91x from se7343
> [PATCH 06/06] sh: update se7343 defconfig
> 
> This patchset simply updates the sh7343 processor code a bit and
> modifies the se7343 board support code to include the external usb
> host controller chip and on-board uarts. The out-of-date ioport
> code gets removed while at it - including some old support for
> unknown-ne2000-pcmcia-card, cf-over-pcmcia and a mysterical smc91x
> that once must have been on a special daughterboard.
> 
> Now with the USB host controller in place we get network connection
> using an ethernet-over-usb adapter (yay) but we're still unfortunately
> stuck loading the kernel over the serial gdbstub which makes kernel
> development too slow to be practical.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
