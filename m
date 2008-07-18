From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 18 Jul 2008 07:40:10 +0000
Subject: [PATCH 01/05] resource: add resource_size()
Message-Id: <20080718074010.32713.22016.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de, lethal@linux-sh.org, i2c@lm-sensors.org, Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org

From: Magnus Damm <damm@igel.co.jp>

Avoid one-off errors by introducing a resource_size() function.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/linux/ioport.h |    4 ++++
 kernel/resource.c      |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

--- 0001/include/linux/ioport.h
+++ work/include/linux/ioport.h	2008-07-09 12:59:04.000000000 +0900
@@ -113,6 +113,10 @@ extern int allocate_resource(struct reso
 int adjust_resource(struct resource *res, resource_size_t start,
 		    resource_size_t size);
 resource_size_t resource_alignment(struct resource *res);
+static inline resource_size_t resource_size(struct resource *res)
+{
+	return res->end - res->start + 1;
+}
 
 /* Convenience shorthand with allocation */
 #define request_region(start,n,name)	__request_region(&ioport_resource, (start), (n), (name))
--- 0001/kernel/resource.c
+++ work/kernel/resource.c	2008-07-09 12:59:41.000000000 +0900
@@ -490,7 +490,7 @@ resource_size_t resource_alignment(struc
 {
 	switch (res->flags & (IORESOURCE_SIZEALIGN | IORESOURCE_STARTALIGN)) {
 	case IORESOURCE_SIZEALIGN:
-		return res->end - res->start + 1;
+		return resource_size(res);
 	case IORESOURCE_STARTALIGN:
 		return res->start;
 	default:
