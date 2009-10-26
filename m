From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 22:25:06 +0000
Subject: Re: [PATCH] sh: add uImage.bin target
Message-Id: <20091026222505.GD9230@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026101239.13565.94659.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026101239.13565.94659.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 05:14:53PM -0400, Mike Frysinger wrote:
> On Monday 26 October 2009 06:12:39 Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add an uImage.bin target to allow uncompressed uImages.
> > Useful for boards with busted u-boot decompression like
> > the rsk7203 on my desk.
> 
> might want to update/fix arch/sh/Makefile's archhelp in the process (seems to 
> have random tab/spaces intermixed).
> 
I've added the archhelp bits now, thanks for catching that. Also, the
tabs/spaces aren't random, they're to make it line up with the rest of
the archhelp bits.
