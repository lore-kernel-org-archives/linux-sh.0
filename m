From: Rich Felker <dalias@libc.org>
Date: Fri, 29 Apr 2016 20:44:35 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <20160429204435.GE21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 29, 2016 at 10:10:40PM +0200, Geert Uytterhoeven wrote:
> > Other than that, what to do about version details for the sake of
> > working around small bugs? It's complicated by the possibility that a
> > bug might even be caused by the bitstream generation for a particular
> > FPGA/board, not the source, so a source version might not even
> > suffice. My leaning for FPGA builds is just to put detailed soc-wide
> > board-target and version information in the top-level DT node (note:
> > once the DT bindings are official, DTB will be included in the boot
> > rom in the FPGA bitream) with the expectation that it's unlikely to be
> > used, but useful to have for bug reporting, etc., and that if you have
> > a buggy build, you should just fix/upgrade it rather than trying to
> > work around it on the kernel side. For future ASICs, OTOH, we should
> > probably coordinate having production-run-specific information in the
> > DT bindings in case there are bugs to be worked around.
> 
> Hmm, I never considered the bitstream generation making a difference,

Supposedly Xilinx's tools are even nondeterministic if you run them in
multithreaded mode. I have not checked this, but given how awful ISE
is, I wouldn't be surprised if it's true.

In any case, certainly the version of the tools you use could make a
difference, just like the version of gcc/binutils you use makes a
difference to your output binaries for software.

> so e.g. having the git SHA1 ID for a component in a read-only hardware
> registers is no longer sufficient to uniquely identify it.

Indeed. I think you'd need to do something like sha1 the FPGA
configuration flash contents at runtime, or have a way of patching in
the hash to the bitstream after it's generated but before it's written
to flash.

> > Does this approach make sense? If so, it might make sense to write up
> > the ideas/rational as a proposal for inclusion in the DT docs, for
> > future soft-core projects to use as guidelines.
> 
> Yes it does.

Great. I don't think I'll get around to that step right away but it's
good to have planned.

Rich
