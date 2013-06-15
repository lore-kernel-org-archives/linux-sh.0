From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Date: Sat, 15 Jun 2013 20:16:13 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <201306152216.14252.heiko@sntech.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <2555796.PtkImJGaK8@avalon> <CACRpkdaF7V3FGhNNj+N+Dc-NWhsfQ=bqh+ETx0wGBFbLmxfGTw@mail.gmail.com>
In-Reply-To: <CACRpkdaF7V3FGhNNj+N+Dc-NWhsfQ=bqh+ETx0wGBFbLmxfGTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, James Hogan <james.hogan@imgtec.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Am Samstag, 15. Juni 2013, 21:56:05 schrieb Linus Walleij:
> On Fri, Jun 14, 2013 at 12:39 AM, Laurent Pinchart
> 
> <laurent.pinchart@ideasonboard.com> wrote:
> >         mmcif_pins: mmcif {
> >         
> >                 mux {
> >                 
> >                         renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
> >                         renesas,function = "mmc0";
> >                 
> >                 };
> >                 cfg {
> >                 
> >                         renesas,groups = "mmc0_data8_0";
> >                         renesas,pins = "PORT279";
> >                         bias-pull-up = <1>;
> 
> If I understood your code correctly that last statement can *optionally*
> be written like just:
> 
>  bias-pull-up;
> 
> Without the parameter?
> 
> I think that Heiko's implementation does this anyway.

Yep, with the fixes-series from yesterday the bias-pull-* now have a better 
default value of <1>.

so you can do
	bias-pull-up;
which is then identical to the
	bias-pull-up = <1>;
above (both are valid of course).


Disable would the be either
	bias-disable;
or
	bias-pull-up = <0>;

A driver should probably handle both, as both are valid pinconf options or 
this.


