From: Matthew Wilcox <willy@infradead.org>
Date: Wed, 17 Jan 2018 20:20:29 +0000
Subject: [PATCH v6 05/99] xarray: Add definition of struct xarray
Message-Id: <20180117202203.19756-6-willy@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180117202203.19756-1-willy@infradead.org>
In-Reply-To: <20180117202203.19756-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-nilfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, linux-sh@vger.kernel.org, intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-btrfs@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

This is a direct replacement for struct radix_tree_root.  Some of the
struct members have changed name; convert those, and use a #define so
that radix_tree users continue to work without change.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/radix-tree.h               | 33 ++++----------
 include/linux/xarray.h                   | 59 +++++++++++++++++++++++++
 lib/Makefile                             |  2 +-
 lib/idr.c                                |  4 +-
 lib/radix-tree.c                         | 75 ++++++++++++++++------------=
----
 lib/xarray.c                             | 42 ++++++++++++++++++
 tools/include/linux/spinlock.h           |  1 +
 tools/testing/radix-tree/.gitignore      |  1 +
 tools/testing/radix-tree/Makefile        |  8 +++-
 tools/testing/radix-tree/linux/bug.h     |  1 +
 tools/testing/radix-tree/linux/kconfig.h |  1 +
 tools/testing/radix-tree/linux/xarray.h  |  2 +
 tools/testing/radix-tree/multiorder.c    |  6 +--
 tools/testing/radix-tree/test.c          |  6 +--
 14 files changed, 168 insertions(+), 73 deletions(-)
 create mode 100644 lib/xarray.c
 create mode 100644 tools/testing/radix-tree/linux/kconfig.h
 create mode 100644 tools/testing/radix-tree/linux/xarray.h

diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index 87f35fe00e55..c8a33e9e9a3c 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -30,6 +30,9 @@
 #include <linux/types.h>
 #include <linux/xarray.h>
=20
+/* Keep unconverted code working */
+#define radix_tree_root		xarray
+
 /*
  * The bottom two bits of the slot determine how the remaining bits in the
  * slot are interpreted:
@@ -59,10 +62,7 @@ static inline bool radix_tree_is_internal_node(void *ptr)
=20
 #define RADIX_TREE_MAX_TAGS 3
=20
-#ifndef RADIX_TREE_MAP_SHIFT
-#define RADIX_TREE_MAP_SHIFT	(CONFIG_BASE_SMALL ? 4 : 6)
-#endif
-
+#define RADIX_TREE_MAP_SHIFT	XA_CHUNK_SHIFT
 #define RADIX_TREE_MAP_SIZE	(1UL << RADIX_TREE_MAP_SHIFT)
 #define RADIX_TREE_MAP_MASK	(RADIX_TREE_MAP_SIZE-1)
=20
@@ -95,36 +95,21 @@ struct radix_tree_node {
 	unsigned long	tags[RADIX_TREE_MAX_TAGS][RADIX_TREE_TAG_LONGS];
 };
=20
-/* The IDR tag is stored in the low bits of the GFP flags */
+/* The IDR tag is stored in the low bits of xa_flags */
 #define ROOT_IS_IDR	((__force gfp_t)4)
-/* The top bits of gfp_mask are used to store the root tags */
+/* The top bits of xa_flags are used to store the root tags */
 #define ROOT_TAG_SHIFT	(__GFP_BITS_SHIFT)
=20
-struct radix_tree_root {
-	spinlock_t		xa_lock;
-	gfp_t			gfp_mask;
-	struct radix_tree_node	__rcu *rnode;
-};
-
-#define RADIX_TREE_INIT(name, mask)	{				\
-	.xa_lock =3D __SPIN_LOCK_UNLOCKED(name.xa_lock),			\
-	.gfp_mask =3D (mask),						\
-	.rnode =3D NULL,							\
-}
+#define RADIX_TREE_INIT(name, mask)	XARRAY_INIT_FLAGS(name, mask)
=20
 #define RADIX_TREE(name, mask) \
 	struct radix_tree_root name =3D RADIX_TREE_INIT(name, mask)
