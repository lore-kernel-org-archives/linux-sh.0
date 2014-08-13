From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Aug 2014 11:58:44 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal
Message-Id: <CAMuHMdX7gD4PyDuAe_Pxc1nFPRbVBOE5KmK8kzxit5bOOsfg3Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140808114855.14647.62725.sendpatchset@w520>
In-Reply-To: <20140808114855.14647.62725.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Aug 8, 2014 at 1:48 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: r8a7779 and Marzen NR_IRQS_LEGACY removal
>
> [PATCH 01/02] ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY
> [PATCH 02/02] ARM: shmobile: marzen: Remove NR_IRQS_LEGACY
>
> Remove NR_IRQS_LEGACY from the machine vector on r8a7779 and Marzen,
> completely untested but other Multiplatform SMP SoCs with GIC seem
> to work well without this - and so does legacy Marzen.
>
> The reason for this removal is that this is just legacy left over
> cruft that once used to be necessary for static interrupt assignment
> (I think) while we migrated to DT support for the GIC.
>
> Not needed in case of Multiplatform and Sparse IRQ.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

And since Sparse IRQ is now always enabled on shmobile, the
remaining ones can be removed as well. Patch series sent.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
