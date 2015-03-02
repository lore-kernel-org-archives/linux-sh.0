From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 02 Mar 2015 23:54:35 +0000
Subject: Re: [PATCH 01/10] media: omap3isp: remove unused clkdev
Message-Id: <20150302235435.GF29584@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnC-0001JU-CX@rmk-PC.arm.linux.org.uk>
 <118780170.u6ZO5zJrEk@avalon>
 <20150302225336.GV6539@valkosipuli.retiisi.org.uk>
In-Reply-To: <20150302225336.GV6539@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

(Combining replies...)

On Tue, Mar 03, 2015 at 12:53:37AM +0200, Sakari Ailus wrote:
> Hi Laurent and Russell,
> 
> On Tue, Mar 03, 2015 at 12:33:44AM +0200, Laurent Pinchart wrote:
> > Sakari, does it conflict with the omap3isp DT support ? If so, how would you 
> > prefer to resolve the conflict ? Russell, would it be fine to merge this 
> > through Mauro's tree ?

As other changes will depend on this, I'd prefer not to.  The whole
"make clk_get() return a unique struct clk" wasn't well tested, and
several places broke - and currently clk_add_alias() is broken as a
result of that.

I'm trying to get to the longer term solution, where clkdev internally
uses a struct clk_hw pointer rather than a struct clk pointer, and I
want to clean stuff up first.

If omap3isp needs to keep this code, then so be it - I'll come up with
a different patch improving its use of clkdev instead.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
