From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 04:41:26 +0000
Subject: Re: [PATCH 0/2] usb: renesas_usbhs: add support for requesting DT DMA
Message-Id: <87iofzl93m.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421639597-2784-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1421639597-2784-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi shimoda-san

> This patch series is based on Felipe's usb.git / testing/next branch.
> (commit id = 05cf6e00b8ff2b80c8b2d1e69f07cdd6c830efe0)
> 
> Yoshihiro Shimoda (2):
>   usb: renesas_usbhs: add usbhsf_dma_init_pdev() function
>   usb: renesas_usbhs: add support for requesting DT DMA
> 
>  .../devicetree/bindings/usb/renesas_usbhs.txt      |    2 ++
>  drivers/usb/renesas_usbhs/fifo.c                   |   21 +++++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)

I guess we can (should ?) use dma_request_slave_channel_compat()
instead of dma_request_slave_channel_reason().
And, we can use shdma_chan_filter instead of original usbhsf_dma_filter()

