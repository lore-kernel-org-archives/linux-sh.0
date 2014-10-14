From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2014 19:32:55 +0000
Subject: Re: [PATCH] ata: sata_rcar: Add r8a7793 device support
Message-Id: <CAMuHMdWSQYct5dnFnDBvVFBRCti8g5qJNKaVBBXOW9NZ6FWwQw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1413271894-10056-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1413271894-10056-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Kaneko-san, Matsuoka-san,

On Tue, Oct 14, 2014 at 9:31 AM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is against for-next branch of Tejun's libata repo.
>
>  drivers/ata/sata_rcar.c | 5 +++++

Can you please also update the binding documentation in
Documentation/devicetree/bindings/ata/sata_rcar.txt?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
