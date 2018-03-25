From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 22:18:37 +0000
Subject: [PATCH v2 00/16] Generic infrastructure for unloading initramfs
Message-Id: <20180325221853.10839-1-shea@shealevy.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180324174458.26423-1-shea@shealevy.com>
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This patch series extracts out code for unloading the initramfs that
was identical across 14 architectures, and moves those architectures
to the common code path. Additionally, RISC-V is newly moved to the
common code path.

In addition to reducing duplication, this allows us to bring future
improvements (such as generalizing existing "keep initrd" command line
options) to multiple architectures at once.

v2: Mark generic free_initrd_mem __init.

