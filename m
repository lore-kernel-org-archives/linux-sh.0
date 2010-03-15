From: Kay Sievers <kay.sievers@vrfy.org>
Date: Mon, 15 Mar 2010 11:29:23 +0000
Subject: Re: [PATCH] driver core: Early dev_name() support.
Message-Id: <ac3eb2511003150429u5aa2e6c8w9ecfcc77293dd82b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100309065753.GA8287@linux-sh.org> <ac3eb2511003111159q84e6cefi43de106c79c0e333@mail.gmail.com> 
	<20100315080359.GA15171@linux-sh.org>
In-Reply-To: <20100315080359.GA15171@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Greg KH <greg@kroah.com>, Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Mar 15, 2010 at 09:03, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Mar 11, 2010 at 08:59:18PM +0100, Kay Sievers wrote:

>> > ??static inline const char *dev_name(const struct device *dev)
>> > ??{
>> > + ?? ?? ?? /* Use the init name until the kobject becomes available */
>>
>> This should probably state that it's used for getting names out of
>> unregistered devices. Otherwise it sounds confusing.
>>
> It's not clear that that distinction makes things any less confusing.
> Early devices are registered, they just haven't been fully initialized
> yet.

For the driver core, "registered" devices are devices where
device_add() or device_register() has been called. Initialized devices
are devices which device_initialize() was called for. The devices you
mean are not "registered" in that sense, right?

Thanks,
Kay
