From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Apr 2014 00:49:57 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <20140424004957.GA5064@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 24, 2014 at 02:18:30AM +0400, Sergei Shtylyov wrote:
> On 04/23/2014 04:22 PM, Magnus Damm wrote:
> 
> [...]
> 
> >>>>>A simple serial port integration prototype that happens to
> >>>>>target Koelsch. Written to propose how to move one step closer
> >>>>>to integrate DT support for serial ports on mach-shmobile.
> 
> >>>>I think you've over-engineering it. I would just switch serial devices to
> >>>>DT in one go, like we do for all other devices.
> 
> >>>I agree about the risk of over-engineering! =)
> 
> >>>At the same time I would like to integrate your serial DT support as soon as
> >>>possible. Order wise I'd like to integrate your serial DT support before
> >>>phasing out legacy board code. We can of course discuss the order, but if we
> >>>first integrate serial DT then we end up with 3 different serial cases
> 
> >>The fact that we even have 3 different cases (DT only, C DT reference and C
> >>legacy) shows that there's a problem. We started with C code that we forked
> >>into C DT reference code instead of porting the C code over to DT, and now we
> >>want to keep using platform devices in the C DT reference code ? Come on...
> 
> >What is the problem? We need to encourage development and also provide
> >a stable base. And from my point of view, you're not even supposed to
> >use the C DT reference code as a developer - you should use DT-only
> >board support for development.
> 
>    I wonder how DT-only support (without C reference code) is
> possible with the current devel branch: only
> board-{lager|koelsch}-reference.c include call to
> of_platform_populate() without which DT probing drivers won't see
> their devices. If we had that call in the setup-r8a779[01].c then I
> would have understood what you mean by DT-only...

I believe Magnus is referring to the case where one boots
without a board file at all. At this stage that case may require
some tweaking to boot.
