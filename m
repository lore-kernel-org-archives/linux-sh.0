From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2013 11:55:16 +0000
Subject: Re: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <20130214115516.GA3882@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 12, 2013 at 04:50:02PM +0100, Guennadi Liakhovetski wrote:
> Not on all sh-/r-mobile platfotms all pins are numbered contiguously from 0
> to N-1. On all ARM-based platforms datasheets use simple numbers to identify
> them, unlike some SuperH-based SoC, naming pins, using strings, e.g. A31:A0,
> B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver supported only
> contiguous pin numbering. This patch adds support for sparse pin numbers to
> support sh73a0 and any other similar SoCs.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

The sh-pfc pinctrl driver is not the place where this sort of lookup
should be happening, especially as the pinctrl subsystem already tracks
GPIO ranges for us. Is there some reason you can't just expand the
platform definition and tie in to pinctrl_add_gpio_ranges() for
supporting multiple ranges instead?

Your sparse case isn't exactly sparse either, as you seem to only be
dealing with multiple linear ranges, which is rather different from a
single pin space with individual GPIOs spread far and wide. The former
entails traversing a list of ranges in lookup paths, while the latter
requires far more complex handling/translation if attempting to tightly
pack the space.
