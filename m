From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jan 2014 10:15:30 +0000
Subject: Re: Failure to bring up secondary CPU on koelsch
Message-Id: <CAMuHMdWJUkzz9xsbUi-sNGtHEm6_OR5AysFuPYRp9T9jZP_PuA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 22, 2013 at 11:14 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> When cold-booting koelsch, it sometimes locks up after printing

This is real cold-booting. Turning of the power for 10s is not enough, you have
to wait for all juice to disappear.

>     Starting kernel ...
>
> Resetting the board and trying again usually helps (sometimes a few tries
> are needed).
>
> As koelsch doesn't have early printk support, I made printk() save all
> messages to a buffer in RAM, to be inspected by uboot after a reset.
> The last lines are:
>
>     CPU0: update cpu_power 1024
>     CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>     Setting up static identity map for 0x4028e1b8 - 0x4028e210

With more debugging code added:

    CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
    r8a7791_smp_prepare_cpus:34 max_cpus 2
    r8a7791_smp_prepare_cpus:53
    kernel_init_freeable:906
    Setting up static identity map for 0x402a5f70 - 0x402a5fc8
    kernel_init_freeable:908
    kernel_init_freeable:911
    shmobile_smp_apmu_boot_secondary:141
    shmobile_smp_hook:24
    shmobile_smp_hook:26
    shmobile_smp_hook:28
    shmobile_smp_hook:31
    shmobile_smp_hook:33
    shmobile_smp_hook:35

> On success, the next lines are:

    shmobile_smp_hook:37
    shmobile_smp_apmu_boot_secondary:145
    shmobile_smp_apmu_boot_secondary:147
    secondary_start_kernel:337
    secondary_start_kernel:346
    secondary_start_kernel:357
    CPU1: Booted secondary processor

So it locks up while executing the second flush_cache_all() below:

void shmobile_smp_hook(unsigned int cpu, unsigned long fn, unsigned long arg)
{
        shmobile_smp_fn[cpu] = 0;
        flush_cache_all();

        shmobile_smp_mpidr[cpu] = cpu_logical_map(cpu);
        shmobile_smp_fn[cpu] = fn;
        shmobile_smp_arg[cpu] = arg;
        flush_cache_all();
}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
