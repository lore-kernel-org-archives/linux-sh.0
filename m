Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E132557E
	for <linux-sh@vger.kernel.org>; Thu, 23 Nov 2023 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zf86Mpvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D003C433C7;
	Thu, 23 Nov 2023 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700747998;
	bh=N25XTanfILzzEPMq9f3q38jodI3w6KFzHpDYvVpV1Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zf86MpvvpUSyuIWqTQjS6FkAPRZpwM4f+TeKXBvDhIluZe8wPdtw8WOOQQ6EEbW2t
	 Lu84J2pQ84UIbTrGBNykTDwPJDkk101z3cmddNpeQBSPHWiWKp2YyIjOcK003TqAvv
	 sJt3BWOPYTKPygoV+WYYHmCunOfO8WUaYpkqkmGy4y8bWnD3sVzFxUhN8qcLfUoAKh
	 XnQueAxmARocyaMVPOqqOVqud3+ZhAGN3Pzqhn1SEay2g/yiqSHo7+eD9b7OlBS+8a
	 nHS/7C6xM3V9XIK1t4poPziQpB2KLYcspvIia5M4q+hfjA04C3J2BhI+KJT4xbk6Db
	 30PshTCWUnbNA==
Date: Thu, 23 Nov 2023 13:59:53 +0000
From: Lee Jones <lee@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4 24/37] mfd: sm501: Convert platform_data to OF property
Message-ID: <20231123135953.GF1243364@google.com>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <478cf6465ab23eaf00515b8d067101bec514358b.1699856600.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <478cf6465ab23eaf00515b8d067101bec514358b.1699856600.git.ysato@users.sourceforge.jp>

On Tue, 14 Nov 2023, Yoshinori Sato wrote:

> Various parameters of SM501 can be set using platform_data,
> so parameters cannot be passed in the DeviceTree target.
> Expands the parameters set in platform_data so that they can be
> specified using DeviceTree properties.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/mfd/sm501.c           | 70 +++++++++++++++++++++++++++++++++++
>  drivers/video/fbdev/sm501fb.c | 70 +++++++++++++++++++++++++++++++++--
>  include/linux/sm501.h         |  3 +-
>  3 files changed, 138 insertions(+), 5 deletions(-)

Where are the Device Tree bindings?  Do they already exist?

I'd be interested to see how well they fair with the DT maintainers.

> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index 28027982cf69..4f9c9c5936ff 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -1370,6 +1370,69 @@ static int sm501_init_dev(struct sm501_devdata *sm)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF

I very much dislike #ifery in C files.

> +static void sm501_of_read_reg_init(struct device_node *np,
> +				   const char *propname, struct sm501_reg_init *val)
> +{
> +	u32 u32_val[2];
> +
> +	if (!of_property_read_u32_array(np, propname, u32_val, sizeof(u32_val))) {
> +		val->set = u32_val[0];
> +		val->mask = u32_val[1];
> +	}
> +}
> +
> +static int sm501_parse_dt(struct sm501_devdata *sm, struct device_node *np)
> +{
> +	struct sm501_platdata *plat;
> +	u32 u32_val;
> +
> +	plat = devm_kzalloc(sm->dev, sizeof(*plat), GFP_KERNEL);
> +	if (!plat)
> +		return -ENOMEM;
> +
> +	plat->init = devm_kzalloc(sm->dev, sizeof(*plat->init), GFP_KERNEL);
> +	if (!plat->init)
> +		return -ENOMEM;
> +
> +	if (!of_property_read_u32(np, "smi,devices", &u32_val))
> +		plat->init->devices = u32_val;
> +
> +	if (!of_property_read_u32(np, "smi,mclk", &u32_val))
> +		plat->init->mclk = u32_val;
> +
> +	if (!of_property_read_u32(np, "smi,m1xclk", &u32_val))
> +		plat->init->m1xclk = u32_val;
> +
> +	sm501_of_read_reg_init(np, "smi,misc-timing", &plat->init->misc_timing);
> +	sm501_of_read_reg_init(np, "smi,misc-control", &plat->init->misc_control);
> +	sm501_of_read_reg_init(np, "smi,gpio-low", &plat->init->gpio_low);
> +	sm501_of_read_reg_init(np, "smi,gpio-high", &plat->init->gpio_high);

So all of these properties are optional?

> +#ifdef CONFIG_MFD_SM501_GPIO
> +	if (plat->init->devices & SM501_USE_GPIO) {
> +		if (!of_property_read_u32_index(np, "smi,num-i2c", 0, &u32_val))
> +			plat->gpio_i2c_nr = u32_val;
> +		else
> +			plat->gpio_i2c_nr = 0;

This is already zero, no?

> +	}
> +	if (plat->gpio_i2c_nr > 0) {
> +		int sz_gpio;
> +
> +		sz_gpio = sizeof(struct sm501_platdata_gpio_i2c) * plat->gpio_i2c_nr;

sizeof(plat->gpio_i2c) * plat->gpio_i2c_nr ?

And put it inside the devm_kzalloc() call.

> +		plat->gpio_i2c = devm_kzalloc(sm->dev, sz_gpio, GFP_KERNEL);
> +		if (plat->gpio_i2c == NULL)

if (!plat->gpio_i2c)

> +			return -ENOMEM;
> +
> +		of_property_read_variable_u32(np, "smi,gpio-i2c",
> +					      plat->gpio_i2c, sz_gpio / sizeof(int));
> +	}
> +#endif	/* CONFIG_MFD_SM501_GPIO */
> +	sm->platdata = plat;
> +	return 0;
> +}
> +#endif	/* CONFIG_OF */
> +
>  static int sm501_plat_probe(struct platform_device *dev)
>  {
>  	struct sm501_devdata *sm;
> @@ -1406,6 +1469,13 @@ static int sm501_plat_probe(struct platform_device *dev)
>  		goto err_res;
>  	}
>  
> +#ifdef CONFIG_OF
> +	if (dev->dev.of_node) {

if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node)

