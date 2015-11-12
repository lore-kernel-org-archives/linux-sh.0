From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Nov 2015 10:25:43 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <CAMuHMdW_pnSZJcvbxOPbyNL9H=umhG2uxkxgEKh7wchRW0u6SA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Simon,

On Thu, Nov 12, 2015 at 2:53 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.
>
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas R-Car DMA Controller driver to follow this convention.

Thanks for tackling this!

> Cc: devicetree@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
