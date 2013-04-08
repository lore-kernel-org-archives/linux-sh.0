From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 08 Apr 2013 09:39:04 +0000
Subject: Re: [PATCH 00/02] sh-pfc: Initial r8a7790 PFC support
Message-Id: <13388783.b56mMEpCKf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130408020834.29957.24249.sendpatchset@w520>
In-Reply-To: <20130408020834.29957.24249.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 08 April 2013 11:13:43 Simon Horman wrote:
> On Mon, Apr 08, 2013 at 11:08:34AM +0900, Magnus Damm wrote:
> > sh-pfc: Initial r8a7790 PFC support
> > 
> > [PATCH 01/02] ARM: shmobile: Add second I/O range for r8a7790 PFC
> > [PATCH 02/02] sh-pfc: Initial r8a7790 PFC support
> > 
> > This mini-series contains initial support for the r8a7790 PFC.
> > Incremental future changes will move over to PINCTRL.
> > 
> > Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> Thanks Magnus.
> 
> Laurent, can I get a review from you.

I've acked the patches.

> And also some indication of how you would like to queue these up.
> 
> The pinmux branch of my tree seems like a likely candidate.

That sounds good to me. I've posted a follow-up patch series that I would like 
to get merged at the same time as these two patches. Is there still time to 
get all that in v3.10 ?

-- 
Regards,

Laurent Pinchart

