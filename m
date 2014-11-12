From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Nov 2014 02:25:50 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock
Message-Id: <20141112022549.GG11597@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415181874-21549-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415181874-21549-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 12, 2014 at 09:57:02AM +0900, Simon Horman wrote:
> On Mon, Nov 10, 2014 at 09:57:46AM +0900, Simon Horman wrote:
> > On Wed, Nov 05, 2014 at 11:04:34AM +0100, Geert Uytterhoeven wrote:
> > > According to the datasheet, the operating clock for IIC0 is the HPP
> > > (RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
> > > speed (50 Mhz).
> > > 
> > > This is consistent with IIC0 being located in the A4R PM domain, and
> > > IIC1 in the A3SP PM domain.
> > 
> > Thanks, I have queued this up.
> 
> Hi Geert,
> 
> As this appears to be a bug fix I would like to accompany this patch with
> some text describing when the problem was introduced and what its effects
> are. In short a rough guide to if it should be applied to -stable. To that
> end I prepared the following which I would appreciate your feedback on.
> 
> * ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock  
> 
>   This problem was introduced when clock support was added DT for the
>   r8a7740 by d9ffd583bf345e2ea ("ARM: shmobile: r8a7740: add SoC clocks to
>   DTS") in v3.17.

s/v3.17/v3.18-rc1/

>   I am not aware of any run-time effect of this problem.
