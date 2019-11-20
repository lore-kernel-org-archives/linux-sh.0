From: Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 20 Nov 2019 00:41:32 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
Message-Id: <413c9aad-2123-b22a-56bc-faa5c7d38d06@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
In-Reply-To: <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> 
> BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?

Geert,

I don't see a defconfig with that combination.

Also, http://kisskb.ellerman.id.au/kisskb/branch/linus/head/af42d3466bdc8f39806b26f593604fdc54140bcb/
didn't report any such problem.  I only addressed the 3 build errors that were reported there as
  page_alloc.c:(.text+0x3148): undefined reference to `node_reclaim_distance'

I did just test sdk7786_defconfig successfully, but that's no surprise since it sets CONFIG_SMP.

-- 
~Randy
