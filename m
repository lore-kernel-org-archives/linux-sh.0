From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Feb 2010 04:19:34 +0000
Subject: Re: [PATCH] sh: sh7723: Add A/D converter driver support
Message-Id: <20100202041934.GI13428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 29, 2010 at 10:40:55AM +0100, Pietrek, Markus wrote:
> This patch adds support for the SH7723 A/D converter. It can be
> registered in arch/sh/boards/<xx>/setup.c with

This looks like a good start, but it will need some extending for the
existing in-tree ADC users (hp6xx, via the SH-3 ADC), which will require
an in-kernel API. (You can grep for adc_single to find the existing
in-tree users).

Having said that, what you have now shouldn't take much to get tidied up
and made more generic, so if you don't get around to it now then I'll
probably just take care of it prior to the next merge window. It's in
patchwork now at least, so it won't get lost.
