From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 02:40:50 +0000
Subject: [PATCH] sh64: mm: use 'unsigned long' instead of 'unsigned long long'
Message-Id: <51F727B2.2010708@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

The address's type is 'unsigned long', so use 'unsigned long' instead
of 'unsigned long long' (warning is treated as error).

The related error (with 'allmodconfig', without "EXTRA_CFLAGS=3D-W"):

    CC      arch/sh/mm/cache-sh5.o
  arch/sh/mm/cache-sh5.c: In function =91sh64_dcache_purge_sets=92:
  arch/sh/mm/cache-sh5.c:255:12: error: cast from pointer to integer of dif=
ferent size [-Werror=3Dpointer-to-int-cast]
  cc1: all warnings being treated as errors


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sh/mm/cache-sh5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/cache-sh5.c b/arch/sh/mm/cache-sh5.c
index d1bffbc..1da2900 100644
--- a/arch/sh/mm/cache-sh5.c
+++ b/arch/sh/mm/cache-sh5.c
@@ -252,7 +252,7 @@ static void inline sh64_dcache_purge_sets(int sets_to_p=
urge_base, int n_sets)
=20
 	for (j =3D 0; j < n_sets; j++, set_offset++) {
 		set_offset &=3D (cpu_data->dcache.sets - 1);
-		eaddr0 =3D (unsigned long long)dummy_alloco_area +
+		eaddr0 =3D (unsigned long)dummy_alloco_area +
 			(set_offset << cpu_data->dcache.entry_shift);
=20
 		/*
--=20
1.7.7.6
