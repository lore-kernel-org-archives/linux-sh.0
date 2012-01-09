From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 03:09:21 +0000
Subject: Re: [PATCH] sh: modify clock-sh7757 for renesas_usbhs
Message-Id: <20120109030920.GJ25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F053033.5050805@renesas.com>
In-Reply-To: <4F053033.5050805@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 05, 2012 at 02:08:03PM +0900, Shimoda, Yoshihiro wrote:
> The renesas_usbhs driver doesn't use the clk functions. So, even if we
> adds "CLKDEV_DEV_ID("renesas_usbhs.0", ...)" only, we cannot use the USB
> controller because clk_late_init() will disable the clock by "usb0".
> So, the patch also removes the "CLKDEV_CON_ID("usb0", ...)".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Thu, Jan 05, 2012 at 02:08:12PM +0900, Shimoda, Yoshihiro wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/sh/boards/board-sh7757lcr.c |   39 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
> 
Both applied, thanks.
