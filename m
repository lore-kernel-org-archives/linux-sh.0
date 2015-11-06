From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 06 Nov 2015 21:19:38 +0000
Subject: Re: [PATCH v5] clk: add CS2000 Fractional-N driver
Message-Id: <CAHp75VcKnJr2zaFky9_G-qetdiuB8fS=r8r7hQTbYPUwEZ7n4g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874mhmuyg8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mhmuyg8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org

On Tue, Oct 20, 2015 at 4:26 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hmm… Something wrong with send-email settings?

> This patch adds CS2000 Fractional-N driver as clock provider.

> +#define CH_SIZE_ERR(ch)                ((ch < 0) || (ch >= CH_MAX))
> +#define hw_to_priv(_hw)                container_of(_hw, struct cs2000_priv, hw)

> +#define priv_to_client(priv)   (priv->client)

to_client()?

> +#define priv_to_dev(priv)      (&(priv_to_client(priv)->dev))

to_dev() ?

> +static int cs2000_bset(struct cs2000_priv *priv, u8 addr, u8 mask, u8 val)
> +{
> +       s32 data;
> +
> +       data = cs2000_read(priv, addr);
> +       if (data < 0)
> +               return data;
> +
> +       data &= ~mask;
> +       data |= (val & mask);
> +
> +       return cs2000_write(priv, addr, data);
> +}
> +
> +static int cs2000_enable_dev_config(struct cs2000_priv *priv, bool enable)
> +{
> +       u32 val;
> +       int ret;
> +
> +       val = enable ? ENDEV1 : 0;

Put in expression below?

> +       ret = cs2000_bset(priv, DEVICE_CFG1, ENDEV1, val);
> +       if (ret < 0)
> +               return ret;
> +
> +       val = enable ? ENDEV2 : 0;

Same.

> +       ret = cs2000_bset(priv, GLOBAL_CFG,  ENDEV2, val);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int cs2000_clk_in_bound_rate(struct cs2000_priv *priv,
> +                                   u32 rate_in)
> +{
> +       u32 val;
> +
> +       if (rate_in >= 32000000 &&
> +           rate_in < 56000000)

One line here and below?

> +               val = 0x0;
> +       else if (rate_in >= 16000000 &&
> +                rate_in < 28000000)
> +               val = 0x1;
> +       else if (rate_in >= 8000000 &&
> +                rate_in < 14000000)
> +               val = 0x2;
> +       else
> +               return -EINVAL;
> +
> +       return cs2000_bset(priv, FUNC_CFG1, 0x3 << 3, val << 3);


> +}
> +
> +static int cs2000_wait_pll_lock(struct cs2000_priv *priv)
> +{
> +       struct device *dev = priv_to_dev(priv);
> +       s32 val;
> +       unsigned int i;
> +
> +       for (i = 0; i < 256; i++) {
> +               val = cs2000_read(priv, DEVICE_CTRL);
> +               if (val < 0)
> +                       return val;
> +               if (!(val & PLL_UNLOCK))
> +                       return 0;
> +               udelay(1);
> +       }

unsigned int i = 256;

do {
val = read();
…
while ((val & PLL_UNLOCK) && --i);

if (!i) {
 …
 return -EIO;

Actually -ETIMEDOUT ?

}
return 0;

> +
> +       dev_err(dev, "pll lock failed\n");
> +
> +       return -EIO;
> +}
> +
> +static int cs2000_clk_out_enable(struct cs2000_priv *priv, bool enable)
> +{
> +       u32 val = enable ? 0 : 0x3;

Redundant variable?

> +
> +       /* enable both AUX_OUT, CLK_OUT */
> +       return cs2000_write(priv, DEVICE_CTRL, val);
> +}
> +
> +static u32 cs2000_rate_to_ratio(u32 rate_in, u32 rate_out)
> +{
> +       u64 ratio;
> +
> +       /*
> +        * ratio = rate_out / rate_in * 2^20
> +        *
> +        * To avoid over flow, rate_out is u64
> +        * The result should be u32
> +        */
> +       ratio = (u64)rate_out << 20;
> +       do_div(ratio, rate_in);
> +
> +       return (u32)ratio;

No need to do explicit casting.

> +}
> +
> +static unsigned long cs2000_ratio_to_rate(u32 ratio, u32 rate_in)
> +{
> +       u64 rate_out;
> +
> +       /*
> +        * ratio = rate_out / rate_in * 2^20
> +        *
> +        * To avoid over flow, rate_out is u64
> +        * The result should be u32

u32 or unsigned long?

Btw, dots at the end of sentences.

> +        */
> +
> +       rate_out = (u64)ratio * rate_in;
> +       return (unsigned long)(rate_out >> 20);

Same.

> +}
> +
> +static int cs2000_ratio_set(struct cs2000_priv *priv,
> +                           int ch, u32 rate_in, u32 rate_out)
> +{
> +       u32 val;
> +       unsigned int i;
> +       int ret;
> +
> +       if (CH_SIZE_ERR(ch))
> +               return -EINVAL;
> +
> +       val = cs2000_rate_to_ratio(rate_in, rate_out);
> +       for (i = 0; i < 4; i++)

4 is magic, you have define already.

> +               ret = cs2000_write(priv,
> +                                  Ratio_Add(ch, i),
> +                                  Ratio_Val(val, i));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static u32 cs2000_ratio_get(struct cs2000_priv *priv, int ch)
> +{
> +       u32 tmp, val;
> +       unsigned int i;
> +
> +       val = 0;
> +       for (i = 0; i < 4; i++) {

Same.

> +               tmp = cs2000_read(priv,
> +                                 Ratio_Add(ch, i));

One line?

> +               if (tmp < 0)
> +                       return 0;
> +
> +               val |= Val_Ratio(tmp, i);
> +       }
> +
> +       return val;
> +}
> +
> +static int cs2000_ratio_select(struct cs2000_priv *priv, int ch)
> +{
> +       int ret;
> +
> +       if (CH_SIZE_ERR(ch))
> +               return -EINVAL;
> +

> +       /*
> +        * FIXME
> +        *
> +        * this driver supports static ratio mode only
> +        * at this point
> +        */

One line?

> +       ret = cs2000_bset(priv, DEVICE_CFG1, RSEL_MASK, RSEL(ch));
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_write(priv, DEVICE_CFG2, 0x0);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static unsigned long cs2000_recalc_rate(struct clk_hw *hw,
> +                                       unsigned long parent_rate)
> +{
> +       struct cs2000_priv *priv = hw_to_priv(hw);
> +       int ch = 0; /* it uses ch0 only at this point */
> +       u32 ratio;
> +
> +       ratio = cs2000_ratio_get(priv, ch);
> +
> +       return cs2000_ratio_to_rate(ratio, parent_rate);
> +}
> +
> +static long cs2000_round_rate(struct clk_hw *hw, unsigned long rate,
> +                             unsigned long *parent_rate)
> +{
> +       u32 ratio;
> +
> +       ratio = cs2000_rate_to_ratio(*parent_rate, rate);
> +
> +       return cs2000_ratio_to_rate(ratio, *parent_rate);
> +}
> +
> +static int __cs2000_set_rate(struct cs2000_priv *priv, int ch,
> +                            unsigned long rate, unsigned long parent_rate)
> +
> +{
> +       int ret;
> +
> +       ret = cs2000_clk_in_bound_rate(priv, parent_rate);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_ratio_set(priv, ch, parent_rate, rate);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_ratio_select(priv, ch);
> +       if (ret < 0)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int cs2000_set_rate(struct clk_hw *hw,
> +                          unsigned long rate, unsigned long parent_rate)
> +{
> +       struct cs2000_priv *priv = hw_to_priv(hw);
> +       int ch = 0; /* it uses ch0 only at this point */
> +
> +       return __cs2000_set_rate(priv, ch, rate, parent_rate);
> +}
> +
> +static int cs2000_enable(struct clk_hw *hw)
> +{
> +       struct cs2000_priv *priv = hw_to_priv(hw);
> +       int ret;
> +
> +       ret = cs2000_enable_dev_config(priv, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_clk_out_enable(priv, true);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_wait_pll_lock(priv);
> +       if (ret < 0)
> +               return ret;
> +
> +       return ret;
> +}
> +
> +static void cs2000_disable(struct clk_hw *hw)
> +{
> +       struct cs2000_priv *priv = hw_to_priv(hw);
> +
> +       cs2000_enable_dev_config(priv, false);
> +
> +       cs2000_clk_out_enable(priv, false);
> +}
> +
> +static u8 cs2000_get_parent(struct clk_hw *hw)
> +{
> +       /* always return REF_CLK */
> +       return REF_CLK;
> +}
> +
> +static const struct clk_ops cs2000_ops = {
> +       .get_parent     = cs2000_get_parent,
> +       .recalc_rate    = cs2000_recalc_rate,
> +       .round_rate     = cs2000_round_rate,
> +       .set_rate       = cs2000_set_rate,
> +       .prepare        = cs2000_enable,
> +       .unprepare      = cs2000_disable,
> +};
> +
> +static int cs2000_clk_get(struct cs2000_priv *priv)
> +{
> +       struct i2c_client *client = priv_to_client(priv);
> +       struct device *dev = &client->dev;
> +       struct clk *clk_in, *ref_clk;
> +
> +       clk_in = devm_clk_get(dev, "clk_in");
> +       /* not yet provided */
> +       if (IS_ERR(clk_in))
> +               return -EPROBE_DEFER;
> +
> +       ref_clk = devm_clk_get(dev, "ref_clk");
> +       /* not yet provided */
> +       if (IS_ERR(ref_clk))
> +               return -EPROBE_DEFER;
> +
> +       priv->clk_in    = clk_in;
> +       priv->ref_clk   = ref_clk;
> +
> +       return 0;
> +}
> +
> +static int cs2000_clk_register(struct cs2000_priv *priv)
> +{
> +       struct device *dev = priv_to_dev(priv);
> +       struct device_node *np = dev->of_node;
> +       struct clk_init_data init;
> +       const char *name = np->name;
> +       struct clk *clk;
> +       static const char *parent_names[CLK_MAX];
> +       int ch = 0; /* it uses ch0 only at this point */
> +       int rate;
> +       int ret;
> +
> +       of_property_read_string(np, "clock-output-names", &name);

What about device property API?

> +
> +       /*
> +        * set default rate as 1/1.
> +        * otherwise .set_rate which setup ratio
> +        * is never called if user requests 1/1 rate
> +        */
> +       rate = clk_get_rate(priv->ref_clk);
> +       ret = __cs2000_set_rate(priv, ch, rate, rate);
> +       if (ret < 0)
> +               return ret;
> +
> +       parent_names[CLK_IN]    = __clk_get_name(priv->clk_in);
> +       parent_names[REF_CLK]   = __clk_get_name(priv->ref_clk);
> +
> +       init.name               = name;
> +       init.ops                = &cs2000_ops;
> +       init.flags              = CLK_SET_RATE_GATE;
> +       init.parent_names       = parent_names;
> +       init.num_parents        = ARRAY_SIZE(parent_names);
> +
> +       priv->hw.init = &init;
> +
> +       clk = clk_register(dev, &priv->hw);
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
> +       if (ret < 0) {
> +               clk_unregister(clk);
> +               return ret;
> +       }
> +
> +       priv->clk_out = clk;
> +
> +       return 0;
> +}
> +
> +static int cs2000_version_print(struct cs2000_priv *priv)
> +{
> +       struct i2c_client *client = priv_to_client(priv);
> +       struct device *dev = &client->dev;
> +       s32 val = cs2000_read(priv, DEVICE_ID);
> +       const char *revision;
> +

Move read here to see how val is assigned.

s32 val;

…

val = read();

> +       if (val < 0)
> +               return val;
> +
> +       /* CS2000 should be 0x0 */
> +       if (0 != (val >> 3))

if (val >> 3)

> +               return -EIO;
> +
> +       switch (val & 0x7) {

magic

> +       case 0x4:

magic

> +               revision = "B2 / B3";
> +               break;
> +       case 0x6:

magic

> +               revision = "C1";
> +               break;
> +       default:
> +               return -EIO;
> +       }
> +
> +       dev_info(dev, "revision - %s\n", revision);
> +
> +       return 0;
> +}
> +
> +static int cs2000_remove(struct i2c_client *client)
> +{
> +       struct cs2000_priv *priv = i2c_get_clientdata(client);
> +       struct device *dev = &client->dev;
> +       struct device_node *np = dev->of_node;
> +
> +       of_clk_del_provider(np);
> +
> +       clk_unregister(priv->clk_out);
> +
> +       return 0;
> +}
> +
> +static int cs2000_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       struct cs2000_priv *priv;
> +       struct device *dev = &client->dev;
> +       int ret;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       priv->client = client;
> +       i2c_set_clientdata(client, priv);
> +
> +       ret = cs2000_clk_get(priv);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_clk_register(priv);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = cs2000_version_print(priv);
> +       if (ret < 0)
> +               goto probe_err;
> +
> +       return 0;
> +
> +probe_err:
> +       cs2000_remove(client);


> +
> +       return ret;
> +}
> +
> +static struct i2c_driver cs2000_driver = {
> +       .driver = {
> +               .name = "cs2000-cp",
> +               .of_match_table = cs2000_of_match,
> +       },
> +       .probe          = cs2000_probe,
> +       .remove         = cs2000_remove,
> +       .id_table       = cs2000_id,
> +};
> +
> +module_i2c_driver(cs2000_driver);
> +
> +MODULE_DESCRIPTION("CS2000-CP driver");
> +MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
