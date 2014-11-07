From: Jason Cooper <jason@lakedaemon.net>
Date: Fri, 07 Nov 2014 05:00:09 +0000
Subject: Re: [PATCH V3 00/14] genirq endian fixes; bcm7120/brcmstb IRQ updates
Message-Id: <20141107050009.GI3698@titan.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kevin Cernekee <cernekee@gmail.com>
Cc: arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de, ralf@linux-mips.org, linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

Kevin,

On Sat, Nov 01, 2014 at 06:03:47PM -0700, Kevin Cernekee wrote:
...
> Kevin Cernekee (14):
>   sh: Eliminate unused irq_reg_{readl,writel} accessors
>   genirq: Generic chip: Change irq_reg_{readl,writel} arguments
>   genirq: Generic chip: Allow irqchip drivers to override
>     irq_reg_{readl,writel}
>   genirq: Generic chip: Add big endian I/O accessors
>   irqchip: brcmstb-l2: Eliminate dependency on ARM code
>   irqchip: bcm7120-l2: Eliminate bad IRQ check
>   irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
>   irqchip: bcm7120-l2: Make sure all register accesses use base+offset
>   irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
>   irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
>     functions
>   irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
>   irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
>   irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
>   irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}

Patches 2, 3, and 4 applied to irqchip/core with Thomas' and Arnd's Acks
added.  Patches 5-$ added to irqchip/core with Arnd's Ack added where it
was missing.

I've left patch #1 for the sh maintainers.

thx,

Jason.
