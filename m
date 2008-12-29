From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 29 Dec 2008 00:28:15 +0000
Subject: Re: [RFC][patch] sh: maple: Dreamcast mouse driver
Message-Id: <200812281628.15790.dmitry.torokhov@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1230508197.7574.4.camel@localhost.localdomain>
In-Reply-To: <1230508197.7574.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>

Hi Adrian,

On Sunday 28 December 2008 15:49:57 Adrian McMenamin wrote:
> +
> +	mdev = to_maple_dev(dev);
> +	mdrv = to_maple_driver(dev->driver);
> +	if (!mdrv||!mdev) {
> +		error = EINVAL;
> +		goto fail;
> +	}

This still does not make sense, mdev and mdrv will never be NULL.

> +fail:
> +	return -error;

You just negated the error returned by input_register_device() and the module 
loading code will think that probe succeeded.

> +
> +static int remove_maple_mouse(struct device *dev)
> +{
> +	struct maple_device *mdev = to_maple_dev(dev);
> +	struct dc_mouse *mse = maple_get_drvdata(mdev);
> +
> +	mdev->callback = NULL;

I am uneasy about just whacking a NULL there. The other driver you sent 
implemented open and close methods and used maple_getcond_callback to 
manipulate callbacks which I assume is safer than just resetting the pointer.

-- 
Dmitry
