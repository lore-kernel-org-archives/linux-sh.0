From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 28 Aug 2013 12:08:24 +0000
Subject: Re: [PATCH 04/14] ARM: shmobile: sh73a0: Remove ->init_machine() special case
Message-Id: <1634183.WaD7XDSkzI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130809094748.6530.16511.sendpatchset@w520>
 <1580455.O5Pubhdtgp@avalon>
 <CANqRtoT1a7Ge2dBvNhAFK+Fpv_xC3QE_O-y6MxajwQfnbaVYHA@mail.gmail.com>
In-Reply-To: <CANqRtoT1a7Ge2dBvNhAFK+Fpv_xC3QE_O-y6MxajwQfnbaVYHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

On Wednesday 28 August 2013 15:40:50 Magnus Damm wrote:
> On Fri, Aug 9, 2013 at 7:47 PM, Laurent Pinchart wrote:
> > On Friday 09 August 2013 18:48:32 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> No need to special case sh73a0 ->init_machine(),
> >> so get rid of undesired cpufreq platform device
> >> from the generic long term sh73a0 DT support code.
> >> 
> >> For short term support on KZM9D the DT reference
> >> implementation now adds a "cpufreq-cpu0" platform
> >> device so that can be used for development.
> > 
> > Doesn't this go against the spirit of the -reference platforms that don't
> > use DT devices in board code ? I don't see an urgent need for this, how
> > far along are the DT cpufreq-related bindings ?
> 
> I'm not sure what the latest state of DT cpufreq bindings are. Actually, it
> seems to me that the cpufreq platform device is a software policy that
> shouldn't be described with DT. And to be honest, I can't really see how
> this policy has anything to do with any particular SoC.

I'm no cpufreq expert, but if we need to register the device in C code, I'm 
pretty uneasy with having that code in board files. One of the DT goals is to 
get rid of most board files.

> Regarding MACHINE_START on mach-shmobile I'd like to have 3 levels:
> 
> 1) MACHINE_START in setup-xxxx.c
> 
> This is where we aim to be in the long term. We should be as
> theoretically correct as ever possible here. I'd like to avoid all
> platform devices here. Also, I'd like to avoid short term random
> policy setting here.
> 
> 2) MACHINE_START in board-xxx-reference.c
> 
> This is where we build DT support for the board. In case we don't have
> DT bindings for a certain device then using platform device here is
> acceptable. Other short term workarounds are also acceptable here.
> 
> 3) MACHINE_START in board-xxx.c
> 
> This is the location of the C-based board support. Some SoC-specific
> bits like CPU cores and interrupt controllers may be initialized via
> DT. Otherwise platform devices are used.
> 
> Hope this clarifies my view!

-- 
Regards,

Laurent Pinchart

