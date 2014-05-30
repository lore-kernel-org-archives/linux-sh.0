From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2014 10:05:16 +0000
Subject: Re: [PATCH 4/7] ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile
Message-Id: <CAMuHMdV2ixL+n23nZUK1geadpvt3ubHoMM18Gw1rq_M+ym7vGw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E677.60801@bp.renesas.com>
In-Reply-To: <5386E677.60801@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Inami-san,

On Thu, May 29, 2014 at 9:49 AM, Gaku Inami
<gaku.inami.xw@bp.renesas.com> wrote:
> I add a new file(cpufreq.c) for the following reasons.
> - Registration of platform_device must be unified in SH-Mobile.
> - We can't create a node of cpufreq drivers into device tree.
>   (Because cpufreq driver is virtual device.)

Just wondering: what will the migration path be to board-less platform
support? I had a quick look how other platforms handle it, but didn't
become much wiser.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
