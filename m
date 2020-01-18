From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 18 Jan 2020 09:36:17 +0000
Subject: Re: [PATCH v2] sh: sh4a: Bring back tmu3_device early device
Message-Id: <CAMuHMdVTg+Amw6Epuqhd60pdUDeCbTzJ=7TNDLE0BQRgCLQHPQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200118081356.22167-1-krzk@kernel.org>
In-Reply-To: <20200118081356.22167-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jan 18, 2020 at 9:14 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Commit 1399c195ef50 ("sh: Switch to new style TMU device") converted
> tmu3_device platform device to new style of platform data but removed it
> from sh7786_early_devices array effectively removing last three timers
> and causing a warning:
>
>     arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
>         warning: ‘tmu3_device’ defined but not used [-Wunused-variable]
>
> Fixes: 1399c195ef50 ("sh: Switch to new style TMU device")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
