From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Feb 2015 09:13:56 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: Add support SOC_BUS to R-Car Gen2
Message-Id: <CAMuHMdXxQZo0HO6F+ir6cjEa+bO1tJ0w6vToBDsk=GR4RK-ziw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423791622-30610-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1423791622-30610-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 13, 2015 at 2:40 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> This provides information through SOC_BUS to sysfs.
> And this moves all on-SoC devices from /sys/devices/platform to
> /sys/devices/socX/.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
