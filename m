From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Tue, 24 Jun 2008 08:15:39 +0000
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-Id: <20080624081539.GE5064@axis.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: Roland McGrath <roland@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "cooloney@kernel.org" <cooloney@kernel.org>, dev-etrax <dev-etrax@axis.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "gerg@uclinux.org" <gerg@uclinux.org>, "yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "paulus@samba.org" <paulus@samba.org>, "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "chris@zankel.net" <chris@zankel.net>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>

Hi,

On Mon, Jun 23, 2008 at 07:48:09PM +0200, Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
>   - cris
>   - frv
>   - powerpc
>   - x86
> - don't expose function prototypes and macros to userspace:
>   - arm
>   - blackfin
>   - cris
>   - mn10300
>   - parisc
> - remove #ifdef CONFIG_'s around #define's:
>   - blackfin
>   - m68knommu
> - sh: AFAIK __SH5__ should work in both kernel and userspace,
>       no need to leak CONFIG_SUPERH64 to userspace
> - xtensa: cosmetical change to remove empty
>             #ifndef __ASSEMBLY__ #else #endif
>           from the userspace headers
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The CRIS parts look ok.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
