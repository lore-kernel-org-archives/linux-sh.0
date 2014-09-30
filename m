From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Sep 2014 06:30:30 +0000
Subject: Re: [PATCH 00/13] ARM: shmobile: dts: Add chosen/stdout-path
Message-Id: <20140930063029.GA30269@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1411661609-4280-1-git-send-email-geert+renesas@glider.be>
 <20140930020755.GC10373@verge.net.au>
In-Reply-To: <20140930020755.GC10373@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 30, 2014 at 11:07:56AM +0900, Simon Horman wrote:
> On Thu, Sep 25, 2014 at 06:13:16PM +0200, Geert Uytterhoeven wrote:
> > 	Hi Simon, Magnus,
> > 
> > This patch series adds chosen/stdout-path to the various shmobile DTS files
> > that are used for reference or multi-platform builds.
> > 
> > This serves two purposes:
> >   1. It makes automatic console selection work in the absence of a "console="
> >      parameter on the kernel command line, allowing to remove "console="
> >      parameters from chosen/bootargs on many platforms.
> >      Note that these "console=" parameters are still needed in some cases:
> >        a. If console output is wanted on two consoles devices (graphical and
> >           serial consoles), like on armadillo and kzm9g,
> >        b. When using a non-default baud for the serial console, like on
> >           henninger and alt,
> >   2. It will allow the PM domain code to find the PM domain for the console
> >      device, to make "no_console_suspend" work in the DT case.
> >      For now, this will matter on armadillo.
> > 
> > The first two patches are small cleanups for emev2 dtsi, on top of which the
> > change for kzm9d is built.
> 
> Thanks, I have queued these up for v3.19.

I spoke a little too soon.

While testing these patches I noticed that the koelsch patch
cases there to be no kernel output to the console (during boot)
when booting using legacy C.

I assume that this is due to removing
console=ttySC6,115200 from bootargs.

I also assume this affects all boards that can still
be booted using legacy C.

I have dropped this series for now.
