From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 11 Mar 2014 16:41:55 +0000
Subject: Re: rcar-i2c: always reads a byte
Message-Id: <531F3CD3.4030408@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <531F3686.7050808@codethink.co.uk> <20140311164043.GA1179@katana>
In-Reply-To: <20140311164043.GA1179@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

On 11/03/14 16:40, Wolfram Sang wrote:
> On Tue, Mar 11, 2014 at 04:15:02PM +0000, Ben Dooks wrote:
>> I have noticed the following behaviour with the i2c-rcar driver
>> with the following single i2c_msg structure:
>>
>> 	msg[0].addr = 0x12;
>> 	msg[0].flags = I2C_M_RD;
>> 	msg[0].len = 0;
>> 	msg[0].buf = data;
>>
>> The system issues an address transaction followed by a single byte
>> read.
>
> This fits to my observation that the rcar driver cannot do SMBUS_QUICK
> (e.g. via i2cdetect). I assumed that handling a length of 0 is broken. I
> haven't had a deeper look yet, so I can't say much. So, you either go
> for it yourself, or you wait until I posted my IIC enablement series for
> Lager. Then, you can switch to the IIC core with the sh_mobile driver.
> That one does SMBUS_QUICK correctly.

I'll have a deeper look into this, I think there may be a solution.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
