From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 26 Aug 2011 04:30:41 +0000
Subject: Re: Can not compile Ecovec board
Message-Id: <CABMQnV+0Xzah33BkHUkXRCxd6b0GLJjjFs45++ePdHQqOAydiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87aaaxou97.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aaaxou97.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This was already revised in linux-next tree.

Best regards,
  Nobuhiro

2011/8/26 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Paul, Magnus, SH-ML members
>
> I can not compile Ecovec board on latest linus/master branch
> it say
>
> -------------------------
> =A0GEN =A0 =A0 /opt/usr/src/WORK/morimoto/gitlinux/binary/ecovec/Makefile
> =A0CHK =A0 =A0 include/linux/version.h
> =A0Using /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6 as source for kern=
el
> =A0CHK =A0 =A0 include/generated/utsrelease.h
> make[3]: `include/generated/machtypes.h' is up to date.
> =A0CALL =A0 =A0/opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/scripts/chec=
ksyscalls.sh
> =A0CHK =A0 =A0 include/generated/compile.h
> =A0CC =A0 =A0 =A0arch/sh/kernel/idle.o
> =A0CC =A0 =A0 =A0arch/sh/kernel/ptrace_32.o
> =A0CC =A0 =A0 =A0arch/sh/kernel/return_address.o
> /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/kernel/idle.c:25:15=
: error: static declaration of 'pm_idle' follows non-static declaration
> /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/include/linux/pm.h:34:15: n=
ote: previous declaration of 'pm_idle' was here
> make[3]: *** [arch/sh/kernel/idle.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/kernel/ptrace_32.c:=
66:6: error: conflicting types for 'ptrace_triggered'
> /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/arch/sh/include/asm/ptrace.=
h:126:13: note: previous declaration of 'ptrace_triggered' was here
> make[3]: *** [arch/sh/kernel/ptrace_32.o] Error 1
> make[2]: *** [arch/sh/kernel] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[2]: *** wait: No child processes. =A0Stop.
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> -------------------------
>
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
