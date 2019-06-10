From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Jun 2019 21:20:00 +0000
Subject: binfmt_flat cleanups and RISC-V support
Message-Id: <20190610212015.9157-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Greg,

below is a larger stash of cleanups for the binfmt_misc code,
preparing for the last patch that now trivially adds RISC-V
support, which will be used for the RISC-V nommu series I am
about to post.
