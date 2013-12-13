From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 13 Dec 2013 03:17:54 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <87txedqw0x.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi


> > EXPORT_SYMBOL() on arch/sh/kernel/sh_ksyms_32.c
> > seems strange for me.
> 
> Handling of these depends on CPUs.
> And in SH32, it may be referred to from modules.
> Therefore, I have feeling that it is not amusing that sh_ksyms_32.c defines these using EXPORT_SYMBOL.
> 
> Would you explain the reason that you thought to be strange?

I think EXPORT_SYMBOL() should be called
from ${LINUX}/mm/[no]bootmem.c, not sh_ksyms_32.c

Best regards
---
Kuninori Morimoto
