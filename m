From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Wed, 04 Jun 2014 09:07:51 +0000
Subject: [PATCH 1/10] sh: use safer test on the result of find_first_zero_bit
Message-Id: <1401872880-23685-2-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1401872880-23685-1-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Find_first_zero_bit considers BITS_PER_LONG bits at a time, and thus may
return a larger number than the maximum position argument if that position
is not a multiple of BITS_PER_LONG.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e1,e2,e3;
statement S1,S2;
@@

e1 = find_first_zero_bit(e2,e3)
...
if (e1 
- =
+ >  e3)
S1 else S2
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/sh/kernel/perf_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -281,7 +281,7 @@ static int sh_pmu_add(struct perf_event
 
 	if (__test_and_set_bit(idx, cpuc->used_mask)) {
 		idx = find_first_zero_bit(cpuc->used_mask, sh_pmu->num_events);
-		if (idx = sh_pmu->num_events)
+		if (idx >= sh_pmu->num_events)
 			goto out;
 
 		__set_bit(idx, cpuc->used_mask);

