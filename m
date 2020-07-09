From: Jia He <justin.he@arm.com>
Date: Thu, 09 Jul 2020 02:06:28 +0000
Subject: [PATCH v3 5/6] device-dax: use fallback nid when numa_node is invalid
Message-Id: <20200709020629.91671-6-justin.he@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200709020629.91671-1-justin.he@arm.com>
In-Reply-To: <20200709020629.91671-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, David Hildenbrand <david@redhat.com>
Cc: Kaly Xin <Kaly.Xin@arm.com>, Michal Hocko <mhocko@suse.com>, Dave Jiang <dave.jiang@intel.com>, Baoquan He <bhe@redhat.com>, linux-sh@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org, Chuhong Yuan <hslester96@gmail.com>, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org, linux-nvdimm@lists.01.org, Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Jia He <justin.he@arm.com>

numa_off is set unconditionally at the end of dummy_numa_init(),
even with a fake numa node. ACPI detects node id as NUMA_NO_NODE(-1) in
acpi_map_pxm_to_node() because it regards numa_off as turning off the numa
node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.

Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT t=
able
isn't present:
$ndctl create-namespace -fe namespace0.0 --mode=DEvdax --map=DEv -s 1g -a 6=
4K
kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with invali=
d node: -1
kmem: probe of dax0.0 failed with error -22

This fixes it by using fallback memory_add_physaddr_to_nid() as nid.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Jia He <justin.he@arm.com>
---
 drivers/dax/kmem.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 275aa5f87399..218f66057994 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -31,22 +31,23 @@ int dev_dax_kmem_probe(struct device *dev)
 	int numa_node;
 	int rc;
=20
+	/* Hotplug starting at the beginning of the next block: */
+	kmem_start =3D ALIGN(res->start, memory_block_size_bytes());
+
 	/*
 	 * Ensure good NUMA information for the persistent memory.
 	 * Without this check, there is a risk that slow memory
 	 * could be mixed in a node with faster memory, causing
-	 * unavoidable performance issues.
+	 * unavoidable performance issues. Furthermore, fallback node
+	 * id can be used when numa_node is invalid.
 	 */
 	numa_node =3D dev_dax->target_node;
 	if (numa_node < 0) {
-		dev_warn(dev, "rejecting DAX region %pR with invalid node: %d\n",
-			 res, numa_node);
-		return -EINVAL;
+		numa_node =3D memory_add_physaddr_to_nid(kmem_start);
+		dev_info(dev, "using nid %d for DAX region with undefined nid %pR\n",
+			numa_node, res);
 	}
=20
-	/* Hotplug starting at the beginning of the next block: */
-	kmem_start =3D ALIGN(res->start, memory_block_size_bytes());
-
 	kmem_size =3D resource_size(res);
 	/* Adjust the size down to compensate for moving up kmem_start: */
 	kmem_size -=3D kmem_start - res->start;
@@ -100,15 +101,19 @@ static int dev_dax_kmem_remove(struct device *dev)
 	resource_size_t kmem_start =3D res->start;
 	resource_size_t kmem_size =3D resource_size(res);
 	const char *res_name =3D res->name;
+	int numa_node =3D dev_dax->target_node;
 	int rc;
=20
+	if (numa_node < 0)
+		numa_node =3D memory_add_physaddr_to_nid(kmem_start);
+
 	/*
 	 * We have one shot for removing memory, if some memory blocks were not
 	 * offline prior to calling this function remove_memory() will fail, and
 	 * there is no way to hotremove this memory until reboot because device
 	 * unbind will succeed even if we return failure.
 	 */
-	rc =3D remove_memory(dev_dax->target_node, kmem_start, kmem_size);
+	rc =3D remove_memory(numa_node, kmem_start, kmem_size);
 	if (rc) {
 		any_hotremove_failed =3D true;
 		dev_err(dev,
--=20
2.17.1
