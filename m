From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 20 Dec 2008 15:16:59 +0000
Subject: Re: [PATCH] sh: maple: add support for Maple controller as a
Message-Id: <20081220151511.GA6528@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1229728542.1441.6.camel@localhost.localdomain>
In-Reply-To: <1229728542.1441.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

On Fri, Dec 19, 2008 at 11:15:42PM +0000, Adrian McMenamin wrote:
> 
> Add support for the SEGA Dreamcast Maple controller as a joystick
> 

[snip]

> +	struct dc_pad *pad = maple_get_drvdata(mapledev);
> +	struct input_dev *dev = pad->dev;
> +	unsigned char *res = mq->recvbuf;
> +
> +	buttons = ~cpu_to_le16(*(unsigned short *)(res + 8));
> +

I may be wrong but shouldn't this use the I/O accessor functions?

> +
> +	pad = kzalloc(sizeof(struct dc_pad), GFP_KERNEL);
> +	idev = input_allocate_device();
> +	if (!pad || !idev){
> +		error = ENOMEM;
> +		goto fail;
> +	}

[snip]

> +fail:
> +	input_free_device(pad->dev);

Possible NULL pointer dereference?
