From: David Howells <dhowells@redhat.com>
Date: Tue, 24 Jun 2008 10:23:48 +0000
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-Id: <8058.1214303028@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: dhowells@redhat.com, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, cooloney@kernel.org, dev-etrax@axis.com, gerg@uclinux.org, yasutake.koichi@jp.panasonic.com, linux-parisc@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org, linux-sh@vger.kernel.org, chris@zankel.net, linux-mips@linux-mips.org, ysato@users.sourceforge.jp, Andrew Morton <akpm@linux-foundation.org>

Adrian Bunk <bunk@kernel.org> wrote:

> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
> ...
>   - frv
> ...
> - don't expose function prototypes and macros to userspace:
> ...
>   - mn10300

Acked-by: David Howells <dhowells@redhat.com> (FRV and MN10300)
