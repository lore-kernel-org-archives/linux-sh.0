From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Dec 2014 08:08:16 +0000
Subject: Re: [PATCH 0/4] KZM9G: Enable various I2C devices in DT
Message-Id: <CAMuHMdXjK--LJwS67r_qS4Zs1sM_WgC8trf9Op9arfPqFskupQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418869570-13529-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418869570-13529-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Dec 18, 2014 at 3:26 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This patch series enables the touchscreen controller, compass and
> accelerometer in the KZM9G DT. It applies on top of your 'wip' branch. You
> probably want to squash patches 3/4 and 4/4 with the patch(es) that add the
> adxl325 and ak8975 DT nodes.

adxl345?

> adxl325 support requires "[PATCH] input: adxl34x: Add OF match support"
> previously posted to the linux-sh mailing list. This series can be applied
> independently though, the device will just not be probed.
>
> Could you please take the patches in your tree (when they will be acked of
> course) ?

Thanks a lot!

I'll take care of squashing/forwarding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
