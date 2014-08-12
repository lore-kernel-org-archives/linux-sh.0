From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2014 13:48:12 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Remove non-existent i2c6 pinmux
Message-Id: <CAMuHMdXif88Tdo-4doF=B6x5zdrcP8banSLOBVgZd59_EEXspA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407848593-23040-1-git-send-email-geert+renesas@glider.be>
	<20140812133622.GC10875@verge.net.au>
In-Reply-To: <20140812133622.GC10875-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Gaku Inami <gaku.inami.xw-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Simon,

On Tue, Aug 12, 2014 at 3:36 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 12, 2014 at 03:03:13PM +0200, Geert Uytterhoeven wrote:
>> On r8a7791, i2c6 (aka iic3) doesn't need pinmux, but the koelsch dts
>> refers to non-existent pinmux configuration data:
>>
>> pinmux core: sh-pfc does not support function i2c6
>> sh-pfc e6060000.pfc: invalid function i2c6 in map table
>>
>> Remove it to fix this.
>>
>> Fixes: commit 1d41f36a68c0f4e9b01d563ce33bab5201858b54 ("ARM: shmobile:
>>        koelsch dts: Add VDD MPU regulator for DVFS")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks Geert. Does this manifest as a run-time problem?

I don't think it causes any harm, despite the error message.
i2c6 works fine (using a modified version of "ARM: shmobile:
koelsch-reference: Add restart function" from the BSP).

> Regardless, it looks like I should queue this up as
> a fix for v3.17. Is that your thinking too?

The error message is a regression from v3.16, so v3.17 would be
appropriate. However, if you have no other DTS fixes for v3.17,
v3.18 is fine for me, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
