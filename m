From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 May 2009 03:22:21 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: use platform_data instead of module_param
Message-Id: <20090526032221.GB9188@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A1B5D7C.6070205@renesas.com>
In-Reply-To: <4A1B5D7C.6070205@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 26, 2009 at 12:09:48PM +0900, Yoshihiro Shimoda wrote:
> +struct r8a66597_platdata {
> +	/* This ops can controll port power instead of DVSTCTR register. */
> +	void (*port_power)(int port, int power);
> +
> +	/* (external controller only) set R8A66597_PLATDATA_XTAL_nnMHZ */
> +	unsigned	xtal:2;
> +
> +	/* set one = 3.3V, set zero = 1.5V */
> +	unsigned	vif:1;
> +
> +	/* set one = big endian, set zero = little endian */
> +	unsigned	endian:1;
> +
> +	/* set one = low level, set zero = falling edge */
> +	unsigned	irq_sense:1;
> +};

I would just get rid of irq_sense entirely. You can OR in
IRQF_TRIGGER_LOW or IRQF_TRIGGER_FALLING against IORESOURCE_IRQ in the
struct resource, so there is no need for reproducing this information
elsewhere.
