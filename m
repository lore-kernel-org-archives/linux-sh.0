From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 01:38:36 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Fix headsmp.S code to use CPUINIT
Message-Id: <20120109013836.GG25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 28, 2011 at 04:44:06PM +0900, Magnus Damm wrote:
> Convert the low level SMP assembly code for SH-Mobile ARM
> from using the INIT to the CPUINIT section. This unbreaks
> onlining of CPUs using the CPU hotplug interface:
> 
> echo 1 > /sys/devices/system/cpu/cpu1/online
> 
> Without this fix the reset vector code used by CPU hotplug
> will be freed as init section data and CPU cores cannot
> be brought online.

On Wed, Dec 28, 2011 at 04:47:16PM +0900, Magnus Damm wrote:
> Add the function shmobile_platform_kill_cpu() to allow
> SoC specific code to tie in their CPU shutdown code.

On Wed, Dec 28, 2011 at 04:53:16PM +0900, Magnus Damm wrote:
> Add cache flushing code to the SH-Mobile specific CPU hotplug
> implementation. While at it, add a cpu mask to make sure the
> cache flushing code is finished in platform_cpu_die() before
> letting the SoC-specific code in shmobile_platform_cpu_kill()
> proceed with turning off power.
> 
> Without this code CPU hotplug offline fails when cache is
> enabled on Cortex-A9 based SoCs.

All applied, thanks.
