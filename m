From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 25 Mar 2011 12:59:07 +0000
Subject: Re: build breakage sh in next
Message-Id: <AANLkTimiK4ntxJG5NJ-4q7WQm6DdM7drargXSmGjCFyy@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103250844300.22824@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103250844300.22824@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

2011/3/25 Guennadi Liakhovetski <g.liakhovetski@gmx.de>:
> /opt/src/linux-2.6/arch/sh/kernel/process.c: In function 'alloc_thread_in=
fo':
> /opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: 'node' undeclared =
(first use in this function)
> /opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: (Each undeclared i=
dentifier is reported only once
> /opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: for each function =
it appears in.)
> make[2]: *** [arch/sh/kernel/process.o] Error 1
> make[1]: *** [arch/sh/kernel] Error 2
> make: *** [sub-make] Error 2

This already revised by patch of "[PATCH] sh: Fix build
alloc_thread_info_node function".

Best regards,
  Nobuhiro
--=20
Nobuhiro Iwamatsu
=A0=A0 iwamatsu at {nigauri.org / debian.org}
=A0=A0 GPG ID: 40AD1FA6
