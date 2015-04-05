From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 05 Apr 2015 08:47:01 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7791: Remove MSIOF address from device tree
Message-Id: <CAMuHMdVH19ZncC0dMbO8-rCzN6MkOVWfiSKLDAnsqW6_Z_pw1Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428166512-2936-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1428166512-2936-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Apr 4, 2015 at 6:55 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
