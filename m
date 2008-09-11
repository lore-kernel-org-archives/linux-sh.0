From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Thu, 11 Sep 2008 09:43:10 +0000
Subject: AW: strace not working with latest git
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305C77F51F@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> Hello all,
> 
> I haven't bee able to get strace working on my sh7722 target:
> 
> $> uname -a
> Linux 192.168.105.52 2.6.27-rc6-00008-g3ed6d13-dirty #184 Wed 
> Sep 10 17:31:44 CEST 2008 sh4al-dsp unknown
> 
> $> strace ls
> restart_syscall(<... resuming interrupted call ...>) = 0
> .
> . <repeating many times>
> .
> restart_syscall(<... resuming interrupted call ...>) = 0 
> restart_syscall(<... resuming interrupted call ...>) = 0
> bin      etc      linuxrc  mplayer  sbin     tmp
> restart_syscall(<... resuming interrupted call ...>) = 0
> boot     include  man      opt      share    usr
> restart_syscall(<... resuming interrupted call ...>) = 0
> dev      lib      mnt      proc     sys      var
> restart_syscall(<... resuming interrupted call ...>) = 0
> ~ #                            
> 
> 
> I traced the problem a bit and in strace sources, the ptrace 
> call PTRACE_PEEKUSR always returns 0 when fetching the 
> syscall number. I also added a printk to PTRACE_PEEKUSR in 
> arch/sh/kernel/ptrace_32.c and the returned value is always 0. 
> 
> What might be wrong here?
> 
> Martin

I got strace now working with following hack. Still don't know why this
is needed though. get_stack_long() seemst to read data from wrong
offset...

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 035cb30..7be388a 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -107,6 +107,7 @@ long arch_ptrace(struct task_struct *child, long
request, long addr, long data)
        struct user * dummy = NULL;
        int ret;

+       addr=(addr+0x34);
        switch (request) {
        /* read the word at location addr in the USER area. */
        case PTRACE_PEEKUSR: {
  
