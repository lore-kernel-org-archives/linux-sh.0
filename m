From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Aug 2012 00:54:32 +0000
Subject: Re: [PATCH] ARM: shmobile: sh73a0: fixup RELOC_BASE of intca_irq_pins_desc
Message-Id: <20120821005431.GC21643@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5l95bfg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5l95bfg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 20, 2012 at 05:35:52PM -0700, Kuninori Morimoto wrote:
> sh73a0 :: intca_irq_pins_desc irq table had conflict
> from irq 552 to irq 557 before.
> But the second controller was simply trampling the
> first one by way of the -EEXIST case from irq_alloc_desc_at().
> 
> But now, we have irqdomain support from
> 1d6a21b0a672fb29b01ccf397d478e0541e17716
> (sh: intc: initial irqdomain support)
> 
> The irqdomain code has simply tightened down the sanity checks and
> error path. So, sh73a0 CPU board got some WARNING when booting now.
> This patch fixup RELOC_BASE to solve this issue.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch is for paul/sh-latest branch
> 
This can go through Rafael's tree, as nothing here depends on anything I
have outstanding. I have the multi-evt fix pending, but that's about it.
