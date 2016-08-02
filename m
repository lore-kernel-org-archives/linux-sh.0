From: Rob Landley <rob@landley.net>
Date: Tue, 02 Aug 2016 18:11:36 +0000
Subject: Re: [PATCH v4 2/2] spi: add driver for J-Core SPI controller
Message-Id: <1a9993f5-2c3c-20dc-1b50-5af1f05468c4@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469686300.git.dalias@libc.org>
 <2a46090a5a7c177b7eca83f68406650844423e7f.1469686300.git.dalias@libc.org>
 <20160728191153.GL11806@sirena.org.uk>
 <20160728194045.GK15995@brightrain.aerifal.cx>
 <20160728195125.GN11806@sirena.org.uk>
 <20160730033441.GO15995@brightrain.aerifal.cx>
 <20160801181245.GZ10376@sirena.org.uk>
 <20160802014531.GS15995@brightrain.aerifal.cx>
In-Reply-To: <20160802014531.GS15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-core-ZxQK9KuXmn0dnm+yROfE0A@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>

On 08/01/2016 08:45 PM, Rich Felker wrote:
> Yes. 50 MHz is the natural default frequency, but I found out at the
> last minute from the hardware engineers that clocking the current SoC
> up to 62.5 MHz (for faster cpu) will require the SPI timing to be
> programmed based on the faster reference clock. This messes up the
> ability to get optimal SD card transfer rates, so we'll probably end
> up having a real 50 MHz clock for the SPI anyway, but I thought it was
> important to be able to handle this issue in the DT binding anyway.

For those of you following along at home, the first open source VHDL
release of http://j-core.org runs at 33 mhz on Spartan 6 FPGAs, the
second at 50mhz on the same hardware, and you'd think the third would be
66mhz as the chip continues to be optimized, but one of the new I/O
busses requires a multiple of 12.5 mhz and they didn't want to add a
clock domain crossing thing for it, hence 62.5 mhz.

Earlier it was easy to get everything to work off a single master clock,
but as we add more peripherals to the SOC and speed things up stuff's
likely to change. (Development is ongoing, and we have a public
http://j-core.org/roadmap.html out through 2019. It you're waiting for
stuff to stop changing before getting basic board support in that runs
on existing releases, it's might be a while.)

Rob
