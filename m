From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Dec 2011 15:24:00 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: process requests asynchronously
Message-Id: <CANqRtoRvqZCuVQF0zeh9kyCnanfjA6k6ttWLOcf1y+-b4OcM_Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Guennadi,

On Thu, Dec 1, 2011 at 12:07 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch converts the sh_mmcif MMC host driver to process requests
> asynchronously instead of waiting in its .request() method for completion.
> This is achieved by using threaded IRQs.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks for your work on this! Interesting with threaded IRQ support.

Would it be possible to split this up into smaller chunks somehow?
This rather big patch is more or less a rewrite of the driver - so it
somehow looks to me like you're implementing multiple functional
changes in a single commit. Maybe you're not doing that, but if so
then at least the new code flow needs some documentation.

How about including some ascii-art style charts of the different
states involved in reads and writes both for PIO and DMA? I'm thinking
of something similar to the comments that describe the bus transaction
and interrupts in drivers/i2c/busses/i2c-sh_mobile.c.

Cheers,

/ magnus
