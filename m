From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 06:25:23 +0000
Subject: Re: [PATCH] ARM: shmobile: Lager memory map update
Message-Id: <20140606062518.GA13049@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605060601.12351.26135.sendpatchset@w520>
In-Reply-To: <20140605060601.12351.26135.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 06:24:07AM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Thu, Jun 5, 2014 at 5:17 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Magnus,
> >
> > On Thu, Jun 5, 2014 at 8:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >>
> >> Update the Lager DTS to make use of the new unified legacy
> >> memory map where the legacy window on Lager and Koelsch
> >> have the same size.
> >>
> >> After update the Lager board has the following map:
> >> Bank0: 1GiB RAM (Legacy 32-bit: 0x40000000->0x7fffffff)
> >> Bank1: 3GiB RAM (LPAE area: 0x140000000->0x1ffffffff)
> >>
> >> Before the update the old map looked like this:
> >> Bank0: 2GiB RAM (Legacy 32-bit: 0x40000000->0xbfffffff)
> >> Bank1: 2GiB RAM (LPAE area: 0x180000000->0x1ffffffff)
> >>
> >> Tested with and without LPAE on r8a7790 Lager.
> >>
> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> >
> > I think this lacks an explanation why you want this...
> 
> The reason is that the legacy portion of the memory map (what is
> included in the 32-bit space) should be unified between Lager and
> Koelsch. I've been asked to do this, and I suspect it is related to
> simplify u-boot board support. It is not however 100% clear to me. Now
> the memory map will at least match documentation.

I think it would be best if some reason was included in the changelog.
I am willing to accept "align code with documentation" at a minimum.
But something more verbose may aid us when looking over this again
in the future.

> 
> > In general, less highmem is better ;-)
> 
> Well, yes, that I agree to. But in this particular case with the
> common 3G/1G user/kernel virtual memory split the amount of highmem
> actually remains the same. =) From highmem/lowmem perspective this
> patch simply takes 1GiB of highmem from the legacy window and moves it
> into the LPAE area that also is accessed as highmem. LPAE needs to be
> enabled to get all the memory though, but that was needed before
> anyway. So this patch really makes no big difference when 3G/1G is
> used.
> 
> However for other split mode like 2G/2G the amount of potential lowmem
> is reduced. It is however my understanding that this split mode is
> however incompatible with the USB Host controllers. Also, on Lager
> regardless how you adjust your split mode you need to enable LPAE to
> get access to all memory.
> 
> Cheers,
> 
> / magnus
> 
