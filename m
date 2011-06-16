From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 16 Jun 2011 20:29:57 +0000
Subject: Re: [PATCH 5/5] kgdbts: unify/generalize gdb breakpoint adjustment
Message-Id: <BANLkTin53yiG02A89tQZiZiGHs90=AcMdA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
 <BANLkTi=iKW+XsfSBoPJmZWZOvq4RKa_Yjg@mail.gmail.com> <BANLkTim5fBUmyH-Vo+6zSgoZdXxu-Mq6OA@mail.gmail.com>
 <201106162221.53360.arnd@arndb.de>
In-Reply-To: <201106162221.53360.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Thu, Jun 16, 2011 at 16:21, Arnd Bergmann wrote:
> On Thursday 16 June 2011 22:07:55 Mike Frysinger wrote:
>> On Thu, Jun 16, 2011 at 16:06, Mike Frysinger wrote:
>> > On Thu, Jun 16, 2011 at 11:07, Arnd Bergmann wrote:
>> >> This patch is causing build problems now, because the instruction_poi=
nter_set()
>> >> that is used now is only defined in asm-generic/ptrace.h, which is on=
ly
>> >> used on x86, blackfin and sparc. Every other architecture now fails to
>> >> build.
>> >
>> > a fix was already merged over two weeks ago. =C2=A0so either your tree=
 is
>> > out of date,
>> >
>> > your tree is out of date.
>>
>> blah, network died before i could finish editing this
>>
>> your tree is out of date or you're seeing a different issue and need
>> to post a full build log
>
> Ok, sorry for the noise. I've only now completed going through the build
> errors of ARM randconfig on -rc1 and obviously need to rebase my fixes.

yeah, rc1 will be busticated when building kgdb
-mike
