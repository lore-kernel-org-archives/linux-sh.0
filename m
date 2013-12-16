From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Dec 2013 13:25:24 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <CAMuHMdU5tVKyb4yDEU=aD2GnMNbddKDOED7GGw4XekFWwN_9sA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 16, 2013 at 2:28 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> 2013/12/14 Andrew Morton <akpm@linux-foundation.org>:
>> On Fri, 13 Dec 2013 09:51:00 +0100 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>>> Note that Ralf decided to fix it differently, by uninlining virt_addr_valid:
>>
>> geeze, what a mess this is.
>>
>> I suppose that the proposed sh patch is reasonable - it's the sh
>> implementation of virt_addr_valid() whcih chooses to use these symbols
>> so sh should export them to support that implementation.
>
> Andrew, thanks for your comment.
>
> Geert, do you think about this?

Both are valid solutions: either you fix it at the high level, like MIPS
does, or at the low level. It's just about what you want to expose, and
if you want to risk people touching too much innards.

Anyway:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
