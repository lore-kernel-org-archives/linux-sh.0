From: Jonathan Corbet <corbet@lwn.net>
Date: Fri, 19 Jun 2020 19:22:11 +0000
Subject: Re: [PATCH] Documentation: remove SH-5 index entries
Message-Id: <20200619132211.0d2b19db@lwn.net>
List-Id: <linux-sh.vger.kernel.org>
References: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
In-Reply-To: <71e1f336-ef5c-f5e9-25cf-16bd4439b9f9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

On Sun, 14 Jun 2020 19:59:07 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Remove SH-5 documentation index entries following the removal
> of SH-5 source code.
> 
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/mm/tlb-sh5.c
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
> Error: Cannot open file ../arch/sh/include/asm/tlb_64.h
> 
> Fixes: 3b69e8b45711 ("Merge tag 'sh-for-5.8' of git://git.libc.org/linux-sh")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: ysato@users.sourceforge.jp
> Cc: linux-sh@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  Documentation/sh/index.rst |   12 ------------
>  1 file changed, 12 deletions(-)

Applied, thanks.

jon