=20
-#define INIT_RADIX_TREE(root, mask)					\
-do {									\
-	spin_lock_init(&(root)->xa_lock);				\
-	(root)->gfp_mask =3D (mask);					\
-	(root)->rnode =3D NULL;						\
-} while (0)
+#define INIT_RADIX_TREE(root, mask) xa_init_flags(root, mask)
=20
 static inline bool radix_tree_empty(const struct radix_tree_root *root)
 {
-	return root->rnode =3D NULL;
+	return root->xa_head =3D NULL;
 }
=20
 /**
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index c308152fde7f..3d2f1fafb7ec 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -10,6 +10,8 @@
  */
=20
 #include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/kconfig.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
=20
@@ -99,6 +101,63 @@ static inline bool xa_is_internal(const void *entry)
 	return ((unsigned long)entry & 3) =3D 2;
 }
=20
+/**
+ * struct xarray - The anchor of the XArray.
+ * @xa_lock: Lock that protects the contents of the XArray.
+ *
+ * To use the xarray, define it statically or embed it in your data struct=
ure.
+ * It is a very small data structure, so it does not usually make sense to
+ * allocate it separately and keep a pointer to it in your data structure.
+ *
+ * You may use the xa_lock to protect your own data structures as well.
+ */
+/*
+ * If all of the entries in the array are NULL, @xa_head is a NULL pointer.
+ * If the only non-NULL entry in the array is at index 0, @xa_head is that
+ * entry.  If any other entry in the array is non-NULL, @xa_head points
+ * to an @xa_node.
+ */
+struct xarray {
+	spinlock_t	xa_lock;
+/* private: The rest of the data structure is not to be used directly. */
+	gfp_t		xa_flags;
+	void __rcu *	xa_head;
+};
+
+#define XARRAY_INIT_FLAGS(name, flags) {			\
+	.xa_lock =3D __SPIN_LOCK_UNLOCKED(name.xa_lock),		\
+	.xa_flags =3D flags,					\
+	.xa_head =3D NULL,					\
+}
+
+#define XARRAY_INIT(name) XARRAY_INIT_FLAGS(name, 0)
+
+/**
+ * DEFINE_XARRAY() - Define an XArray
+ * @name: A string that names your XArray
+ *
+ * This is intended for file scope definitions of XArrays.  It declares
+ * and initialises an empty XArray with the chosen name.  It is equivalent
+ * to calling xa_init() on the array, but it does the initialisation at
+ * compiletime instead of runtime.
+ */
+#define DEFINE_XARRAY(name) struct xarray name =3D XARRAY_INIT(name)
+#define DEFINE_XARRAY_FLAGS(name, flags) \
+			struct xarray name =3D XARRAY_INIT_FLAGS(name, flags)
+
+void xa_init_flags(struct xarray *, gfp_t flags);
+
+/**
+ * xa_init() - Initialise an empty XArray.
+ * @xa: XArray.
+ *
+ * An empty XArray is full of NULL entries.
+ */
+static inline void xa_init(struct xarray *xa)
+{
+	xa_init_flags(xa, 0);
+}
+
 #define xa_trylock(xa)		spin_trylock(&(xa)->xa_lock)
 #define xa_lock(xa)		spin_lock(&(xa)->xa_lock)
 #define xa_unlock(xa)		spin_unlock(&(xa)->xa_lock)
diff --git a/lib/Makefile b/lib/Makefile
index d11c48ec8ffd..6aa523acc7c1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -18,7 +18,7 @@ KCOV_INSTRUMENT_debugobjects.o :=3D n
 KCOV_INSTRUMENT_dynamic_debug.o :=3D n
=20
 lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
-	 rbtree.o radix-tree.o dump_stack.o timerqueue.o\
+	 rbtree.o radix-tree.o dump_stack.o timerqueue.o xarray.o \
 	 idr.o int_sqrt.o extable.o \
 	 sha1.o chacha20.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
