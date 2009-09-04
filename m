From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 04 Sep 2009 08:15:09 +0000
Subject: Re: [BUG] Error in copy_process, when enable CONFIG_PROVE_LOCKING.
Message-Id: <4AA0CC8D.3060609@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
In-Reply-To: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Nobuhiro Iwamatsu wrote:
> 2009/7/29 Paul Mundt <lethal@linux-sh.org>:
>> On Tue, May 12, 2009 at 01:40:35PM +0900, Nobuhiro Iwamatsu wrote:
>>> Error in copy_process, when enable CONFIG_PROVE_LOCKING.
>>> This error has p->hardirqs_enabled in kernel.fork.c
>>>
>>>  987 #ifdef CONFIG_PROVE_LOCKING
>>>  988     DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
>>>  989     DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>>>  990 #endif
>>>  991     retval = -EAGAIN;
>>>
>>> The error message is as follows.
>>> I am debuging this. Please teach if you know the revision method of
>>> this problem.
>>>
>> This should be fixed now in current git. Can you give it a try?
>>
> 
> OK.

I checked this.
Work fine.

Best regards,
   Nobuhiro
