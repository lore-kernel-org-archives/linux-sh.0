From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Sep 2014 09:02:54 +0000
Subject: Re: [PATCH 8/8] ARM: shmobile: koelsch: Enable DU device in DT
Message-Id: <20140924090254.GA17979@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410963073-3176-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410963073-3176-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 18, 2014 at 12:07:48PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Wednesday 17 September 2014 16:51:20 Geert Uytterhoeven wrote:
> > On Wed, Sep 17, 2014 at 4:11 PM, Laurent Pinchart wrote:
> > > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > > @@ -209,6 +209,46 @@
> > >                 states = <3300000 1
> > >                           1800000 0>;
> > >         };
> > > +
> > > +       panel {
> > > +               compatible = "mitsubishi,aa104xd12", "panel-dpi";
> > 
> > This device is not present on a stock Koelsch, so I don't think it belongs
> > in this DTS.
> 
> I agree. Still, it would be good to have support for that panel in mainline, 
> as it's commonly used by Renesas with the Koelsch board (among others). I'll 
> create a separate .dtsi file that developers can just include in their board 
> file to hook up the panel.

Thanks, that seems reasonable to me.

> > > +
> > > +               width-mm = <210>;
> > > +               height-mm = <158>;
> > > +
> > > +               panel-timing {
> > > +                       /* 1024x768 @65Hz */
> > > +                       clock-frequency = <65000000>;
> > > +                       hactive = <1024>;
> > > +                       vactive = <768>;
> > > +                       hsync-len = <136>;
> > > +                       hfront-porch = <20>;
> > > +                       hback-porch = <160>;
> > > +                       vfront-porch = <3>;
> > > +                       vback-porch = <29>;
> > > +                       vsync-len = <6>;
> > > +               };
> > > +
> > > +               port {
> > > +                       panel_in: endpoint {
> > > +                               remote-endpoint = <&du_out_lvds0>;
> > > +                       };
> > > +               };
> > > +       };
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
