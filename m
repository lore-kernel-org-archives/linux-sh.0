From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2014 13:13:38 +0000
Subject: Re: [PATCH] clk: shmobile: mstp: Fix the is_enabled() operation
Message-Id: <CAMuHMdW2PvHs57tKT2-wgP1vaFxoPfmL8fW5=hvhdxwnjAse-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1394658274-6348-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Mar 13, 2014 at 12:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> The msiof and rspi drivers seem to enable/disable clocks explicitly, so they
> should probably work. However the rspi driver seems to be missing
> clk_prepare/clk_unprepare calls. Do you plan to fix that ?

Those haven been removed in the conversion of the rspi driver to spi
core auto_runtime_pm.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
