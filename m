From: David Howells <dhowells@redhat.com>
Date: Tue, 29 May 2012 17:23:04 +0000
Subject: Has anyone got gcc-4.7.0 to build an SH64 kernel without dying?
Message-Id: <10426.1338312184@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: dhowells@redhat.com, dhorak@redhat.com, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org


Has anyone had any success building a gcc-4.7.0 that can build SH64 binaries
without dying?  I am seeing ICEs and SEGVs:

include/linux/genhd.h:214:3: internal compiler error: Segmentation fault
mm/madvise.c:285:2: internal compiler error: Segmentation fault
mm/percpu.c: In function 'pcpu_free_area':
mm/percpu.c:602:1: error: unrecognizable insn:
(insn 74 73 75 8 (set (reg:SI 279)
        (abs:SI (reg:SI 280))) mm/percpu.c:575 -1
     (nil))
mm/percpu.c:602:1: internal compiler error: in extract_insn, at recog.c:2123

I'm not entirely certain what target triplet I should be using.  I'm currently
using sh64-linux-gnu.  It does build a compiler (and it can find its
binutils).  I've also tried sh64-elf, but that doesn't work either.

David
