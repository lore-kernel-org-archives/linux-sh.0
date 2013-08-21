From: Simon Horman <horms@verge.net.au>
Date: Wed, 21 Aug 2013 08:59:50 +0000
Subject: Re: [PATCH 00/05] ARM: shmobile: Yet another SMP series
Message-Id: <20130821085949.GI20014@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130807221321.22251.22774.sendpatchset@w520>
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 08, 2013 at 07:13:21AM +0900, Magnus Damm wrote:
> ARM: shmobile: Yet another SMP series
> 
> [PATCH 01/05] ARM: shmobile: Introduce shmobile_smp_cpu_disable()
> [PATCH 02/05] ARM: shmobile: Use shmobile_smp_cpu_disable() on sh73a0
> [PATCH 03/05] ARM: shmobile: Remove unused shmobile_smp_init_cpus()
> [PATCH 04/05] ARM: shmobile: Expose shmobile_invalidate_start()
> [PATCH 05/05] ARM: shmobile: Introduce shmobile_boot_size
> 
> This series cleans up the existing SMP code and introduces various new SMP
> functions for mach-shmobile. The new functions are partially used by existing
> SMP support code, but are also consumed by upcoming SMP support patches.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks Magnus,

I plan to queue this up in the smp branch which will most likely occur
tomorrow.
