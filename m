From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Sep 2015 00:27:17 +0000
Subject: Re: [PATCH 07/14][RFC] arm64: renesas: salvator-x: enable I2C
Message-Id: <87a8sthki8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9n2n3x1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9n2n3x1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Wolfram

> > +&i2c2 {
> > +	pinctrl-0 = <&i2c2_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +};
> 
> I think we should add the bus speed here explicitly and not rely on a
> default:
> 
> 	clock-frequency = <100000>;
> 
> Maybe 400000 if all connected devices support that.

Thanks, actually I used clock-frequency = <100000> in my test.
Then, removed it for posting.
will add it again in v2
