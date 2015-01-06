From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Jan 2015 13:02:31 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: sh73a0: Set control-parent for all irqpin nodes
Message-Id: <CAMuHMdWE+3hJQGyC2ENa=e8F8Jhxvxxcah2gHmbRmCa_+Zbr7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Dec 18, 2014 at 3:26 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The sh73a0 INTC can't mask interrupts properly most likely due to a
> hardware bug. Set the control-parent property to delegate masking to the
> parent interrupt controller.

Thanks a lot!

Without this, accessing the three-axis digital accelerometer ADXL345
through /dev/input/event0 causes an interrupt storm, which requires a
power-cycle to recover from.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
