From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2014 12:00:58 +0000
Subject: Re: [PATCH 3/3] Documentation: dt-bindings: update xhci-platform DT binding for R-Car H2 and M2
Message-Id: <CAMuHMdVU-bHUxi_O-3A_dn=A2425prMHxC5=6Ed_p2LeZkczBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D813.1040100@renesas.com>
In-Reply-To: <5379D813.1040100@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, May 19, 2014 at 12:08 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This commit extends the compatible string list of the xhci-platform
> binding with the new "renesas,r8a7790-xhci" and "renesas,r8a7791-xhci"
> compatible strings. It is used to describe the xHCI controller which
> is available in the R-Car H2 and M2 SoCs.
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
