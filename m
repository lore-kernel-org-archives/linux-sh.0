From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 29 May 2008 09:40:24 +0000
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Message-Id: <20080529024024.63d726de.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Thu, 29 May 2008 18:24:51 +0900 Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch adds frame buffer support for the LCDC block found in
> SuperH Mobile processors. The hardware supports up to two LCD panels
> per LCDC block, and both RGB and SYS interfaces can be used to hook
> up LCD panels/modules.
> 
> The device driver is a regular platform driver, so LCD configuration
> and board specific hooks are passed to the driver using platform data.
> LCD modules using SYS interface often require special configuration
> using the SYS bus, and to solve this cleanly the driver provides SYS
> interface operations to the board code.
> 
> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> WVGA panels using RGB16 and RGB18 interfaces.
> 
> ...
>
> +	while (lcdc_read(ch->lcdc, _LDSR) & 2)
> +	  ;

Indenting is odd and inconsistent with most of the other zillions of
busywait loops here (multiple instances)

It might make sense to write a single function to do this busywaiting. 
That function can implement a timeout and can avoid lockups and provide
useful diagnostics.

Is sh's cpu_relax() a no-op?  Or are we assuming that ioread is a
suitable substitute?

