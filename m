From: Joe Perches <joe@perches.com>
Date: Fri, 17 Feb 2017 07:11:20 +0000
Subject: [PATCH 07/35] sh: Convert remaining uses of pr_warning to pr_warn
Message-Id: <f9b2916457629d85e9db81593b7ce67a6c66af9c.1487314667.git.joe@perches.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1487314666.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for arch/sh

Prior to this patch, there were 6 uses of pr_warning and
1 use of pr_warn in arch/sh

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sh/boards/mach-sdk7786/nmi.c    | 2 +-
 arch/sh/drivers/pci/fixups-sdk7786.c | 2 +-
 arch/sh/kernel/io_trapped.c          | 2 +-
 arch/sh/kernel/setup.c               | 2 +-
 arch/sh/mm/consistent.c              | 5 ++---
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-sdk7786/nmi.c b/arch/sh/boards/mach-sdk7786/nmi.c
index edcfa1f568ba..7d6a6797ac7f 100644
--- a/arch/sh/boards/mach-sdk7786/nmi.c
+++ b/arch/sh/boards/mach-sdk7786/nmi.c
@@ -40,7 +40,7 @@ static int __init nmi_mode_setup(char *str)
 		nmi_mode = NMI_MODE_ANY;
 	else {
 		nmi_mode = NMI_MODE_UNKNOWN;
-		pr_warning("Unknown NMI mode %s\n", str);
+		pr_warn("Unknown NMI mode %s\n", str);
 	}
 
 	printk("Set NMI mode to %d\n", nmi_mode);
diff --git a/arch/sh/drivers/pci/fixups-sdk7786.c b/arch/sh/drivers/pci/fixups-sdk7786.c
index 36eb6fc3c18a..15ee04fcb2de 100644
--- a/arch/sh/drivers/pci/fixups-sdk7786.c
+++ b/arch/sh/drivers/pci/fixups-sdk7786.c
@@ -56,7 +56,7 @@ static int __init sdk7786_pci_init(void)
 
 		/* Warn about forced rerouting if slot#3 is occupied */
 		if ((data & PCIECR_PRST3) = 0) {
-			pr_warning("Unreachable card detected in slot#3\n");
+			pr_warn("Unreachable card detected in slot#3\n");
 			return -EBUSY;
 		}
 	} else
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 4d4e7a2a774b..1dd3f58b23f0 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -102,7 +102,7 @@ int register_trapped_io(struct trapped_io *tiop)
 
 	return 0;
  bad:
-	pr_warning("unable to install trapped io filter\n");
+	pr_warn("unable to install trapped io filter\n");
 	return -1;
 }
 EXPORT_SYMBOL_GPL(register_trapped_io);
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 3a44c753b642..cd9e18c39d80 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -345,7 +345,7 @@ void __init setup_arch(char **cmdline_p)
 /* processor boot mode configuration */
 int generic_mode_pins(void)
 {
-	pr_warning("generic_mode_pins(): missing mode pin configuration\n");
+	pr_warn("generic_mode_pins(): missing mode pin configuration\n");
 	return 0;
 }
 
diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 92b6976fde59..5c6212e817a5 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -134,8 +134,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	r = pdev->resource + pdev->num_resources - 1;
 	if (r->flags) {
-		pr_warning("%s: unable to find empty space for resource\n",
-			name);
+		pr_warn("%s: unable to find empty space for resource\n", name);
 		return -EINVAL;
 	}
 
@@ -145,7 +144,7 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 
 	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
-		pr_warning("%s: unable to allocate memory\n", name);
+		pr_warn("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-- 
2.10.0.rc2.1.g053435c

