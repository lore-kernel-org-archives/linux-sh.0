From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 10:59:53 +0000
Subject: Re: [PATCH] sh: Revert CONFIG_NR_ONCHIP_DMA_CHANNELS to MAX_DMA_CHANNELS
Message-Id: <20090316105953.GA21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8ACFF.1030604@renesas.com>
In-Reply-To: <49B8ACFF.1030604@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 12, 2009 at 03:34:39PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> ---
>  arch/sh/include/asm/dma-sh.h |   17 +++++++++--------
>  1 files changed, 9 insertions(+), 8 deletions(-)

On Fri, Mar 13, 2009 at 01:31:34PM +0900, Nobuhiro Iwamatsu wrote:
> get_dma_error_irq() used in dma-sh is function for exclusive use of SH4.
> SH3 doesn't have DMA Error interrupt.
> This fixes it to compile it only in SH4.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Fri, Mar 13, 2009 at 02:03:37PM +0900, Nobuhiro Iwamatsu wrote:
> -- log --
> arch/sh/kernel/cpu/sh4/../sh3/entry.S:365: Error: invalid operands for opcode
> make[4]: *** [arch/sh/kernel/cpu/sh4/../sh3/entry.o] Error 1
> make[3]: *** [arch/sh/kernel/cpu/sh4] Error 2
> -- log --
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

All applied, thanks.
