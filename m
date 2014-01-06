From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Jan 2014 08:43:11 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: Set CONFIG_LOCALVERSION in defconfigs
Message-Id: <CAMuHMdUSbvg593r_2prWaD9BsgXqw+sfur_S9Et5gX1a+v3PuA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
 <1388764128-27686-2-git-send-email-geert@linux-m68k.org>
 <20140106022758.GE11231@verge.net.au>
In-Reply-To: <20140106022758.GE11231@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 6, 2014 at 3:27 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Jan 03, 2014 at 04:48:46PM +0100, Geert Uytterhoeven wrote:
>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>
>> This allows to derive the kernel flavor from the kernel version.
>
> Is this a common practice for ARM?

Not really, only 5 ARM deconfigs do that.
Globally, ca. 10% of the Linux defconfigs do it.

> I'm a little hesitant to take this if its not.
> Particularly as we are planing to deprecate these defconfigs
> in favour of a shared multiplatform defconfig.

A shared multiplatform defconfig can still have
CONFIG_LOCALVERSION="-shmobile", so you'll know it's a multiplatform
kernel when you see the dmesg.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
