From: Shawn Guo <shawn.guo@linaro.org>
Date: Thu, 21 May 2015 02:08:42 +0000
Subject: Re: [PATCH] ARM: v7 setup function should invalidate L1 cache
Message-Id: <20150521020841.GL24844@dragon>
List-Id: <linux-sh.vger.kernel.org>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 19, 2015 at 05:12:56PM +0100, Russell King wrote:
> All ARMv5 and older CPUs invalidate their caches in the early assembly
> setup function, prior to enabling the MMU.  This is because the L1
> cache should not contain any data relevant to the execution of the
> kernel at this point; all data should have been flushed out to memory.
> 
> This requirement should also be true for ARMv6 and ARMv7 CPUs - indeed,
> these typically do not search their caches when caching is disabled (as
> it needs to be when the MMU is disabled) so this change should be safe.
> 
> ARMv7 allows there to be CPUs which search their caches while caching is
> disabled, and it's permitted that the cache is uninitialised at boot;
> for these, the architecture reference manual requires that an
> implementation specific code sequence is used immediately after reset
> to ensure that the cache is placed into a sane state.  Such
> functionality is definitely outside the remit of the Linux kernel, and
> must be done by the SoC's firmware before _any_ CPU gets to the Linux
> kernel.
> 
> Changing the data cache clean+invalidate to a mere invalidate allows us
> to get rid of a lot of platform specific hacks around this issue for
> their secondary CPU bringup paths - some of which were buggy.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
...
>  arch/arm/mach-imx/headsmp.S           |  1 -

Acked-by: Shawn Guo <shawn.guo@linaro.org>
