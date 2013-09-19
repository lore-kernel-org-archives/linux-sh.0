From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 19 Sep 2013 12:01:48 +0000
Subject: [PATCH] KVM: ARM: enable Cortex A7 hosts
Message-Id: <1379592108-28584-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kvm@vger.kernel.org
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht@gmail.com>

KVM runs fine on Cortex A7 cores, so they should be enabled. Tested on an
APE6EVM board (r8a73a4 SoC).

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/kvm/guest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 152d036..05c62d5 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -192,6 +192,8 @@ int __attribute_const__ kvm_target_cpu(void)
 	switch (part_number) {
 	case ARM_CPU_PART_CORTEX_A15:
 		return KVM_ARM_TARGET_CORTEX_A15;
+	case ARM_CPU_PART_CORTEX_A7:
+		return KVM_ARM_TARGET_CORTEX_A15;
 	default:
 		return -EINVAL;
 	}
-- 
1.8.3.1

