From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Wed, 10 Sep 2008 15:52:02 +0000
Subject: strace not working with latest git
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305C513CBB@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello all,

I haven't bee able to get strace working on my sh7722 target:

$> uname -a
Linux 192.168.105.52 2.6.27-rc6-00008-g3ed6d13-dirty #184 Wed Sep 10
17:31:44 CEST 2008 sh4al-dsp unknown

$> strace ls
restart_syscall(<... resuming interrupted call ...>) = 0
.
. <repeating many times>
.
restart_syscall(<... resuming interrupted call ...>) = 0
restart_syscall(<... resuming interrupted call ...>) = 0
bin      etc      linuxrc  mplayer  sbin     tmp
restart_syscall(<... resuming interrupted call ...>) = 0
boot     include  man      opt      share    usr
restart_syscall(<... resuming interrupted call ...>) = 0
dev      lib      mnt      proc     sys      var
restart_syscall(<... resuming interrupted call ...>) = 0
~ #                            


I traced the problem a bit and in strace sources, the ptrace call
PTRACE_PEEKUSR always returns 0 when fetching the syscall number. I also
added a printk to PTRACE_PEEKUSR in arch/sh/kernel/ptrace_32.c and the
returned value is always 0. 

What might be wrong here?

Martin
