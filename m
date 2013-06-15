From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 15 Jun 2013 19:56:05 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <CACRpkdaF7V3FGhNNj+N+Dc-NWhsfQ=bqh+ETx0wGBFbLmxfGTw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20130612124833.A3ADB3E0A56@localhost>
	<2555796.PtkImJGaK8@avalon>
In-Reply-To: <2555796.PtkImJGaK8@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, James Hogan <james.hogan@imgtec.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Jun 14, 2013 at 12:39 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

>         mmcif_pins: mmcif {
>                 mux {
>                         renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
>                         renesas,function = "mmc0";
>                 };
>                 cfg {
>                         renesas,groups = "mmc0_data8_0";
>                         renesas,pins = "PORT279";
>                         bias-pull-up = <1>;

If I understood your code correctly that last statement can *optionally*
be written like just:

 bias-pull-up;

Without the parameter?

I think that Heiko's implementation does this anyway.

Yours,
Linus Walleij
