From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 07 Jul 2011 13:50:43 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 generic suspend/resume
Message-Id: <20110707135043.GQ8286@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110707134813.22370.25948.sendpatchset@t400s>
In-Reply-To: <20110707134813.22370.25948.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 07, 2011 at 10:48:13PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Convert the sh7372 Core Standby code to make use
> of the new generic ARM cpu suspend/resume code.

Thanks.  Only thing which stands out is:

> +	.global sh7372_resume_core_standby
> +sh7372_resume_core_standby:
> +	ldr     pc, 1f
> +1:	.long   cpu_resume - PAGE_OFFSET + PLAT_PHYS_OFFSET

Is this because sh7372_resume_core_standby must be ARM stuff, but
cpu_resume may be Thumb?

I suspect we should make cpu_resume always be ARM instructions because I'd
imagine a lot of firmware won't cope with Thumb entry.
