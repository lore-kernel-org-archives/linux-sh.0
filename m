From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 04 Feb 2019 09:10:55 +0000
Subject: [PATCH v2] sh: fix build error for invisible CONFIG_BUILTIN_DTB_SOURCE
Message-Id: <1549271455-19292-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>

I fixed a similar build error in commit 1b1e4ee86e00 ("sh: fix build
error for empty CONFIG_BUILTIN_DTB_SOURCE"), but it came back again.

Since commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb
build rules"), the combination of CONFIG_OF_EARLY_FLATTREE=y and
CONFIG_USE_BUILTIN_DTB=n results in the following build error:

make[1]: *** No rule to make target 'arch/sh/boot/dts/.dtb.o', needed by 'arch/sh/boot/dts/built-in.a'.  Stop.
make: *** [Makefile;1727: arch/sh/boot/dts/] Error 2

Prior to that commit, there was only one path to descend into
arch/sh/boot/dts/, and arch/sh/Makefile correctly guards it with
CONFIG_USE_BUILTIN_DTB:

  core-$(CONFIG_USE_BUILTIN_DTB)  += arch/sh/boot/dts/

Now, there is another path to descend there from the top Makefile
when CONFIG_OF_EARLY_FLATTREE=y. If CONFIG_USE_BUILTIN_DTB is disabled,
CONFIG_BUILTIN_DTB_SOURCE is invisible instead of defined as "".

Add obj-$(CONFIG_USE_BUILTIN_DTB) guard to avoid the attempt to build
the non-existing file.

Fixes: 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Observant reviewers may point out another problem.
There is a race condition when CONFIG_OF_EARLY_FLATTREE=y.

Some architectures (sh, xtensa, etc.) embed a DTB in vmlinux,
so there are two paths to descend into arch/*/boot/dts/.
For parallel build with -j<N> option, two threads may build
under arch/*/boot/dts/ simultaneously.

Yes, this is a problem, and it is in my TODO list.
For some reasons, I will postpone it by the next development cycle.

For now, I want to fix this sh build error first because kbuild test
robot is still complaining about it.


Changes in v2:
  - Change the subject a bit because the cause of the error is different

 arch/sh/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 01d0f7f..2563d1e 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_BUILTIN_DTB_SOURCE),"")
-obj-y += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
+obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 endif
-- 
2.7.4
