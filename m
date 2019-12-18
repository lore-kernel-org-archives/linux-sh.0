From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Dec 2019 07:35:31 +0000
Subject: Re: [PATCH] sh: use generic strncpy()
Message-Id: <87y2vahyrg.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8736dijdit.wl-kuninori.morimoto.gx@renesas.com>
        <871rt2jdgi.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871rt2jdgi.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


Hi

> From: Karl Nasrallah <knnspeed@aol.com>
> 
> Current SH will get below warning at strncpy()
> 
> In file included from ${LINUX}/arch/sh/include/asm/string.h:3,
>                  from ${LINUX}/include/linux/string.h:20,
>                  from ${LINUX}/include/linux/bitmap.h:9,
>                  from ${LINUX}/include/linux/nodemask.h:95,
>                  from ${LINUX}/include/linux/mmzone.h:17,
>                  from ${LINUX}/include/linux/gfp.h:6,
>                  from ${LINUX}/innclude/linux/slab.h:15,
>                  from ${LINUX}/linux/drivers/mmc/host/vub300.c:38:
> ${LINUX}/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
> ${LINUX}/arch/sh/include/asm/string_32.h:51:42: warning: array subscript\
>   80 is above array bounds of 'char[26]' [-Warray-bounds]
>    : "0" (__dest), "1" (__src), "r" (__src+__n)
>                                      ~~~~~^~~~
> 
> This patch fixup it
> 
> Signed-off-by: Karl Nasrallah <knnspeed@aol.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Grr, I failed Subject.
Sato-san, Rich, please let me know if you select this patch.
I can repost it with correct Subject

Thank you for your help !!
Best regards
---
Kuninori Morimoto
