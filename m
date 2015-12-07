From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Dec 2015 06:27:40 +0000
Subject: Re: [PATCH] serial: sh-sci: Fix length of scatterlist
Message-Id: <20151207062740.GG22834@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449238879-31169-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449238879-31169-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Fri, Dec 04, 2015 at 03:21:19PM +0100, Geert Uytterhoeven wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> This patch fixes an issue that the "length" of scatterlist should be
> set using sg_dma_len(). Otherwise, a dmaengine driver cannot work
> correctly if CONFIG_NEED_SG_DMA_LENGTH=y.
> 
> Fixes: 7b39d90184 (serial: sh-sci: Fix NULL pointer dereference if HIGHMEM is enabled)
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

