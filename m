From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Feb 2013 12:09:09 +0000
Subject: Re: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <22311313.nA5k2WFyDE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

On Thursday 14 February 2013 20:55:16 Paul Mundt wrote:
> On Tue, Feb 12, 2013 at 04:50:02PM +0100, Guennadi Liakhovetski wrote:
> > Not on all sh-/r-mobile platfotms all pins are numbered contiguously from
> > 0 to N-1. On all ARM-based platforms datasheets use simple numbers to
> > identify them, unlike some SuperH-based SoC, naming pins, using strings,
> > e.g. A31:A0, B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver
> > supported only contiguous pin numbering. This patch adds support for
> > sparse pin numbers to support sh73a0 and any other similar SoCs.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> The sh-pfc pinctrl driver is not the place where this sort of lookup
> should be happening, especially as the pinctrl subsystem already tracks
> GPIO ranges for us. Is there some reason you can't just expand the
> platform definition and tie in to pinctrl_add_gpio_ranges() for
> supporting multiple ranges instead?

Using pinctrl_add_gpio_ranges() was also my initial idea. While I think it's 
still useful, there's one issue it doesn't fix: GPIO numbering in DT and 
sysfs. On the sh73a0 platform the GPIO_PORT* enumerated values don't match the 
port number. While that's not a major issue in board code that uses the enum 
names, this would become very confusing in DT and sysfs. GPIO 128, for 
instance, would be referenced by the number 119 in DT.

I think we should fix that and use the port number in the GPIO API. This 
requires translating from the port number to the GPIO entry index in internal 
pinmux_pins[] array. There are several way to do so, one is to index the array 
by the port number (and thus making it sparse, using more memory), the other 
is to add a list of ranges (either explicitly as in Guennadi's patch, or 
implicitly by adding the port number to each entry in the pinmux_pins[] array 
and computing the list of ranges at init time). I haven't decided yet which 
solution I like the best, I'm experimenting with both.

> Your sparse case isn't exactly sparse either, as you seem to only be
> dealing with multiple linear ranges, which is rather different from a
> single pin space with individual GPIOs spread far and wide. The former
> entails traversing a list of ranges in lookup paths, while the latter
> requires far more complex handling/translation if attempting to tightly
> pack the space.

-- 
Regards,

Laurent Pinchart

