From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Apr 2012 02:44:33 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <20120406024427.GE27120@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 06, 2012 at 11:13:24AM +0900, Shimoda, Yoshihiro wrote:
> Hi Simon-san,
> 
> 2012/04/06 10:57, Simon Horman wrote:
> > On Fri, Apr 06, 2012 at 09:59:14AM +0900, Shimoda, Yoshihiro wrote:
> >> SCIF modules which have SCSPTR can output the break signal.
> >> This patch supports it.
> >>
> >> This patch tested on sh7757lcr.
> > 
> > Hi Shimoda-san,
> > 
> > I have checked that this change boots on the sh7757lcr
> > and that the serial console seems to work. I am curious to
> > know if there is anything else that can be tested.
> 
> Thank you for the check.
> setup-xxxx.c which have "PORT_SCIF" can be tested:
>  - SH7724, SH7785, R8A7779, etc.

Thanks, I will try and test on ecovec which I believe has SH7724.
Do you have any information on how I should test the code,
other than booting it
