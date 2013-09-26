From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Sep 2013 00:29:20 +0000
Subject: Re: [PATCH] ARM: shmobile: Add r8a7790 thermal sensor DT device
Message-Id: <20130926002919.GB13464@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130925231119.16473.31647.sendpatchset@w520>
 <20130925233552.GA20882@verge.net.au>
 <CANqRtoRPAMDDgPo5kBTxnEoVG7N1UwxWGBuz+ORzTPqP=+7r_A@mail.gmail.com>
In-Reply-To: <CANqRtoRPAMDDgPo5kBTxnEoVG7N1UwxWGBuz+ORzTPqP=+7r_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 26, 2013 at 08:43:46AM +0900, Magnus Damm wrote:
> On Thu, Sep 26, 2013 at 8:35 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 26, 2013 at 08:11:19AM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Hook up the single channel thermal sensor via DT
> >> on r8a7790. The information used by the platform
> >> device has been verified against the data sheet.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >
> > Hi Magnus,
> >
> > I would prefer if this was split into two patches.
> > An SoC patch that updates clock-r8a7790.c.
> > And a DT patch which updates r8a7790.dtsi.
> 
> Sure, that's fine with me. I will do that from now on.

Thanks. I'm trying to reduce dependencies/conflicts between
branches. I'm not sure how well it will pan out. But that is my aim
at the moment.

> I believe that common clock framework will allow us to handle all
> within a single dtsi patch.

Excellent.
