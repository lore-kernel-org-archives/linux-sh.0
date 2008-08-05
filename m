From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 05 Aug 2008 15:44:29 +0000
Subject: rsk7203_defconfig build error
Message-Id: <20080805154429.GD22895@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Paul,

rsk7203_defconfig fails to build with the following error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/sh/kernel/built-in.o:(__ksymtab+0xb8): undefined reference to `__udivsi3_i4i'
arch/sh/kernel/built-in.o:(__ksymtab+0xc8): undefined reference to `__sdivsi3_i4i'
make[1]: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

That worked with 2.6.26, and these are far less undefined references 
than in the cases where libgcc was missing.

Does it build with your toolchain?
Do you have any clue what's going wrong here?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

