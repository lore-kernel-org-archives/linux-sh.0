From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 31 May 2020 23:43:38 +0000
Subject: Re: [PATCH] sh: fixup strncpy()
Message-Id: <87eeqzzn4m.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8736dijdit.wl-kuninori.morimoto.gx@renesas.com>
        <87zhfqhyuf.wl-kuninori.morimoto.gx@renesas.com>
        <b1336fcf-8b04-e16c-420c-ed7e766fef12@physik.fu-berlin.de>
In-Reply-To: <b1336fcf-8b04-e16c-420c-ed7e766fef12@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


Hi John

Thank you for mail to me

> > From: Karl Nasrallah <knnspeed@aol.com>
> > 
> > Current SH will get below warning at strncpy()
> > 
> > In file included from ${LINUX}/arch/sh/include/asm/string.h:3,
> >                  from ${LINUX}/include/linux/string.h:20,
> >                  from ${LINUX}/include/linux/bitmap.h:9,
> >                  from ${LINUX}/include/linux/nodemask.h:95,
> >                  from ${LINUX}/include/linux/mmzone.h:17,
> >                  from ${LINUX}/include/linux/gfp.h:6,
> >                  from ${LINUX}/innclude/linux/slab.h:15,
> >                  from ${LINUX}/linux/drivers/mmc/host/vub300.c:38:
> > ${LINUX}/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
> > ${LINUX}/arch/sh/include/asm/string_32.h:51:42: warning: array subscript\
> >   80 is above array bounds of 'char[26]' [-Warray-bounds]
> >    : "0" (__dest), "1" (__src), "r" (__src+__n)
> >                                      ~~~~~^~~~
> > 
> > This patch fixup it
> > 
> > Signed-off-by: Karl Nasrallah <knnspeed@aol.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I very much appreciated your SH fixes as I am still maintaining a SuperH
> port in Debian.
> 
> Since I don't want your fixes to fall off the table, you can ask Andrew
> Morton to pick up your patches which is apparently the normal path to
> choose when the original maintainers are currently not available.

Actually, I had been posted it to Andrew many times [1],
but nothing happened.
And according to [2], it seems SH maintainers are still working,
thus, normal path is still them.

I had been worked for SH before, and posted many fixup patches
for many times to both Andrew and SH maintainers.
But their are still not yet reviewd/accepted.
And unfortunately, it seems I'm judged as spam from SH maintainers [2].
So I can do nothing anymore...

[1]
https://lore.kernel.org/linux-renesas-soc/87o8uyylat.wl-kuninori.morimoto.gx@renesas.com/

[2]
https://lore.kernel.org/linux-renesas-soc/656cb059-366e-06b1-0d8f-741454c472b8@landley.net/

Thank you for your help !!

Best regards
---
Kuninori Morimoto
