From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Mar 2012 07:30:25 +0000
Subject: Re: [PATCH (sh-2.6)] sh: do not export syscalls that are actually not implemented
Message-Id: <20120328073024.GW26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1322685809-15587-1-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 19, 2012 at 02:28:16PM +0100, Carmelo AMOROSO wrote:
> On 30/11/2011 21.56, Mike Frysinger wrote:
> > On Wednesday 30 November 2011 15:43:29 Carmelo AMOROSO wrote:
> >> Avoid user space to erroneously assume that a syscall is
> >> implemented by picking __NR_xxx from kernel headers that are
> >> actually mapped to sys_ni_syscall.
> > 
> > Acked-by: Mike Frysinger <vapier@gentoo.org> -mike
> 
> Hello,
> any progress on this patch ?
> 
Yes, sorry about the delay, it was on my todo list for 3.4 and I've just
gotten around to it now. I had to go through manually for both _32/_64 and
convert over accordingly. The end result tidies up a few things, and is what
I'll be checking in -- hopefully I've got all of them!

There still seems to be an odd one out, namely nfsservctl. The syscall
was killed off ages ago, but even platforms that have been more diligent
about stubbing out the __NR_xxx definitions for sys_ni_syscall cases have
left the __NR_nfsservctl definition defined. I suppose there is some
userspace component that depends on the definition, so I've left it alone
for now.

Attached for reference.

---

 arch/sh/include/asm/unistd_32.h |   57 +++++++++++++++++----------------
 arch/sh/include/asm/unistd_64.h |   68 ++++++++++++++++++++--------------------
 arch/sh/kernel/syscalls_32.S    |    8 ++--
 arch/sh/kernel/syscalls_64.S    |    8 ++--
 4 files changed, 71 insertions(+), 70 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index 152b862..2b83a49 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -26,7 +26,7 @@
 #define __NR_mknod		 14
 #define __NR_chmod		 15
 #define __NR_lchown		 16
-#define __NR_break		 17
+				 /* 17 was sys_break */
 #define __NR_oldstat		 18
 #define __NR_lseek		 19
 #define __NR_getpid		 20
@@ -40,11 +40,11 @@
 #define __NR_oldfstat		 28
 #define __NR_pause		 29
 #define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
+				 /* 31 was sys_stty */
+				 /* 32 was sys_gtty */
 #define __NR_access		 33
 #define __NR_nice		 34
-#define __NR_ftime		 35
+				 /* 35 was sys_ftime */
 #define __NR_sync		 36
 #define __NR_kill		 37
 #define __NR_rename		 38
@@ -53,7 +53,7 @@
 #define __NR_dup		 41
 #define __NR_pipe		 42
 #define __NR_times		 43
-#define __NR_prof		 44
+				 /* 44 was sys_prof */
 #define __NR_brk		 45
 #define __NR_setgid		 46
 #define __NR_getgid		 47
@@ -62,13 +62,13 @@
 #define __NR_getegid		 50
 #define __NR_acct		 51
 #define __NR_umount2		 52
-#define __NR_lock		 53
+				 /* 53 was sys_lock */
 #define __NR_ioctl		 54
 #define __NR_fcntl		 55
-#define __NR_mpx		 56
+				 /* 56 was sys_mpx */
 #define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
+				 /* 58 was sys_ulimit */
+				 /* 59 was sys_olduname */
 #define __NR_umask		 60
 #define __NR_chroot		 61
 #define __NR_ustat		 62
@@ -91,7 +91,7 @@
 #define __NR_settimeofday	 79
 #define __NR_getgroups		 80
 #define __NR_setgroups		 81
-#define __NR_select		 82
+				 /* 82 was sys_oldselect */
 #define __NR_symlink		 83
 #define __NR_oldlstat		 84
 #define __NR_readlink		 85
@@ -107,10 +107,10 @@
 #define __NR_fchown		 95
 #define __NR_getpriority	 96
 #define __NR_setpriority	 97
-#define __NR_profil		 98
+				 /* 98 was sys_profil */
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+				/* 101 was sys_ioperm */
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -119,10 +119,10 @@
 #define __NR_lstat		107
 #define __NR_fstat		108
 #define __NR_olduname		109
-#define __NR_iopl		110
+				/* 110 was sys_iopl */
 #define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86old		113
