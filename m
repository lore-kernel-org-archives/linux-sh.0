From: Adrian Bunk <bunk@kernel.org>
Date: Mon, 28 Jul 2008 13:06:13 +0000
Subject: sh kexec build error
Message-Id: <20080728130613.GB30612@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huang Ying <ying.huang@intel.com>, Vivek Goyal <vgoyal@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, ebiederm@xmission.com, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 3ab83521378268044a448113c6aa9a9e245f4d2f (kexec jump)
causes the following build error on sh:

<--  snip  -->

...
  CC      kernel/kexec.o
{standard input}: Assembler messages:
{standard input}:1518: Error: offset to unaligned destination
make[2]: *** [kernel/kexec.o] Error 1

<--  snip  -->

If I understand the assembler correctly it fails at
include/asm-sh/kexec.h:59

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

