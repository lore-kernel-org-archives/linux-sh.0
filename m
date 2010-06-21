From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 21 Jun 2010 04:44:55 +0000
Subject: Re: [uClinux-dev] Userspace command line gcc options troubles
Message-Id: <20100621044455.GD29997@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100617210346.GA422@minime.bse>
In-Reply-To: <20100617210346.GA422@minime.bse>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(Adding superh-gnu-discuss to the Cc..)

On Fri, Jun 18, 2010 at 09:20:13AM +0200, Fabio Giovagnini wrote:
> This is the result (i suppose):
> *asm:
> %(subtarget_asm_endian_spec) %{mrelax:-relax 
> %(subtarget_asm_relax_spec)}%(subtarget_asm_isa_spec) %(subtarget_asm_spec) 
> %{m2a:--isa=sh2a} %{m2a-single:--isa=sh2a} %{m2a-single-only:--isa=sh2a} 
> %{m2a-nofpu:--isa=sh2a-nofpu} %{m5-compact*:--isa=SHcompact} %{m5-32media*:--
> isa=SHmedia --abi2} %{m5-64media*:--isa=SHmedia --abid} %{m4al:-dsp} 
> %{mcut2-workaround:-cut2-workaround}
> 
> Nowhere I can see :
> --fdpic--isa=sh2a
> 
> I think it should be 
> --fdpic --isa=sh2a
> at most (with a blank space in between)
> 
> In data gioved? 17 giugno 2010 23:03:47, Daniel Gl?ckner ha scritto:
> : > On Thu, Jun 17, 2010 at 12:32:56PM +0200, Fabio Giovagnini wrote:
> > > uclinux/bin/as: unrecognized option '--fdpic--isa=sh2a'
> > >
> > > How could I solve?
> > 
> > cd /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/target/
> > ./bin/sh-uclinux-gcc -dumpspecs > lib/gcc/sh-uclinux/4.4.1/specs
> > sed -i 's/subtarget_asm_spec)/& /' lib/gcc/sh-uclinux/4.4.1/specs