+				/* 112 was sys_idle */
+				/* 113 was sys_vm86old */
 #define __NR_wait4		114
 #define __NR_swapoff		115
 #define __NR_sysinfo		116
@@ -136,17 +136,17 @@
 #define __NR_adjtimex		124
 #define __NR_mprotect		125
 #define __NR_sigprocmask	126
-#define __NR_create_module	127
+				/* 127 was sys_create_module */
 #define __NR_init_module	128
 #define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
+				/* 130 was sys_get_kernel_syms */
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
 #define __NR_bdflush		134
 #define __NR_sysfs		135
 #define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
+				/* 137 was sys_afs_syscall */
 #define __NR_setfsuid		138
 #define __NR_setfsgid		139
 #define __NR__llseek		140
@@ -175,8 +175,8 @@
 #define __NR_mremap		163
 #define __NR_setresuid		164
 #define __NR_getresuid		165
-#define __NR_vm86		166
-#define __NR_query_module	167
+				/* 166 was sys_vm86 */
+				/* 167 was sys_query_module */
 #define __NR_poll		168
 #define __NR_nfsservctl		169
 #define __NR_setresgid		170
@@ -197,8 +197,8 @@
 #define __NR_capset		185
 #define __NR_sigaltstack	186
 #define __NR_sendfile		187
-#define __NR_streams1		188	/* some people actually want it */
-#define __NR_streams2		189	/* some people actually want it */
+				/* 188 reserved for sys_getpmsg */
+				/* 189 reserved for sys_putpmsg */
 #define __NR_vfork		190
 #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
 #define __NR_mmap2		192
@@ -231,7 +231,8 @@
 #define __NR_madvise		219
 #define __NR_getdents64		220
 #define __NR_fcntl64		221
-/* 223 is unused */
+				/* 222 is reserved for tux */
+				/* 223 is unused */
 #define __NR_gettid		224
 #define __NR_readahead		225
 #define __NR_setxattr		226
@@ -251,15 +252,15 @@
 #define __NR_futex		240
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
-#define __NR_set_thread_area	243
-#define __NR_get_thread_area	244
+				/* 243 is reserved for set_thread_area */
+				/* 244 is reserved for get_thread_area */
 #define __NR_io_setup		245
 #define __NR_io_destroy		246
 #define __NR_io_getevents	247
 #define __NR_io_submit		248
 #define __NR_io_cancel		249
 #define __NR_fadvise64		250
-
+				/* 251 is unused */
 #define __NR_exit_group		252
 #define __NR_lookup_dcookie	253
 #define __NR_epoll_create	254
@@ -281,7 +282,7 @@
 #define __NR_tgkill		270
 #define __NR_utimes		271
 #define __NR_fadvise64_64	272
-#define __NR_vserver		273
+				/* 273 is reserved for vserver */
 #define __NR_mbind              274
 #define __NR_get_mempolicy      275
 #define __NR_set_mempolicy      276
@@ -301,7 +302,7 @@
 #define __NR_inotify_init	290
 #define __NR_inotify_add_watch	291
 #define __NR_inotify_rm_watch	292
-/* 293 is unused */
+				/* 293 is unused */
 #define __NR_migrate_pages	294
 #define __NR_openat		295
 #define __NR_mkdirat		296
diff --git a/arch/sh/include/asm/unistd_64.h b/arch/sh/include/asm/unistd_64.h
index c330c23..d6ef1af 100644
--- a/arch/sh/include/asm/unistd_64.h
+++ b/arch/sh/include/asm/unistd_64.h
@@ -31,7 +31,7 @@
 #define __NR_mknod		 14
 #define __NR_chmod		 15
 #define __NR_lchown		 16
-#define __NR_break		 17
+				 /* 17 was sys_break */
 #define __NR_oldstat		 18
 #define __NR_lseek		 19
 #define __NR_getpid		 20
@@ -45,11 +45,11 @@
 #define __NR_oldfstat		 28
 #define __NR_pause		 29
 #define __NR_utime		 30
-#define __NR_stty		 31
-#define __NR_gtty		 32
+				 /* 31 was sys_stty */
+				 /* 32 was sys_gtty */
 #define __NR_access		 33
 #define __NR_nice		 34
-#define __NR_ftime		 35
+				 /* 35 was sys_ftime */
 #define __NR_sync		 36
 #define __NR_kill		 37
 #define __NR_rename		 38
