From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 Dec 2013 00:45:17 +0000
Subject: Re: [PATCH v6 15.1/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
Message-Id: <20131223004517.GH12239@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 20, 2013 at 11:46:10PM +0100, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Friday 20 December 2013 23:40:19 Magnus Damm wrote:
> > On Fri, Dec 20, 2013 at 11:24 PM, Laurent Pinchart wrote:
> > > On Friday 20 December 2013 16:18:39 Magnus Damm wrote:
> > >> On Fri, Dec 20, 2013 at 12:28 AM, Laurent Pinchart wrote:
> > >> > The Koelsh reference device tree is going away, copy the missing GPIO
> > >> > keys device node to the Koeslch device tree file.
> > >> > 
> > >> > Signed-off-by: Laurent Pinchart
> > >> > <laurent.pinchart+renesas@ideasonboard.com>
> > >> > ---
> > >> > 
> > >> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 54 +++++++++++++++++++++++++++
> > >> >  1 file changed, 54 insertions(+)
> > >> > 
> > >> > Hi Simon,
> > >> > 
> > >> > This patch contains the differences between v4 (which you have queued
> > >> > up) and v5 of "ARM: shmobile: Sync Koelsch DTS with Koelsch reference
> > >> > DTS".> Feel free to apply it on top of your dt branch, or alternatively
> > >> > rebase the branch to replace v4 with v5.
> > >> 
> > >> Hi Laurent,
> > >> 
> > >> Thanks for this patch. If you compare GPIO-keys on Koelsch and Lager
> > >> then you can see that both have a DIP switch and Koelsch also has a
> > >> set of buttons. I may recall wrong, but I think the legacy code
> > >> supports both the DIP switch and buttons. This DT reference patch
> > >> seems to only add buttons, not the DIP switch. Any plans to include
> > >> the DIP switch?
> > > 
> > > I've seen that when implementing the original Koelsh GPIO keys DT support
> > > and poundered how to handle it properly. It basically boils down the how
> > > we define a GPIO key. A GPIO is a hardware concept, but a key is defined
> > > by its usage intent. As the buttons and DIP switches you refer to are
> > > just buttons and switches without a defined purpose, how to handle them
> > > is I believe a policy decision.
> > 
> > I agree. This is IMO the same as for the platform device case, but I guess
> > there it is more common to mix software policy and hardware description
> > there. There are also no letters printed on the buttons on the actual
> > hardware, so assigning something dummy in DT seems kind of odd too.
> > 
> > > In the end I've decided to handle the buttons with the GPIO keys driver as
> > > I believe it makes sense to have keys hooked up to the input subsystem on
> > > a development board. As the DIP switches are not momentary buttons from a
> > > hardware point of view I've decided to omit them and let them be used for
> > > other purposes.
> > 
> > What are "other purposes" here if I may ask? =)
> 
> Boot configuration is one possibility. Basically anything that the GPIO API 
> can expose to kernelspace and/or userspace. Exposing GPIOs as GPIOs is 
> probably useful on a development board the same way exposing them as keys is.
> 
> > > I'm fine with revisiting this decision, but please note that this patch
> > > only synchronizes the non-reference dts with the reference dts.
> > 
> > How do you mean by synchronize? It seems to half-synchronize to me, see
> > below!
> 
> This patch is about synchronizing r8a7791-koelsch.dts with r8a7791-koelsch-
> reference.dts, as r8a7791-koelsch-reference.dts will be removed. I'm not 
> opposed to adding keys for the DIP switch to r8a7791-koelsch.dts as a second 
> step.
> 
> > I want to keep the legacy board code and the DT reference stuff in full
> > sync. I also would like to keep software support for Lager and Koelsch on a
> > similar level.
> > 
> > As you know, I submitted GPIO code to the Koelsch legacy code earlier, and I
> > was about to send the DT bits too, but someone else got there before me. =)
> > 
> > Unless I'm mistaken the legacy Koelsch code contains this:
> > 
> > static struct gpio_keys_button gpio_buttons[] = {
> > GPIO_KEY(KEY_4, RCAR_GP_PIN(5, 3), "SW2-pin4"),
> > GPIO_KEY(KEY_3, RCAR_GP_PIN(5, 2), "SW2-pin3"),
> > GPIO_KEY(KEY_2, RCAR_GP_PIN(5, 1), "SW2-pin2"),
> > GPIO_KEY(KEY_1, RCAR_GP_PIN(5, 0), "SW2-pin1"),
> > 
> > So if you want to use SW2 for something else, then I think it's something we
> > should do across both Lager and Koelsch and both legacy and DT reference
> > code. Just being special in one place seems odd.
> 
> Lager and Koelsch are two different boards so I don't think they should have 
> the same features set just for the sake of it, but that doesn't mean I'm 
> opposed to adding keys for the DIP switch on Koelsch.
> 
> > Please note that in the Lager case we only have DIP switches, so waking up
> > from Suspend-to-RAM via GPIO can only be done via the DIP switch.
> 
> Doesn't the reset button wake up the CPU ? :-p
> 
> > Because of that I prefer to allow wakeup via DIP switch in a consistent way
> > for both Lager and Koelsch. Did you have any special idea how to interface
> > to the DIP switches so we can wake up from Suspend-to-RAM? =)
> 
> That's a good question. Aren't there use cases where we want a button to wake 
> up the system, but without exposing it as a key ?
> 
> Anyway, I'm not opposed to adding keys for the DIP switch, but I'd rather do 
> it on top of this patch series.

My understanding is that this patch merely moves code that
was (the file has now been removed by the subsequent patch,
which I have queued up) from r8a7791-koelsch-reference.dts to
r8a7791-koelsch.dts.

With this in mind I think that this patch is entirely reasonable in
its current form and that further enablement can be added on top.

Are there any objections to me queuing up this patch?
