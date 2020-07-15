From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 15 Jul 2020 15:39:14 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <f10d2711-674b-50b4-cf7a-234070b3c265@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
In-Reply-To: <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 7/15/20 4:37 PM, John Paul Adrian Glaubitz wrote:
> Will report once I found the bad commit that introduced the problem.

git bisect lead me to a merge commit:

glaubitz@epyc:..glaubitz/linux> git bisect log
git bisect start
# good: [1c163f4c7b3f621efff9b28a47abb36f7378d783] Linux 5.0
git bisect good 1c163f4c7b3f621efff9b28a47abb36f7378d783
# bad: [7bc20f6563b4e117d61ca575427208e0eaa945b9] sh: Fix unneeded constructor in page table allocation
git bisect bad 7bc20f6563b4e117d61ca575427208e0eaa945b9
# bad: [eeb2045bb7d20fea0a242148059377cd0cb4a499] Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
git bisect bad eeb2045bb7d20fea0a242148059377cd0cb4a499
# bad: [5ce40fd86cf155e0eefc73509343bb3eeaafa4bc] drm/amdgpu: add Arcturus chip_name for init sdma microcode
git bisect bad 5ce40fd86cf155e0eefc73509343bb3eeaafa4bc
# good: [8f14c99c7edaaba9c0bb1727d44db6ebf157cc61] netfilter: conntrack: limit sysctl setting for boolean options
git bisect good 8f14c99c7edaaba9c0bb1727d44db6ebf157cc61
# good: [dce45af5c2e9e85f22578f2f8065f225f5d11764] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
git bisect good dce45af5c2e9e85f22578f2f8065f225f5d11764
# bad: [60fce36afa9c77c7ccbf980c4f670f3be3651fce] mm/compaction.c: correct zone boundary handling when isolating pages from a pageblock
git bisect bad 60fce36afa9c77c7ccbf980c4f670f3be3651fce
# bad: [414147d99b928c574ed76e9374a5d2cb77866a29] Merge tag 'pci-v5.2-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 414147d99b928c574ed76e9374a5d2cb77866a29
# bad: [1fb3b526df3bd7647e7854915ae6b22299408baf] Merge tag 'docs-5.2a' of git://git.lwn.net/linux
git bisect bad 1fb3b526df3bd7647e7854915ae6b22299408baf
# bad: [ea5aee6d97fd2d4499b1eebc233861c1def70f06] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad ea5aee6d97fd2d4499b1eebc233861c1def70f06
# bad: [45182e4e1f8ac04708ca7508c51d9103f07d81ab] Merge branch 'i2c/for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
git bisect bad 45182e4e1f8ac04708ca7508c51d9103f07d81ab
# good: [5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e] SUNRPC: Rebalance a kref in auth_gss.c
git bisect good 5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e
# bad: [abde77eb5c66b2f98539c4644b54f34b7e179e6b] Merge branch 'for-5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
git bisect bad abde77eb5c66b2f98539c4644b54f34b7e179e6b
# bad: [7664cd6e3a0b2709f04c07435e96c7c85e7d7324] Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
git bisect bad 7664cd6e3a0b2709f04c07435e96c7c85e7d7324
# good: [3e9dfc6e1e8bce62a329f1452c7eeccbac230980] orangefs: move do_readv_writev to direct_IO
git bisect good 3e9dfc6e1e8bce62a329f1452c7eeccbac230980
# good: [4077a0f25b001926f86d35f6236351583bada9a4] orangefs: pass slot index back to readpage.
git bisect good 4077a0f25b001926f86d35f6236351583bada9a4
# good: [2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d] Merge branch 'next-integrity-for-james' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-integrity
git bisect good 2bfebea90dd5e8c57ae1021a5d1bb6c1057eee6d
# good: [33713cd09ccdc1e01b10d0782ae60200d4989553] orangefs: truncate before updating size
git bisect good 33713cd09ccdc1e01b10d0782ae60200d4989553
# bad: [882388056194d2d4c3f589b194b6bdcc47e677e8] Merge tag 'for-linus-5.2-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
git bisect bad 882388056194d2d4c3f589b194b6bdcc47e677e8
# first bad commit: [882388056194d2d4c3f589b194b6bdcc47e677e8] Merge tag 'for-linus-5.2-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux
glaubitz@epyc:..glaubitz/linux>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
