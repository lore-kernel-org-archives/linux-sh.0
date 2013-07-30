From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 02:15:41 +0000
Subject: [Suggestion] sh64: kernel: about the warning: "unexpected non-allocatable section".
Message-Id: <51F721CD.3010006@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Maintainers:

When I build sh64 with allmodconfig (without "EXTRA_CFLAGS=-W"), it
report the warnings below:

    LD      arch/sh/kernel/cpu/sh5/built-in.o
  WARNING: arch/sh/kernel/cpu/sh5/built-in.o (.cranges): unexpected non-allocatable section.
  Did you forget to use "ax"/"aw" in a .S file?
  Note that for example <linux/init.h> contains
  section definitions for use in .S files.

Can it cause real world issue ?

Welcome any members suggestions or completions.


Thanks.
--
Chen Gang.
