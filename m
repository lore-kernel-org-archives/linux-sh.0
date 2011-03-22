From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 22 Mar 2011 15:22:05 +0000
Subject: Re: [PATCH] Input: tca6416-keypad: Change to module_init()
Message-Id: <AANLkTimRV9vzOE7+VPX48y3KebLJSvBOkqxoM--9gqGb@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110322142619.1109.89105.sendpatchset@t400s>
	<20110322142855.GB2202@sirena.org.uk>
	<20110322143307.GB24004@linux-sh.org>
In-Reply-To: <20110322143307.GB24004@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 22, 2011 at 11:33 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Mar 22, 2011 at 02:28:55PM +0000, Mark Brown wrote:
>> On Tue, Mar 22, 2011 at 11:26:19PM +0900, Magnus Damm wrote:
>>
>> > The tca6416 driver makes use of the I2C bus for chatting
>> > with the actual hardware device. Without this patch both
>> > the I2C bus driver and the tca6416 driver are initialized
>> > at the subsys_initcall() level. This may lead to problems
>> > with the tca6416 driver being initialized before the I2C
>> > bus driver.
>>
>> While this change seems reasonable I'm curious what the problems caused
>> by out of order registration are?
>
> I'm also curious as to why link order isn't a sufficient gaurantee like
> it is for everyone else?

I believe all other i2c keyboard drivers use module_init().

/ magnus
