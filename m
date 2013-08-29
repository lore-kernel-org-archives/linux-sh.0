From: Ian Molton <ian.molton@codethink.co.uk>
Date: Thu, 29 Aug 2013 13:35:35 +0000
Subject: Re: [PATCH] EMMA: Add em i2c driver
Message-Id: <521F4E27.1070800@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1377688911-10911-1-git-send-email-ian.molton@codethink.co.uk> <CANqRtoRK+Ur=87-me7CpP+s9SO5g0ZVZSEOrqwDf4HFfjZZmZA@mail.gmail.com> <521F2156.6040506@codethink.co.uk>
In-Reply-To: <521F2156.6040506@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, SH-Linux <linux-sh@vger.kernel.org>

On 29/08/13 11:24, Ben Dooks wrote:
> On 29/08/13 06:33, Magnus Damm wrote:
>> Hi Ian,
>>
>> Thanks for submitting this patch. I have one comment only, please see 
>> below.
>>> +#ifdef CONFIG_I2C_EMXX_SMC
>>> +       i2c_dev->flags |= I2C_BIT_SMC0;
>>> +#endif
>>
>> I think CONFIG_I2C_EMXX_SMC probably want to be reworked somehow. I
>> assume it's an old left over in this particular case. But if you need
>> to have some special configuration method then please consider some
>> other way than CONFIG_ variables that are not very compatible with
>> future multi-platform kernel images.
>
> Is it something that needs to be passed through the device tree binding
> or something we can detect from the SoC itself?
>

Probably. Its the switch to select between 100 and 400kHz modes.

I wonder if theres a standard binding for it?


-Ian
