From: Rob Herring <robh@kernel.org>
Date: Wed, 06 Jan 2016 17:08:44 +0000
Subject: Re: [RFC v2 3/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <CAL_JsqK8bekw0_FhzMmrZftWpFLv=NnJ7J7767KNwESROPgzPA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de> <1452088285-6427-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452088285-6427-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

On Wed, Jan 6, 2016 at 7:51 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This driver allows an I2C bus to switch between multiple masters. This
> is not hot-swichting because connected I2C slaves will be
> re-instantiated. It is meant to select the best I2C core at runtime once
> the task is known. Example: Prefer i2c-gpio over another I2C core
> because of HW errata affetcing your use case.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

[...]

> +static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
> +{
> +       struct i2c_adapter *adap;
> +       struct pinctrl *p;
> +       int ret;
> +
> +       mutex_lock(&of_mutex);
> +       ret = of_changeset_apply(&priv->chan[new_chan].chgset);
> +       mutex_unlock(&of_mutex);

Looks like you need this patch[1] rather than exposing of_mutex.

Rob

[1] https://patchwork.ozlabs.org/patch/539938/
