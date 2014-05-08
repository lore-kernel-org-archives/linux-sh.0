From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 08 May 2014 10:12:29 +0000
Subject: Re: [PATCH v4] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <CAMuHMdWwenyU1RS4c8spFcb7M0oCXP9z8zbGQ0VACKj7EbvvkA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399411579-10681-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 6, 2014 at 11:26 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Tested on Koelsch (legacy, reference, shmobile, and shmobile+bbb kernels)
> and BeagleBone Black (shmobile+bbb). Will test on more hardware tomorrow.

Tested on genmai with Wolfram's CCF support.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
