From: Olof Johansson <olof@lixom.net>
Date: Fri, 30 Nov 2012 22:10:47 +0000
Subject: Re: [PATCH 01/17] ARM: shmobile: fix memory size for kota2_defconfig
Message-Id: <CAOesGMg6afPjBc82FEOwzwn-nBAFPY7K_udJRJO1bBrtCk3Yvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1349195816-2225-1-git-send-email-arnd@arndb.de>
	<1349195816-2225-2-git-send-email-arnd@arndb.de>
	<20121003003759.GD31207@verge.net.au>
	<201210040834.55096.arnd@arndb.de>
	<20121004085857.GA7240@verge.net.au>
In-Reply-To: <20121004085857.GA7240@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@infradead.org, arm@kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

On Thu, Oct 4, 2012 at 1:58 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 04, 2012 at 08:34:54AM +0000, Arnd Bergmann wrote:
>> On Wednesday 03 October 2012, Simon Horman wrote:
>> > I looked through my fines and found a config that I believe
>> > worked with a derivative of 2.6.35.7.
>> >
>> > It has CONFIG_MEMORY_SIZE=0x1e800000.
>> >
>> > So what I suspect has happened is that an extra zero has crept into
>> > arch/arm/configs/kota2_defconfig and the intended value is:
>> >
>> > CONFIG_MEMORY_SIZE=0x1e000000
>> >
>> > Unfortunately I do not have access to a board to test this,
>> > nor am I aware of anyone who does.
>>
>> Ok, I'll drop this patch for now then, so we keep the warning around
>> to remind us of the problem.
>
> Thanks. I have subsequently located a Kota2 board,
> however it may be a little while before I get my hands on it.

Gentle ping. I just came across this warning again so I figured I'd check.


-Olof
