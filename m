From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2015 07:24:16 +0000
Subject: Re: [PATCH v2 1/2] pinctrl: sh-pfc: Remove hardcoded IRQ numbers
Message-Id: <CAMuHMdW_yAwu_QtmhGmSB0piOkJkW8UU=UaVSUC0GqOoC9v0XQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442905694-2317-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442905694-2317-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Sep 22, 2015 at 9:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Sep 22, 2015 at 9:08 AM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>> Now that all ARM-based Renesas SoCs use multiplatform kernels only the
>> hardcoded IRQ numbers can be dropped as they're dynamically allocated.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Upon closer look, compared to v1, you also dropped the removal of

    #ifndef CONFIG_ARCH_MULTIPLATFORM
    #include <mach/irqs.h>
    #endif

for r8a7740/sh73a0, which was probably not intentional?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
