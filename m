From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Sep 2013 08:50:25 +0000
Subject: Re: [PATCH 0/3] Lager i2c bus support
Message-Id: <1683639.Kv1TdYPjqG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1378813194-19493-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 25 September 2013 13:59:26 Simon Horman wrote:
> On Thu, Sep 19, 2013 at 02:28:20PM -0700, Simon Horman wrote:
> > On Mon, Sep 16, 2013 at 03:23:46PM +0200, Ulrich Hecht wrote:
> > > On Thu, Sep 12, 2013 at 3:51 PM, Guennadi Liakhovetski wrote:
> > Apologies for me excessively slow response.
> > 
> > > > What is your preferred way to resolve this? We can choose one of the
> > > > following:
> > > > 
> > > > 1. merge the two i2c clock patches into one - feel free to take my
> > > > code into "ARM: shmobile: r8a7790: add the I2C bus clock" from this
> > > > series
> > > > 
> > > > 2. port one of the patches on top of the other one - if this series
> > > > isn't going to be modified again, I can port my patch on top of it.
> > > 
> > > Since my DU stuff will have to be ported to DT anyway and I have found
> > > that my work towards that on the rcar-i2c driver is virtually
> > > identical to what Guennadi has already posted, I'd suggest to go with
> > > his version.
> > 
> > That sounds like a good resolution to me.
> 
> Btw, as far as I can see the current status of this work is as follows.
> 
> 1. Awaiting Ack from Laurent on
>    "pinctrl: sh-pfc: r8a7790: add pin definitions for the I2C3 interface"
>    by Guennadi. This patch is targeted at Linus Walleji's tree.

I've replied to Guennadi's patch, there will likely be a v2.

> 2. Once Linus has queued up that patch I will queue up
>    "ARM: shmobile: r8a7790: add I2C support in Device Tree mode"
>    in the renesas tree.

There's no dependency between the two patches, you can thus queue it up 
already.

> 3. From there I think you should be able to repost the parts of your
>    series that aren't included in Guennadi's work.
> 
> To be clear: I have marked this series as "Changes Requested" in patchwork
> and it is will not be on my radar unless it is re-posted in some form.
-- 
Regards,

Laurent Pinchart

