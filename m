From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 07 Oct 2020 11:14:35 +0000
Subject: Re: [LTP] [PATCH 1/1] cacheflush01: Rewrite into new API
Message-Id: <1478290725.17134142.1602069275205.JavaMail.zimbra@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20201002202416.28972-1-petr.vorel@gmail.com>
In-Reply-To: <20201002202416.28972-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vorel <petr.vorel@gmail.com>
Cc: ltp@lists.linux.it, Ofer Levi <oferle@nvidia.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Guo Ren <guoren@kernel.org>, Greentime Hu <green.hu@gmail.com>, "Maciej W . Rozycki" <macro@linux-mips.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Vincent Chen <deanbo422@gmail.com>



----- Original Message -----
> This syscall is currently (v5.9) supported on these architectures:
> arc, csky, mips, m68k, nds32, sh
> 
> constants are missing for m68k, not sure if the testcase is valid for it.
> Untested.
> 
> Test for __LTP__NR_INVALID_SYSCALL saves adding autotools check for
> <asm/cachectl.h>.
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
> Hi,
> 
> FYI: I was going to ask for removal of this test, but all these archs are
> still supported. This test compiles on all archs now, but I haven't run
> it (I don't have access to none of these archs, not sure if LTP is even
> tested on these archs).

I haven't tested it too, but rewrite looks good.

Acked-by: Jan Stancek <jstancek@redhat.com>
