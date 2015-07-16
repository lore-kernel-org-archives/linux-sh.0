From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2015 08:16:55 +0000
Subject: Re: [PATCH 01/03] ARM: shmobile: marzen: Remove legacy board code
Message-Id: <CAMuHMdVrtZeqEkMcL=zPd_G44gpuv74cCxytsXKe01-MBMnSOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150716075352.1198.7492.sendpatchset@little-apple>
In-Reply-To: <20150716075352.1198.7492.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 16, 2015 at 9:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Remove Marzen legacy board code written in C. Instead
> board support expressed in DT shall be used together
> with Multiplatform and shmobile_defconfig.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
