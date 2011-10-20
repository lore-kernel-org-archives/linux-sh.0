From: Will Deacon <will.deacon@arm.com>
Date: Thu, 20 Oct 2011 07:01:06 +0000
Subject: Re: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-Id: <20111020070105.GA28548@mudshark.cambridge.arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20111020042444.GA20260@verge.net.au>
In-Reply-To: <20111020042444.GA20260@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 20, 2011 at 05:24:45AM +0100, Simon Horman wrote:
> Hi Will, Hi All,

Hi Simon,

> it appears that "ARM: proc: add definition of cpu_reset for
>  ARMv6 and ARMv7 cores" (f4daf06fc23b99df5ca5b3e892428b91e148cc52),
> which was introduced for 3.1-rc1, causes a regression and that
> kexec no longer works on ARM. The board that I am testing
> on is a Renesas Mackerel which has an SH7372 (ARMv7) processor.

Wow, I'm surprised the old code worked at all on an ARMv7 CPU! It's certainly
highly unlikely to work by the letter of the architecture, so I guess the
planets aligned in just the right way for your particular implementation.

Please can you try my kexec/mmu-off patches? They should add the bits and
pieces you need for kexec to work reliably on a UP system. I plan to finish
these off next week in Prague so hopefully they'll hit mainline in the near
future.

https://github.com/wdeacon/linux-wd/commits/kexec/mmu-off

Will
