From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 21 Jan 2008 07:46:21 +0000
Subject: Re: Hi, all,
Message-Id: <47944DCD.5070406@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mike Frysinger wrote:
> On Sunday 20 January 2008, Mike Frysinger wrote:
>   
>> On Sunday 20 January 2008, Fabio Giovagnini wrote:
>>     
>>> I have such a problem with.
>>> sh-uclibc-g++ 3.4.6
>>>
>>> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw2-fd
>>> e- glibc.c:291: undefined reference to `dl_iterate_phdr'
>>>
>>> How can I solve.
>>> Any suggestion will be appreciated.
>>>       
>> a one line error isnt exactly useful ... you didnt say what version of
>> uClibc you're using or what you're using for a build system.
>>     
>
> and more importantly, what exactly are you doing
> -mike
>   
Hi Mike,
I think that Fabio is trying to linking statically a C++ application
against uClibc. If so, (Fabio please clarify), the problem is extactly 
the same
I posted on uClibc list last week (mmove _dl_iterate_phdr from libdl.a 
to libc.a).

I have a already fixed it for nptl/sh4 branch... I'm just now merging 
the patch
for the uClibc branch and post it for a wider review on uClibc.

I'll put Fabio into the loop.. anyway Fabio should post his full command 
line
used to build/link his application.

Cheers,
Carmelo
