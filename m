From: Kaz Kojima <kkojima@rr.iij4u.or.jp>
Date: Fri, 30 Jan 2009 23:40:49 +0000
Subject: Re: ERESTART* seen by userland
Message-Id: <20090131.084049.14336755.kkojima@rr.iij4u.or.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
In-Reply-To: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt <lethal@linux-sh.org> wrote:
> This should fix it up:
> 
> ---
> 
>  arch/sh/include/asm/syscall_32.h |   22 +++-------------------
>  arch/sh/include/asm/syscall_64.h |   22 +++-------------------
>  arch/sh/kernel/signal_32.c       |    4 +---
>  arch/sh/kernel/signal_64.c       |    4 +---
>  4 files changed, 8 insertions(+), 44 deletions(-)

Sorry for the delay.  I've confirmed that this also fixes
the test cases I'm having.

Regards,
	kaz

