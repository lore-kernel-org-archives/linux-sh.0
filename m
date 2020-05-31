From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 31 May 2020 09:43:02 +0000
Subject: Re: [PATCH] sh: fixup strncpy()
Message-Id: <b1336fcf-8b04-e16c-420c-ed7e766fef12@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8736dijdit.wl-kuninori.morimoto.gx@renesas.com>
 <87zhfqhyuf.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zhfqhyuf.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Kuninori!

On 12/18/19 8:33 AM, Kuninori Morimoto wrote:
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

I very much appreciated your SH fixes as I am still maintaining a SuperH
port in Debian.

Since I don't want your fixes to fall off the table, you can ask Andrew
Morton to pick up your patches which is apparently the normal path to
choose when the original maintainers are currently not available.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
