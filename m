From: Steven Price <steven.price@arm.com>
Date: Wed, 27 Feb 2019 17:05:53 +0000
Subject: [PATCH v3 19/34] sh: mm: Add p?d_large() definitions
Message-Id: <20190227170608.27963-20-steven.price@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190227170608.27963-1-steven.price@arm.com>
In-Reply-To: <20190227170608.27963-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Mark Rutland <Mark.Rutland@arm.com>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will.deacon@arm.com>, "H. Peter Anvin" <hpa@zytor.com>, "Liang, Kan" <kan.liang@linux.intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org, Steven Price <steven.price@arm.com>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>

walk_page_range() is going to be allowed to walk page tables other than
those of user space. For this it needs to know when it has reached a
'leaf' entry in the page tables. This information is provided by the
p?d_large() functions/macros.

For sh, we don't support large pages, so add stubs returning 0.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Steven Price <steven.price@arm.com>
---
 arch/sh/include/asm/pgtable-3level.h | 1 +
 arch/sh/include/asm/pgtable_32.h     | 1 +
 arch/sh/include/asm/pgtable_64.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 7d8587eb65ff..9d8b2b002582 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -48,6 +48,7 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 #define pud_present(x)	(pud_val(x))
 #define pud_clear(xp)	do { set_pud(xp, __pud(0)); } while (0)
 #define	pud_bad(x)	(pud_val(x) & ~PAGE_MASK)
+#define pud_large(x)	(0)
 
 /*
  * (puds are folded into pgds so this doesn't get actually called,
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 29274f0e428e..61186aa11021 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -329,6 +329,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define pmd_present(x)	(pmd_val(x))
 #define pmd_clear(xp)	do { set_pmd(xp, __pmd(0)); } while (0)
 #define	pmd_bad(x)	(pmd_val(x) & ~PAGE_MASK)
+#define pmd_large(x)	(0)
 
 #define pages_to_mb(x)	((x) >> (20-PAGE_SHIFT))
 #define pte_page(x)	pfn_to_page(pte_pfn(x))
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 1778bc5971e7..80fe9264babf 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -64,6 +64,7 @@ static __inline__ void set_pte(pte_t *pteptr, pte_t pteval)
 #define pmd_clear(pmd_entry_p)	(set_pmd((pmd_entry_p), __pmd(_PMD_EMPTY)))
 #define pmd_none(pmd_entry)	(pmd_val((pmd_entry)) = _PMD_EMPTY)
 #define pmd_bad(pmd_entry)	((pmd_val(pmd_entry) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pmd_large(pmd_entry)	(0)
 
 #define pmd_page_vaddr(pmd_entry) \
 	((unsigned long) __va(pmd_val(pmd_entry) & PAGE_MASK))
-- 
2.20.1
