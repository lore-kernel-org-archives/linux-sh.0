From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 01:12:54 +0000
Subject: Re: [PATCH v4 0/3] ARM: shmobile: r8a7779/90: Poll MSTP clocks status
Message-Id: <4663408.9RIOQ39hEV@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034633-3798-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034633-3798-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 08 January 2014 10:03:54 Simon Horman wrote:
> On Tue, Jan 07, 2014 at 05:53:38PM +0900, Simon Horman wrote:
> > On Tue, Jan 07, 2014 at 09:34:12AM +0100, Laurent Pinchart wrote:
> > > On Saturday 14 December 2013 16:23:50 Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This patch set implements a busy loop to ensure that enabling an MSTP
> > > > clock will not return before the clock is actually enabled. It has
> > > > successfully been tested on the Marzen board and on the Lager board
> > > > where they fix random crashes with the VSP1.
> > > > 
> > > > Simon, could you please apply this for v3.14 ?
> > > 
> > > Ping ?
> > > 
> > > This patch series is required to fix crashes with the VSP1 on R8A7790.
> > 
> > Thanks. I haven't heard back from Paul so I'll look at queuing
> > this up tomorrow.
> 
> Hi Laurent,
> 
> I have queued up this series locally in the soc-fixes-for-v3.14 which
> I plan to include in the devel and next branches and push later today.
> 
> It would help me when sending a pull-request for these changes if
> you could give me a description of the problem they solve and if
> possible when they problem was introduced.
> 
> e.g. (I am completely guessing about the cause)
> 
> This resolves crashing when using VSP1 which has been observed on the
> r8a7779 (R-Car H1) based Marzen board. This problem has been present since
> VSP support was added to Marzen by deadbeef ("ARM: shmobile: marzen: Add
> VSP1") in v3.W-rcX.
> 
> This also resolves the same problem on the r8a7790 (R-Car H2) based Lager
> board. The problem was introduced there by by dead1234 ("ARM: shmobile:
> lager: Add VSP1") in v3.Y-rcZ.

---- 8< ----
This resolves unhandled faults caused by accessing devices with their clock 
disabled. The issue has been noticed with the VSP1 on r8a7790 and has been 
present since the VSP1 driver has been added by commit 26e0ca22c3b8 ("[media] 
v4l: Renesas R-Car VSP1 driver") in v3.12-rc1.
---- 8< ----

(Note that VSP1 support hasn't been added to board files in mainline yet.)

-- 
Regards,

Laurent Pinchart

