From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 10:34:58 +0000
Subject: [PATCH 0/3] binfmt_elf_fdpic: auxvec updates, v2.
Message-Id: <20080806103458.GE2610@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This is a tiny series of patches for bringing binfmt_elf_fdpic back in
line with binfmt_elf in terms of auxiliary vector layout, particularly
for the new entries that have popped up recently.

[PATCH 1/3] binfmt_elf_fdpic: Support auxvec base platform string.
[PATCH 2/3] binfmt_elf_fdpic: Convert initial stack alignment to arch_align_stack().
[PATCH 3/3] binfmt_elf_fdpic: Wire up AT_EXECFD, AT_EXECFN, AT_SECURE.

Changes since the last version include the updated 2/3 patch and a
cosmetic fixup in 1/3.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 fs/binfmt_elf_fdpic.c |   89 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 25 deletions(-)
