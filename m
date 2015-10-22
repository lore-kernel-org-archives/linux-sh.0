From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 22 Oct 2015 20:07:30 +0000
Subject: Re: of_mdiobus_register_phy() and deferred probe
Message-Id: <56294202.5020507@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdX+_0Cf0VwmKDtcfMNwaPEN5jvjZQUXg6MKMJa+cvYz3w@mail.gmail.com>
In-Reply-To: <CAMuHMdX+_0Cf0VwmKDtcfMNwaPEN5jvjZQUXg6MKMJa+cvYz3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello.

On 10/22/2015 04:31 PM, Geert Uytterhoeven wrote:

> Due to a probe deferral of an interrupt controller[1], the Micrel
> Ethernet PHY on
> r8a7791/koelsch started failing to get its IRQ:
>
>      no irq domain found for /interrupt-controller@e61c0000 !
>
> However, of_mdiobus_register_phy() uses irq_of_parse_and_map(), which plainly
> ignores EPROBE_DEFER, and it just continues.
>
> Later I get:
>
>      sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ -1) to driver
> Micrel KSZ8041RNLI
>
> instead of
>
>      sh-eth ee700000.ethernet eth0: attached PHY 1 (IRQ 408) to driver
> Micrel KSZ8041RNLI
>
> Ethernet still works, as the interrupt seems to be unneeded(?).

    Yes, the phylib uses PHY polling anyway, IRQ isn't strictly necessary.

> Has anyone already looked into fixing of_mdio to handle deferred probing?

    It's the first time I hear about that. Will have to look into this...

> Gr{oetje,eeting}s,
>                          Geert

MBR, Sergei

