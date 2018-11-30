From: David Hildenbrand <david@redhat.com>
Date: Fri, 30 Nov 2018 17:59:22 +0000
Subject: [PATCH RFCv2 4/4] mm/memory_hotplug: Drop MEMORY_TYPE_UNSPECIFIED
Message-Id: <20181130175922.10425-5-david@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181130175922.10425-1-david@redhat.com>
In-Reply-To: <20181130175922.10425-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-acpi@vger.kernel.org, devel@linuxdriverproject.org, xen-devel@lists.xenproject.org, x86@kernel.org, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Pavel Tatashin <pasha.tatashin@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Banman <andrew.banman@hpe.com>, "mike.travis@hpe.com" <mike.travis@hpe.com>, Oscar Salvador <osalvador@suse.com>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@kernel.org>, =?UTF-8?q?Michal=20Such=C3=A1nek?

We now have proper types for all users, we can drop this one.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Banman <andrew.banman@hpe.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Oscar Salvador <osalvador@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Such=C3=A1nek <msuchanek@suse.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 3 ---
 include/linux/memory.h | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index c5fdca7a3009..a6e524f0ea38 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -388,9 +388,6 @@ static ssize_t type_show(struct device *dev, struct dev=
ice_attribute *attr,
 	ssize_t len =3D 0;
=20
 	switch (mem->type) {
-	case MEMORY_BLOCK_UNSPECIFIED:
-		len =3D sprintf(buf, "unspecified\n");
-		break;
 	case MEMORY_BLOCK_BOOT:
 		len =3D sprintf(buf, "boot\n");
 		break;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index a3a1e9764805..11679622f743 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -50,10 +50,6 @@ int set_memory_block_size_order(unsigned int order);
  *  No memory block is to be created (e.g. device memory). Not exposed to
  *  user space.
  *
- * MEMORY_BLOCK_UNSPECIFIED:
- *  The type of memory block was not further specified when adding the
- *  memory block.
- *
  * MEMORY_BLOCK_BOOT:
  *  This memory block was added during boot by the basic system. No
  *  specific device driver takes care of this memory block. This memory
@@ -103,7 +99,6 @@ int set_memory_block_size_order(unsigned int order);
  */
 enum {
 	MEMORY_BLOCK_NONE =3D 0,
-	MEMORY_BLOCK_UNSPECIFIED,
 	MEMORY_BLOCK_BOOT,
 	MEMORY_BLOCK_DIMM,
 	MEMORY_BLOCK_DIMM_UNREMOVABLE,
--=20
2.17.2
