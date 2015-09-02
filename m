From: Rob Landley <rob@landley.net>
Date: Wed, 02 Sep 2015 13:36:20 +0000
Subject: [PATCH] common checksum code uses post-sh2 instruction
Message-Id: <55E6FB54.9090800@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Rob Landley <rob@landley.net>

The common checksum code uses shld which sh2 hasn't got, so unwind it.

Note: http://nommu.org/jcore added SHAD and SHLD, and if anybody's
building for an actual sh2 they'll either need gcc 4.7 or earlier or
a fix to https://gcc.gnu.org/bugzilla/show_bug.cgi?idT089 but
when regression testing against the actual historical hardware,
you need this.

Signed-off-by: Rob Landley <rob@landley.net>
---

 arch/sh/lib/checksum.S |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 356c8ec..7f0fc6b 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -88,8 +88,9 @@ ENTRY(csum_partial)
 2:
 	! buf is 4 byte aligned (len could be 0)
 	mov	r5, r1
-	mov	#-5, r0
-	shld	r0, r1
+	shlr2	r1		! mov	#-5, r0
+	shlr2	r1		! shld	r0, r1
+	shlr	r1
 	tst	r1, r1
 	bt/s	4f		! if it's =0, go to 4f
 	 clrt
@@ -288,8 +289,9 @@ DST(	mov.w	r0,@r5		)
 	addc	r0,r7
 2:
 	mov	r6,r2
-	mov	#-5,r0
-	shld	r0,r6
+	shlr2	r6		! mov	#-5, r0
+	shlr2	r6		! shld	r0, r6
+	shlr	r6
 	tst	r6,r6
 	bt/s	2f
 	 clrt
