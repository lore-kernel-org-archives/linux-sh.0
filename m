Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D76ACE79CF
	for <linux-sh@archiver.kernel.org>; Wed, 20 Sep 2023 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjITM0H (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Sep 2023 08:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbjITM0D (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Sep 2023 08:26:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9815C6
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 05:25:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4433FC433CB;
        Wed, 20 Sep 2023 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695212754;
        bh=aSlXio74zXOLFNUI0ByW9vzI5smz6GIgYDTZTNqu1PE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=beSWC6erjUt64E/Qt4J6Jm+7yEzRx6Ua1+uSRszA419g7qGDGXPSb6QyM53675PyA
         xeWgE2qbNmgQgYlQwgV7e+S1PWffxWzru4LHoz985jSabHQ1f9T5NirR9n6H/5K+h3
         w3vQGSYPVKF//1Cd1j8qQmMCtVS0pIcKKRnxcbCArLDApRXFNRPvQzNgsaTkGom0k/
         bn5nm33jO5JnQK37tLbdSy27LrsmAThCUoWYAZhQh/0u2jtmFaAB192vSci3+g07yw
         XHLUly3AVLP/wND1Wpr/6Qc3GT+eZkGEdo0EQdSipmcQgYEL7w7kf8aeZN8QvCIBEp
         feC9kLQhhCUVA==
Date:   Wed, 20 Sep 2023 13:25:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Subject: Re: [RFC PATCH v2 20/30] drivers/mfd: sm501 add some properties.
Message-ID: <20230920122550.GF13143@google.com>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <9c298d2dc42df60fdbbec395a8d790511e35c531.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c298d2dc42df60fdbbec395a8d790511e35c531.1694596125.git.ysato@users.sourceforge.jp>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Subject line is wrong in many of your commits.

Use `git log --online -- <subsystem>` to help you.

On Wed, 13 Sep 2023, Yoshinori Sato wrote:

> SM501's OF support is not enough parameter in platform device.
> This change adds the missing parameter.

You need more information.

What currently doesn't work?  How does this help?

How does it work?  What will happen if it's not applied?

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/mfd/sm501.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)

Please resubmit this set and Cc it to everyone.

I would like to see all of the changes please, since they are related.

> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index 28027982cf69..82508f6d96da 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1370,6 +1370,113 @@ static int sm501_init_dev(struct sm501_devdata *sm)
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)

Avoid #ifery as much as possible.

> +static unsigned int sm501_parse_devices_str(struct device_node *np)
> +{
> +	unsigned int device = 0;
> +	unsigned int i, j;
> +	unsigned int nstr;
> +	const char *devstr;
> +	static const struct {
> +		char *devname;
> +		unsigned int devid;
> +	} devlist[] = {
> +		{ "usb-host", SM501_USE_USB_HOST },
> +		{ "usb-gadget", SM501_USE_USB_SLAVE },
> +		{ "ssp0", SM501_USE_SSP0 },
> +		{ "ssp1", SM501_USE_SSP1 },
> +		{ "uart0", SM501_USE_UART0 },
> +		{ "uart1", SM501_USE_UART1 },
> +		{ "accel", SM501_USE_FBACCEL },
> +		{ "ac97", SM501_USE_AC97 },
> +		{ "i2s", SM501_USE_I2S },
> +		{ "gpio", SM501_USE_GPIO },
> +		{ "all", SM501_USE_ALL },
> +	};
> +
> +	nstr = of_property_count_strings(np, "sm501,devices");
> +	for (i = 0; i < nstr; i++) {
> +		if (of_property_read_string_index(np, "sm501,devices", i, &devstr))

Not a lot I can do without seeing the DT binding.

> +			break;
> +		for (j = 0; j < ARRAY_SIZE(devlist); j++) {
> +			if (strcmp(devstr, devlist[j].devname) == 0) {
> +				device |= devlist[j].devid;
> +				goto next;
> +			}
> +		}
> +next:
> +	}
> +	return device;
> +}
> +
> +static void sm501_of_read_reg_init(struct device_node *np,
> +				   const char *propname, struct sm501_reg_init *val)
> +{
> +	u32 u32_val[2];
> +
> +	if (!of_property_read_u32_array(np, propname, u32_val, sizeof(u32_val))) {
> +		val->set = u32_val[0];
> +		val->mask = u32_val[1];
> +	} else {
> +		val->set = 0;
> +		val->mask = 0;
> +	}
> +}
> +
> +static int sm501_parse_dt(struct sm501_devdata *sm, struct device_node *np)
> +{
> +	struct sm501_platdata *plat;
> +	u32 u32_val;
> +
> +	plat = devm_kzalloc(sm->dev, sizeof(struct sm501_platdata), GFP_KERNEL);

sizeof(*plat)

> +	if (plat == NULL)

if (!plat)

> +		return -ENOMEM;
> +
> +	plat->init = devm_kzalloc(sm->dev, sizeof(struct sm501_initdata), GFP_KERNEL);
> +	if (plat->init == NULL)
> +		return -ENOMEM;
> +
> +	plat->init->devices = sm501_parse_devices_str(np);
> +
> +	if (!of_property_read_u32_index(np, "sm501,mclk", 0, &u32_val))
> +		plat->init->mclk = u32_val;
> +	else
> +		plat->init->mclk = 0;
> +
> +	if (!of_property_read_u32_index(np, "sm501,m1xclk", 0, &u32_val))
> +		plat->init->m1xclk = u32_val;
> +	else
> +		plat->init->m1xclk = 0;
> +
> +	sm501_of_read_reg_init(np, "sm501,misc-timing", &plat->init->misc_timing);
> +	sm501_of_read_reg_init(np, "sm501,misc-control", &plat->init->misc_control);
> +	sm501_of_read_reg_init(np, "sm501,gpio-low", &plat->init->gpio_low);
> +	sm501_of_read_reg_init(np, "sm501,gpio-high", &plat->init->gpio_high);
> +
> +#ifdef CONFIG_MFD_SM501_GPIO
> +	if (plat->init->devices & SM501_USE_GPIO) {
> +		if (!of_property_read_u32_index(np, "sm501,num-i2c", 0, &u32_val))
> +			plat->gpio_i2c_nr = u32_val;
> +		else
> +			plat->gpio_i2c_nr = 0;
> +	}
> +	if (plat->gpio_i2c_nr > 0) {
> +		int sz_gpio;
> +
> +		sz_gpio = sizeof(struct sm501_platdata_gpio_i2c) * plat->gpio_i2c_nr;
> +		plat->gpio_i2c = devm_kzalloc(sm->dev, sz_gpio, GFP_KERNEL);
> +		if (plat->gpio_i2c == NULL)
> +			return -ENOMEM;
> +
> +		of_property_read_variable_u32(np, "sm501,gpio-i2c",
> +					      plat->gpio_i2c, plat->gpio_i2c_nr * 5);
> +	}
> +#endif
> +	sm->platdata = plat;
> +	return 0;
> +}
> +#endif
> +
>  static int sm501_plat_probe(struct platform_device *dev)
>  {
>  	struct sm501_devdata *sm;
> @@ -1406,6 +1513,12 @@ static int sm501_plat_probe(struct platform_device *dev)
>  		goto err_res;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
> +		ret = sm501_parse_dt(sm, dev->dev.of_node);
> +		if (ret)
> +			goto err_res;
> +	}
> +
>  	platform_set_drvdata(dev, sm);
>  
>  	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
