From: viresh kumar <viresh.kumar@st.com>
Date: Tue, 24 May 2011 04:30:12 +0000
Subject: Re: [PATCH 1/4] clk: Add a generic clock infrastructure
Message-Id: <4DDB3184.2080301@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305876469.326305.518470530485.1.gpush@pororo>
In-Reply-To: <1305876469.326305.518470530485.1.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/20/2011 12:57 PM, Jeremy Kerr wrote:
> +static DEFINE_SPINLOCK(enable_lock);
> +static DEFINE_MUTEX(prepare_lock);

Probably all clocks can be handled separately, i.e. single lock for all
of them will make system slower. Suppose i want to enable UART's clock
then why should spi code be waiting for the lock.
So, we should have per clk lock.

<...>

> +struct clk *clk_register(struct clk_hw_ops *ops, struct clk_hw *hw,
> +               const char *name)
> +{
> +       struct clk *clk;
> +
> +       clk = kzalloc(sizeof(*clk), GFP_KERNEL);
> +       if (!clk)
> +               return NULL;
> +
> +       clk->name = name;
> +       clk->ops = ops;
> +       clk->hw = hw;
> +       hw->clk = clk;
> +
> +       /* Query the hardware for parent and initial rate */
> +

Can remove this blank line.

> +       if (clk->ops->get_parent)
> +               /* We don't to lock against prepare/enable here, as
> +                * the clock is not yet accessible from anywhere */

Shouldn't we use following style for multi-line comments.
/*
 * ....
 */

> +               clk->parent = clk->ops->get_parent(clk->hw);
> +
> +       if (clk->ops->recalc_rate)
> +               clk->rate = clk->ops->recalc_rate(clk->hw);
> +
> +

Can remove one of these blank lines.

-- 
viresh
