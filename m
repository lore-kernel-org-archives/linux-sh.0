From: Rabin Vincent <rabin@rab.in>
Date: Sun, 21 Dec 2008 09:28:37 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a
Message-Id: <20081221091637.GA23532@debian>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain>
In-Reply-To: <1229728542.1441.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

On Fri, Dec 19, 2008 at 11:15:42PM +0000, Adrian McMenamin wrote:
> Add support for the SEGA Dreamcast Maple controller as a joystick

[snip]

> +
> +	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
> +	idev = input_allocate_device();
> +	if (!pad || !idev){
> +		error = ENOMEM;
> +		goto fail;
> +	}
> +

[snip]

> +
> +	error = input_register_device(idev);
> +	if (error)
> +		goto fail;
> +
> +	mdev->driver = mdrv;
> +	maple_set_drvdata(mdev, pad);
> +
> +	return error;
> +
> +fail:
> +	input_free_device(pad->dev);
> +	kfree(pad);
> +	maple_set_drvdata(mdev, NULL);
> +	return -error;
> +}

This will incorrectly negate the already negative error code from
input_register_device.

Rabin
