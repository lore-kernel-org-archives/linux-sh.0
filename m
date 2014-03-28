From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Mar 2014 15:35:16 +0000
Subject: Re: [PATCH] drivers/sh: pm_runtime implementation needs to suspend and resume devices
Message-Id: <CAMuHMdVNd3zPFfjMATxKrTd+eTuc7_gEyrDyvr9X79+Dea1arg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395334473-27600-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1395334473-27600-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 20, 2014 at 5:54 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> If we override the platform bus calls for pm_runtime then we end up
> with the calls to the devices' suspend and resume methods ignored
> in favour of the bus ones.
>
> Change to calling the pm_runtime calls to suspend and resume the
> devices specifically in the drivers/sh/pm_runtime.c implementation
> to allow any device that may want to run power management to do so.
>
> Note, all the current sh driver implementations do not use their
> own power management code so this is not a major implementation
> issues.
>
> This also brings the implementation into line with the versions
> used by the Davinci and Keystone PM domain code, so once fully
> tested these implementations could be merged together.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
