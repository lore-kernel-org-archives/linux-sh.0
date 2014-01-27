From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 27 Jan 2014 15:43:15 +0000
Subject: Re: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
Message-Id: <20140127154315.GG32608@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
In-Reply-To: <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 27, 2014 at 06:08:17AM +0000, Nicolas Pitre wrote:
> ARM and ARM64 are the only two architectures implementing
> arch_cpu_idle_prepare() simply to call local_fiq_enable().
> 
> We have secondary_start_kernel() already calling local_fiq_enable() and
> this is done a second time in arch_cpu_idle_prepare() in that case. And
> enabling FIQs has nothing to do with idling the CPU to start with.
> 
> So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> at late_initcall time but this shouldn't make a difference in practice
> given that FIQs are not currently used on ARM64.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

For arm64, we could simply remove any reference to FIQs. I'm not aware
of anyone using them.

-- 
Catalin
