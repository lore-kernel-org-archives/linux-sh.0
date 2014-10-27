From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 27 Oct 2014 09:05:37 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove FSF address from copyright headers
Message-Id: <1414427220.i8IQn7EkpG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414333227-15674-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414333227-15674-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 27 October 2014 10:04:55 Simon Horman wrote:
> On Sun, Oct 26, 2014 at 08:31:47PM +0100, Geert Uytterhoeven wrote:
> > On Sun, Oct 26, 2014 at 3:20 PM, Laurent Pinchart wrote:
> > > The information is already included in the COPYING file in the kernel
> > > sources root directory, we don't want to modify all source files when
> > > the FSF will move to a new address, and I'm tired of seeing the related
> > > checkpatch.pl warnings.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > The fun part will be to merge this while minimizing the risk of
> > > conflicts :-)> 
> > Simon can just ask Linus to pull all of this at once after v3.18-rc2?
> 
> I think it is easy enough to simply add it to a cleanup branch
> and manage the conflicts from there. So far the only conflict
> is with Laurent's DU-DT series (which removes some of the files
> changed by this series). I have rebased it accordingly.

Sure, that's fine with me.

-- 
Regards,

Laurent Pinchart

