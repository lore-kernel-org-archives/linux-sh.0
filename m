From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2014 12:38:42 +0000
Subject: Re: [PATCH v4 8/9] ARM: shmobile: koelsch-reference: Remove DU platform device
Message-Id: <CAMuHMdU+LDJRksP-zYTfEVkaVK_tYw+kYAhNYaF0hAzPXqcn1g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414152241-5390-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414152241-5390-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 2:04 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> --- a/arch/arm/mach-shmobile/board-koelsch-reference.c
> +++ b/arch/arm/mach-shmobile/board-koelsch-reference.c

> -static void __init koelsch_add_standard_devices(void)
> -{
> -       shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);

And that was the last user of shmobile_clk_workaround(), which can now be
sent to the land of the dodo...

> -       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -
> -       koelsch_add_du_device();
> -}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
