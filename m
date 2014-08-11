From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Aug 2014 01:10:15 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal
Message-Id: <20140811011011.GH26570@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140808114855.14647.62725.sendpatchset@w520>
In-Reply-To: <20140808114855.14647.62725.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 08, 2014 at 08:48:55PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal
> 
> [PATCH 01/02] ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY
> [PATCH 02/02] ARM: shmobile: marzen: Remove NR_IRQS_LEGACY
> 
> Remove NR_IRQS_LEGACY from the machine vector on r8a7779 and Marzen,
> completely untested but other Multiplatform SMP SoCs with GIC seem
> to work well without this - and so does legacy Marzen.
> 
> The reason for this removal is that this is just legacy left over
> cruft that once used to be necessary for static interrupt assignment
> (I think) while we migrated to DT support for the GIC.
> 
> Not needed in case of Multiplatform and Sparse IRQ.

Thanks, I have queued these up.
