From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Wed, 21 Mar 2012 16:24:19 +0000
Subject: Re: [PATCH] VMUFAT filesystem [1/4]
Message-Id: <CACwZE5TZdJoAUcB+BN2OB0UK0UajnuMPia0vgCZs8wM=3bNE7Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAN628AFKSgd2nKY5Ga7JqhVWqAySRW8OpeLyykOwocn4K_a-qQ@mail.gmail.com>
	<20120321153317.GA30250@kroah.com>
	<CACwZE5RbGARjgNRuJuLquDY_THjspH20JMEbKqsZVwj4jJtFhw@mail.gmail.com>
In-Reply-To: <CACwZE5RbGARjgNRuJuLquDY_THjspH20JMEbKqsZVwj4jJtFhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Adrian McMenamin <lkmladrian@gmail.com>, viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, Linux-sh <linux-sh@vger.kernel.org>

On 22 March 2012 00:13, Adrian McMenamin <adrianmcmenamin@gmail.com> wrote:
> On 21 March 2012 23:33, Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Wed, Mar 21, 2012 at 12:30:36PM +0800, Adrian McMenamin wrote:
>>> >From d587b09573c06309bb2c3ef12223b77fffc3a922 Mon Sep 17 00:00:00 2001
>>> From: Adrian McMenamin <adrianmcmenamin@gmail.com>
>>> Date: Wed, 21 Mar 2012 12:17:51 +0800
>>> Subject: [PATCH] Add vmufat filesystem
>>>
>>> ---
>>
>> Hint, read Documentation/SubmittingPatches for how to properly create
>> patches that could be applied, if they were in mergable state (you
>> forgot the changelog entry, signed-off-by line, and probably a few other
>> things...)
>>
>
> In fact a changelog and a signed-off-by line are in the email marked
> 1/4 - which plainly made it to the lkml even if some subscribers would
> appear not to have seen it: https://lkml.org/lkml/2012/3/21/10

I guess the complaint is that I didn't include this with each bit. So,
apologies for that, I cut it up by hand to avoid a 1700 line single
patch. But I won't post it this way again, obviously
