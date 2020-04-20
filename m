From: Will Deacon <will@kernel.org>
Date: Mon, 20 Apr 2020 20:42:39 +0000
Subject: Re: [RFC PATCH v1 40/50] arch/*/include/asm/stackprotector.h: Use get_random_canary() consistently
Message-Id: <20200420204238.GB29998@willie-the-truck>
List-Id: <linux-sh.vger.kernel.org>
References: <202003281643.02SGhM0T009250@sdf.org>
In-Reply-To: <202003281643.02SGhM0T009250@sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: George Spelvin <lkml@sdf.org>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Paul Burton <paulburton@kernel.org>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Dec 10, 2019 at 12:35:14AM -0500, George Spelvin wrote:
> ... in boot_init_stack_canary().
> 
> This is the archetypical example of where the extra security of
> get_random_bytes() is wasted.  The canary is only important as
> long as it's stored in __stack_chk_guard.
> 
> It's also a great example of code that has been copied around
> a lot and not updated.
> 
> Remove the XOR with LINUX_VERSION_CODE as it's pointless; the inclusion
> of utsname() in init_std_data in the random seeding obviates it.
> 
> The XOR with the TSC on x86 and mtfb() on powerPC were left in,
> as I haven't proved them redundant yet.  For those, we call
> get_random_long(), xor, and mask manually.
> 
> FUNCTIONAL CHANGE: mips and xtensa were changed from 64-bit
> get_random_long() to 56-bit get_random_canary() to match the
> others, in accordance with the logic in CANARY_MASK.
> 
> (We could do 1 bit better and zero *one* of the two high bytes.)
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc:  "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/arm/include/asm/stackprotector.h     | 9 +++------
>  arch/arm64/include/asm/stackprotector.h   | 8 ++------
>  arch/mips/include/asm/stackprotector.h    | 7 ++-----
>  arch/powerpc/include/asm/stackprotector.h | 6 ++----
>  arch/sh/include/asm/stackprotector.h      | 8 ++------
>  arch/x86/include/asm/stackprotector.h     | 4 ++--
>  arch/xtensa/include/asm/stackprotector.h  | 7 ++-----
>  7 files changed, 15 insertions(+), 34 deletions(-)

Just found this kicking around in the depths of my inbox. Is the series
dead?

Will
