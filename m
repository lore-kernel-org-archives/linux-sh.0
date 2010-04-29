From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Apr 2010 14:36:53 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
Message-Id: <20100429143653.GD9621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100428082530.29018.50464.sendpatchset@t400s>
In-Reply-To: <20100428082530.29018.50464.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 28, 2010 at 05:25:30PM +0900, Magnus Damm wrote:
> This patch sets CONSISTENT_DMA_SIZE to 158 MB
> for all SH-Mobile ARM processors.
> 
> The DMA area is mapped at 0xf6000000 - 0xffdfffff,
> on top of the 256 MB I/O window at 0xe6000000.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

On Wed, Apr 28, 2010 at 05:36:57PM +0900, Magnus Damm wrote:
> Extend VMALLOC_END to the I/O Window at 0xe6000000.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Both applied, thanks.
