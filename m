From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2015 17:49:06 +0000
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Message-Id: <CAMuHMdVQ=sDF__DgxSviH8=Q-4hN1wEL5DgUFoHoBRLCLB09rQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Thu, Jan 15, 2015 at 3:54 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> DT nodes should use the more specific adi,adxl345 and adi,adxl346
> compatible values instead. As the ADXL346 is backward-compatible with
> the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
> in that order.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
