From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 15:03:59 +0000
Subject: [PATCH 0/3] binfmt_elf_fdpic: auxvec updates.
Message-Id: <20080728150359.GA16555@linux-sh.org>
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

These depend on the refactored NEW_AUX_ENT(), so against -next or -mm
presently.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 fs/binfmt_elf_fdpic.c |   91 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 66 insertions(+), 25 deletions(-)
