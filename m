From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 28 Aug 2020 16:21:17 +0000
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-Id: <2302ba3f-b429-23fb-b231-4e97659d5ec4@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
In-Reply-To: <20200828155024.GX3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On 8/28/20 5:50 PM, Rich Felker wrote:
> This patch broke strace - it spews out bogus syscalls and gets the
> tracee hung. I suspect the last hunk is wrong and breaks all
> non-seccomp tracing. I'll follow up with further analysis and possibly
> a fix if you don't find one sooner.
Hmm, it does not hang for me but it looks suspicious:

root@tirpitz:~> strace ./test
execve("./test", ["./test"], 0x7be59690 /* 24 vars */) = 0
brk(NULL)                               = 0x52abc000
uname({sysname="Linux", nodename="tirpitz", ...}) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_sizeg578, ...}) = 0
mmap2(NULL, 67578, PROT_READ, MAP_PRIVATE, 3, 0) = 0x29584000
close(3)                                = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EPERM (Operation not permitted)
openat(AT_FDCWD, "/lib/sh4-linux-gnu/tls/sh4a/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat64("/lib/sh4-linux-gnu/tls/sh4a", 0x7b89fb2c) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib/sh4-linux-gnu/tls/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat64("/lib/sh4-linux-gnu/tls", 0x7b89fb2c) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib/sh4-linux-gnu/sh4a/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = -1 ENOENT (No such file or directory)
stat64("/lib/sh4-linux-gnu/sh4a", 0x7b89fb2c) = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/lib/sh4-linux-gnu/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0*\0\1\0\0\0t\306\1\0004\0\0\0"..., 512) = 512
pread64(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0", 32, 1290836) = 32
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EPERM (Operation not permitted)
close(3)                                = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = -1 EPERM (Operation not permitted)
writev(2, [{iov_base="./test", iov_len=6}, {iov_base=": ", iov_len=2}, {iov_base="error while loading shared libra"..., iov_len6}, {iov_base=": ", iov_len=2}, {iov_base="", iov_len=0}, {iov_base="", iov_len=0}, {iov_base="out of memory", iov_len}, {iov_base=": ", iov_len=2}, {iov_base="Operation not permitted", iov_len#}, {iov_base="\n", iov_len=1}], 10./test: error while loading shared libraries: out of memory: Operation not permitted
) = 85
exit_group(127)                         = ?
+++ exited with 127 +++
root@tirpitz:~>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
