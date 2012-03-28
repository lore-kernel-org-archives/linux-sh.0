From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Mar 2012 05:41:56 +0000
Subject: Re: [PATCH RESEND] sh: add platform_device for RSPI in setup-sh7757
Message-Id: <20120328054156.GS26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F56F641.4030809@renesas.com>
In-Reply-To: <4F56F641.4030809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 07, 2012 at 03:00:03PM +0900, Shimoda, Yoshihiro wrote:
> 2012/03/07 14:55, Paul Mundt wrote:
> > On Wed, Mar 07, 2012 at 02:46:41PM +0900, Shimoda, Yoshihiro wrote:
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
> >>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   20 ++++++++++++++++++++
> >>  1 files changed, 20 insertions(+), 0 deletions(-)
> >>
> > I wasn't going to bother applying this until the actual driver itself had
> > been merged. Obviously we can merge the data regardless, as it doesn't
> > depend on any headers or anything, but it would be pointless if changes
> > have to be made to the driver first.
> > 
> 
> Thank you for the comment. I understood it.
> 
Ok, looks like the driver is in mainline now, so I've queued this up.
