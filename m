From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 May 2019 06:00:13 +0000
Subject: remove asm-generic/ptrace.h v2
Message-Id: <20190520060018.25569-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi all,

asm-generic/ptrace.h is a little weird in that it doesn't actually
implement any functionality, but it provided multiple layers of macros
that just implement trivial inline functions.  We implement those
directly in the few architectures and be off with a much simpler
design.

Changes since v1:
 - add a missing empty line between functions
