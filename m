From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 16:15:55 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Clean up headsmp.S
Message-Id: <20101220161555.GB30700@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101220110450.6824.92672.sendpatchset@t400s>
In-Reply-To: <20101220110450.6824.92672.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 20, 2010 at 08:04:50PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use PAGE_OFFSET and PHYS_OFFSET for secondary_startup
> entry point as recommended by Russell King.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Tested on the AG5EVB board using the sh73a0 processor.
> 
>  Applies on top of the rmobile/smp topic branch in sh-2.6 git.
> 
Applied, thanks.
