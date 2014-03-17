From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2014 15:53:33 +0000
Subject: Re: [RFC 1/6] shmobile: pm_runtime does not need idle callback
Message-Id: <CAMuHMdVVw-5gYsfMcZ9jiDZ1Y3jE7PsmVsXrDEst0wiWxHA-tQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395054917-27390-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1395054917-27390-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Mon, Mar 17, 2014 at 12:15 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> In the runtime_pm idle callback the code assumes that a NULL .runtime_idle
> entry is the same as a .runtime_idle entry that returns 0 as a result. This
> means the entry in drivers/sh/pm_runtime can be removed in favour of just
> leaving the entry NULL.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks, this part is definitely correct, and can go in now.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
