From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 17 Feb 2010 03:48:53 +0000
Subject: Re: [PATCH] sh: fix sh7722 SDHI support using INTC force_disable
Message-Id: <20100217034852.GA16585@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100216051752.6966.30761.sendpatchset@t400s>
In-Reply-To: <20100216051752.6966.30761.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 16, 2010 at 02:17:52PM +0900, Magnus Damm wrote:
> Update the sh7722 INTC tables with force_enable support
> to mask out pending unsupported SDHI interrupt sources.
> 
> Without this patch the kernel locks up due to a pending
> SDHI interrupt that the tmio_mmc driver cannot handle.

On Tue, Feb 16, 2010 at 02:19:19PM +0900, Magnus Damm wrote:
> Update the sh7723 INTC tables with force_enable support
> to mask out pending unsupported SDHI interrupt sources.
> 
> Without this patch the kernel locks up due to a pending
> SDHI interrupt that the tmio_mmc driver cannot handle.

Applied.
