From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Jan 2020 01:21:46 +0000
Subject: [PATCH resend 0/3] SH: compile fixup patches
Message-Id: <87o8uyylat.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>


Hi Andrew
Cc: Yoshinori, Rich

I'm posting these patches to SH ML from few month ago,
but SH maintainer is not working in these days...

Is it possible to consider about these ?
SH compile will be fail without these patchese.

I have +1 patch, but will has conflict to Geert's this patch,
thus, I'm skipping it now.

iomap: Constify ioreadX() iomem argument (as in generic implementation)
https://lore.kernel.org/lkml/20200108200528.4614-2-krzk@kernel.org/


Kuninori Morimoto (3):
  sh: Add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
  sh: Convert iounmap() macros to inline functions
  sh: Convert ins[bwl]/outs[bwl] macros to inline functions

 arch/sh/include/asm/io.h          |  2 +-
 arch/sh/include/asm/io_noioport.h | 34 ++++++++++++++++++++++++++++------
 arch/sh/kernel/sh_ksyms_32.c      | 17 +++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.7.4
