From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Sep 2014 00:30:09 +0000
Subject: Re: [PATCH] ARM: shmobile: lager: Remove legacy C board code
Message-Id: <20140910003005.GA28662@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904023440.26241.39089.sendpatchset@w520>
In-Reply-To: <20140904023440.26241.39089.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 05, 2014 at 12:35:49PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Thu, Sep 4, 2014 at 9:14 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 04, 2014 at 08:38:02PM +0900, Magnus Damm wrote:
> >> Hi Sergei,
> >>
> >> On Thu, Sep 4, 2014 at 8:06 PM, Sergei Shtylyov
> >> <sergei.shtylyov@cogentembedded.com> wrote:
> >> > Hello.
> >> >
> >> > On 9/4/2014 6:34 AM, Magnus Damm wrote:
> >> >
> >> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> >
> >> >
> >> >> The Multiplatform r8a7790 Lager board code is at this point
> >> >> in equally or better state compared to the legacy code.
> >> >
> >> >
> >> >    I think it's a bit premature to say this. For example, USBHS DT support
> >> > hasn't been merged (the .dts[i] part hasn't even been posted yet IIRC).
> >> > The USB PHY DT support also hasn't been merged.
> >>
> >> Thanks for letting us know. It may be a bit early then.
> >
> > At this point my feeling is that its better to wait if there are still
> > features in Legacy-C that haven't made it across to multiplatform yet.
> 
> I agree, waiting must be the best option. Thanks!

A general comment about removing board code:

As suggested by Arnd elsewhere, please also submit a patch to remove
#ifdef CONFIG_USE_OF from the relevant setup-*.c file when you remove
the legacy board code if the setup-*.c will thus always be compiled with
ARCH_MULTIPLATFORM which selects CONFIG_USE_OF.
