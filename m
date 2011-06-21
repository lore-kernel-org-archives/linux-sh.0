From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Jun 2011 08:37:46 +0000
Subject: Re: [PATCH] usb: renesas_usbhs: use dma handler
Message-Id: <20110621083744.GE7920@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 03:09:19PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/usb/renesas_usbhs/mod_gadget.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
Does this have any dependencies? What about platforms that don't support
dmaengine?
