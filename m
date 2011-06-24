From: Will Drewry <wad@chromium.org>
Date: Fri, 24 Jun 2011 00:36:52 +0000
Subject: [PATCH v9 13/13] sh: select HAVE_SECCOMP_FILTER
Message-Id: <1308875813-20122-13-git-send-email-wad@chromium.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1308875813-20122-1-git-send-email-wad@chromium.org>
In-Reply-To: <1308875813-20122-1-git-send-email-wad@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, djm@mindrot.org, segoon@openwall.com, kees.cook@canonical.com, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, fweisbec@gmail.com, tglx@linutronix.de, scarybeasts@gmail.com, Will Drewry <wad@chromium.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Add support for CONFIG_SECCOMP_FILTER by selecting HAVE_SECCOMP_FILTER.

v9: rebase on to bccaeafd7c117acee36e90d37c7e05c19be9e7bf

Signed-off-by: Will Drewry <wad@chromium.org>
---
 arch/sh/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f03338c..79f046d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -10,6 +10,7 @@ config SUPERH
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_ATTRS
 	select HAVE_IRQ_WORK
+	select HAVE_SECCOMP_FILTER
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_KERNEL_GZIP
-- 
1.7.0.4

