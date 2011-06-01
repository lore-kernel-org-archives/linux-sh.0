From: Will Drewry <wad@chromium.org>
Date: Wed, 01 Jun 2011 03:10:45 +0000
Subject: [PATCH v3 13/13] sh: select HAVE_SECCOMP_FILTER
Message-Id: <1306897845-9393-13-git-send-email-wad@chromium.org>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
In-Reply-To: <BANLkTimNcag-ZmVTXjUoTyiuJm6jtW0DgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kees.cook@canonical.com, torvalds@linux-foundation.org, tglx@linutronix.de, mingo@elte.hu, rostedt@goodmis.org, jmorris@namei.org, Will Drewry <wad@chromium.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Add support for CONFIG_SECCOMP_FILTER by selecting HAVE_SECCOMP_FILTER.
---
 arch/sh/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 4b89da2..41ea3a7 100644
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

