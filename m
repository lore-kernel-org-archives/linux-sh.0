From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 26 Sep 2010 20:26:41 +0000
Subject: Re: [PATCH] sh: Work around GCC bug in set_bl_bit()
Message-Id: <20100926202641.GF28588@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ed5637cc82664f68c1609e0f511808c412d4cf68.1285498785.git.matt@console-pimps.org>
In-Reply-To: <ed5637cc82664f68c1609e0f511808c412d4cf68.1285498785.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 26, 2010 at 12:08:37PM +0100, Matt Fleming wrote:
> It seems that some versions of GCC do not handle negative constants in
> inline assembly very well, specifically any negative constant less that
> -129. Here is a reduced example of the problematic code,
> 
> static inline void set_bl_bit(void)
> {
> 	unsigned long __dummy0;
> 
> 	__asm__ __volatile__ (
> 		"and	%1, %0\n\t"
> 		: "=r" (__dummy0)
> 		: "r" (0xffffff0f)
> 		: "memory"
> 	);
> }
> 
> Now, what GCC should do is place 0xffffff0f in a constant pool and load
> it into a register with a mov.l instruction. What actually happens is
> that GCC truncates 0xffffff0f to 16-bits (0xff0f), places it in a
> constant pool and loads it with mov.w. Since the BL bit of the status
> register is at bit-position 28, it doesn't even get set.
> 
> To work around this issue simply replace 0xffffff0f with 0xffffffff. It
> is safe to include the IMASK field of the sr register in the 'and' mask
> because we're blocking interrupts anyway by setting the BL bit, so
> there's no need to disable them. The original mask was buggy anyway as
> if any bits were set in IMASK we'd drop them on the floor and they'd
> never be restored.
> 
> This bug was discovered after applying commit
> 73a38b839b9295216e8d44dabf54de88270e77b8 ("sh: Only use bl bit toggling
> for sleeping idle."), which made my sh7785lcr board reset after calling
> local_irq_enable() in default_idle().
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Someone just kindly pointed out to me that this diagnosis is
incorrect. mov.w will sign-extend the value loaded from memory before
storing it in a register, so there's no problem there and this isn't a
GCC bug. However, there's still something odd going on with my board and
the change to set_bl_bit() to use 0xffffffff instead of 0xffffff0f
_does_ stop my board resetting.

I'll investigate further.
