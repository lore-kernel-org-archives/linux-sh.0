From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jul 2012 10:03:17 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix platsmp.c build when ARCH_SH73A0=n
Message-Id: <20120706100313.GA20787@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20120706082005.30495.53308.sendpatchset@w520>
In-Reply-To: <20120706082005.30495.53308.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 06, 2012 at 05:20:05PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix build error in the case of SMP=y but ARCH_SH73A0=n
> introduced by:
> 
> 9601e87 ARM: shmobile: fix smp build
> 
> The use of of_machine_is_compatible() will link in the
> the SoC-specific symbols:
> "sh73a0_get_core_count", "sh73a0_smp_prepare_cpus",
> "sh73a0_secondary_init" and "sh73a0_boot_secondary".
> 
> This patch adds an ugly #ifdef wrapper as a stop-gap
> solution.

I will be happier once we have a more permanent solution :^)

> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Tested-by: Simon Horman <horms@verge.net.au>
