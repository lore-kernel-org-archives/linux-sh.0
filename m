From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 19 Aug 2009 06:35:05 +0000
Subject: Re: [BUG] Error in copy_process, when enable CONFIG_PROVE_LOCKING.
Message-Id: <29ab51dc0908182335v465c1e92y34ac70ad1cf46741@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
In-Reply-To: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2009/7/29 Paul Mundt <lethal@linux-sh.org>:
> On Tue, May 12, 2009 at 01:40:35PM +0900, Nobuhiro Iwamatsu wrote:
>> Error in copy_process, when enable CONFIG_PROVE_LOCKING.
>> This error has p->hardirqs_enabled in kernel.fork.c
>>
>> =A0987 #ifdef CONFIG_PROVE_LOCKING
>> =A0988 =A0 =A0 DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
>> =A0989 =A0 =A0 DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>> =A0990 #endif
>> =A0991 =A0 =A0 retval =3D -EAGAIN;
>>
>> The error message is as follows.
>> I am debuging this. Please teach if you know the revision method of
>> this problem.
>>
> This should be fixed now in current git. Can you give it a try?
>

OK.


--=20
Nobuhiro Iwamatsu / Debian Developer
   iwamatsu at {nigauri.org / debian.org}
