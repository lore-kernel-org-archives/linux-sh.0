From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Dec 2015 22:46:32 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7793: Add I2C master nodes to DT
Message-Id: <1543689.KcWvfEt5Ye@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1451299221-18679-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1451299221-18679-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 30 December 2015 09:32:52 Simon Horman wrote:
> On Mon, Dec 28, 2015 at 12:40:21PM +0200, Laurent Pinchart wrote:
> > Instantiate all the 9 I2C controllers in the disabled state.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I took a slightly different approach for the last 3 controllers in:
> 
> * [PATCH/RFC 01/19] ARM: shmobile: r8a7793: add i2c clocks
> * [PATCH/RFC 04/19] ARM: shmobile: r8a7793: add iic(b)  to device tree
> 
> I'm wondering if we could reach some consensus on how to handle that.
> If that seems difficult perhaps we could just enable the first 6
> controllers for now.

I'm fine with any approach. This is a case where discussing how to implement 
the feature will take longer than implementing it, so feel free to drop my 
patch and use yours :-)

-- 
Regards,

Laurent Pinchart

