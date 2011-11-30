From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 30 Nov 2011 20:43:29 +0000
Subject: [PATCH (sh-2.6)] sh: do not export syscalls that are actually not implemented
Message-Id: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Avoid user space to erroneously assume that a syscall is implemented
by picking __NR_xxx from kernel headers that are actually mapped
to sys_ni_syscall.

The following interfaces have been removed

sycall               | #
---------------------------
__NR_break           |  17
__NR_stty            |  31
__NR_gtty            |  32
__NR_prof            |  44
__NR_lock            |  53
__NR_mpxi            |  56
__NR_ulimit          |  58
__NR_oldolduname     |  59
__NR_select          |  82
__NR_profil          |  98
__NR_ioperm          | 101
__NR_iopl            | 110
__NR_idle            | 112
__NR_vm86old         | 113
__NR_create_module   | 127
__NR_get_kernel_syms | 130
__NR_afs_syscall     | 137
__NR_vm86            | 166
__NR_query_module    | 167
__NR_streams1        | 188
__NR_streams2        | 189
__NR_set_thread_area | 243
__NR_get_thread_area | 244
__NR_vserver         | 273
---------------------------

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/include/asm/unistd_32.h |   53 ++++++++++++++++++++-------------------
 1 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index 3432008..c7ee965 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -26,7 +26,7 @@
 #define __NR_mknod		 14
 #define __NR_chmod		 15
 #define __NR_lchown		 16
-#define __NR_break		 17
+		/* 17 __NR_break obsolete */
 #define __NR_oldstat		 18
 #define __NR_lseek		 19
 #define __NR_getpid		 20
@@ -40,11 +40,11 @@
 #define __NR_oldfstat		 28
 #define __NR_pause		 29
 #define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
+		/* 31 __NR_stty obsolete */
+		/* 32 __NR_gtty	obsolete */
 #define __NR_access		 33
 #define __NR_nice		 34
-#define __NR_ftime		 35
+		/* 35 __NR_ftime 35 obsolete */
 #define __NR_sync		 36
 #define __NR_kill		 37
 #define __NR_rename		 38
@@ -53,7 +53,7 @@
 #define __NR_dup		 41
 #define __NR_pipe		 42
 #define __NR_times		 43
-#define __NR_prof		 44
+		/* 44 __NR_prof obsolete */
 #define __NR_brk		 45
 #define __NR_setgid		 46
 #define __NR_getgid		 47
@@ -62,13 +62,13 @@
 #define __NR_getegid		 50
 #define __NR_acct		 51
 #define __NR_umount2		 52
-#define __NR_lock		 53
+		/* 53 __NR_lock obsolete */
 #define __NR_ioctl		 54
 #define __NR_fcntl		 55
-#define __NR_mpx		 56
+		/* 56 __NR_mpxi obsolete */
 #define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
+		/* 58 __NR_ulimit obsolete */
+		/* 59 __NR_oldolduname obsolete */
 #define __NR_umask		 60
 #define __NR_chroot		 61
 #define __NR_ustat		 62
@@ -91,7 +91,7 @@
 #define __NR_settimeofday	 79
 #define __NR_getgroups		 80
 #define __NR_setgroups		 81
-#define __NR_select		 82
+		/* 82 __NR_select obsolete */
 #define __NR_symlink		 83
 #define __NR_oldlstat		 84
 #define __NR_readlink		 85
@@ -107,10 +107,10 @@
 #define __NR_fchown		 95
 #define __NR_getpriority	 96
 #define __NR_setpriority	 97
-#define __NR_profil		 98
+		/* 98 __NR_profil obsolete */
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+		/* 101 __NR_ioperm obsolete */
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -119,10 +119,10 @@
 #define __NR_lstat		107
 #define __NR_fstat		108
 #define __NR_olduname		109
-#define __NR_iopl		110
+		/* 110 __NR_iopl obsolete */
 #define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86old		113
+		/* 112 __NR_idle obsolete */
+		/* 113 __NR_vm86old	obsolete */
 #define __NR_wait4		114
 #define __NR_swapoff		115
 #define __NR_sysinfo		116
@@ -136,17 +136,17 @@
 #define __NR_adjtimex		124
 #define __NR_mprotect		125
 #define __NR_sigprocmask	126
-#define __NR_create_module	127
+		/* 127 __NR_create_module obsolete */
 #define __NR_init_module	128
 #define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
+		/* 130 __NR_get_kernel_syms obsolete */
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
 #define __NR_bdflush		134
 #define __NR_sysfs		135
 #define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
+		/* 137 __NR_afs_syscall	obsolete */
 #define __NR_setfsuid		138
 #define __NR_setfsgid		139
 #define __NR__llseek		140
@@ -175,8 +175,8 @@
 #define __NR_mremap		163
 #define __NR_setresuid		164
 #define __NR_getresuid		165
-#define __NR_vm86		166
-#define __NR_query_module	167
+		/* 166 __NR_vm86 obsolete */
+		/* 167 __NR_query_module obsolete */
 #define __NR_poll		168
 #define __NR_nfsservctl		169
 #define __NR_setresgid		170
@@ -197,8 +197,8 @@
 #define __NR_capset		185
 #define __NR_sigaltstack	186
 #define __NR_sendfile		187
-#define __NR_streams1		188	/* some people actually want it */
-#define __NR_streams2		189	/* some people actually want it */
+		/* 188 __NR_streams1 obsolete */
+		/* 189 __NR_streams2 obsolete */
 #define __NR_vfork		190
 #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
 #define __NR_mmap2		192
@@ -231,6 +231,7 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
+/* 222 is unused */
 /* 223 is unused */
 #define __NR_gettid		224
 #define __NR_readahead		225
@@ -251,15 +252,15 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
-#define __NR_set_thread_area	243
-#define __NR_get_thread_area	244
+		/* 243 __NR_set_thread_area obsolete */
+		/* 244 __NR_get_thread_area obsolete */
 #define __NR_io_setup		245
 #define __NR_io_destroy		246
 #define __NR_io_getevents	247
 #define __NR_io_submit		248
 #define __NR_io_cancel		249
 #define __NR_fadvise64		250
-
+/* 251 unused */
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
 #define __NR_epoll_create	254
@@ -281,7 +282,7 @@
 #define __NR_tgkill		270
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
-#define __NR_vserver		273
+		/* 273 __NR_vserver obsolete */
 #define __NR_mbind              274
 #define __NR_get_mempolicy      275
 #define __NR_set_mempolicy      276
-- 
1.7.4.4

