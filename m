From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Feb 2010 04:45:29 +0000
Subject: Re: [PATCH] sh: extend INTC with force_disable
Message-Id: <20100216044529.GA10212@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100215114025.22039.11843.sendpatchset@t400s>
In-Reply-To: <20100215114025.22039.11843.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 15, 2010 at 08:40:25PM +0900, Magnus Damm wrote:
> Extend the shared INTC code with force_disable support to
> allow keeping mask bits statically disabled. Needed for
> SDHI support to mask out unsupported interrupt sources.

On Mon, Feb 15, 2010 at 08:53:43PM +0900, Magnus Damm wrote:
> Update the sh7724 INTC tables with force_enable support
> to mask out pending unsupported SDHI interrupt sources.
> 
> Without this patch the kernel locks up due to a pending
> SDHI interrupt that the tmio_mmc driver cannot handle.

Both applied, thanks.
