From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 20 Jan 2014 09:56:05 +0000
Subject: Re: [PATCH] MAINTAINERS: Add dts files for r8 series to SHMOBILE
Message-Id: <52DCF2B5.2060208@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057071-12455-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390057071-12455-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/01/14 00:11, Simon Horman wrote:
> On Sat, Jan 18, 2014 at 05:07:30PM +0100, Geert Uytterhoeven wrote:
>> On Sat, Jan 18, 2014 at 3:57 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1239,6 +1239,8 @@ Q:        http://patchwork.kernel.org/project/linux-sh/list/
>>>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
>>>   S:     Supported
>>>   F:     arch/arm/mach-shmobile/
>>> +F:     arch/arm/boot/dts/r8*
>>
>> While you're at it, can you please also include r7s*?
>
> There is also sh73* and emev2*.
>
> And while we are opening this topic, are the defconfigs of interest too?

Time to check what the other entries are like, although the defconfigs
do seem to be a reasonably sensible thing to have listed here.

I will get this updated today and re-send.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
