From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Nov 2012 13:19:51 +0000
Subject: Re: Single zImage for Armadillo and KZM9G
Message-Id: <3248223.GdFiQ804qF@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <7563707.giGeIu5Uba@avalon>
In-Reply-To: <7563707.giGeIu5Uba@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 21 November 2012 10:28:34 Simon Horman wrote:
> On Wed, Nov 21, 2012 at 02:07:20AM +0100, Laurent Pinchart wrote:
> > On Wednesday 21 November 2012 09:47:14 Simon Horman wrote:
> > > On Wed, Nov 21, 2012 at 01:38:19AM +0100, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > I've been trying to boot the same zImage on both Armadillo (r8a7740)
> > > > and KZM9G (sh73a0) and stumbled on CONFIG_MEMORY_START. Armadillo has
> > > > the memory start at 0x40000000 while KZM9G seems to reserver the first
> > > > 16MB, and thus starts at 0x41000000.
> > > > 
> > > > The memory address and size can be specified per-board in the device
> > > > tree, but a mismatch between the DT memory start and
> > > > CONFIG_MEMORY_START results in a pretty hard boot failure (tested on
> > > > Armadillo).
> > > > 
> > > > Has anyone run into the same issue ? Pointers would be appreciated.
> > > 
> > > The most recent discussion of CONFIG_MEMORY_START that I am aware of was
> > > in a thread that stemmed from "[GIT,PULL] Renesas ARM-based SoC
> > > defconfig for v3.8"
> > > 
> > > https://patchwork.kernel.org/patch/1627511/
> > > 
> > > In short, it would be nice to get rid of CONFIG_MEMORY_START to allow,
> > > amongst other things, (valid) values to be read from DT. But there
> > > is some work to be done.
> > 
> > Thank you for the information. Is there anyone working (or planning to
> > work in the near future) on this ?
> 
> I was planning to look at it but have not done so yet.
> Feel free to jump in if you feel so inclined.

I wish I had time to do so :-) If I happen to find an empty space in my 
schedule I'll let you know, but please proceed otherwise.

-- 
Regards,

Laurent Pinchart

