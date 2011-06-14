From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Jun 2011 06:31:01 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Mackerel USB platform data update
Message-Id: <20110614063101.GB17891@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609070337.3122.1679.sendpatchset@t400s>
In-Reply-To: <20110609070337.3122.1679.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 09, 2011 at 05:44:21PM +0900, Magnus Damm wrote:
> Hi Morimoto-san,
> 
> On Thu, Jun 9, 2011 at 4:09 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Magnus
> >
> > Thank you for your patch.
> > small comment from me
> >
> >> +static u32 usbhs0_pipe_cfg[] = {
> >> + ? ? USB_ENDPOINT_XFER_CONTROL,
> >> + ? ? USB_ENDPOINT_XFER_ISOC,
> >> + ? ? USB_ENDPOINT_XFER_ISOC,
> >> + ? ? USB_ENDPOINT_XFER_BULK,
> >> + ? ? USB_ENDPOINT_XFER_BULK,
> >> + ? ? USB_ENDPOINT_XFER_BULK,
> >> + ? ? USB_ENDPOINT_XFER_INT,
> >> + ? ? USB_ENDPOINT_XFER_INT,
> >> + ? ? USB_ENDPOINT_XFER_INT,
> >> + ? ? USB_ENDPOINT_XFER_BULK,
> >> +};
> >
> > I think AP4 USB0 pipe9 is interrupt.
> > If so, this pipe config is not needed.
> > it is same as renesas_usbhs default pipe configs.
> > see
> > ?renesas_usbhs/common.c :: usbhs_default_pipe_type
> 
> Ok, thanks, can you please send an incremental patch to fix this?
> 
I've grudgingly applied this patch as it is, but I really don't like this
half-assed approach to patch submission. The onus is not on Morimoto-san
to fix up your submission when he's pointed out something that you
obviously failed to take under consideration on an initial patch. You
should have simply discarded this and submitted an updated version that
fixed this up, and in a timely fashion.

Since none of these things have happened and it's unlikely that any of
them will before some -next time leading up to the next -rc I've taken it
verbatim, but am certainly not happy with having had to do so, nor do I
see much reason to continue to do so in the future.

> >> ? ? ? [1] = {
> >> @@ -752,7 +846,6 @@ static struct platform_device usbhs1_dev
> >> ? ? ? .resource ? ? ? = usbhs1_resources,
> >> ?};
> >>
> >> -
> >> ?/* LED */
> >> ?static struct gpio_led mackerel_leds[] = {
> >
> > this "just line erase" is not needed =)
> 
> Well, perhaps it's only me, but trying to make the code look less like
> shit may be a good idea. =)
> 
Pot calling the kettle black much? Perhaps adding new lines following
comment blocks for no reason as your patch does should go, too? Or you
could make your multi-line comments comply with Documentation/CodingStyle
too, as everyone else seems to be able to. Or are we just randomly
choosing which parts of the kernel coding style to comply with and
criticise others over today?
