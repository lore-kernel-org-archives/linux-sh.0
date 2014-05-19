From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2014 12:00:42 +0000
Subject: Re: [PATCH 1/3] usb: host: xhci-plat: add xhci_plat_start()
Message-Id: <CAMuHMdWSuZv0kTEW6XJ8XTnd6LuYnMBQ0MhN0G35riwKfvDbag@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D7F8.5060604@renesas.com>
In-Reply-To: <5379D7F8.5060604@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: mathias.nyman@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, May 19, 2014 at 12:07 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Some platforms (such as the Renesas R-Car) need to initialize some specific
> registers after xhci driver calls usb_add_hcd() and before the driver calls
> xhci_run(). So, this patch adds the xhci_plat_start() function.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
