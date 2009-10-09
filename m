From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Fri, 09 Oct 2009 12:55:30 +0000
Subject: Possibly icahe/dcache synchronization problem on sh7785lcr
Message-Id: <4ACF32C2.9010501@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

During execution of user space application form time to time
invalid instruction or bus error occured or even init dies during sturtup.
The situation became more stable if i use the following code:
static void sh4_flush_icache_page(void *arg)
{
         flush_dcache_all();
         flush_icache_all();
}
...
local_flush_icache_page         = sh4_flush_icache_page;
This is done because previous experience  with 2.6.20 on sdk7785.
There was the similar problems (at least it looks like).

So my question is if it really might be icache/dcache synchronization 
problem or something different.
May be somebody has had the same problems and know how to solve it right?


I have the following configuration:
sh7785lcr
2.6.32-rc2. pagesize = 8K (avoid cache alias problem)
uclibc-9.28 with pagesize = 8k

Example of illegal instruction execution:
...
[    7.408000] VFS: Mounted root (nfs filesystem) on device 0:12.
[    7.416000] Freeing unused kernel memory: 136k freed
init started:  BusyBox v1.01 (Slind 1:1.01-2.slind3) multi-call binary
init: Bummer, can't write to log on /dev/vc/5!
Starting pid 881, console /dev/ttySC1: '/etc/init.d/rcS'
Loading kernel modules
cat: /etc/modules: No such file or directory
Done loading modules
.: 15: Can't open /lib/lsb/init-functions
Activating swap.
Cleaning up ifupdown...done.
Starting OpenBSD Secure Shell server: sshdIllegal instruction
...

Example of unfixed unaligned access:
[    7.416000] Freeing unused kernel memory: 136k freed
init started:  BusyBox v1.01 (Slind 1:1.01-2.slind3) multi-call binary
init: Bummer, can't write to log on /dev/vc/5!
Starting pid 881, console /dev/ttySC1: '/etc/init.d/rcS'
Loading kernel modules
cat: /etc/modules: No such file or directory
Done loading modules
.: 15: Can't open /lib/lsb/init-functions
Activating swap.
Cleaning up ifupdown...done.
[    9.764000] Unaligned userspace access in "sshd" pid20 
pc=0x29684740 ins=0x2f86
[    9.776000] Fixing up unaligned userspace access in "sshd" pid20 
pc=0x29684740 ins=0x2f86
Starting OpenBSD Secure Shell server: sshd[    9.916000] Unaligned 
userspace access in "sshd" pid27 pc=0x296731e4 ins=0x2f96
[    9.924000] Fixing up unaligned userspace access in "sshd" pid27 
pc=0x296731e4 ins=0x2f96
[    9.932000] Unaligned userspace access in "sshd" pid27 
pc=0x296731f2 ins=0x0103
[    9.940000] Fixing up unaligned userspace access in "sshd" pid27 
pc=0x296731f2 ins=0x0103
[    9.948000] Sending SIGBUS to "sshd" due to unaligned access (PC 
b3325bf8 PR 296731f6)
Bus error


Best regards,
Valentin.
