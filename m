From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 17 Sep 2014 19:25:42 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile: r8a7779: Add DU node to device tree
Message-Id: <2123803.QxCV3SLlmi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410963073-3176-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410963073-3176-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 17 September 2014 22:03:12 Sergei Shtylyov wrote:
> Hello.
> 
> On 9/17/2014 5:11 PM, Laurent Pinchart wrote:
> > Add the DU device with a disabled state. Boards that want to enable the
> > DU need to specify the output topology
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/boot/dts/r8a7779.dtsi | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi
> > b/arch/arm/boot/dts/r8a7779.dtsi index 7cfba9a..f4c03cc 100644
> > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > @@ -379,6 +379,30 @@
> >   		status = "disabled";
> >   	};
> > 
> > +	du: du@fff80000 {
> 
> Perhaps the "display" name from the ePAPR section 2.2.2 fits here?

You're absolutely right. I'm sure I'll start thinking about it by myself one 
day, but until then, please keep on bugging me when I get it wrong :-)

I'll wait for others to comment on the series and I'll then resubmit it.

-- 
Regards,

Laurent Pinchart

