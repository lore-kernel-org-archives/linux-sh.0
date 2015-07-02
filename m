From: Joseph Myers <joseph@codesourcery.com>
Date: Thu, 02 Jul 2015 15:53:23 +0000
Subject: [PATCH 6/8] sh/math-emu: Move sh from math-emu-old to math-emu
Message-Id: <alpine.DEB.2.10.1507021552170.29415@digraph.polyomino.org.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au

From: Joseph Myers <joseph@codesourcery.com>

This patch moves sh from math-emu-old to math-emu, updating it for
the API changes.

The following cleanups or bug fixes (that might change how the
emulation behaves, or that go beyond mechanical conversion to new
APIs) are included in this patch because of their close connection to
the API changes:

* SH now uses after-rounding tininess detection.

* On SH, fused multiply-add operations now use the new soft-fp fma
  support (meaning they are properly fused rather than only having 3
  extra bits precision on the intermediate result of the
  multiplication).

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index d3c5484..01e05fe 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -37,6 +37,13 @@
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
   _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)				\
+  _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)				\
+  _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
+  _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
@@ -49,6 +56,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /*
  * If one NaN is signaling and the other is not,
@@ -80,5 +88,7 @@
 #define FP_EX_UNDERFLOW		(1<<1)
 #define FP_EX_INEXACT		(1<<0)
 
+#define _FP_TININESS_AFTER_ROUNDING 1
+
 #endif
 
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index 0cd5ec3..5975df5 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -19,9 +19,9 @@
 #include <asm/io.h>
 
 #include "sfp-util.h"
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/single.h>
-#include <math-emu-old/double.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
+#include <math-emu/double.h>
 
 #define	FPUL		(fregs->fpul)
 #define FPSCR		(fregs->fpscr)
@@ -55,11 +55,26 @@
 #define READ(d,a)	({if(get_user(d, (typeof (d)*)a)) return -EFAULT;})
 
 #define PACK_S(r,f)	FP_PACK_SP(&r,f)
+#define PACK_SEMIRAW_S(r,f)	FP_PACK_SEMIRAW_SP(&r,f)
+#define PACK_RAW_S(r,f)	FP_PACK_RAW_SP(&r,f)
 #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
+#define UNPACK_SEMIRAW_S(f,r)	FP_UNPACK_SEMIRAW_SP(f,&r)
+#define UNPACK_RAW_S(f,r)	FP_UNPACK_RAW_SP(f,&r)
 #define PACK_D(r,f) \
 	{u32 t[2]; FP_PACK_DP(t,f); ((u32*)&r)[0]=t[1]; ((u32*)&r)[1]=t[0];}
+#define PACK_SEMIRAW_D(r,f) \
+	{u32 t[2]; FP_PACK_SEMIRAW_DP(t,f); ((u32*)&r)[0]=t[1]; \
+		((u32*)&r)[1]=t[0];}
+#define PACK_RAW_D(r,f) \
+	{u32 t[2]; FP_PACK_RAW_DP(t,f); ((u32*)&r)[0]=t[1]; ((u32*)&r)[1]=t[0];}
 #define UNPACK_D(f,r) \
 	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; FP_UNPACK_DP(f,t);}
+#define UNPACK_SEMIRAW_D(f,r) \
+	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; \
+		FP_UNPACK_SEMIRAW_DP(f,t);}
+#define UNPACK_RAW_D(f,r) \
+	{u32 t[2]; t[0]=((u32*)&r)[1]; t[1]=((u32*)&r)[0]; \
+		FP_UNPACK_RAW_DP(f,t);}
 
 // 2 args instructions.
 #define BOTH_PRmn(op,x) \
@@ -68,11 +83,11 @@
 #define CMP_X(SZ,R,M,N) do{ \
 	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
 	UNPACK_##SZ(Fm, M); UNPACK_##SZ(Fn, N); \
-	FP_CMP_##SZ(R, Fn, Fm, 2); }while(0)
+	FP_CMP_##SZ(R, Fn, Fm, 2, 0); }while(0)
 #define EQ_X(SZ,R,M,N) do{ \
 	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); \
 	UNPACK_##SZ(Fm, M); UNPACK_##SZ(Fn, N); \
-	FP_CMP_EQ_##SZ(R, Fn, Fm); }while(0)
+	FP_CMP_EQ_##SZ(R, Fn, Fm, 0); }while(0)
 #define CMP(OP) ({ int r; BOTH_PRmn(OP##_X,r); r; })
 
 static int
@@ -102,17 +117,23 @@ fcmp_eq(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 	FP_##OP##_##SZ(Fr, Fn, Fm); \
 	PACK_##SZ(N, Fr); }while(0)
 
+#define ARITH_SEMIRAW_X(SZ,OP,M,N) do{ \
+	FP_DECL_##SZ(Fm); FP_DECL_##SZ(Fn); FP_DECL_##SZ(Fr); \
+	UNPACK_SEMIRAW_##SZ(Fm, M); UNPACK_SEMIRAW_##SZ(Fn, N); \
+	FP_##OP##_##SZ(Fr, Fn, Fm); \
+	PACK_SEMIRAW_##SZ(N, Fr); }while(0)
+
 static int
 fadd(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
-	BOTH_PRmn(ARITH_X, ADD);
+	BOTH_PRmn(ARITH_SEMIRAW_X, ADD);
 	return 0;
 }
 
 static int
 fsub(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
-	BOTH_PRmn(ARITH_X, SUB);
+	BOTH_PRmn(ARITH_SEMIRAW_X, SUB);
 	return 0;
 }
 
@@ -135,15 +156,13 @@ fmac(struct sh_fpu_soft_struct *fregs, struct pt_regs *regs, int m, int n)
 {
 	FP_DECL_EX;
 	FP_DECL_S(Fr);
-	FP_DECL_S(Ft);
 	FP_DECL_S(F0);
 	FP_DECL_S(Fm);
 	FP_DECL_S(Fn);
 	UNPACK_S(F0, FR0);
 	UNPACK_S(Fm, FRm);
 	UNPACK_S(Fn, FRn);
-	FP_MUL_S(Ft, Fm, F0);
-	FP_ADD_S(Fr, Fn, Ft);
+	FP_FMA_S(Fr, Fm, F0, Fn);
 	PACK_S(FRn, Fr);
 	return 0;
 }
@@ -284,8 +303,8 @@ NOTYETn(fsrra)
 
 #define EMU_FLOAT_X(SZ,N) do { \
 	FP_DECL_##SZ(Fn); \
-	FP_FROM_INT_##SZ(Fn, FPUL, 32, int); \
-	PACK_##SZ(N, Fn); }while(0)
+	FP_FROM_INT_##SZ(Fn, FPUL, 32, unsigned int); \
+	PACK_RAW_##SZ(N, Fn); }while(0)
 static int ffloat(struct sh_fpu_soft_struct *fregs, int n)
 {
 	FP_DECL_EX;
@@ -300,7 +319,7 @@ static int ffloat(struct sh_fpu_soft_struct *fregs, int n)
 
 #define EMU_FTRC_X(SZ,N) do { \
 	FP_DECL_##SZ(Fn); \
-	UNPACK_##SZ(Fn, N); \
+	UNPACK_RAW_##SZ(Fn, N); \
 	FP_TO_INT_##SZ(FPUL, Fn, 32, 1); }while(0)
 static int ftrc(struct sh_fpu_soft_struct *fregs, int n)
 {
@@ -319,9 +338,9 @@ static int fcnvsd(struct sh_fpu_soft_struct *fregs, int n)
 	FP_DECL_EX;
 	FP_DECL_S(Fn);
 	FP_DECL_D(Fr);
-	UNPACK_S(Fn, FPUL);
-	FP_CONV(D, S, 2, 1, Fr, Fn);
-	PACK_D(DRn, Fr);
+	UNPACK_RAW_S(Fn, FPUL);
+	FP_EXTEND(D, S, 2, 1, Fr, Fn);
+	PACK_RAW_D(DRn, Fr);
 	return 0;
 }
 
@@ -330,9 +349,9 @@ static int fcnvds(struct sh_fpu_soft_struct *fregs, int n)
 	FP_DECL_EX;
 	FP_DECL_D(Fn);
 	FP_DECL_S(Fr);
-	UNPACK_D(Fn, DRn);
-	FP_CONV(S, D, 1, 2, Fr, Fn);
-	PACK_S(FPUL, Fr);
+	UNPACK_SEMIRAW_D(Fn, DRn);
+	FP_TRUNC(S, D, 1, 2, Fr, Fn);
+	PACK_SEMIRAW_S(FPUL, Fr);
 	return 0;
 }
 


-- 
Joseph S. Myers
joseph@codesourcery.com
