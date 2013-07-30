From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 02:07:51 +0000
Subject: [PATCH 0/2] sh64: kernel: fix the compiling issue for process_64.c
Message-Id: <51F71FF7.8080104@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

The related 2 patches are for fixing the issue below:

The related errors:

    CC      arch/sh/kernel/process_64.o
  arch/sh/kernel/process_64.c: In function =91copy_thread=92:
  arch/sh/kernel/process_64.c:396:39: error: =91fn=92 undeclared (first use=
 in this function)
  arch/sh/kernel/process_64.c:396:39: note: each undeclared identifier is r=
eported only once for each function it appears in
  arch/sh/kernel/process_64.c:377:30: error: unused variable =91regs=92 [-W=
error=3Dunused-variable]
  cc1: all warnings being treated as errors

--
 arch/sh/kernel/process_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
