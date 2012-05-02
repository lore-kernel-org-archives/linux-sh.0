From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Wed, 02 May 2012 14:41:12 +0000
Subject: Re: [PATCH 06/06] serial8250-em: Add Emma Mobile UART driver
Message-Id: <4FA14788.6090000@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120502124642.30480.41373.sendpatchset@w520> <20120502124736.30480.48207.sendpatchset@w520>
In-Reply-To: <20120502124736.30480.48207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com

On 12-05-02 08:47 AM, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add a platform driver for Emma Mobile 8250 hardware.


[...]

> +
> +config SERIAL_8250_EM
> +	tristate "Support for Emma Mobile intergrated serial port"
> +	depends on SERIAL_8250

Should we depend on arch=ARM or something similar?  Even if the
driver is written to be arch independent, if the Emma itself is
physically tied to ARM platforms, we probably don't need to be
building it for sparc allyesconfig etc.

P.

> +	help
> +	  Selecting this option will add support for the integrated serial
> +	  port hardware found on the Emma Mobile line of processors.
> +	  If unsure, say N.
> --- 0001/drivers/tty/serial/8250/Makefile
> +++ work/drivers/tty/serial/8250/Makefile	2012-05-02 17:25:19.000000000 +0900
> @@ -18,3 +18,4 @@ obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_
>  obj-$(CONFIG_SERIAL_8250_MCA)		+= 8250_mca.o
>  obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
>  obj-$(CONFIG_SERIAL_8250_DW)		+= 8250_dw.o
> +obj-$(CONFIG_SERIAL_8250_EM)		+= 8250_em.o
