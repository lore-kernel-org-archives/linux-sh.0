From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 May 2014 06:52:47 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: Add Core-Standby-state for Suspend to RAM
Message-Id: <20140530065244.GA19611@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E089.3050003@renesas.com>
In-Reply-To: <5386E089.3050003@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 30, 2014 at 03:21:19PM +0900, Magnus Damm wrote:
> On Fri, May 30, 2014 at 8:38 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, May 29, 2014 at 04:23:53PM +0900, keita kobayashi wrote:
> >> These patches add Core-Standby-state for Suspend to RAM support to the
> >> r8a7790/r8a7791 SoC. This patch series depend on previously posted patch.
> >>       [PATCH] ARM: shmobile: r8a7791: SYSC setup code.
> >>
> >> This patch series is based on renesas-devel-v3.15-rc7-20140526 tag
> >
> > Thanks.
> >
> > Please repost this series once that patch has been accepted
> > (I believe you need to post v2 of it to address some review of it.)
> >
> >> Keita Kobayashi (3):
> >>   ARM: shmobile: APMU: Add Core-Standby-state for Suspend to RAM
> >>   ARM: shmobile: r8a7790: Support Core-Standby for Suspend to RAM
> >>   ARM: shmobile: r8a7791: Support Core-Standby for Suspend to RAM
> 
> Hi Simon and Kobayashi-san,
> 
> >From my point of view this series looks quite fine. I believe it
> should apply as-is on top of v2 of "[PATCH] ARM: shmobile: r8a7791:
> SYSC setup code", but I may fail to see some of the dependencies.
> 
> Acked-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Kobayashi-san, please follow the guidance from Simon. I believe he
> will tell you if you need to resend or not.
> 
> Simon, can you let us know how to proceed?

Thanks for the Acks.
I will queue up these patches.
