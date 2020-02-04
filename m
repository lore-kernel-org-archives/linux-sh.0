From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Date: Tue, 04 Feb 2020 14:13:23 +0000
Subject: No newer system calls for SuperH64?
Message-Id: <939c9260-213f-cfd7-f81a-e9b635a6aa10@juszkiewicz.com.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I am maintaining system calls table [1] which shows which system call
has which number on all architectures supported by Linux kernel
(including those removed in last years).

1. https://fedora.juszkiewicz.com.pl/syscalls.html

Today I have noticed that SH64 supports system calls up to 393 which is
pwritev2() one. None of later calls is supported in mainline 5.6-rc tree.

Is it an error in kernel headers or it is true? Or maybe it is an error
in my script but it works fine for other architectures.

Note: I do not own nor plan to own SuperH64 hardware. I do not even
remember where it was used. Just noticed weird state of it.

Affected system calls are:

fsconfig
fsmount
fsopen
fspick
io_uring_enter
io_uring_register
io_uring_setup
move_mount
openat2
open_tree
pidfd_getfd
pidfd_open
pidfd_send_signal
pkey_alloc
pkey_free
pkey_mprotect
rseq
statx
