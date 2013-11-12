From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Nov 2013 02:30:22 +0000
Subject: Re: [PATCH/RFC] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY
Message-Id: <20131112023022.GE9863@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383782061-7111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 11, 2013 at 09:45:12AM +0000, phil.edworthy@renesas.com wrote:
> Hi Laurent,
> 
> > On Friday 08 November 2013 14:57:29 stephen.lawrence@renesas.com wrote:
> > > linux-sh-owner@vger.kernel.org wrote on 08/11/2013 06:08:05:
> > > > On Thu, Nov 07, 2013 at 03:04:57PM +0900, Magnus Damm wrote:
> > > > > On Thu, Nov 7, 2013 at 8:54 AM, Laurent Pinchart wrote:
> > > > > > SH-Mobile platforms are transitioning from non-multiplatform to
> > > > > > multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration 
> symbol
> > > > > > has been created to group all multiplatform-enabled SH-Mobile 
> SoCs.
> > > > > > The existing ARCH_SHMOBILE configuration symbol groups SoCs
> > > > > > that haven't been converted yet.
> > > 
> > > I'm sure there are reasons for keeping it but looking forward I can't 
> help
> > > but wonder if this wouldn't be a good time to lose the SHMOBILE tag 
> for
> > > new platforms? It doesn't seem to be a great match to our business or 
> the
> > > architectures.
> > > 
> > > I know from conversations I've had in the last year or so that 
> external
> > > engineers working on R-Car sometimes do not find your good work 
> upstream
> > > as the combination of sh-mobile and using the product number proved
> > > an effective method of concealment. Although of course they could
> > > find it 
> by
> > > searching the right files.
> > 
> > It's not a bad idea, but I'm not sure how we could proceed. SH-Mobile, 
> R-
> > Mobile and R-Car chipsets are all supported by a single code base, for 
> which 
> > we need a name. Splitting the code base wouldn't make much sense from a
> > technical point of view.
> 
> True, but it would be helpful to have Renesas in the device name
> somewhere. Maybe include Renesas in the mach-shmobile/Kconfig description
> for the devices, and also update the description in arm/Kconfig to
> include R-Car.

Hi,

I have been involved in several discussions relating to moving away from
the shmobile name.

Prior to this thread the most recent discussion I was involved in was with
Olof Johansson, ARM-SoC co-maintainer, and Magnus. Due to the amount of
churn involved in changing the name of the mach-shmobile directory or
somehow splitting the code between multiple mach- directories, which was
the variant of the topic under discussion, the consensus was that moving
things around was not on the cards at this time.  There is also, as Laurent
mentioned, the technical issue that splitting the code doesn't make a whole
lot of sense from an implementation point of view.

From my point of view changing the SHMOBILE potion of ARCH_SHMOBILE_*
only really makes sense if the name of mach-shmobile directory is changed
in a similar way, which as I mentioned above that seems to be off the cards
at this time. The reason I think this is that if the ARCH_XXX name doesn't
match the directory we will add confusion rather than removing it.

With the above in mind I think that Phil's proposal to enhance
the descriptions in mach-shmobile/Kconfig and arm/Kconfig is
an excellent one given the hand of cards we have available to play.
