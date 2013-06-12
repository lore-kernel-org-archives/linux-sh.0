From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Jun 2013 14:10:10 +0000
Subject: Re: [PATCH 02/02] ARM: shmobile: Remove romImage CONFIG_MEMORY_START
Message-Id: <20130612141009.GY32751@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605075514.17653.77135.sendpatchset@w520>
 <20130605075531.17653.38073.sendpatchset@w520>
In-Reply-To: <20130605075531.17653.38073.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 05, 2013 at 04:55:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Instead of relying on CONFIG_MEMORY_START for memory
> base address, let each romImage board header file
> specify this information.
> 
> This is reworks code not to rely on CONFIG_MEMORY_START
> which in turn is needed for ARCH_MULTIPLATFORM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.11 in the (new) cleanup-boot branch.
