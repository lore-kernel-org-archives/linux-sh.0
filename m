From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Oct 2015 20:55:14 +0000
Subject: Re: [PATCH 1/4] usb: host: xhci-rcar: add xhci_rcar_is_compatible() function
Message-Id: <CAMuHMdXEbEwgNgu6qbEhPXoikneVeHN4Qw_gAzwO445hQy291w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444046790-5804-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444046790-5804-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Shimoda-san,

On Mon, Oct 5, 2015 at 2:06 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> +bool xhci_rcar_is_compatible(struct usb_hcd *hcd)
> +{
> +       struct device_node *of_node = hcd->self.controller->of_node;
> +
> +       if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
> +           of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
> +               return true;

If you want to match against multiple compatible values, you may be better
off with of_match_node().
This may also simplify the code to match specific firmware paths to the
various compatible entries.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
