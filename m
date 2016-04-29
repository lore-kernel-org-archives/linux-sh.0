From: Rich Felker <dalias@libc.org>
Date: Fri, 29 Apr 2016 16:13:42 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <20160429161342.GD21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 29, 2016 at 11:20:02AM +0200, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Fri, Apr 29, 2016 at 10:56 AM, Rob Landley <rob@landley.net> wrote:
> > On 04/29/2016 01:58 AM, Geert Uytterhoeven wrote:
> >> On Thu, Apr 7, 2016 at 5:01 PM, Rich Felker <dalias@libc.org> wrote:
> >>> --- /dev/null
> >>> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> >>> @@ -0,0 +1,98 @@
> >>> +/dts-v1/;
> >>> +
> >>> +/ {
> >>> +       compatible = "jcore,j2-soc";
> >>> +       model = "J2 FPGA SoC on Mimas v2 board";
> >>> +
> >>> +       #address-cells = <1>;
> >>> +       #size-cells = <1>;
> >>> +
> >>> +       interrupt-parent = <&aic>;
> >>> +
> >>> +       cpus {
> >>> +               #address-cells = <1>;
> >>> +               #size-cells = <0>;
> >>> +
> >>> +               cpu@0 {
> >>> +                       device_type = "cpu";
> >>> +                       compatible = "jcore,j2";
> >>
> >> This brings an interesting question: how do you plan to do IP core versioning?
> >> I.e. which version of the HDL code does "jcore,j2" correspond to?
> >
> > J2 has a stable instruction set based on sh2 plus 2 backported sh3
> > barrel shift instructions and one added cmpxchg instruction. Other than
> > the cmpxchg (which was added last year when we started adding SMP
> > support) it's been stable for a couple years now. We're pondering a run
> > of ASICs, which sets it in stone, and don't expect any instruction set
> > changes between now and then. (That'll probably be our next kickstarter
> > after the turtle boards.)
> 
> OK. So that's your answer for the CPU core.
> 
> What about the other IP cores, e.g. jcore,emac and jcore,spi2?
> The latter already has a "2" suffix?

We went through several rounds of ideas on how to name things, and the
one I'm trying to go with is trying to match, as closely as is
reasonable, the names and numbers used in the jcore source & repo
history. spi2 is the current generation of the spi controller and
there's a spi3 in the works that's dma-based. aic2 is the name that's
been used internally in all development discussion and in the source
for the new interrupt controller that supports a lot more irqs and
does not require configuration of their priorities. etc.

There's always the option to use completely new naming for a new
version of a device, like i486->pentium, etc. I don't think we have to
be completely committed to any particular naming/numbering scheme; we
just have to have names where it's clear what maps to what. And that's
why I opted for following the names from the source -- it's clear to
someone working with both the DT and the hw source what maps to what
(and soon the hw build process is going to be generating DTs from the
hw source, even).

Rich
