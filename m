Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FA37B02D
	for <linux-sh@vger.kernel.org>; Wed,  9 Sep 2026 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788974984; cv=none; b=V/6MUbN2ARrurxO+rDUfnwoq6mtxbVPIwMGPqIAc2ucktXp3UqanAjv2mmCibptHdvF82OEZzhGvnRriiMUL0fRQkWuLM5d6fBzkhEKM2ImrCOfoXIsCYweXXgpbJ6FoZBsDT9TEaakzLTbnGYzyUkPKk0gC/acNl8egR0D+NI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788974984; c=relaxed/simple;
	bh=3XHuEAHmF9mZh+23lL0Y/SKnX00eK8sbmtD5tQwkD3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtTik9NM5wAdjdiBS4DlDI1cOwH0nELve7cHr43VvU4rd9f6ztEnMrIfQvYeMkA5BX4ET2pMeaqVUn+O9w9o4uZuHjqi8qXsHTMyOtKj2VI/N/qGCWq9d6bjUojDjpjN1Uw7SRjUO0rJj4MVIO5Gz7u9T9ocnk9hqMyOOQilVcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8QDTIVN; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8QDTIVN"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so537744a91.1
        for <linux-sh@vger.kernel.org>; Wed, 09 Sep 2026 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788974982; x=1789579782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doXhXrJthHFYgvoQ59t6i4yuIdUh6fUHC6pQJIIVyWE=;
        b=K8QDTIVNhfLASTp3QphzlEUfrSvguuCg5pG4jCmWw9B7cxs5OOMcWg+MyeZMlQE2s/
         iD1b9Lm1HxiHaT1c5K2N1lCkrWuVY/v236AcLxp/UYrKdudm9hC4ppaUdSSREiVpl36W
         PZud1RO8O+XqaFoDSoShPh4PZGDP1pAI5L7/LOyYLP+MZPAPHz2E8gPTJk7GsiLxCEHX
         SY9GUkq4SebbICg+ysSv2+I92KkXS6tROdlau6CdOKhaqfoyhY5d0UJuZDLmeqeE6z4y
         FCUbaUkkMZxkC+1TDYwKrdCYkoGGIxy8D0XMQUJblDH05mquDPEM9lNIPgiBPAZyajW6
         Alqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788974982; x=1789579782;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doXhXrJthHFYgvoQ59t6i4yuIdUh6fUHC6pQJIIVyWE=;
        b=SUVUgjeDIb3YLdVNlbnYODqVRkqqjAb1wJLSmIs9YvC8MF7RyM+S1kE9H4N+fESmqT
         C33HefCy2WPjrydjZEoQzcQcGYHjojjNNVXH76DMiHypwNkR8BXcDJt91uJ7sNIyg2G8
         FyN7+tcKuNk6+V8Q5nYaZjNdzvGzQ9AwxrRoyPHTmOVM/BmRkwDaTptggw1wq8KrpyWj
         zmQGxIBEY7mav3oTKRQFG4n/EfqEczvO0WTYHBYfN24UM8vfrHj3KBa6gVQLyxqAuYtY
         FMo/EGH0GZRxJ1yqL2Sdc4mHaZkfe5+PMVVheeJvxD0oKRWMLiwiE22kLohumey+6yNt
         A+Ew==
X-Forwarded-Encrypted: i=1; AKwUvBzsOd9sEfZ6DTW7UpjWg9dw7k44ifaZepol44HnFFJZUh1ZOdst2xLaUVyksE7fiv6WOW01phzfYg==@vger.kernel.org
X-Gm-Message-State: AFuF++m4aVEknMZdRucGQWJ27ut/j3uhaQ97kkWfq3TbxObhsa7onkGe
	me5YevwDe3ssFgygIKnPBYi8/M5v3pNj9pkFVpSxA9A3h4gA+nQoOT5M+tpVmg==
X-Gm-Gg: AYBFou0W84HHwqvxFdgQ6XAxnJL2OJsSo3sE7lRq5/A7H/UU0mImPlwimFreO9bqNPf
	aFKHEqVXuPyD7WyDibWJRq2WwGcpUxU21MK2YH3OHXatRbX5UO2ecA3CiP7FlO97N6jJQ+k+J2S
	3zLY6xNiKPIkzuQ9LSD3ZagYgKe1/ZLxfmqRBfAikHmiU3y0tudiibmoc30VPGxYJYrmIdywLeS
	kdwvl2gR4D8UyNTxNLPolHyBOTE7MBZGz3E6uJuTwxDj/vcasuDUaewZy124Tsr4lvcynfV7cdp
	d3Db4i34AQPpF0kxwqNY6iUsFym2NM16O7pwIGVYop2pPfrXMuU1QarVv9kWoi6pK7pyCjGRkhz
	YkCK1zGEd7ng/EOfsyHY1ktvoLVV2k3eIk/V/HlGifny3mYTsxmbwduqiVezzPLNE06/IDF9CI/
	QulZ0J4HyrPrB3YsiDUe1E3hYBC38ZrqQdK1u1aHM356IzYSq2yk7QLodkyNaiLJERHKDJnmlX8
	WaekZBk6uibotjxHdDrcQSGN3nG/YssdxzfFs0F
