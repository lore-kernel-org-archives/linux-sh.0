From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 15 Feb 2011 01:41:00 +0000
Subject: Re: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
Message-Id: <201102150941.00668.jeremy.kerr@canonical.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1297233693.242725.820672531799.2.gpush@pororo>
	<4D54738C.80900@bluewatersys.com>
In-Reply-To: <4D54738C.80900@bluewatersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ryan,

> A fixed clock may still have other operations such as enable/disable.

Then it's not a fixed clock; I'd prefer this to be a separate type, as it's 
now hardware dependent.

> Maybe do something like this instead:
> #define INIT_CLK_FIXED(name, ops, r) { 		\
> 	.clk = INIT_CLK(name.clk, ops, rate), 	\
> 	.clk.ops.get_rate = clk_fixed_get_rate, \
> 	.rate = (r),				\
> }
> 
> That's untested though. I'm not sure if you can reliably assign
> something twice in a struct initialiser?

also, clk->ops is a const.

Cheers,


Jeremy
