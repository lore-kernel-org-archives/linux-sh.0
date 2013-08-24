From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
Date: Sat, 24 Aug 2013 15:16:43 +0000
Subject: Re: [PATCH v3 3/5] clk: Add common __clk_get(), __clk_put() implementations
Message-Id: <5218CE5B.1020906@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
 <1377270227-1030-4-git-send-email-s.nawrocki@samsung.com>
 <20130823231314.GR6617@n2100.arm.linux.org.uk>
In-Reply-To: <20130823231314.GR6617@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/24/2013 01:13 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 23, 2013 at 05:03:45PM +0200, Sylwester Nawrocki wrote:
>> >  This patch adds common __clk_get(), __clk_put() clkdev helpers which
>> >  replace their platform specific counterparts when the common clock
>> >  API is enabled.
>> >
>> >  The owner module pointer field is added to struct clk so a reference
>> >  to the clock supplier module can be taken by the clock consumers.
>> >
>> >  Signed-off-by: Sylwester Nawrocki<s.nawrocki@samsung.com>
>> >  Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>
> I'm mostly happy with this now.
>
>> >  +int __clk_get(struct clk *clk)
>> >  +{
>> >  +	if (clk&&  !try_module_get(clk->owner))
>> >  +		return 0;
>> >  +
>> >  +	return 1;
>> >  +}
>> >  +EXPORT_SYMBOL(__clk_get);
>> >  +
>> >  +void __clk_put(struct clk *clk)
>> >  +{
>> >  +	if (WARN_ON_ONCE(IS_ERR(clk)))
>> >  +		return;
>> >  +
>> >  +	if (clk)
>> >  +		module_put(clk->owner);
>> >  +}
>> >  +EXPORT_SYMBOL(__clk_put);
>
> Why are these exported?  clkdev can only be built into the kernel, as can
> the common clk framework - they can't be modular.  So why would a module
> wish to access these directly?

I must have been mislead by the fact that some ARM sub-architecture exports
those, have added them initially and then didn't think enough about it and
left these in. Actually, at some point I noticed the exporting is not 
needed,
but never did get around to remove it. Thanks. The updated series to 
follow.