diff --git a/lib/idr.c b/lib/idr.c
index 48c53890adc0..b9aa08e198a2 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -35,8 +35,8 @@ int idr_alloc_ul(struct idr *idr, void *ptr, unsigned lon=
g *nextid,
 	if (WARN_ON_ONCE(radix_tree_is_internal_node(ptr)))
 		return -EINVAL;
=20
-	if (WARN_ON_ONCE(!(idr->idr_rt.gfp_mask & ROOT_IS_IDR)))
-		idr->idr_rt.gfp_mask |=3D IDR_RT_MARKER;
+	if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
+		idr->idr_rt.xa_flags |=3D IDR_RT_MARKER;
=20
 	radix_tree_iter_init(&iter, *nextid);
 	slot =3D idr_get_free(&idr->idr_rt, &iter, gfp, max);
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index f16f63d15edc..126eeb06cfef 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -123,7 +123,7 @@ static unsigned int radix_tree_descend(const struct rad=
ix_tree_node *parent,
=20
 static inline gfp_t root_gfp_mask(const struct radix_tree_root *root)
 {
-	return root->gfp_mask & ((__GFP_BITS_MASK >> 4) << 4);
+	return root->xa_flags & ((__GFP_BITS_MASK >> 4) << 4);
 }
=20
 static inline void tag_set(struct radix_tree_node *node, unsigned int tag,
@@ -146,32 +146,32 @@ static inline int tag_get(const struct radix_tree_nod=
e *node, unsigned int tag,
=20
 static inline void root_tag_set(struct radix_tree_root *root, unsigned tag)
 {
-	root->gfp_mask |=3D (__force gfp_t)(1 << (tag + ROOT_TAG_SHIFT));
+	root->xa_flags |=3D (__force gfp_t)(1 << (tag + ROOT_TAG_SHIFT));
 }
=20
 static inline void root_tag_clear(struct radix_tree_root *root, unsigned t=
ag)
 {
-	root->gfp_mask &=3D (__force gfp_t)~(1 << (tag + ROOT_TAG_SHIFT));
+	root->xa_flags &=3D (__force gfp_t)~(1 << (tag + ROOT_TAG_SHIFT));
 }
=20
 static inline void root_tag_clear_all(struct radix_tree_root *root)
 {
-	root->gfp_mask &=3D (1 << ROOT_TAG_SHIFT) - 1;
+	root->xa_flags &=3D (__force gfp_t)((1 << ROOT_TAG_SHIFT) - 1);
 }
=20
 static inline int root_tag_get(const struct radix_tree_root *root, unsigne=
d tag)
 {
-	return (__force int)root->gfp_mask & (1 << (tag + ROOT_TAG_SHIFT));
+	return (__force int)root->xa_flags & (1 << (tag + ROOT_TAG_SHIFT));
 }
=20
 static inline unsigned root_tags_get(const struct radix_tree_root *root)
 {
-	return (__force unsigned)root->gfp_mask >> ROOT_TAG_SHIFT;
+	return (__force unsigned)root->xa_flags >> ROOT_TAG_SHIFT;
 }
=20
 static inline bool is_idr(const struct radix_tree_root *root)
 {
-	return !!(root->gfp_mask & ROOT_IS_IDR);
+	return !!(root->xa_flags & ROOT_IS_IDR);
 }
=20
 /*
@@ -290,12 +290,12 @@ static void dump_node(struct radix_tree_node *node, u=
nsigned long index)
 /* For debug */
 static void radix_tree_dump(struct radix_tree_root *root)
 {
-	pr_debug("radix root: %p rnode %p tags %x\n",
-			root, root->rnode,
-			root->gfp_mask >> ROOT_TAG_SHIFT);
-	if (!radix_tree_is_internal_node(root->rnode))
+	pr_debug("radix root: %p xa_head %p tags %x\n",
+			root, root->xa_head,
+			root->xa_flags >> ROOT_TAG_SHIFT);
+	if (!radix_tree_is_internal_node(root->xa_head))
 		return;
-	dump_node(entry_to_node(root->rnode), 0);
+	dump_node(entry_to_node(root->xa_head), 0);
 }
=20
 static void dump_ida_node(void *entry, unsigned long index)
@@ -339,9 +339,9 @@ static void dump_ida_node(void *entry, unsigned long in=
dex)
 static void ida_dump(struct ida *ida)
 {
 	struct radix_tree_root *root =3D &ida->ida_rt;
-	pr_debug("ida: %p node %p free %d\n", ida, root->rnode,
-				root->gfp_mask >> ROOT_TAG_SHIFT);
-	dump_ida_node(root->rnode, 0);
+	pr_debug("ida: %p node %p free %d\n", ida, root->xa_head,
+				root->xa_flags >> ROOT_TAG_SHIFT);
+	dump_ida_node(root->xa_head, 0);
 }
 #endif
=20
@@ -575,7 +575,7 @@ int radix_tree_maybe_preload_order(gfp_t gfp_mask, int =
order)
 static unsigned radix_tree_load_root(const struct radix_tree_root *root,
 		struct radix_tree_node **nodep, unsigned long *maxindex)
 {
-	struct radix_tree_node *node =3D rcu_dereference_raw(root->rnode);
+	struct radix_tree_node *node =3D rcu_dereference_raw(root->xa_head);
=20
 	*nodep =3D node;
=20
@@ -604,7 +604,7 @@ static int radix_tree_extend(struct radix_tree_root *ro=
ot, gfp_t gfp,
 	while (index > shift_maxindex(maxshift))
 		maxshift +=3D RADIX_TREE_MAP_SHIFT;
=20
-	entry =3D rcu_dereference_raw(root->rnode);
+	entry =3D rcu_dereference_raw(root->xa_head);
 	if (!entry && (!is_idr(root) || root_tag_get(root, IDR_FREE)))
 		goto out;
=20
@@ -632,7 +632,7 @@ static int radix_tree_extend(struct radix_tree_root *ro=
ot, gfp_t gfp,
 		if (radix_tree_is_internal_node(entry)) {
 			entry_to_node(entry)->parent =3D node;
 		} else if (xa_is_value(entry)) {
-			/* Moving an exceptional root->rnode to a node */
+			/* Moving an exceptional root->xa_head to a node */
 			node->exceptional =3D 1;
 		}
 		/*
@@ -641,7 +641,7 @@ static int radix_tree_extend(struct radix_tree_root *ro=
ot, gfp_t gfp,
 		 */
 		node->slots[0] =3D (void __rcu *)entry;
 		entry =3D node_to_entry(node);
-		rcu_assign_pointer(root->rnode, entry);
+		rcu_assign_pointer(root->xa_head, entry);
 		shift +=3D RADIX_TREE_MAP_SHIFT;
 	} while (shift <=3D maxshift);
 out:
@@ -658,7 +658,7 @@ static inline bool radix_tree_shrink(struct radix_tree_=
root *root,
 	bool shrunk =3D false;
=20
 	for (;;) {
-		struct radix_tree_node *node =3D rcu_dereference_raw(root->rnode);
+		struct radix_tree_node *node =3D rcu_dereference_raw(root->xa_head);
 		struct radix_tree_node *child;
=20
 		if (!radix_tree_is_internal_node(node))
@@ -686,9 +686,9 @@ static inline bool radix_tree_shrink(struct radix_tree_=
root *root,
 		 * moving the node from one part of the tree to another: if it
 		 * was safe to dereference the old pointer to it
 		 * (node->slots[0]), it will be safe to dereference the new
-		 * one (root->rnode) as far as dependent read barriers go.
+		 * one (root->xa_head) as far as dependent read barriers go.
 		 */
-		root->rnode =3D (void __rcu *)child;
+		root->xa_head =3D (void __rcu *)child;
 		if (is_idr(root) && !tag_get(node, IDR_FREE, 0))
 			root_tag_clear(root, IDR_FREE);
=20
@@ -736,9 +736,8 @@ static bool delete_node(struct radix_tree_root *root,
=20
 		if (node->count) {
 			if (node_to_entry(node) =3D
-					rcu_dereference_raw(root->rnode))
-				deleted |=3D radix_tree_shrink(root,
-								update_node);
+					rcu_dereference_raw(root->xa_head))
+				deleted |=3D radix_tree_shrink(root, update_node);
 			return deleted;
 		}
=20
@@ -753,7 +752,7 @@ static bool delete_node(struct radix_tree_root *root,
 			 */
 			if (!is_idr(root))
 				root_tag_clear_all(root);
-			root->rnode =3D NULL;
+			root->xa_head =3D NULL;
 		}
=20
 		WARN_ON_ONCE(!list_empty(&node->private_list));
@@ -778,7 +777,7 @@ static bool delete_node(struct radix_tree_root *root,
  *	at position @index in the radix tree @root.
  *
  *	Until there is more than one item in the tree, no nodes are
- *	allocated and @root->rnode is used as a direct slot instead of
+ *	allocated and @root->xa_head is used as a direct slot instead of
  *	pointing to a node, in which case *@nodep will be NULL.
  *
  *	Returns -ENOMEM, or 0 for success.
@@ -788,7 +787,7 @@ int __radix_tree_create(struct radix_tree_root *root, u=
nsigned long index,
 			void __rcu ***slotp)
 {
 	struct radix_tree_node *node =3D NULL, *child;
-	void __rcu **slot =3D (void __rcu **)&root->rnode;
+	void __rcu **slot =3D (void __rcu **)&root->xa_head;
 	unsigned long maxindex;
 	unsigned int shift, offset =3D 0;
 	unsigned long max =3D index | ((1UL << order) - 1);
@@ -804,7 +803,7 @@ int __radix_tree_create(struct radix_tree_root *root, u=
nsigned long index,
 		if (error < 0)
 			return error;
 		shift =3D error;
-		child =3D rcu_dereference_raw(root->rnode);
+		child =3D rcu_dereference_raw(root->xa_head);
 	}
=20
 	while (shift > order) {
@@ -995,7 +994,7 @@ EXPORT_SYMBOL(__radix_tree_insert);
  *	tree @root.
  *
  *	Until there is more than one item in the tree, no nodes are
- *	allocated and @root->rnode is used as a direct slot instead of
+ *	allocated and @root->xa_head is used as a direct slot instead of
  *	pointing to a node, in which case *@nodep will be NULL.
  */
 void *__radix_tree_lookup(const struct radix_tree_root *root,
@@ -1008,7 +1007,7 @@ void *__radix_tree_lookup(const struct radix_tree_roo=
t *root,
=20
  restart:
 	parent =3D NULL;
-	slot =3D (void __rcu **)&root->rnode;
+	slot =3D (void __rcu **)&root->xa_head;
 	radix_tree_load_root(root, &node, &maxindex);
 	if (index > maxindex)
 		return NULL;
@@ -1160,9 +1159,9 @@ void __radix_tree_replace(struct radix_tree_root *roo=
t,
 	/*
 	 * This function supports replacing exceptional entries and
 	 * deleting entries, but that needs accounting against the
-	 * node unless the slot is root->rnode.
+	 * node unless the slot is root->xa_head.
 	 */
-	WARN_ON_ONCE(!node && (slot !=3D (void __rcu **)&root->rnode) &&
+	WARN_ON_ONCE(!node && (slot !=3D (void __rcu **)&root->xa_head) &&
 			(count || exceptional));
 	replace_slot(slot, item, node, count, exceptional);
=20
@@ -1714,7 +1713,7 @@ void __rcu **radix_tree_next_chunk(const struct radix=
_tree_root *root,
 		iter->tags =3D 1;
 		iter->node =3D NULL;
 		__set_iter_shift(iter, 0);
-		return (void __rcu **)&root->rnode;
+		return (void __rcu **)&root->xa_head;
 	}
=20
 	do {
@@ -2108,7 +2107,7 @@ void __rcu **idr_get_free(struct radix_tree_root *roo=
t,
 			      unsigned long max)
 {
 	struct radix_tree_node *node =3D NULL, *child;
-	void __rcu **slot =3D (void __rcu **)&root->rnode;
+	void __rcu **slot =3D (void __rcu **)&root->xa_head;
 	unsigned long maxindex, start =3D iter->next_index;
 	unsigned int shift, offset =3D 0;
=20
@@ -2124,7 +2123,7 @@ void __rcu **idr_get_free(struct radix_tree_root *roo=
t,
 		if (error < 0)
 			return ERR_PTR(error);
 		shift =3D error;
-		child =3D rcu_dereference_raw(root->rnode);
+		child =3D rcu_dereference_raw(root->xa_head);
 	}
=20
 	while (shift) {
@@ -2187,10 +2186,10 @@ void __rcu **idr_get_free(struct radix_tree_root *r=
oot,
  */
 void idr_destroy(struct idr *idr)
 {
-	struct radix_tree_node *node =3D rcu_dereference_raw(idr->idr_rt.rnode);
+	struct radix_tree_node *node =3D rcu_dereference_raw(idr->idr_rt.xa_head);
 	if (radix_tree_is_internal_node(node))
 		radix_tree_free_nodes(node);
-	idr->idr_rt.rnode =3D NULL;
+	idr->idr_rt.xa_head =3D NULL;
 	root_tag_set(&idr->idr_rt, IDR_FREE);
 }
 EXPORT_SYMBOL(idr_destroy);
diff --git a/lib/xarray.c b/lib/xarray.c
new file mode 100644
index 000000000000..c56b0f858e10
--- /dev/null
+++ b/lib/xarray.c
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * XArray implementation
+ * Copyright (c) 2017 Microsoft Corporation
+ * Author: Matthew Wilcox <mawilcox@microsoft.com>
+ */
+
+#include <linux/export.h>
+#include <linux/xarray.h>
+
+/*
+ * Coding conventions in this file:
+ *
+ * @xa is used to refer to the entire xarray.
+ * @xas is the 'xarray operation state'.  It may be either a pointer to
+ * an xa_state, or an xa_state stored on the stack.  This is an unfortunate
+ * ambiguity.
+ * @index is the index of the entry being operated on
+ * @tag is an xa_tag_t; a small number indicating one of the tag bits.
+ * @node refers to an xa_node; usually the primary one being operated on by
+ * this function.
+ * @offset is the index into the slots array inside an xa_node.
+ * @parent refers to the @xa_node closer to the head than @node.
+ * @entry refers to something stored in a slot in the xarray
+ */
+
+/**
+ * xa_init_flags() - Initialise an empty XArray with flags.
+ * @xa: XArray.
+ * @flags: XA_FLAG values.
+ *
+ * If you need to initialise an XArray with special flags (eg you need
+ * to take the lock from interrupt context), use this function instead
+ * of xa_init().
+ */
+void xa_init_flags(struct xarray *xa, gfp_t flags)
+{
+	spin_lock_init(&xa->xa_lock);
+	xa->xa_flags =3D flags;
+	xa->xa_head =3D NULL;
+}
+EXPORT_SYMBOL(xa_init_flags);
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index b21b586b9854..34fed5c38da2 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -8,6 +8,7 @@
 #define spinlock_t		pthread_mutex_t
 #define DEFINE_SPINLOCK(x)	pthread_mutex_t x =3D PTHREAD_MUTEX_INITIALIZER;
 #define __SPIN_LOCK_UNLOCKED(x)	(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER
+#define spin_lock_init(x)	pthread_mutex_init(x, NULL);
=20
 #define spin_lock_irqsave(x, f)		(void)f, pthread_mutex_lock(x)
 #define spin_unlock_irqrestore(x, f)	(void)f, pthread_mutex_unlock(x)
diff --git a/tools/testing/radix-tree/.gitignore b/tools/testing/radix-tree=
/.gitignore
index d4706c0ffceb..8d4df7a72a8e 100644
--- a/tools/testing/radix-tree/.gitignore
+++ b/tools/testing/radix-tree/.gitignore
@@ -4,3 +4,4 @@ idr-test
 main
 multiorder
 radix-tree.c
+xarray.c
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/M=
akefile
index fa7ee369b3c9..3868bc189199 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -4,7 +4,7 @@ CFLAGS +=3D -I. -I../../include -g -O2 -Wall -D_LGPL_SOURCE=
 -fsanitize=ADdress
 LDFLAGS +=3D -fsanitize=ADdress
 LDLIBS+=3D -lpthread -lurcu
 TARGETS =3D main idr-test multiorder
-CORE_OFILES :=3D radix-tree.o idr.o linux.o test.o find_bit.o
+CORE_OFILES :=3D xarray.o radix-tree.o idr.o linux.o test.o find_bit.o
 OFILES =3D main.o $(CORE_OFILES) regression1.o regression2.o regression3.o=
 \
 	 tag_check.o multiorder.o idr-test.o iteration_check.o benchmark.o
=20
@@ -33,9 +33,13 @@ vpath %.c ../../lib
 $(OFILES): Makefile *.h */*.h generated/map-shift.h \
 	../../include/linux/*.h \
 	../../include/asm/*.h \
+	../../../include/linux/xarray.h \
 	../../../include/linux/radix-tree.h \
 	../../../include/linux/idr.h
=20
+xarray.c: ../../../lib/xarray.c
+	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
+
 radix-tree.c: ../../../lib/radix-tree.c
 	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
=20
@@ -46,6 +50,6 @@ idr.c: ../../../lib/idr.c
=20
 mapshift:
 	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
-		echo "#define RADIX_TREE_MAP_SHIFT $(SHIFT)" >		\
+		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
 				generated/map-shift.h;			\
 	fi
diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/radix-tre=
e/linux/bug.h
index 23b8ed52f8c8..03dc8a57eb99 100644
--- a/tools/testing/radix-tree/linux/bug.h
+++ b/tools/testing/radix-tree/linux/bug.h
@@ -1 +1,2 @@
+#include <stdio.h>
 #include "asm/bug.h"
diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/radix=
-tree/linux/kconfig.h
new file mode 100644
index 000000000000..6c8675859913
--- /dev/null
+++ b/tools/testing/radix-tree/linux/kconfig.h
@@ -0,0 +1 @@
+#include "../../../../include/linux/kconfig.h"
diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/radix-=
tree/linux/xarray.h
new file mode 100644
index 000000000000..df3812cda376
--- /dev/null
+++ b/tools/testing/radix-tree/linux/xarray.h
@@ -0,0 +1,2 @@
+#include "generated/map-shift.h"
+#include "../../../../include/linux/xarray.h"
diff --git a/tools/testing/radix-tree/multiorder.c b/tools/testing/radix-tr=
ee/multiorder.c
index 684e76f79f4a..24293a2fd82d 100644
--- a/tools/testing/radix-tree/multiorder.c
+++ b/tools/testing/radix-tree/multiorder.c
@@ -191,13 +191,13 @@ static void multiorder_shrink(unsigned long index, in=
t order)
=20
 	assert(item_insert_order(&tree, 0, order) =3D 0);
=20
-	node =3D tree.rnode;
+	node =3D tree.xa_head;
=20
 	assert(item_insert(&tree, index) =3D 0);
-	assert(node !=3D tree.rnode);
+	assert(node !=3D tree.xa_head);
=20
 	assert(item_delete(&tree, index) !=3D 0);
-	assert(node =3D tree.rnode);
+	assert(node =3D tree.xa_head);
=20
 	for (i =3D 0; i < max; i++) {
 		struct item *item =3D item_lookup(&tree, i);
diff --git a/tools/testing/radix-tree/test.c b/tools/testing/radix-tree/tes=
t.c
index 0d69c49177c6..6e1cc2040817 100644
--- a/tools/testing/radix-tree/test.c
+++ b/tools/testing/radix-tree/test.c
@@ -262,7 +262,7 @@ static int verify_node(struct radix_tree_node *slot, un=
signed int tag,
=20
 void verify_tag_consistency(struct radix_tree_root *root, unsigned int tag)
 {
-	struct radix_tree_node *node =3D root->rnode;
+	struct radix_tree_node *node =3D root->xa_head;
 	if (!radix_tree_is_internal_node(node))
 		return;
 	verify_node(node, tag, !!root_tag_get(root, tag));
@@ -292,13 +292,13 @@ void item_kill_tree(struct radix_tree_root *root)
 		}
 	}
 	assert(radix_tree_gang_lookup(root, (void **)items, 0, 32) =3D 0);
-	assert(root->rnode =3D NULL);
+	assert(root->xa_head =3D NULL);
 }
=20
 void tree_verify_min_height(struct radix_tree_root *root, int maxindex)
 {
 	unsigned shift;
-	struct radix_tree_node *node =3D root->rnode;
+	struct radix_tree_node *node =3D root->xa_head;
 	if (!radix_tree_is_internal_node(node)) {
 		assert(maxindex =3D 0);
 		return;
--=20
2.15.1

