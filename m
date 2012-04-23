From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 23 Apr 2012 02:48:32 +0000
Subject: [RFC/PATCH] sh: Remove cast of atomic_t in ATOMIC_INIT macro
Message-Id: <1335149312-1564-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

By the update of the trace system (enable CONFIG_TRACING), trace build is not made in SH.
This is macro of trace, and ATOMIC_INIT is used, but becomes the build error with an initialization code.

----
include/trace/events/oom.h:8:13: error: initializer element is not constant
include/trace/events/oom.h:8:13: error: (near initialization for '__tracepoint_oom_score_adj_update')
include/trace/events/oom.h:8:13: error: initializer element is not constant
include/trace/events/oom.h:8:13: error: (near initialization for '__tracepoint_oom_score_adj_update.key')
----

This is caused by that the cast to atomic_t is performed by ATOMIC_INIT of SH.
However, at almost all the architecture, the cast to atomic_t is not performed by ATOMIC_INIT.
When I perform the initialization that is static of the struct, I understand it if the cast to a struct is necessary.
However, it becomes the error when I initialize the struct in the struct.

I show a code following.
-----
typedef struct {
	int counter;
} atomic_t;

struct b
{
	atomic_t data;
};

struct a
{
	struct b x;
};

#define ATOMIC_INIT(i)    ( (atomic_t) { (i) } )
//#define ATOMIC_INIT(i)      { (i) }

static struct a t ={
	((struct b) { .data = ATOMIC_INIT(1)} )
};

static struct b k = { .data = ATOMIC_INIT(1)}
-----

Please teach me how we should correspond this problem.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/atomic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/atomic.h b/arch/sh/include/asm/atomic.h
index 37f2f4a..f4c1c20 100644
--- a/arch/sh/include/asm/atomic.h
+++ b/arch/sh/include/asm/atomic.h
@@ -11,7 +11,7 @@
 #include <linux/types.h>
 #include <asm/cmpxchg.h>
 
-#define ATOMIC_INIT(i)	( (atomic_t) { (i) } )
+#define ATOMIC_INIT(i)	{ (i) }
 
 #define atomic_read(v)		(*(volatile int *)&(v)->counter)
 #define atomic_set(v,i)		((v)->counter = (i))
-- 
1.7.9.1

