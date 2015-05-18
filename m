From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2015 11:55:08 +0000
Subject: Re: [PATCH v2 1/2] usb: renesas_usbhs: Change USBHS_TYPE_R8A779x to USBHS_TYPE_RCAR_GEN2
Message-Id: <CAMuHMdXJ99kLYi48NQwPX7MxjOEYG5PtVyR3W31MN0rHNQhArg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431947055-4324-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1431947055-4324-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431947055-4324-2-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, May 18, 2015 at 1:04 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the HSUSB controllers of R-Car Gen2 are the same specification
> (they have 16 pipes and usb-dmac), this patch changes USBHS_TYPE_R8A7790
> and USBHS_TYPE_R8A7791 to USBHS_TYPE_RCAR_GEN2.
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
