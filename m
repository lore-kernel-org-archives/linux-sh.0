From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 12 Feb 2015 15:59:23 +0000
Subject: Re: [PATCH v2 08/15] ARM: shmobile: r8a7778, bockw: add internal ethernet controller to DT
Message-Id: <1775207.RiYzQcpkbm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wednesday 11 February 2015 08:48:23 Geert Uytterhoeven wrote:
> On Wed, Feb 11, 2015 at 4:54 AM, Laurent Pinchart wrote:
> >> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> >> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> >> @@ -59,6 +59,11 @@
> >>       };
> >>  };
> >> 
> >> +&ether {
> >> +     pinctrl-0 = <&ether_pins>;
> >> +     pinctrl-names = "default";
> > 
> > The internal ethernet controller isn't used on the BockW board, its pins
> > are used for display. I thus wouldn't add it to r8a7778-bockw.dts.
> 
> Depending on SW62 (and parts of SW84/85)...
> 
> >> +};
> 
> There's no 'status = "okay";', so it is still disabled.
> 
> What about adding a comment about the switches?

How about a device tree overlay instead ? That would avoid populating DT with 
needless nodes.

-- 
Regards,

Laurent Pinchart

