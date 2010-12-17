From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 17 Dec 2010 08:42:11 +0000
Subject: Re: [PATCH 01/03] ARM: mach-shmobile: SMP base support
Message-Id: <20101217084211.GZ9937@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20101214075647.11275.25933.sendpatchset@t400s>
	<20101214075655.11275.95963.sendpatchset@t400s>
In-Reply-To: <20101214075655.11275.95963.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 14, 2010 at 04:56:55PM +0900, Magnus Damm wrote:
> +/*
> + * Reset vector for secondary CPUs.
> + * This will be mapped at address 0 by SBAR register.
> + * We need _long_ jump to the physical address.
> + */
> +	.align  12
> +ENTRY(shmobile_secondary_vector)
> +	ldr     pc, 1f
> +1:	.long   secondary_startup - CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START

BTW, why not use - PAGE_OFFSET + PHYS_OFFSET here?  Both these macros
are available for use in assembly code - just include asm/memory.h.
