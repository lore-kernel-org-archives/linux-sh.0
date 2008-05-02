From: "Roni Feldman" <ronifeldman@gmail.com>
Date: Fri, 02 May 2008 11:53:39 +0000
Subject: Re: initramfs /init freeze
Message-Id: <7b5883fc0805020453xa4bf398jd8dc19b0b8b0aa0e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
In-Reply-To: <7b5883fc0804281204l7bf2f9e8me942dfc0628f30@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

My fault indeed! I use the sh4-unknown-linux-gnu toolchain, so the gcc
crt*.o files were with FPU support (with FPU instructions). Only I
disabled FPU support in the kernel since I'm not going to use it. So
an FPU opcode probably cause the CPU freeze. Everything works
now (with FPU support enabled), but I really don't want the FPU. I
tried generating an sh4-softfloat-linux-gnu toolchain (gcc 4.1.2 libc
2.7) with crossdev but I failed.
I'm probably missing something obvious, but I didn't work on it for too long...

Thanks a lot!
Roni Feldman

On Fri, May 2, 2008 at 4:22 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 28 April 2008, Kristoffer Ericson wrote:
>
> > On Mon, 28 Apr 2008 21:04:49 "Roni Feldman" wrote:
>  > > I'm experiencing odd behavior on an SH4 setup: I have an embedded
>  > > initramfs in the kernel image.
>  > > The kernel boots fine but the sequence freezes after
>  > > run_init_process("/init") is executed.
>  > >
>  > > I say "freeze" because I tried code that only does "return 0;" and I
>  > > even wrote an init.s with
>  > > a _start function that jmp's to address 0 (and was supposed to cause
>  > > an exception, but nothing
>  > > appeared in ttySC1, not even a panic for the exit of the init process).
>  > >
>  > > All the printk()'s are visible, and the console handover from sercon0
>  > > to ttySC1 seems to work
>  > > fine (I have no trouble doing printk's before the call to kernel_execve).
>  > >
>  > > I also tried both static and dynamic linking when I wrote the empty
>  > > main().
>  >
>  > I believe the dynamic linking issue was in pre glibc 2.3.4 (atleast on SH3)
>  > so shouldn't be an issue atm.
>
>  and static seems to fail the same way ...
>
>  you could try enabling magic sysrq on your system.  otherwise, jtag/kgdb would
>  be very useful just to see where the processor is stuck.
>
>
>  > > Busybox as a shell and an /init shell script seems to suffer from the
>  > > same symptoms.
>  > >
>  > > My setup:
>  > > cpu: SH7751R LE configuration
>  > > kernel: 2.6.25-rc8
>  > > gcc: Gentoo 4.1.2 p1.0.2 with glibc 2.7
>  > >
>  > > I started to suspect my too-new glibc, so now I'm struggling with
>  > > crossdev to compile a uclibc
>  > > toolchain.
>  >
>  > I know glibc 2.3.x / 2.4.x / 2.5.x works well, but never tried 2.7. Usually
>  > though its gcc thats causing the issues. But you should step back and build
>  > it with older gcc/glibc just to make sure.
>  >
>  > For reference I usually use gcc 3.4.5 & glibc 2.3.6 for kernel builds.
>
>  glibc-2.7 seems to work fine on my systems ...
>  -mike
>