@@ -58,7 +58,7 @@
 #define __NR_dup		 41
 #define __NR_pipe		 42
 #define __NR_times		 43
-#define __NR_prof		 44
+				 /* 44 was sys_prof */
 #define __NR_brk		 45
 #define __NR_setgid		 46
 #define __NR_getgid		 47
@@ -67,13 +67,13 @@
 #define __NR_getegid		 50
 #define __NR_acct		 51
 #define __NR_umount2		 52
-#define __NR_lock		 53
+				 /* 53 was sys_lock */
 #define __NR_ioctl		 54
 #define __NR_fcntl		 55
-#define __NR_mpx		 56
+				 /* 56 was sys_mpx */
 #define __NR_setpgid		 57
-#define __NR_ulimit		 58
-#define __NR_oldolduname	 59
+				 /* 58 was sys_ulimit */
+				 /* 59 was sys_olduname */
 #define __NR_umask		 60
 #define __NR_chroot		 61
 #define __NR_ustat		 62
@@ -96,7 +96,7 @@
 #define __NR_settimeofday	 79
 #define __NR_getgroups		 80
 #define __NR_setgroups		 81
-#define __NR_select		 82
+				 /* 82 was sys_select */
 #define __NR_symlink		 83
 #define __NR_oldlstat		 84
 #define __NR_readlink		 85
@@ -112,10 +112,10 @@
 #define __NR_fchown		 95
 #define __NR_getpriority	 96
 #define __NR_setpriority	 97
-#define __NR_profil		 98
+				 /* 98 was sys_profil */
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+				/* 101 was sys_ioperm */
 #define __NR_socketcall		102	/* old implementation of socket systemcall */
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -124,10 +124,10 @@
 #define __NR_lstat		107
 #define __NR_fstat		108
 #define __NR_olduname		109
-#define __NR_iopl		110
+				/* 110 was sys_iopl */
 #define __NR_vhangup		111
-#define __NR_idle		112
-#define __NR_vm86old		113
+				/* 112 was sys_idle */
+				/* 113 was sys_vm86old */
 #define __NR_wait4		114
 #define __NR_swapoff		115
 #define __NR_sysinfo		116
@@ -141,17 +141,17 @@
 #define __NR_adjtimex		124
 #define __NR_mprotect		125
 #define __NR_sigprocmask	126
-#define __NR_create_module	127
+				/* 127 was sys_create_module */
 #define __NR_init_module	128
 #define __NR_delete_module	129
-#define __NR_get_kernel_syms	130
+				/* 130 was sys_get_kernel_syms */
 #define __NR_quotactl		131
 #define __NR_getpgid		132
 #define __NR_fchdir		133
 #define __NR_bdflush		134
 #define __NR_sysfs		135
 #define __NR_personality	136
-#define __NR_afs_syscall	137 /* Syscall for Andrew File System */
+				/* 137 was sys_afs_syscall */
 #define __NR_setfsuid		138
 #define __NR_setfsgid		139
 #define __NR__llseek		140
@@ -180,8 +180,8 @@
 #define __NR_mremap		163
 #define __NR_setresuid		164
 #define __NR_getresuid		165
-#define __NR_vm86		166
-#define __NR_query_module	167
+				/* 166 was sys_vm86 */
+				/* 167 was sys_query_module */
 #define __NR_poll		168
 #define __NR_nfsservctl		169
 #define __NR_setresgid		170
@@ -202,8 +202,8 @@
 #define __NR_capset		185
 #define __NR_sigaltstack	186
 #define __NR_sendfile		187
-#define __NR_streams1		188	/* some people actually want it */
-#define __NR_streams2		189	/* some people actually want it */
+				/* 188 reserved for getpmsg */
+				/* 189 reserved for putpmsg */
 #define __NR_vfork		190
 #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
 #define __NR_mmap2		192
@@ -262,16 +262,15 @@
 #define __NR_msgrcv		241
 #define __NR_msgget		242
 #define __NR_msgctl		243
-#if 0
-#define __NR_shmatcall		244
-#endif
+#define __NR_shmat		244
 #define __NR_shmdt		245
 #define __NR_shmget		246
 #define __NR_shmctl		247
 
 #define __NR_getdents64		248
 #define __NR_fcntl64		249