... and let the compiler do the rest.

> +		ret = sm501_parse_dt(sm, dev->dev.of_node);
> +		if (ret)
> +			goto err_res;
> +	}
> +#endif
>  	platform_set_drvdata(dev, sm);
>  
>  	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
> diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
> index d6fdc1737cd2..36a080dd35a1 100644
> --- a/drivers/video/fbdev/sm501fb.c
> +++ b/drivers/video/fbdev/sm501fb.c
> @@ -1932,10 +1932,62 @@ static int sm501fb_start_one(struct sm501fb_info *info,
>  	return 0;
>  }
>  
> +#if defined(CONFIG_OF)
> +static struct sm501_platdata_fbsub *read_fbsub(struct device_node *np, const char *ch_name)
> +{
> +	struct sm501_platdata_fbsub *fbsub = NULL;
> +	struct fb_videomode *def_mode;
> +	struct device_node *child;
> +	const void *prop;
> +	u32 flags;
> +	u32 bpp;
> +	int len;
> +
> +	child = of_get_child_by_name(np, ch_name);
> +	if (child == NULL)
> +		return NULL;
> +
> +	prop = of_get_property(child, "edid", &len);
> +	if (prop && len == EDID_LENGTH) {
> +		struct fb_monspecs *specs;
> +		u8 *edid;
> +
> +		edid = kmemdup(prop, EDID_LENGTH, GFP_KERNEL);
> +		if (edid) {
> +			specs = kzalloc(sizeof(*specs), GFP_KERNEL);
> +			if (specs) {
> +				fb_edid_to_monspecs(edid, specs);
> +				def_mode = specs->modedb;
> +			}
> +			kfree(specs);
> +		}
> +		kfree(edid);
> +	}
> +
> +	if (of_property_read_u32(child, "bpp", &bpp))
> +		bpp = 0;
> +	if (of_property_read_u32(child, "smi,flags", &flags))
> +		flags = 0;
> +
> +	if (def_mode || bpp || flags) {
> +		fbsub = kzalloc(sizeof(*fbsub), GFP_KERNEL);
> +		if (fbsub) {
> +			fbsub->def_mode = def_mode;
> +			fbsub->def_bpp = bpp;
> +			fbsub->flags = flags;
> +		}
> +	}
> +	return fbsub;
> +}
> +#endif

All of this needs moving to the display driver.  And I have suspicions
that all of the new code above should live there too.

>  static int sm501fb_probe(struct platform_device *pdev)
>  {
> -	struct sm501fb_info *info;
>  	struct device *dev = &pdev->dev;
> +	struct sm501fb_info *info;
> +	const void *prop;
> +	const char *cp;
> +	int len;
>  	int ret;
>  
>  	/* allocate our framebuffers */
> @@ -1957,9 +2009,7 @@ static int sm501fb_probe(struct platform_device *pdev)
>  		int found = 0;
>  #if defined(CONFIG_OF)
>  		struct device_node *np = pdev->dev.parent->of_node;
> -		const u8 *prop;
> -		const char *cp;
> -		int len;
> +		struct sm501_platdata_fbsub *sub;
>  
>  		info->pdata = &sm501fb_def_pdata;
>  		if (np) {
> @@ -1974,6 +2024,18 @@ static int sm501fb_probe(struct platform_device *pdev)
>  				if (info->edid_data)
>  					found = 1;
>  			}
> +			if (of_property_read_bool(np, "route-crt-panel"))
> +				info->pdata->fb_route = SM501_FB_CRT_PANEL;
> +			else
> +				info->pdata->fb_route = SM501_FB_OWN;
> +			if (of_property_read_bool(np, "swap-fb-endian"))
> +				info->pdata->flags |= SM501_FBPD_SWAP_FB_ENDIAN;
> +			sub = read_fbsub(np, "crt");
> +			if (sub)
> +				info->pdata->fb_crt = sub;
> +			sub = read_fbsub(np, "panel");
> +			if (sub)
> +				info->pdata->fb_pnl = sub;
>  		}
>  #endif
>  		if (!found) {
> diff --git a/include/linux/sm501.h b/include/linux/sm501.h
> index 2f3488b2875d..5c9a683b0615 100644
> --- a/include/linux/sm501.h
> +++ b/include/linux/sm501.h
> @@ -6,6 +6,8 @@
>   *	Vincent Sanders <vince@simtec.co.uk>
>  */
>  
> +#include <dt-bindings/display/sm501.h>
> +
>  extern int sm501_unit_power(struct device *dev,
>  			    unsigned int unit, unsigned int to);
>  
> @@ -35,7 +37,6 @@ extern unsigned long sm501_modify_reg(struct device *dev,
>  				      unsigned long clear);
>  
>  
> -/* Platform data definitions */
>  
>  #define SM501FB_FLAG_USE_INIT_MODE	(1<<0)
>  #define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
