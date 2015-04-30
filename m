From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:42 +0000
Subject: Re: [PATCH 06/11] ARM: shmobile: r8a7793: add SMP support
Message-Id: <CAO3366zY2Fjap1f+H7Fd7VHQo0gVHDJEWvzj-cq28DwXn3GqvA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 8, 2015 at 11:10 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Mar 7, 2015 at 1:08 AM, Simon Horman <horms@verge.net.au> wrote:
>>> +     /* setup for debug mode */
>>> +     if (rcar_gen2_read_mode_pins() & MD(21)) {
>>> +             p = ioremap_nocache(APMU, 0x2000);
>>> +             val = readl_relaxed(p + CA15DBGRCR);
>>> +             writel_relaxed((val | 0x01f80000), p + CA15DBGRCR);
>>> +             iounmap(p);
>>
>> As you noted elsewhere, the above is inconsistent with the r8a7791 where an
>> error returned if debug mode is enabled: that is if the if condition is
>> true.
>
> The above may actually be what is needed on r8a7791, too :-)

If I correctly remember the conversation I had with Magnus on this
issue, it would be more correct to say "something like the above", as
the hoop we have to jump through there is SoC-specific.

CU
Uli
