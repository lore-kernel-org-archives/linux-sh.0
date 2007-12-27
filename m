From: Heiko Schocher <heiko.schocher@invitel.hu>
Date: Thu, 27 Dec 2007 08:34:05 +0000
Subject: Re: [Patch] Add support for Poseidon board.
Message-Id: <4773637D.7000702@invitel.hu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,

Sorry for the long delay, but in Christmas time the idle() function is
never called ;-)

Paul Mundt wrote:
> On Wed, Dec 12, 2007 at 03:08:32PM +0100, Manuel Lauss wrote:
>   
>> On Wed, Dec 12, 2007 at 08:57:57AM +0100, Heiko Schocher wrote:
>>     
>>> --- /dev/null
>>> +++ b/arch/sh/boards/emblux/poseidon/io.c
>>> @@ -0,0 +1,171 @@
>>> +/*
>>> + * linux/arch/sh/boards/emblux/poseidon/io.c
>>> + *
>>> + * Copyright (C) 2007 Heiko Schocher <heiko.schocher@invitel.hu>
>>> + *
>>> + * I/O routine for Poseidon.
>>> + *
>>> + */
>>>       
>
> Please kill this io.c completely. If the generic routines don't work for
> you, we can look at conditionalizing timeouts there if it's absolutely
> needed. Other architectures have similar hooks for broken platforms.
>   

I played with the Bus-timing registers, but without any success :-(
When I disable the cache it works fine with the generic io routines!

Now I dont know, if we have to modify the generic routines, because
I think its a really special problem for me, and that shouldnt go into
generic routines, or?

bye,
Heiko
