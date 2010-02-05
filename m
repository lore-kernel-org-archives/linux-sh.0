From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 05 Feb 2010 22:10:09 +0000
Subject: Re: [PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support
Message-Id: <20100205221009.GA1923@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20100205111440.17065.33296.sendpatchset@rxone.opensource.se>
	<20100205111449.17065.11983.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100205111449.17065.11983.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 05, 2010 at 08:14:49PM +0900, Magnus Damm wrote:
> +	.macro  get_irqnr_preamble, base, tmp
> +	.endm
> +
> +	.macro  arch_ret_to_user, tmp1, tmp2
> +	.endm
> +
> +	.macro  get_irqnr_and_base, irqnr, irqstat, base, tmp
> +	ldr     \base, =INTFLGA

There's the potential for an optimisation here - move this instruction
into get_irqnr_preamble, and you'll avoid having to re-load the base
register if there's multiple IRQs pending.
