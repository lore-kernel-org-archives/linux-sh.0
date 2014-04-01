From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 01 Apr 2014 11:19:42 +0000
Subject: Re: [PATCH 0/4] r8a779[01] I2C clocks fixes
Message-Id: <CAMuHMdVp_=mu49GE+vxnn4U9buYWMHr7aG_KXhbYnpO1-PJevA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Apr 1, 2014 at 1:02 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The I2C clocks select an incorrect parent on r8a7790 and r8a7791, both in the
> legacy C code and in DT. This patch set fixes that.

Thanks!

> Laurent Pinchart (4):
>   ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
>   ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
>   ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
>   ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
