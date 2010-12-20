From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Dec 2010 13:45:03 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Bump up NR_IRQS to 1024
Message-Id: <20101220134503.GA26766@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311053352.26717.21158.sendpatchset@t400s>
In-Reply-To: <20100311053352.26717.21158.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 20, 2010 at 08:00:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Increase NR_IRQS from 512 to 1024 on SH-Mobile ARM.
> 
> Needed to support vectors in the sh73a0 INTCS block.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

This will bring us to the maximum number we can support in the hardirq
bits, just so you're aware.
