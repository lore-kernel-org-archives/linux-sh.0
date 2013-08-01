From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 01 Aug 2013 05:44:11 +0000
Subject: [PATCH] scripts/mod/modpost.c: permit '.cranges' secton for sh64 architecture.
Message-Id: <51F9F5AB.6030002@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>, James Hogan <james.hogan@imgtec.com>, mmarek@suse.cz, Sam Ravnborg <sam@ravnborg.org>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Need permit '.cranges' section for sh64 architecture, or modpost will
report warning:

    LD      init/built-in.o
  WARNING: init/built-in.o (.cranges): unexpected non-allocatable section.
  Did you forget to use "ax"/"aw" in a .S file?
  Note that for example <linux/init.h> contains
  section definitions for use in .S files.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 scripts/mod/modpost.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6216434..8247979 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -821,6 +821,7 @@ static const char *section_white_list[]  {
 	".comment*",
 	".debug*",
+	".cranges",		/* sh64 */
 	".zdebug*",		/* Compressed debug sections. */
 	".GCC-command-line",	/* mn10300 */
 	".GCC.command.line",	/* record-gcc-switches, non mn10300 */
-- 
1.7.7.6
