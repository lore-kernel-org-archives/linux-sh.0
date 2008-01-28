From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jan 2008 02:47:13 +0000
Subject: Re: set_dma_addr missing ?
Message-Id: <20080128024713.GA7191@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
In-Reply-To: <38b2ab8a0801261302i68a84fdo6d6ebdb26d9acfc8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jan 26, 2008 at 10:02:02PM +0100, Francis Moreau wrote:
> Sorry to be blind but I can't figure out why this function is missing
> for SH architecture ?
> 
It's not "missing", it's only enabled if you specifically request support
for the ISA DMA API wrapper. It's a total kludge, since the SH DMAC has
very little in common with how ISA DMA works, but it's provided for
compatability anyways. If you're trying to use this API in a driver,
you're almost definitely doing the wrong thing.

Anyways, you can have it supported by selecting ISA_DMA_API in
arch/sh/Kconfig.
