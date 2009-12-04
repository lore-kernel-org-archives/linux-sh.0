From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:55 +0000
Subject: [PATCH (sh-2.6.30.y) 13/13] sh: pmb: Fixed resume from hibernation
Message-Id: <1259938375-27499-13-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the '__set_pmb_entry' to have a working
resume from hibernation.

Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
---
 arch/sh/mm/pmb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index d28f040..91293dd 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -102,6 +102,7 @@ static __always_inline void __set_pmb_entry(unsigned long vpn,
 	 */
 	ctrl_outl(vpn, mk_pmb_addr(pos));
 	ctrl_outl(ppn | flags | PMB_V, mk_pmb_data(pos));
+	ctrl_inl(mk_pmb_addr(pos));
 }
 
 static void __uses_jump_to_uncached set_pmb_entry(unsigned long vpn,
-- 
1.6.2.5

