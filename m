From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 09 Nov 2015 00:49:42 +0000
Subject: Re: [PATCH v5] clk: add CS2000 Fractional-N driver
Message-Id: <877flsknmk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874mhmuyg8.wl%kuninori.morimoto.gx@renesas.com>
	<CAHp75VcKnJr2zaFky9_G-qetdiuB8fS=r8r7hQTbYPUwEZ7n4g@mail.gmail.com>
In-Reply-To: <CAHp75VcKnJr2zaFky9_G-qetdiuB8fS=r8r7hQTbYPUwEZ7n4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon <horms@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org


Hi

Thank you for your feedback

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Hmm… Something wrong with send-email settings?

Nothing wrong. I would like to overwrite Author
(Sender and Author are same though...)

> > +#define priv_to_client(priv)   (priv->client)
> 
> to_client()?
> 
> > +#define priv_to_dev(priv)      (&(priv_to_client(priv)->dev))
> 
> to_dev() ?

I would like to have "from"

> > +static int cs2000_enable_dev_config(struct cs2000_priv *priv, bool enable)
> > +{
> > +       u32 val;
> > +       int ret;
> > +
> > +       val = enable ? ENDEV1 : 0;
> 
> Put in expression below?
> 
> > +       ret = cs2000_bset(priv, DEVICE_CFG1, ENDEV1, val);
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       val = enable ? ENDEV2 : 0;
> 
> Same.

OK

> > +       if (rate_in >= 32000000 &&
> > +           rate_in < 56000000)
> 
> One line here and below?

OK


> > +static int cs2000_wait_pll_lock(struct cs2000_priv *priv)
> > +{
> > +       struct device *dev = priv_to_dev(priv);
> > +       s32 val;
> > +       unsigned int i;
> > +
> > +       for (i = 0; i < 256; i++) {
> > +               val = cs2000_read(priv, DEVICE_CTRL);
> > +               if (val < 0)
> > +                       return val;
> > +               if (!(val & PLL_UNLOCK))
> > +                       return 0;
> > +               udelay(1);
> > +       }
> 
> unsigned int i = 256;
> 
> do {
> val = read();
> …
> while ((val & PLL_UNLOCK) && --i);
> 
> if (!i) {
>  …
>  return -EIO;
> 
> Actually -ETIMEDOUT ?
> 
> }

What is the motivation of above ?
It needs "i" anyway ? it needs to check (val < 0) anyway ?
what is the difference between do {} while <-> for(xxx)

> > +static int cs2000_clk_out_enable(struct cs2000_priv *priv, bool enable)
> > +{
> > +       u32 val = enable ? 0 : 0x3;
> 
> Redundant variable?

OK


> > +static u32 cs2000_rate_to_ratio(u32 rate_in, u32 rate_out)
> > +{
> > +       u64 ratio;
> > +
> > +       /*
> > +        * ratio = rate_out / rate_in * 2^20
> > +        *
> > +        * To avoid over flow, rate_out is u64
> > +        * The result should be u32
> > +        */
> > +       ratio = (u64)rate_out << 20;
> > +       do_div(ratio, rate_in);
> > +
> > +       return (u32)ratio;
> 
> No need to do explicit casting.
> 
> > +}
> > +
> > +static unsigned long cs2000_ratio_to_rate(u32 ratio, u32 rate_in)
> > +{
> > +       u64 rate_out;
> > +
> > +       /*
> > +        * ratio = rate_out / rate_in * 2^20
> > +        *
> > +        * To avoid over flow, rate_out is u64
> > +        * The result should be u32
> 
> u32 or unsigned long?
> 
> Btw, dots at the end of sentences.
> 
> > +        */
> > +
> > +       rate_out = (u64)ratio * rate_in;
> > +       return (unsigned long)(rate_out >> 20);
> 
> Same.

OK

> > +static int cs2000_ratio_set(struct cs2000_priv *priv,
> > +                           int ch, u32 rate_in, u32 rate_out)
> > +{
> > +       u32 val;
> > +       unsigned int i;
> > +       int ret;
> > +
> > +       if (CH_SIZE_ERR(ch))
> > +               return -EINVAL;
> > +
> > +       val = cs2000_rate_to_ratio(rate_in, rate_out);
> > +       for (i = 0; i < 4; i++)
> 
> 4 is magic, you have define already.

OK

> > +       /*
> > +        * FIXME
> > +        *
> > +        * this driver supports static ratio mode only
> > +        * at this point
> > +        */
> 
> One line?

OK

> > +static int cs2000_clk_register(struct cs2000_priv *priv)
> > +{
> > +       struct device *dev = priv_to_dev(priv);
> > +       struct device_node *np = dev->of_node;
> > +       struct clk_init_data init;
> > +       const char *name = np->name;
> > +       struct clk *clk;
> > +       static const char *parent_names[CLK_MAX];
> > +       int ch = 0; /* it uses ch0 only at this point */
> > +       int rate;
> > +       int ret;
> > +
> > +       of_property_read_string(np, "clock-output-names", &name);
> 
> What about device property API?

Sorry, which API ?
Many other clk-xxx.c are using this style ?

> > +static int cs2000_version_print(struct cs2000_priv *priv)
> > +{
> > +       struct i2c_client *client = priv_to_client(priv);
> > +       struct device *dev = &client->dev;
> > +       s32 val = cs2000_read(priv, DEVICE_ID);
> > +       const char *revision;
> > +
> 
> Move read here to see how val is assigned.
> 
> s32 val;
> 
> …
> 
> val = read();
> 
> > +       if (val < 0)
> > +               return val;
> > +
> > +       /* CS2000 should be 0x0 */
> > +       if (0 != (val >> 3))
> 
> if (val >> 3)
> 
> > +               return -EIO;
> > +
> > +       switch (val & 0x7) {
> 
> magic
> 
> > +       case 0x4:
> 
> magic
> 
> > +               revision = "B2 / B3";
> > +               break;
> > +       case 0x6:
> 
> magic

OK


