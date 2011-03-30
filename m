From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 30 Mar 2011 01:20:32 +0000
Subject: Re: [PATCH] sh: Fix build arch_ptrace function by init_fpu
Message-Id: <AANLkTikbfyToYfW+iQOddvkmdoAe+aTwRyHVGL6Hembs@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1301398619-10753-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301398619-10753-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2011/3/30 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Dear Iwamatsu san
>
>> init_fpu can use only with CPU having FPU.
>> his was used in arch_ptrace, but came to use even the CPU which did not
>> have an FPU.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>> =A0arch/sh/kernel/ptrace_32.c | =A0 =A04 ++++
>> =A0arch/sh/kernel/ptrace_64.c | =A0 =A04 ++++
>> =A02 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
>> index 2130ca6..e00ddad 100644
>> --- a/arch/sh/kernel/ptrace_32.c
>> +++ b/arch/sh/kernel/ptrace_32.c
>> @@ -394,9 +394,11 @@ long arch_ptrace(struct task_struct *child, long re=
quest,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 tmp =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned lon=
g index;
>> +#ifdef CONFIG_SH_FPU
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D init=
_fpu(child);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 break;
>> +#endif
>
> How about modify "init_fpu" function side instead of this patch ?
> I don't know detail but like this ?

By your method, this problem is not settled.
Because init_fpu defined in asm/fpu.h becomes be enable by CONFIG_SH_FPU.

Best regard,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
