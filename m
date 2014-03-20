From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Mar 2014 09:14:19 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <CAMuHMdU3=6C+62SjBeTNrhTvOknT=F41GYG5M1T2F=ahyx+TpA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Thu, Mar 20, 2014 at 9:56 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>    [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
>
> I thought there was already a of capable intc driver in the
> irq drivers directory?

SH4A doesn't use OF. Or am I missing your point?

> Thanks, I will probably not get around to testing this until next
> week as I am not in the office until Monday now. I think there is
> one more thing we need to do, which is to do a device suspend and
> resume like the current davinci implementation.

Thanks, I'll have a look at that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
