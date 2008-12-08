From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Mon, 08 Dec 2008 07:56:49 +0000
Subject: Re: [Bug report] dead lock is occur in mutex_trylock
Message-Id: <29ab51dc0812072356j300b9816ne6984ce37bb3f15f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uej0jyw3m.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2008/12/8 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Dec 08, 2008 at 04:17:17PM +0900, morimoto.kuninori@renesas.com wrote:
>>
>> Dear Paul
>>
>> I noticed dead lock occur on latest linux-sh.git
>>
>> It works well if I use old ${LINUX}/arch/sh/include/asm/mutex-llsc.h,
>> But, latest mutex-llsc.h seems cause dead lock on __mutex_fastpath_trylock.
>>
>> It confirmed on AP325 board.
>>
> Do you have a test case that can reproduce this?

Sorry,I don't have time to make a patch to solve this problem.
I send report only.

----
I do bisect your git repository.

iwamatsu@xps-iwamatsu:~/work/git/kernel/sh-2.6-devel (no branch)$ git bisect bad
782af8b25c1ce97b01b30c3b36bff02ccfd1b1c8 is first bad commit
commit 782af8b25c1ce97b01b30c3b36bff02ccfd1b1c8
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Mon Dec 8 11:25:50 2008 +0900

    sh: Fix up the SH-4A mutex fastpath semantics.

    This fixes up the __mutex_fastpath_xxx() routines to match the semantics
    noted in the comment. Previously these were looping rather than doing a
    single-pass, which is counter-intuitive, as the slow path takes care of
    the looping for us in the event of contention.

    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

:040000 040000 4fd2b63c9b887d77e8362bdf50b5cf8c78a05806
7b4b20b85fb7c400dffb784f3f3162af303d8c8f M	arch

Best regards,
 Nobuhiro


-- 
Nobuhiro Iwamatsu
