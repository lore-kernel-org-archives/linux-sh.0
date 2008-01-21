From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 21 Jan 2008 17:14:43 +0000
Subject: Re: Hi, all,
Message-Id: <4794D303.8070001@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Fabio Giovagnini wrote:
> Sorry Carmelo,
> could you explain me better how you solved the problem?
> Regards
>
>  =20
There is a problem into uClibc when statically linking a C++ application,
but it's not clear if this is what you are trying to do.... even if the=20
output
is the same as in my case.
So you should attach the whole command line used to build you app,=20
further the verbose output (using -v)
could be useful.

Carmelo
> Alle 08:46, luned=EC 21 gennaio 2008, Carmelo AMOROSO ha scritto:
>  =20
>> Mike Frysinger wrote:
>>    =20
>>> On Sunday 20 January 2008, Mike Frysinger wrote:
>>>      =20
>>>> On Sunday 20 January 2008, Fabio Giovagnini wrote:
>>>>        =20
>>>>> I have such a problem with.
>>>>> sh-uclibc-g++ 3.4.6
>>>>>
>>>>> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw=
2-
>>>>> fd e- glibc.c:291: undefined reference to `dl_iterate_phdr'
>>>>>
>>>>> How can I solve.
>>>>> Any suggestion will be appreciated.
>>>>>          =20
>>>> a one line error isnt exactly useful ... you didnt say what version of
>>>> uClibc you're using or what you're using for a build system.
>>>>        =20
>>> and more importantly, what exactly are you doing
>>> -mike
>>>      =20
>> Hi Mike,
>> I think that Fabio is trying to linking statically a C++ application
>> against uClibc. If so, (Fabio please clarify), the problem is extactly
>> the same
>> I posted on uClibc list last week (mmove _dl_iterate_phdr from libdl.a
>> to libc.a).
>>
>> I have a already fixed it for nptl/sh4 branch... I'm just now merging
>> the patch
>> for the uClibc branch and post it for a wider review on uClibc.
>>
>> I'll put Fabio into the loop.. anyway Fabio should post his full command
>> line
>> used to build/link his application.
>>
>> Cheers,
>> Carmelo
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>    =20
>
>  =20

