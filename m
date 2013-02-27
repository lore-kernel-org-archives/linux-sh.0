From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Feb 2013 08:23:38 +0000
Subject: Re: [PATCH] irqchip: Renesas INTC External IRQ pin driver
Message-Id: <20130227082335.GB30395@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218142834.28739.39417.sendpatchset@w520>
In-Reply-To: <20130218142834.28739.39417.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au, tglx@linutronix.de

On Mon, Feb 18, 2013 at 11:28:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch adds a driver for external IRQ pins connected
> to the INTC block on recent SoCs from Renesas.
> 
So how exactly does this interact with the existing sh_intc code? Or is
there some reason why you have opted to bypass it in order to implement a
simplified reduced-functionality version of INTC support focused only on
external pins? If both are used together this is going to be a nightmare
for locking, and it's also non-obvious how the IRQ domains on both sides
will interact.

This needs a lot more explanation.
