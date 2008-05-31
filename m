From: Matthew Wilcox <matthew@wil.cx>
Date: Sat, 31 May 2008 11:13:41 +0000
Subject: Missing memory clobber in ip_fast_csum
Message-Id: <20080531111340.GE28074@parisc-linux.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dhowells@redhat.com, lethal@linux-sh.org, linux-sh@vger.kernel.org, chris@zankel.net
Cc: linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>


Kyle McMartin just tracked down a bug on parisc to a missing "memory"
clobber in the inline assembly implementation of ip_fast_csum.  The FRV,
SH and Xtensa ports are also missing a memory clobber, so I thought it
would be polite to let you know.

The bug manifests as dropped network packets (obviously they have the
wrong checksum).  It started appearing for parisc with GCC 4.3.

The GCC manual says:

 If your assembler instructions access memory in an unpredictable
 fashion, add `memory' to the list of clobbered registers.  This will
 cause GCC to not keep memory values cached in registers across the
 assembler instruction and not optimize stores or loads to that memory.

I see that FRV has a 400 byte memory output which may prevent this
problem from appearing, but SH and Xtensa have nothing to prevent this
bug.  Hope this saves you a few days of debugging.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
