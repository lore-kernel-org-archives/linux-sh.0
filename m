From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 04 Feb 2015 09:53:34 +0000
Subject: Re: [RFC/PATCH] pinctrl: sh-pfc: Accept standard function, pins and groups properties
Message-Id: <12938873.nmb8Ng8mNb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <CACRpkda4SBof0EaZVWtEYaeb6j_BGAVj39kje+mBz90eB3qAwQ@mail.gmail.com> <1422390694-12389-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CACRpkda6H7hbgXhmSbgtwOC_8PbHnES5syp-YEp1+V6s5Ym6Cw@mail.gmail.com>
In-Reply-To: <CACRpkda6H7hbgXhmSbgtwOC_8PbHnES5syp-YEp1+V6s5Ym6Cw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niso-UNjuZkX4dYU@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Hi Linus,

On Wednesday 04 February 2015 09:40:48 Linus Walleij wrote:
> On Tue, Jan 27, 2015 at 9:31 PM, Laurent Pinchart wrote:
> > The "function", "pins" and "groups" pinmux and pinctrl properties have
> > been standardized. Support them in addition to the custom "renesas,*"
> > properties. New-style and old-style properties can't be mixed in DT.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> (...)
> 
> >> Would be nice if the PFC driver could be augmented to also accept the
> >> now standard bindings "groups" and "function" simply :) we're adding
> >> parse functions for those to the core.
> > 
> > Something like this ?
> 
> Yes :)
> 
> > Please note two differences between the Renesas PFC bindings and the
> > standard bindings:
> > 
> > - The standard bindings state that a pinctrl node must contain either a
> >   "pins" property or a "groups" property, while the Renesas bindings
> >   allows for both to coexist in the same node.
> 
> Sascha also says this makes sense for him so I guess I'm getting a bit
> soft on the issue.
> 
> > - The standard bindings don't allow a pinmux node to contain a "pins"
> >   property, while the Renesas bindings do.
> 
> Does that mean "pins" affect the muxing or that "pins" is about some per-pin
> config shoveled into the same node?
> 
> The former is not OK, the latter is.

It means "pins" affect the muxing. The sh-pfc driver supports both muxing 
groups and muxing individual pins.

> >                 mmcif_pins: mmcif {
> >                 
> >                         mux {
> > -                               renesas,groups = "mmc0_data8_0",
> > "mmc0_ctrl_0";
> > -                               renesas,function = "mmc0";
> > +                               groups = "mmc0_data8_0", "mmc0_ctrl_0";
> > +                               function = "mmc0";
> >                         };
> 
> So that looks just very nice.
> 
> >                         cfg {
> > -                               renesas,groups = "mmc0_data8_0";
> > -                               renesas,pins = "PORT279";
> > +                               groups = "mmc0_data8_0";
> > +                               pins = "PORT279";
> >                                 bias-pull-up;
> 
> And here I can't see the use of "groups" in this node since it
> doesn't match a function. It's a bit ambiguous what "groups"
> mean when you run into it like this.

It means that the bias-pull-up configuration is applied to all pins of the 
"mmc0_data8_0" group, as well as to pin 279.

-- 
Regards,

Laurent Pinchart

