From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Sep 2015 09:25:45 +0000
Subject: Re: [PATCH v2 2/2] usb: renesas_usbhs: Add support for R-Car H3
Message-Id: <CAMuHMdW-HLyuvTA3WSu39kboj_GLQxNKsRZ4rNzCfxSvzs+Q6w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443518479-2864-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1443518479-2864-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1443518479-2864-3-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Sep 29, 2015 at 11:21 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds a compatible string to support for R-Car H3.
>
> Since the HS-USB controller of R-Car H3 is almost the same specification
> with R-Car Gen2 (these have 16 pipes and usb-dmac), this patch
> sets the "type" of renesas_usbhs_driver_param to USBHS_TYPE_RCAR_GEN2.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
