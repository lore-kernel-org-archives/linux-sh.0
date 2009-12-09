From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 09 Dec 2009 03:45:44 +0000
Subject: Re: [PATCH] sh: fix size calculation for NUMA node 0
Message-Id: <20091209034544.GD28280@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091207141159.6318.90269.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091207141159.6318.90269.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 07, 2009 at 11:11:59PM +0900, Magnus Damm wrote:
> Fix the NUMA size calculation for node 0. Do the same
> as the UMA version of setup_memory() and use address
> instead of pfn when calculating the size.

On Mon, Dec 07, 2009 at 11:16:07PM +0900, Magnus Damm wrote:
> This patch updates the NUMA version of setup_memory()
> with UMA code changes and also modifies the last argument
> to lmb_alloc_base() to use an address instead of pfn.

On Mon, Dec 07, 2009 at 11:20:06PM +0900, Magnus Damm wrote:
> This patch adds a ->start_transfer() callback to the
> driver sh_mobile_lcdcfb.c. The callback is used to
> program the LCDC panel in the case of one-shot mode.
> 
> Needed by the LCD controller used on the KFR2R09 board.

On Mon, Dec 07, 2009 at 11:26:05PM +0900, Magnus Damm wrote:
> This patch adds a ->start_transfer() callback to the
> KFR2R09 lcd handling code. The callback is used to
> notify the lcd controller that a new frame of data
> is about to be transferred. The callback is only used
> in combination with deferred io, but the code has
> been tested both with and without deferred io enabled.
> 
> Without this patch the display data on the KFR2R09
> lcd panel becomes corrupted over time.

All applied, thanks.
