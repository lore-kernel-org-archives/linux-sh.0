From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 15 Oct 2015 18:28:40 +0000
Subject: Re: [PATCH v4] clk: add CS2000 Fractional-N driver
Message-Id: <20151015182840.GJ4558@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <871te03x17.wl%kuninori.morimoto.gx@renesas.com>
 <20151002003851.GH12338@codeaurora.org>
 <87twqarsdf.wl%kuninori.morimoto.gx@renesas.com>
 <20151002181123.GM12338@codeaurora.org>
 <87r3kwor4d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3kwor4d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org

On 10/15, Kuninori Morimoto wrote:
> 
> I understand. If my understanding is correct, user driver
> setups/enables this clock.
> If so, I still want this "clock-frequency" feature.
> because this clock requests other clock on my board.
> And requested clock requests this clock too.
> Thus, these clocks have dead lock on probe time
> 
> 	cs2000: clk_multiplier@4f {
> 		...
> 		clocks = <&rcar_sound 0>, ...
> 		...
> 	};
> 
> 	&rcar_sound {
> 		...
> 		assigned-clocks = <&cs2000>;
> 	        assigned-clock-rates = <24576000>;
> 		...
> 	};
> 

I think you're saying that the clock provider itself can't set
the rate with assigned-clock-rates? That isn't true, we should be
able to set the rate of the clock from within the provider node.

	cs2000: clk_multiplier@4f {
		assigned-clocks = <&cs2000>;
		assigned-clock-rates = <24576000>;
	};

The above should work.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
