From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 03:17:00 +0000
Subject: Re: [PATCH 1/2 v2] ARM: mach-shmobile: mackerel: add HDMI video support
Message-Id: <20110106031700.GK23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbdmycna.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbdmycna.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 06, 2011 at 11:44:09AM +0900, Kuninori Morimoto wrote:
> @@ -412,6 +535,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
>  	&leds_device,
>  	&fsi_device,
>  	&fsi_ak4643_device,
> +	&hdmi_lcdc_device,
> +	&hdmi_device,
>  };
>  
>  /* Keypad Initialization */

Note that this doesn't match what's in rmobile-latest, so it looks like
you used an earlier version (or possibly what's in rmobile/mackerel?). I
fixed it up by hand, but you may wish to double check you're on the
branch you think you are :-)
