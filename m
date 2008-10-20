From: David Brownell <david-b@pacbell.net>
Date: Mon, 20 Oct 2008 04:30:23 +0000
Subject: Re: [PATCH 00/05] sh: GPIO for SuperH using gpiolib
Message-Id: <200810192130.24189.david-b@pacbell.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080927181008.11246.53495.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080927181008.11246.53495.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Saturday 27 September 2008, Magnus Damm wrote:
> The pinmux code is written so multiple GPIOs map to one physical pin.
> So for example on sh7723, pin PTS5 can be accessed as regular Port S pin 5
> GPIO, but it can also be locked to two different functions - as TX pin of
> the SCIF1 serial port or as SDHI0D3 - a D3 pin on the first MMC interface.

I've lost track of the status of these patches, but as a terminology
point I think it's best to keep in mind that those alternate functions
are not what's called a "GPIO".  The GPIO framework only expects to
handle the first function -- "GPIO".


> This specific PTS5 pin is exported as 3 different GPIOs:
> GPIO_PTS5
> GPIO_FN_SCIF1_PTS_TXD
> GPIO_FN_SDHI0D3_PTS
> Only one at a time can be selected using gpio_request().
> 


