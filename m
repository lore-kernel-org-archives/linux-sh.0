From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 21 Feb 2013 16:28:32 +0000
Subject: Re: [PATCH 1/3] serial: sh-sci: Add Device Tree probing
Message-Id: <20130221162831.GA10147@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 21, 2013 at 09:46:37AM -0600, Bastian Hecht wrote:
> Hi Paul,
> 
> thanks for commenting on this.
> 
> 2013/2/20 Paul Mundt <lethal@linux-sh.org>:
> > On Tue, Feb 19, 2013 at 12:29:44PM -0600, Bastian Hecht wrote:
> >> +Required properties:
> >> +- compatible : Should be "renesas,shmobile-sci-hwb-<x>", where <x> denotes a
> >> +  hardware block version number of the following list - choose it according
> >> +  to your SoC in use.
> >> +  1: sh7372, sh73a0, r8a7740
> >> +  2: r8a7779
> >
> > This is introducing another layer of arbitrary versioning that pretty
> > much side-steps all of the existing abstraction that exists for dealing
> > with block versioning to begin with, so no, this isn't going to fly.
> 
> Yes, it kind of felt like introducing the 1000th way of versioning...
> Agreed, let's avoid this!
> 
> > If you want to use version numbering like this, then it should be matched
> > to the regtype, which handles all possible variations already.
> 
> What do you mean by "regtype"? Could you give me an example
> .compatible line, please?
> 
Looking at it a bit more, the regtype is probably ok just as an added
property, given that most of the time you're going to be using the probed
one anyways.

As far as compatible lines go, I would break them out per-port type, as
many other drivers do, and pass along the PORT_xxx definition under
.data, which should be sufficient to determine the regtype in most cases.
Adding a special regtype property would still be necessary for the case
we don't want the default, however.

So something along the lines of:
	renesas,sci-<port type>

with or without a trailing -uart should work fine.

> >> +#ifdef CONFIG_OF
> >> +/*
> >> + * We provide setup data for different hardware block versionis. See
> >> + * Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt
> >> + * for further information.
> >> + */
> >> +static struct plat_sci_port sci_drv_data_hwb_1 = {
> >> +     .flags          = UPF_BOOT_AUTOCONF,
> >> +     .scscr          = SCSCR_RE | SCSCR_TE,
> >> +     .scbrr_algo_id  = SCBRR_ALGO_4,
> >> +};
> >> +
> >> +static struct plat_sci_port sci_drv_data_hwb_2 = {
> >> +     .flags          = UPF_BOOT_AUTOCONF | UPF_IOREMAP,
> >> +     .scscr          = SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
> >> +     .scbrr_algo_id  = SCBRR_ALGO_2,
> >> +};
> >> +
> > While this no doubt works ok for some limited subset of hardware, this
> > has no place in the driver itself. If you want to use a DT binding, then
> > this information needs to be represented there somehow, as well.
> 
> I suppose this boils down to the generic question if we want to have a
> lean .dts file or a lean driver.

I don't think the two are at odds. We already have an abstraction in
place for dealing with this information, and it does need to be
provideded by the platform. Hacking it in to the serial driver is not an
acceptable solution, simply because you happen to be using the device
tree.

If it's really the case that you can use one or two definitions on all of
the boards, then it should be no problem having a tiny .dtsi file with
these definitions that you include in the platform's .dts file.

> If I don't get something wrong, Magnus prefers to use the .data field
> of the struct of_device_id to hide SoC specific parts from the
> external visible bindings, if there is only 1 legal way to setup the
> device. I personally prefer the .data way - but I don't want to be a
> 3rd person joining the discussion. I'd prefer a decision. So please
> Magnus, comment on this issue. I have no problem going either way.
> 
I don't have any strong opinions on how .data gets used, but we will not
be applying anything that adds arbitrary plat_sci_port definitions to the
driver, as that is nothing but lazy and shortsighted.