X-Received: by 2002:a17:90b:3809:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39d70b1a9d7mr2622732a91.17.1788974982000;
        Wed, 09 Sep 2026 10:29:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2d43:5153:5c50:643e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm40462438c88.3.2026.09.09.10.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 10:29:41 -0700 (PDT)
Date: Wed, 9 Sep 2026 10:29:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Mark Brown <broonie@kernel.org>, jacopo mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Subject: Re: [RESEND PATCH] sh: ecovec24: use static device properties to
 describe the touchscreen
Message-ID: <aqGXSGr87b3NPDBI@google.com>
References: <alUyZ2zVWCPhyHHX@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUyZ2zVWCPhyHHX@google.com>

On Mon, Jul 13, 2026 at 02:41:31PM -0700, Dmitry Torokhov wrote:
> Convert the board to use static device properties instead of platform
> data to describe the touchscreen, so that support for platform data can
> be removed from tsc2007 driver (ecovec24 is the last board using this
> mechanism of describing tsc2007).
> 
> Device properties do not allow custom board methods, so the method for
> getting "pen down" state was removed (the driver is capable of working
> without it). If this functionality is needed proper pin control/gpio
> support needs to be implemented so that the same pin can serve as an
> input GPIO and an interrupt.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> This is a resend of the patch I sent in August of 2024. My fault of not
> noticing reply from Adrian inquiring about potential negative impact
> from not having GPIO-based "pen down" detection. I believe this is fine,
> the "pen down" is an optional feature and the driver can detect the
> touches even when it is not specified. Additionally, this is an
> evaluation board, so user impact should be negligible.
> 
> However the bigger question is whether ecovec24 board still relevant.
> According to my research it has the following regressions currently
> unfixed:
> 
> 5716fb9bd9c6 ("mmc: spi: Convert to use GPIO descriptors")
>   - MMC SPI device naming broken (broke SD fallback mode)
> 
> 9fda6693335c ("spi: sh-msiof: Convert to use GPIO descriptors")
>   - SPI CS polarity inverted (broke initialization on the MSIOF0 SPI bus)
> 
> c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
>   - Camera array sentinel missing (causes out-of-bounds reads and
>     potentially kernel panics)
>   - Camera standby polarity inverted (enadvertently keeps cameras
>     permanently powered off)
>   - Camera disabled iby default (board defconfig points to a deleted
>     driver)
> 
> They are ~6 years old, so I wonder: do people actually *actively* use
> this board with modern kernels? Should it simply be removed?

John, gentle ping...

> 
> Thanks!
> 
>  arch/sh/boards/mach-ecovec24/setup.c | 38 ++++++++--------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index a641e26f8fdf..110a77f903b5 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -26,6 +26,7 @@
>  #include <linux/platform_data/tmio.h>
>  #include <linux/platform_data/tsc2007.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regulator/fixed.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/sh_eth.h>
> @@ -589,39 +590,21 @@ static struct platform_device keysc_device = {
>  /* TouchScreen */
>  #define IRQ0 evt2irq(0x600)
>  
> -static int ts_get_pendown_state(struct device *dev)
> -{
> -	int val = 0;
> -	gpio_free(GPIO_FN_INTC_IRQ0);
> -	gpio_request(GPIO_PTZ0, NULL);
> -	gpio_direction_input(GPIO_PTZ0);
> -
> -	val = gpio_get_value(GPIO_PTZ0);
> -
> -	gpio_free(GPIO_PTZ0);
> -	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
> -
> -	return val ? 0 : 1;
> -}
> -
> -static int ts_init(void)
> -{
> -	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
> -	return 0;
> -}
> +static const struct property_entry tsc2007_properties[] = {
> +	PROPERTY_ENTRY_U32("ti,x-plate-ohms", 180),
> +	{ }
> +};
>  
> -static struct tsc2007_platform_data tsc2007_info = {
> -	.model			= 2007,
> -	.x_plate_ohms		= 180,
> -	.get_pendown_state	= ts_get_pendown_state,
> -	.init_platform_hw	= ts_init,
> +static const struct software_node tsc2007_swnode = {
> +	.name = "tsc2007",
> +	.properties = tsc2007_properties,
>  };
>  
>  static struct i2c_board_info ts_i2c_clients = {
>  	I2C_BOARD_INFO("tsc2007", 0x48),
>  	.type		= "tsc2007",
> -	.platform_data	= &tsc2007_info,
>  	.irq		= IRQ0,
> +	.swnode		= &tsc2007_swnode,
>  };
>  
>  static struct regulator_consumer_supply cn12_power_consumers[] =
> @@ -1242,8 +1225,9 @@ static int __init arch_setup(void)
>  		gpio_direction_output(GPIO_PTF4, 1);
>  
>  		/* enable TouchScreen */
> -		i2c_register_board_info(0, &ts_i2c_clients, 1);
> +		gpio_request(GPIO_FN_INTC_IRQ0, NULL);
>  		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
> +		i2c_register_board_info(0, &ts_i2c_clients, 1);
>  	}
>  
>  	/* enable CEU0 */
> -- 
> 2.55.0.795.g602f6c329a-goog
> 
> 

-- 
Dmitry
