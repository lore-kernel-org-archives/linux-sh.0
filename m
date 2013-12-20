From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 20 Dec 2013 14:24:19 +0000
Subject: Re: [PATCH v6 15.1/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
Message-Id: <18271175.fqPEWBKZqR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Friday 20 December 2013 16:18:39 Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 12:28 AM, Laurent Pinchart
> 
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > The Koelsh reference device tree is going away, copy the missing GPIO
> > keys device node to the Koeslch device tree file.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 54 ++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > Hi Simon,
> > 
> > This patch contains the differences between v4 (which you have queued up)
> > and v5 of "ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS".
> > Feel free to apply it on top of your dt branch, or alternatively rebase
> > the branch to replace v4 with v5.
> 
> Hi Laurent,
> 
> Thanks for this patch. If you compare GPIO-keys on Koelsch and Lager
> then you can see that both have a DIP switch and Koelsch also has a
> set of buttons. I may recall wrong, but I think the legacy code
> supports both the DIP switch and buttons. This DT reference patch
> seems to only add buttons, not the DIP switch. Any plans to include
> the DIP switch?

I've seen that when implementing the original Koelsh GPIO keys DT support and 
poundered how to handle it properly. It basically boils down the how we define 
a GPIO key. A GPIO is a hardware concept, but a key is defined by its usage 
intent. As the buttons and DIP switches you refer to are just buttons and 
switches without a defined purpose, how to handle them is I believe a policy 
decision.

In the end I've decided to handle the buttons with the GPIO keys driver as I 
believe it makes sense to have keys hooked up to the input subsystem on a 
development board. As the DIP switches are not momentary buttons from a 
hardware point of view I've decided to omit them and let them be used for 
other purposes.

I'm fine with revisiting this decision, but please note that this patch only 
synchronizes the non-reference dts with the reference dts.

-- 
Regards,

Laurent Pinchart

