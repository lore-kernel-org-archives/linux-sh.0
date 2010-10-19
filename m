From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 19 Oct 2010 01:50:44 +0000
Subject: Re: [RFC/PATCH] sh: Add 32bit cou mode to cpu_flags
Message-Id: <AANLkTinpGJti1hoh6qnN6+pfxceTOhB0ZrU7on-dR+hP@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Oh, sorry. Subject is wrong.
  s/cou/cpu


Nobuhiro

2010/10/19 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>:
> There is not method to confirm which of 32bit mode or 29bit mode Linux
> kernel works.
> This patch adds a mode to cpu_flags and can confirm it from auxv and proc
> filesystem.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
> =A0arch/sh/include/asm/cpu-features.h | =A0 =A01 +
> =A0arch/sh/kernel/cpu/sh4/probe.c =A0 =A0 | =A0 =A04 ++++
> =A0arch/sh/kernel/setup.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A08 +++++++-
> =A03 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/arch/sh/include/asm/cpu-features.h b/arch/sh/include/asm/cpu=
-features.h
> index 694abe4..dc1265b 100644
> --- a/arch/sh/include/asm/cpu-features.h
> +++ b/arch/sh/include/asm/cpu-features.h
> @@ -22,5 +22,6 @@
> =A0#define CPU_HAS_L2_CACHE =A0 =A0 =A0 0x0080 =A0/* Secondary cache / UR=
AM */
> =A0#define CPU_HAS_OP32 =A0 =A0 =A0 =A0 =A0 0x0100 =A0/* 32-bit instructi=
on support */
> =A0#define CPU_HAS_PTEAEX =A0 =A0 =A0 =A0 0x0200 =A0/* PTE ASID Extension=
 support */
> +#define CPU_IS_32BIT_MODE =A0 =A0 =A00x0400 =A0/* linux kernel works 32b=
it mode */
>
> =A0#endif /* __ASM_SH_CPU_FEATURES_H */
> diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/prob=
e.c
> index b93458f..4bda234 100644
> --- a/arch/sh/kernel/cpu/sh4/probe.c
> +++ b/arch/sh/kernel/cpu/sh4/probe.c
> @@ -189,6 +189,10 @@ void __cpuinit cpu_probe(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> +#ifdef CONFIG_32BIT
> + =A0 =A0 =A0 boot_cpu_data.flags |=3D CPU_IS_32BIT_MODE;
> +#endif
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * On anything that's not a direct-mapped cache, look to t=
he CVR
> =A0 =A0 =A0 =A0 * for I/D-cache specifics.
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 4e27846..460ac72 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -352,7 +352,8 @@ EXPORT_SYMBOL(get_cpu_subtype);
> =A0/* Symbolic CPU flags, keep in sync with asm/cpu-features.h */
> =A0static const char *cpu_flags[] =3D {
> =A0 =A0 =A0 =A0"none", "fpu", "p2flush", "mmuassoc", "dsp", "perfctr",
> - =A0 =A0 =A0 "ptea", "llsc", "l2", "op32", "pteaex", NULL
> + =A0 =A0 =A0 "ptea", "llsc", "l2", "op32", "pteaex", "32bit",
> + =A0 =A0 =A0 NULL
> =A0};
>
> =A0static void show_cpuflags(struct seq_file *m, struct sh_cpuinfo *c)
> @@ -410,6 +411,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(m, "cut\t\t: %d.%d\n", c->cut_m=
ajor, c->cut_minor);
>
> + =A0 =A0 =A0 if (c->flags & CPU_IS_32BIT_MODE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(m, "cpu mode\t: 32bit\n");
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 seq_printf(m, "cpu mode\t: 29bit\n");
> +
> =A0 =A0 =A0 =A0show_cpuflags(m, c);
>
> =A0 =A0 =A0 =A0seq_printf(m, "cache type\t: ");
> --
> 1.7.1
>
>



--=20
Nobuhiro Iwamatsu
