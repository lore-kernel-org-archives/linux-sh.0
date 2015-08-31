From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 07:37:09 +0000
Subject: Re: [PATCH] drivers: sh: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <CAMuHMdW2ysn6PK5ZgZVws5dUwS5bSbJaEk4Ry-zr2uShiNg7Dg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440705906-3230-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440705906-3230-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Mon, Aug 31, 2015 at 8:40 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 31, 2015 at 03:36:24PM +0900, Simon Horman wrote:
>> On Thu, Aug 27, 2015 at 10:05:06PM +0200, Geert Uytterhoeven wrote:
>> > Shmobile is all multiplatform these days, so get rid of the reference to
>> > CONFIG_ARCH_SHMOBILE_MULTI.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > ---
>> > This must not be applied to a branch that still has
>> > CONFIG_SHMOBILE_LEGACY.
>>
>> Thanks, I have queued this up for v4.4.
>
> It seems this patch is a duplicate of "drivers: sh: Get rid of
> CONFIG_ARCH_SHMOBILE_MULTI". I have queued up that patch instead of this
> one.

Yeah, I copied too many lines from Magnus' patches, leading to a missing
"ARCH_" infix ;-) Sorry for that...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
