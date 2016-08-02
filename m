From: Rich Felker <dalias@libc.org>
Date: Tue, 02 Aug 2016 01:45:32 +0000
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Message-Id: <20160802014531.GS15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk>
 <20160730033441.GO15995@brightrain.aerifal.cx>
 <20160801181245.GZ10376@sirena.org.uk>
In-Reply-To: <20160801181245.GZ10376-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>

On Mon, Aug 01, 2016 at 07:12:45PM +0100, Mark Brown wrote:
> On Fri, Jul 29, 2016 at 11:34:41PM -0400, Rich Felker wrote:
> 
> > I was able to get it working via the clk api and I'll include support
> > for this in the next version of the patch, but to actually use it
> > depends on changing arch/sh to use the common clk framework; otherwise
> > there's no way to provide a suitable clk in the DT and have
> > [devm_]clk_get actually pick it up. Should I keep around the option of
> > using clock-frequency too? That would be most convenient.
> 
> It sounds like at the minute the devices all have one frequency anyway
> in which case just having a default frequency in there that you fall
> back to if you get -ENOENT from a failed clock lookup might be enough?

Yes. 50 MHz is the natural default frequency, but I found out at the
last minute from the hardware engineers that clocking the current SoC
up to 62.5 MHz (for faster cpu) will require the SPI timing to be
programmed based on the faster reference clock. This messes up the
ability to get optimal SD card transfer rates, so we'll probably end
up having a real 50 MHz clock for the SPI anyway, but I thought it was
important to be able to handle this issue in the DT binding anyway.

Since it's not an immediate need right now anyway I'll drop the
clock-frequency property proposal and just use the more general clocks
approach you suggested.

Rich
