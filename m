From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:10:05 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: Let romImage rely on default ATAGS
Message-Id: <20130612141004.GX32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <20130605075522.17653.20769.sendpatchset@w520>
In-Reply-To: <20130605075522.17653.20769.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 05, 2013 at 04:55:22PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Remove the ATAGS data structure from head-shmobile.S
> since a default ATAGS is already provided by the code
> in arch/arm/kernel/atags_parser.c. Passing a NULL as
> ATAGS is valid. For actual hardware specific setup
> the fixup callback in the board code may be used.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