-/* 223 is unused */
+				/* 250 is reserved for tux */
+				/* 251 is unused */
 #define __NR_gettid		252
 #define __NR_readahead		253
 #define __NR_setxattr		254
@@ -291,14 +290,15 @@
 #define __NR_futex		268
 #define __NR_sched_setaffinity	269
 #define __NR_sched_getaffinity	270
-#define __NR_set_thread_area	271
-#define __NR_get_thread_area	272
+				/* 271 is reserved for set_thread_area */
+				/* 272 is reserved for get_thread_area */
 #define __NR_io_setup		273
 #define __NR_io_destroy		274
 #define __NR_io_getevents	275
 #define __NR_io_submit		276
 #define __NR_io_cancel		277
 #define __NR_fadvise64		278
+				/* 279 is unused */
 #define __NR_exit_group		280
 
 #define __NR_lookup_dcookie	281
@@ -321,17 +321,17 @@
 #define __NR_tgkill		298
 #define __NR_utimes		299
 #define __NR_fadvise64_64	300
-#define __NR_vserver		301
-#define __NR_mbind              302
-#define __NR_get_mempolicy      303
-#define __NR_set_mempolicy      304
+				/* 301 is reserved for vserver */
+				/* 302 is reserved for mbind */
+				/* 303 is reserved for get_mempolicy */
+				/* 304 is reserved for set_mempolicy */
 #define __NR_mq_open            305
 #define __NR_mq_unlink          (__NR_mq_open+1)
 #define __NR_mq_timedsend       (__NR_mq_open+2)
 #define __NR_mq_timedreceive    (__NR_mq_open+3)
 #define __NR_mq_notify          (__NR_mq_open+4)
 #define __NR_mq_getsetattr      (__NR_mq_open+5)
-#define __NR_kexec_load		311
+				/* 311 is reserved for kexec */
 #define __NR_waitid		312
 #define __NR_add_key		313
 #define __NR_request_key	314
@@ -341,7 +341,7 @@
 #define __NR_inotify_init	318
 #define __NR_inotify_add_watch	319
 #define __NR_inotify_rm_watch	320
-/* 321 is unused */
+				/* 321 is unused */
 #define __NR_migrate_pages	322
 #define __NR_openat		323
 #define __NR_mkdirat		324
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index ee56a9b..4b68f0f 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -204,8 +204,8 @@ ENTRY(sys_call_table)
 	.long sys_capset           /* 185 */
 	.long sys_sigaltstack
 	.long sys_sendfile
-	.long sys_ni_syscall	/* streams1 */
-	.long sys_ni_syscall	/* streams2 */
+	.long sys_ni_syscall	/* getpmsg */
+	.long sys_ni_syscall	/* putpmsg */
 	.long sys_vfork            /* 190 */
 	.long sys_getrlimit
 	.long sys_mmap2
@@ -259,8 +259,8 @@ ENTRY(sys_call_table)
 	.long sys_futex		/* 240 */
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
-	.long sys_ni_syscall
-	.long sys_ni_syscall
+	.long sys_ni_syscall	/* reserved for set_thread_area */
+	.long sys_ni_syscall	/* reserved for get_thread_area */
 	.long sys_io_setup	/* 245 */
 	.long sys_io_destroy
 	.long sys_io_getevents
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
index 9af7de2..0956345 100644
--- a/arch/sh/kernel/syscalls_64.S
+++ b/arch/sh/kernel/syscalls_64.S
@@ -208,8 +208,8 @@ sys_call_table:
 	.long sys_capset		/* 185 */
 	.long sys_sigaltstack
 	.long sys_sendfile
-	.long sys_ni_syscall	/* streams1 */
-	.long sys_ni_syscall	/* streams2 */
+	.long sys_ni_syscall	/* getpmsg */
+	.long sys_ni_syscall	/* putpmsg */
 	.long sys_vfork			/* 190 */
 	.long sys_getrlimit
 	.long sys_mmap2
@@ -296,8 +296,8 @@ sys_call_table:
 	.long sys_futex
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity	/* 270 */
-	.long sys_ni_syscall
-	.long sys_ni_syscall
+	.long sys_ni_syscall		/* reserved for set_thread_area */
+	.long sys_ni_syscall		/* reserved for get_thread_area */
 	.long sys_io_setup
 	.long sys_io_destroy
 	.long sys_io_getevents		/* 275 */
