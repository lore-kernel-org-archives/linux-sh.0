From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Dec 2012 13:32:03 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 external IRQ wake update
Message-Id: <20121214133203.GI16382@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20121214034312.20055.61728.sendpatchset@w520>
In-Reply-To: <20121214034312.20055.61728.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 14, 2012 at 12:43:12PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use sh73a0_set_wake() for external IRQ signals on sh73a0.
> 
> The sh73a0 IRQ hardware for external IRQ pins consists of
> the INTCA interrupt controller and the GIC together doing
> their best to limp along. These external IRQ pins are
> treated as a special case where interrupts need to be
> managed in both interrupt controllers in parallel.
> 
> The ->irq_set_wake() callback for the external IRQ pins
> can be dealt with in the same way as INTCA-only without
> involving the GIC. So this patch updates the external
> IRQ pin code for sh73a0 to no longer involve the GIC.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks applied.

I have applied this to a temporary 'soc5' branch which is based on 3.7-rc1.
I will rebase this on 3.8-rc1 once it is released and rename the branch
to the more sane 'soc'.

I have also merged this change into the next branch.
