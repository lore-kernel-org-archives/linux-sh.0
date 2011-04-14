From: Tony Lindgren <tony@atomide.com>
Date: Thu, 14 Apr 2011 12:49:16 +0000
Subject: Re: [PATCH 1/2] Add a common struct clk
Message-Id: <20110414124916.GB3336@atomide.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1299134429.100626.661279191478.0.gpush@pororo>
	<1299134429.101167.227629761799.1.gpush@pororo>
In-Reply-To: <1299134429.101167.227629761799.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Jeremy Kerr <jeremy.kerr@canonical.com> [110303 08:39]:
> 
> Platforms can enable the generic struct clock through
> CONFIG_USE_COMMON_STRUCT_CLK. In this case, the clock infrastructure
> consists of a common struct clk:
> 
> struct clk {
> 	const struct clk_ops	*ops;
> 	unsigned int		enable_count;
> 	unsigned int		prepare_count;
> 	spinlock_t		enable_lock;
> 	struct mutex		prepare_lock;
> };
> 
> And a set of clock operations (defined per type of clock):
> 
> struct clk_ops {
> 	int             (*enable)(struct clk *);
> 	void            (*disable)(struct clk *);
> 	unsigned long   (*get_rate)(struct clk *);
> 	[...]
> };
> 
> To define a hardware-specific clock, machine code can "subclass" the
> struct clock into a new struct (adding any device-specific data), and
> provide a set of operations:
> 
> struct clk_foo {
> 	struct clk	clk;
> 	void __iomem	*some_register;
> };
> 
> struct clk_ops clk_foo_ops = {
> 	.get_rate = clk_foo_get_rate,
> };

Anybody looked into passing the clock register and type
from device tree?

To me it looks like the above would allow doing that
pretty easily while avoiding duplicating all the
data from devicetree into struct clk_foo.

Tony
