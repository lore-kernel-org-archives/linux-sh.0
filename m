From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Nov 2011 07:46:05 +0000
Subject: Re: [PATCH] sh: fix build warning in board-sh7757lcr
Message-Id: <20111118074605.GF30555@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4EC60A12.9000504@renesas.com>
In-Reply-To: <4EC60A12.9000504@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 18, 2011 at 04:32:34PM +0900, Yoshihiro Shimoda wrote:
> This patch fixed the following build warnings:
> 
>   CC      arch/sh/boards/board-sh7757lcr.o
> arch/sh/boards/board-sh7757lcr.c:77: warning: initialization from incompatible pointer type
> arch/sh/boards/board-sh7757lcr.c:106: warning: initialization from incompatible pointer type
> arch/sh/boards/board-sh7757lcr.c:151: warning: initialization from incompatible pointer type
> arch/sh/boards/board-sh7757lcr.c:181: warning: initialization from incompatible pointer type
> arch/sh/boards/board-sh7757lcr.c:213: warning: missing braces around initializer
> arch/sh/boards/board-sh7757lcr.c:213: warning: (near initialization for ???sh7757lcr_mmcif_dma.chan_priv_tx???)
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied, thanks.
