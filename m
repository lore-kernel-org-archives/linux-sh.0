From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 07:50:17 +0000
Subject: Re: [PATCH v4 0/3] ARM: shmobile: r8a7779/90: Poll MSTP clocks status
Message-Id: <26716651.17InoLzNy9@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034633-3798-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034633-3798-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wednesday 08 January 2014 16:04:44 Magnus Damm wrote:
> On Tue, Jan 7, 2014 at 5:34 PM, Laurent Pinchart wrote:
> > On Saturday 14 December 2013 16:23:50 Laurent Pinchart wrote:
> >> Hello,
> >> 
> >> This patch set implements a busy loop to ensure that enabling an MSTP
> >> clock will not return before the clock is actually enabled. It has
> >> successfully been tested on the Marzen board and on the Lager board where
> >> they fix random crashes with the VSP1.
> >> 
> >> Simon, could you please apply this for v3.14 ?
> > 
> > Ping ?
> > 
> > This patch series is required to fix crashes with the VSP1 on R8A7790.
> 
> Thanks for fixing this issue, the missing status bit check has been
> around for ages.

You're welcome.

> I suspect a similar fix is needed for r8a7791 as well, any chance that
> would be needed for DU / VSP1 on Koelsch?

Indeed. I'll submit a patch.

-- 
Regards,

Laurent Pinchart

