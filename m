From: Rich Felker <dalias@libc.org>
Date: Sun, 16 Aug 2020 17:00:42 +0000
Subject: Re: Ping: Pull Request for 5.9
Message-Id: <20200816170041.GA3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
In-Reply-To: <b9ea23ec-4925-aee6-07a8-571971a42194@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 16, 2020 at 06:38:58PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Geert!
> 
> On 8/16/20 10:34 AM, Geert Uytterhoeven wrote:
> > On Sat, Aug 15, 2020 at 12:41 PM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> >> @Geert: What about that patch to fix the serial interface on LANDISK?
> > 
> > It's a fix for serial parity handling for SCIF, and thus not really needed for
> > a serial console.    No need to worry, as it's already in.
> 
> Great. Then I hope we can work on the device tree stuff in the near future ;-).

Sounds good. I think most of it in principle isn't that bad to rebase,
but I hit lots of breakage a couple years back when I tried making the
PCI code work, and that was a show-stopper since it broke my emulated
environment. Let's look at it again now.

> My hope is that with device tree support in the kernel for SH, it might be easier
> to re-add support for the NextVoD devices of which I have plenty of.

In principle this is true, but there was a lot of out-of-tree stuff in
STlinux that may be needed to support their SoC "platform devices". We
need to find and archive git repos of that if possible, or otherwise
at least the latest releases, to study and determine what's actually
needed.

Rich
