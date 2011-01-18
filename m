From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 18 Jan 2011 15:10:43 +0000
Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
Message-Id: <201101181610.44240.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Paul,
the prolem is the following:
if I build a linux.bin linking togheter my bootstrap code and teh kernel=20
zImage the kernel boots;
when I build uImage it doesn't boot. Really I see nothing on the minicom=20
terminal, but using the e10a emulator tu run the uboot + kernel I see the=20
software looped into cpu_idle function.

One guy wrote to me that arm need to match teh uboot board supprot and the =

kerne lboard support.
Is it true?
If yes is it true also for renesas?

Thanks





On Monday 17 January 2011 22:30:28 Fabio Giovagnini wrote:
> Where could I find the exact sequence of command I have to execute to bui=
ld
> and run under u-boot the kernel?
> I did:
> make uImage and I got the following:
>=20
> Is there anything wrong?
> I used the toolchain
> sh7203-uclinux-4.4-206
> and with the same u-boot is built and executed properly.
>=20
> Thanks in advance
>=20
>=20
> fgiovagnini@aurio01:~/sh7203/sh7203-uclinux-4.4-206/build$ make -f
> Makefile.sh-2.6
>=20
>=20
> ***************************************************
> ***                Building Linux               ***
> ***************************************************
> make -C /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/../sh-2.6
> ARCH=3Dsh CROSS_COMPILE=3Dsh-uclinux- uImage
> make[1]: ingresso nella directory =AB/home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/sh-2.6=BB
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: =ABinclude/generated/machtypes.h=BB =E8 aggiornato.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> sh-uclinux-ld: Warning: size of symbol `read_persistent_clock' changed fr=
om
> 24 in arch/sh/kernel/built-in.o to 16 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_probe_nr_irqs' changed from =
28
> in arch/sh/kernel/built-in.o to 12 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_callchain_kernel' changed fr=
om
> 96 in arch/sh/kernel/built-in.o to 10 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_pmu_name' changed from 30 in
> arch/sh/kernel/built-in.o to 18 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_dup_task_struct' changed from
> 104 in arch/sh/kernel/built-in.o to 28 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_mremap' changed from 12 in
> kernel/built-in.o to 108 in mm/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd4' changed from 12 in
> kernel/built-in.o to 340 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_setup' changed from 12 in
> kernel/built-in.o to 894 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_cancel' changed from 12 in
> kernel/built-in.o to 332 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create' changed from 12
> in kernel/built-in.o to 32 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_set' changed from 12 in
> kernel/built-in.o to 480 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_pwait' changed from 12 =
in
> kernel/built-in.o to 256 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_ctl' changed from 12 in
> kernel/built-in.o to 916 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_wait' changed from 12 in
> kernel/built-in.o to 664 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_add_watch' changed fr=
om
> 12 in kernel/built-in.o to 648 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd2' changed from 12 in
> kernel/built-in.o to 104 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create1' changed from 12
> in kernel/built-in.o to 260 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_settime' changed from
> 12 in kernel/built-in.o to 440 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init' changed from 12
> in kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init1' changed from 12
> in kernel/built-in.o to 292 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_submit' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_bdflush' changed from 12 in
> kernel/built-in.o to 120 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_create' changed from =
12
> in kernel/built-in.o to 164 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_flock' changed from 12 in
> kernel/built-in.o to 264 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_gettime' changed from
> 12 in kernel/built-in.o to 316 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_rm_watch' changed from
> 12 in kernel/built-in.o to 132 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_get' changed from 12 in
> kernel/built-in.o to 496 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_getevents' changed from 12
> in kernel/built-in.o to 776 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_destroy' changed from 12 in
> kernel/built-in.o to 44 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_lookup_dcookie' changed from =
12
> in kernel/built-in.o to 284 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgget' changed from 12 in
> kernel/built-in.o to 80 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmdt' changed from 12 in
> kernel/built-in.o to 140 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgrcv' changed from 12 in
> kernel/built-in.o to 92 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semget' changed from 12 in
> kernel/built-in.o to 104 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semctl' changed from 12 in
> kernel/built-in.o to 180 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semtimedop' changed from 12 in
> kernel/built-in.o to 1300 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmctl' changed from 12 in
> kernel/built-in.o to 1088 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgsnd' changed from 12 in
> kernel/built-in.o to 60 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semop' changed from 12 in
> kernel/built-in.o to 24 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmat' changed from 12 in
> kernel/built-in.o to 40 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgctl' changed from 12 in
> kernel/built-in.o to 772 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmget' changed from 12 in
> kernel/built-in.o to 88 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ipc' changed from 12 in
> kernel/built-in.o to 444 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `__div64_32' changed from 56 in
> arch/sh/lib/lib.a(div64-generic.o) to 172 in lib/built-in.o
>   KSYM    .tmp_kallsyms1.S
>   AS      .tmp_kallsyms1.o
>   LD      .tmp_vmlinux2
> sh-uclinux-ld: Warning: size of symbol `read_persistent_clock' changed fr=
om
> 24 in arch/sh/kernel/built-in.o to 16 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_probe_nr_irqs' changed from =
28
> in arch/sh/kernel/built-in.o to 12 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_callchain_kernel' changed fr=
om
> 96 in arch/sh/kernel/built-in.o to 10 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_pmu_name' changed from 30 in
> arch/sh/kernel/built-in.o to 18 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_dup_task_struct' changed from
> 104 in arch/sh/kernel/built-in.o to 28 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_mremap' changed from 12 in
> kernel/built-in.o to 108 in mm/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd4' changed from 12 in
> kernel/built-in.o to 340 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_setup' changed from 12 in
> kernel/built-in.o to 894 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_cancel' changed from 12 in
> kernel/built-in.o to 332 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create' changed from 12
> in kernel/built-in.o to 32 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_set' changed from 12 in
> kernel/built-in.o to 480 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_pwait' changed from 12 =
in
> kernel/built-in.o to 256 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_ctl' changed from 12 in
> kernel/built-in.o to 916 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_wait' changed from 12 in
> kernel/built-in.o to 664 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_add_watch' changed fr=
om
> 12 in kernel/built-in.o to 648 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd2' changed from 12 in
> kernel/built-in.o to 104 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create1' changed from 12
> in kernel/built-in.o to 260 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_settime' changed from
> 12 in kernel/built-in.o to 440 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init' changed from 12
> in kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init1' changed from 12
> in kernel/built-in.o to 292 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_submit' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_bdflush' changed from 12 in
> kernel/built-in.o to 120 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_create' changed from =
12
> in kernel/built-in.o to 164 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_flock' changed from 12 in
> kernel/built-in.o to 264 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_gettime' changed from
> 12 in kernel/built-in.o to 316 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_rm_watch' changed from
> 12 in kernel/built-in.o to 132 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_get' changed from 12 in
> kernel/built-in.o to 496 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_getevents' changed from 12
> in kernel/built-in.o to 776 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_destroy' changed from 12 in
> kernel/built-in.o to 44 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_lookup_dcookie' changed from =
12
> in kernel/built-in.o to 284 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgget' changed from 12 in
> kernel/built-in.o to 80 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmdt' changed from 12 in
> kernel/built-in.o to 140 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgrcv' changed from 12 in
> kernel/built-in.o to 92 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semget' changed from 12 in
> kernel/built-in.o to 104 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semctl' changed from 12 in
> kernel/built-in.o to 180 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semtimedop' changed from 12 in
> kernel/built-in.o to 1300 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmctl' changed from 12 in
> kernel/built-in.o to 1088 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgsnd' changed from 12 in
> kernel/built-in.o to 60 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semop' changed from 12 in
> kernel/built-in.o to 24 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmat' changed from 12 in
> kernel/built-in.o to 40 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgctl' changed from 12 in
> kernel/built-in.o to 772 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmget' changed from 12 in
> kernel/built-in.o to 88 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ipc' changed from 12 in
> kernel/built-in.o to 444 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `__div64_32' changed from 56 in
> arch/sh/lib/lib.a(div64-generic.o) to 172 in lib/built-in.o
>   KSYM    .tmp_kallsyms2.S
>   AS      .tmp_kallsyms2.o
>   LD      vmlinux
> sh-uclinux-ld: Warning: size of symbol `read_persistent_clock' changed fr=
om
> 24 in arch/sh/kernel/built-in.o to 16 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_probe_nr_irqs' changed from =
28
> in arch/sh/kernel/built-in.o to 12 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_callchain_kernel' changed fr=
om
> 96 in arch/sh/kernel/built-in.o to 10 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `perf_pmu_name' changed from 30 in
> arch/sh/kernel/built-in.o to 18 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `arch_dup_task_struct' changed from
> 104 in arch/sh/kernel/built-in.o to 28 in kernel/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_mremap' changed from 12 in
> kernel/built-in.o to 108 in mm/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd4' changed from 12 in
> kernel/built-in.o to 340 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_setup' changed from 12 in
> kernel/built-in.o to 894 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_cancel' changed from 12 in
> kernel/built-in.o to 332 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create' changed from 12
> in kernel/built-in.o to 32 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_set' changed from 12 in
> kernel/built-in.o to 480 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_pwait' changed from 12 =
in
> kernel/built-in.o to 256 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_ctl' changed from 12 in
> kernel/built-in.o to 916 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_wait' changed from 12 in
> kernel/built-in.o to 664 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_add_watch' changed fr=
om
> 12 in kernel/built-in.o to 648 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_signalfd' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_eventfd2' changed from 12 in
> kernel/built-in.o to 104 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_epoll_create1' changed from 12
> in kernel/built-in.o to 260 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_settime' changed from
> 12 in kernel/built-in.o to 440 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init' changed from 12
> in kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_init1' changed from 12
> in kernel/built-in.o to 292 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_submit' changed from 12 in
> kernel/built-in.o to 24 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_bdflush' changed from 12 in
> kernel/built-in.o to 120 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_create' changed from =
12
> in kernel/built-in.o to 164 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_flock' changed from 12 in
> kernel/built-in.o to 264 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_timerfd_gettime' changed from
> 12 in kernel/built-in.o to 316 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_inotify_rm_watch' changed from
> 12 in kernel/built-in.o to 132 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ioprio_get' changed from 12 in
> kernel/built-in.o to 496 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_getevents' changed from 12
> in kernel/built-in.o to 776 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_io_destroy' changed from 12 in
> kernel/built-in.o to 44 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_lookup_dcookie' changed from =
12
> in kernel/built-in.o to 284 in fs/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgget' changed from 12 in
> kernel/built-in.o to 80 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmdt' changed from 12 in
> kernel/built-in.o to 140 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgrcv' changed from 12 in
> kernel/built-in.o to 92 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semget' changed from 12 in
> kernel/built-in.o to 104 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semctl' changed from 12 in
> kernel/built-in.o to 180 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semtimedop' changed from 12 in
> kernel/built-in.o to 1300 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmctl' changed from 12 in
> kernel/built-in.o to 1088 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgsnd' changed from 12 in
> kernel/built-in.o to 60 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_semop' changed from 12 in
> kernel/built-in.o to 24 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmat' changed from 12 in
> kernel/built-in.o to 40 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_msgctl' changed from 12 in
> kernel/built-in.o to 772 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_shmget' changed from 12 in
> kernel/built-in.o to 88 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `sys_ipc' changed from 12 in
> kernel/built-in.o to 444 in ipc/built-in.o
> sh-uclinux-ld: Warning: size of symbol `__div64_32' changed from 56 in
> arch/sh/lib/lib.a(div64-generic.o) to 172 in lib/built-in.o
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   OBJCOPY arch/sh/boot/vmlinux.bin
>   GZIP    arch/sh/boot/vmlinux.bin.gz
>   UIMAGE  arch/sh/boot/uImage.gz
> Image Name:   Linux-2.6.37+
> Created:      Mon Jan 17 22:27:07 2011
> Image Type:   SuperH Linux Kernel Image (gzip compressed)
> Data Size:    975877 Bytes =3D 953.00 kB =3D 0.93 MB
> Load Address: 0x0C001000
> Entry Point:  0x0C002000
>   Image arch/sh/boot/uImage is ready
> make[1]: uscita dalla directory =AB/home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/sh-2.6=BB
> make -C /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/../sh-2.6
> ARCH=3Dsh CROSS_COMPILE=3Dsh-uclinux- modules
> make[1]: ingresso nella directory =AB/home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/sh-2.6=BB
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: =ABinclude/generated/machtypes.h=BB =E8 aggiornato.
>   CALL    scripts/checksyscalls.sh
>   Building modules, stage 2.
>   MODPOST 1 modules
> make[1]: uscita dalla directory =AB/home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/sh-2.6=BB
> mkdir -p /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/sh7203-
> images/root_fs/lib/modules
> cd /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/../sh-2.6/driver=
s;
> \ cp `find . -name '*.ko' -print` /home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/build/sh7203-images/root_fs/lib/modules
>=20
>=20
> ***************************************************
> ***              Building Complete              ***
> ***************************************************
>=20
> On Monday 17 January 2011 09:55:28 Paul Mundt wrote:
> > On Mon, Jan 17, 2011 at 09:55:15AM +0100, Fabio Giovagnini wrote:
> > > Thanks Paul for your answer.
> > > Did you use uBoot for booting, or the MCP data bootloader?
> >=20
> > The only boards I have all have uboot on them. The uboot version I use =
is
> > a bit buggy though so I often have to use trimmed down kernels for the
> > decompression to succeed (Iwamatsu-san did the initial port as I recall,
> > and I don't think its had much attention since then). I'm unaware of
> > whether other versions of the board have the same issues or not. I've
> > never seen the MPC loader, so if you're using that then of course you
> > will have to ask them for support.

--=20
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
