From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 28 May 2009 21:29:08 +0000
Subject: Re: [PATCH 02/04] Driver Core: Add idle and wakeup functions
Message-Id: <200905282329.09804.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100642.29671.52231.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 27 May 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add platform_device_idle() and platform_device_wakeup()
> and allow architectures to implement their own versions
> of these if CONFIG_HAVE_PLATFORM_IDLE_WAKEUP is set.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Yes, this needs documentation. See [00/04] for now.
> 
>  arch/Kconfig                    |    3 +++
>  include/linux/platform_device.h |    8 ++++++++
>  2 files changed, 11 insertions(+)
> 
> --- 0002/arch/Kconfig
> +++ work/arch/Kconfig	2009-05-26 12:31:06.000000000 +0900
> @@ -115,3 +115,6 @@ config HAVE_DEFAULT_NO_SPIN_MUTEXES
>  
>  config HAVE_PLATFORM_DEVICE_ARCHDATA
>  	bool
> +
> +config HAVE_PLATFORM_DEVICE_IDLE_WAKEUP

Again, I'm not sure if the new CONFIG_ option is really necessary.

> +	bool
> --- 0002/include/linux/platform_device.h
> +++ work/include/linux/platform_device.h	2009-05-26 12:32:40.000000000 +0900
> @@ -57,6 +57,14 @@ extern int platform_device_add(struct pl
>  extern void platform_device_del(struct platform_device *pdev);
>  extern void platform_device_put(struct platform_device *pdev);
>  
> +#ifdef CONFIG_HAVE_PLATFORM_DEVICE_IDLE_WAKEUP
> +void platform_device_idle(struct platform_device *pdev);
> +void platform_device_wakeup(struct platform_device *pdev);
> +#else
> +static inline void platform_device_idle(struct platform_device *pdev) {}
> +static inline void platform_device_wakeup(struct platform_device *pdev) {}
> +#endif
> +
>  struct platform_driver {
>  	int (*probe)(struct platform_device *);
>  	int (*remove)(struct platform_device *);
