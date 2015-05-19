From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 19 May 2015 22:18:43 +0000
Subject: Re: [PATCH] ARM: v7 setup function should invalidate L1 cache
Message-Id: <8164344.VcU8v2tIF5@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <2080993.BUNZpO9uLL@wuerfel> <20150519220721.GK2067@n2100.arm.linux.org.uk>
In-Reply-To: <20150519220721.GK2067@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 19 May 2015 23:07:21 Russell King - ARM Linux wrote:
> If you look carefully at this, you'll notice that it's utter crap.
> (Sorry, but it is.)  It has two problems:
> 
> 1. It'll never match a Cortex-A9 CPU.  Cortex-A9 has a MIDR value of
>    0x412fc09a, not 0x00000c09.  The bit position of the part number
>    field isn't even right.
>
> 2. If it does match, then we branch to "v7_invalidate_l1" without setting
>    the link register: we'll never return back here (we'll return to whatever
>    random value the link register contains) and so we'll never make it to
>    secondary_startup.  *Thankfully*, because of (1), this branch will
>    never be taken - this is it's saving grace.

Yes, I've understood both before.
 
> Your patch introduces a /third/ form of crapiness:
> 
> 3. If the PSR happens to have Z=1, the "beq" instruction will be taken,
>    thereby crashing the system because of (2).

Right, this was the result of sloppiness on my side when fat-fingering
a patch for illustration.
 
> The /simplest/ change which would fix this problem is to just change
> proc-v7.S.  The remainder is effectively a cleanup removing redundant
> code.

Fair enough. I wasn't sure if we're confident enough about that
change already to put it into stable backports. If the risk is low
enough, that's fine.

	Arnd
