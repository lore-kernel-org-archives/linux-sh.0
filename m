From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Thu, 28 Aug 2008 11:57:31 +0000
Subject: Re: [PATCH] i2c: fix i2c-sh_mobile timing issues
Message-Id: <aec7e5c30808280457mbfdf595na06e83390f7b2983@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080827093356.9145.33751.sendpatchset@rx1.opensource.se>
	 <20080827130944.02e8ec49@hyperion.delvare>
In-Reply-To: <20080827130944.02e8ec49@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: i2c@lm-sensors.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

Hi Jean,

On Wed, Aug 27, 2008 at 8:09 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Wed, 27 Aug 2008 18:33:56 +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch teaches the i2c-sh_mobile driver to make use of wait irqs.
>> Without this patch only dte irqs are used which may lead to overruns
>> and cases of missing stop and extra bytes being read on the i2c bus.
>>
>> Use of wait irqs forces the hardware to pause and wait until the cpu
>> is ready. Polling is also reworked in this patch to fix ms delay issues.
>>
>> Verified with bus analyzer and tested on MigoR and AP325RXA boards.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>>
>>  Paul, can you merge this for 2.6.27?
>>
>>  drivers/i2c/busses/i2c-sh_mobile.c |  271 +++++++++++++++++++++++++++---------
>>  1 file changed, 208 insertions(+), 63 deletions(-)
>>
>
> I'm not sure why I am Cc'd on this but Ben Dooks isn't. Ben is the one
> in charge of i2c bus drivers for embedded system. I'm adding him.

Sorry about that. My fault, I based my emails on my previous emails.

I'd like to classify this patch as bug fix, but it required quite a
big rewrite since I had to change the interrupt handling which
affected the main state machine. And while at it I decided to add some
clarifications which added even more lines.

So I'd like to see this included in 2.6.27 if possible. It's a pretty
isolated change.

Thanks for your help!

/ magnus
