From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 26 Jan 2014 19:07:02 +0000
Subject: Re: [PATCH 6/8] phy-rcar-usb-gen2: add device tree documentation
Message-Id: <CAMuHMdV=_guap4ZpkifB+3pcYVM_myc-d2vJgoVPMLni+QFyrg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk>
	<1390754945-28142-7-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390754945-28142-7-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, horms+renesas@verge.net.au

On Sun, Jan 26, 2014 at 5:49 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/renesas,rcar-gen2-usb-phy.txt
> @@ -0,0 +1,16 @@
> +Renesas RCar gen2 USB PHY bindings
> +
> +Required properties:
> + - compatible: "renesas,usb-phy-r8a7790" for the R8A7790 SoC or
> +    "renesas,rcar-gen2-usb-phy" for any generic comaptible device.
> + - reg : A single region to access device registers
> + - clocks : The reference to the clock to use for this block
> + - clock-names : The name for the clock at index 0 (must be "usbhs")
> +
> +Note, interrupt is currently not supported by the driver, but there should
> +be a node in the device tree for it.

s/node/property/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
