From: Mike Turquette <mturquette@linaro.org>
Date: Sun, 23 Feb 2014 21:00:24 +0000
Subject: Re: [PATCH 1/3] clk: add clock-indices support
Message-Id: <20140223210024.22529.40658@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Ben Dooks (2014-02-13 10:02:49)
> Add a property called clock-indices to allow clock-output-names
> to be used where the index used to lookup a clock is not a 1:1
> mapping to the array position in the clock-output-names
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Ben & Laurent,

The clock-indices stuff looks sane to me. I've taken Ben's patch #1 into
clk-next. It seems patch #3 might be dropped and patch #2 didn't apply
cleanly for me.

Can Laurent's patches and Ben's #2 be rebased and sent together as a PR?
I'll leave it up to you guys to figure out the backwards compatibility
issue with Ben's patch #3.

Regards,
Mike

> ---
>  .../devicetree/bindings/clock/clock-bindings.txt     | 17 +++++++++++++++++
>  drivers/clk/clk.c                                    | 20 +++++++++++++++++++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> index 7c52c29..700e7aa 100644
> --- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -44,6 +44,23 @@ For example:
>    clocks by index. The names should reflect the clock output signal
>    names for the device.
>  
> +clock-indices:    If the identifyng number for the clocks in the node
> +                  is not linear from zero, then the this mapping allows
> +                  the mapping of identifiers into the clock-output-names
> +                  array.
> +
> +For example, if we have two clocks <&oscillator 1> and <&oscillator 3>:
> +
> +       oscillator {
> +               compatible = "myclocktype";
> +               #clock-cells = <1>;
> +               clock-indices = <1>, <3>;
> +               clock-output-names = "clka", "clkb";
> +       }
> +
> +       This ensures we do not have any empty nodes in clock-output-names
> +
> +
>  =Clock consumers=
>  
>  Required properties:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 5517944..18633c9 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2505,8 +2505,12 @@ EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
>  const char *of_clk_get_parent_name(struct device_node *np, int index)
>  {
>         struct of_phandle_args clkspec;
> +       struct property *prop;
>         const char *clk_name;
> +       const __be32 *vp;
> +       u32 pv;
>         int rc;
> +       int count;
>  
>         if (index < 0)
>                 return NULL;
> @@ -2516,8 +2520,22 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
>         if (rc)
>                 return NULL;
>  
> +       index = clkspec.args_count ? clkspec.args[0] : 0;
> +       count = 0;
> +
> +       /* if there is an indices property, use it to transfer the index
> +        * specified into an array offset for the clock-output-names property.
> +        */
> +       of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
> +               if (index = pv) {
> +                       index = count;
> +                       break;
> +               }
> +               count++;
> +       }
> +
>         if (of_property_read_string_index(clkspec.np, "clock-output-names",
> -                                         clkspec.args_count ? clkspec.args[0] : 0,
> +                                         index,
>                                           &clk_name) < 0)
>                 clk_name = clkspec.np->name;
>  
> -- 
> 1.8.5.3
> 
