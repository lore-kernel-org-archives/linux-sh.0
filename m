From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 09 May 2014 22:55:00 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <536D5CC4.6030209@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk> <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk> <536BFF39.40607@cogentembedded.com> <536CA0B1.4040300@codethink.co.uk>
In-Reply-To: <536CA0B1.4040300-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org
Cc: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello.

On 05/09/2014 01:32 PM, Ben Dooks wrote:

>>> The i2c-rcar driver currently prints an error message if the master_xfer
>>> callback fails. However if the bus is being probed then lots of NAKs
>>> will be generated, causing the output of a number of errors printed.

>>> To solve this, disable the print if the error is not -EREMOTEIO.

>>> An example of running i2cdetect:

>>> 10: i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15
>>> -- 12 i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15
>>> -- i2c-rcar e6530000.i2c: error -121 : 15

>>> Cc: Simon Horman <horms+renesas@verge.net.au>
>>> Cc: Wolfram Sang <wsa@the-dreams.de>
>>> Cc: linux-i2c@vger.kernel.org
>>> Cc: linux-sh@vger.kernel.org
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   drivers/i2c/busses/i2c-rcar.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)

>>> diff --git a/drivers/i2c/busses/i2c-rcar.c
>>> b/drivers/i2c/busses/i2c-rcar.c
>>> index 2c2fd7c..0d25104 100644
>>> --- a/drivers/i2c/busses/i2c-rcar.c
>>> +++ b/drivers/i2c/busses/i2c-rcar.c
>>> @@ -623,7 +623,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter
>>> *adap,
>>>
>>>       pm_runtime_put(dev);
>>>
>>> -    if (ret < 0)
>>> +    if (ret < 0 && ret != -EREMOTEIO)
>>>           dev_err(dev, "error %d : %x\n", ret, priv->flags);

>>     Hm, I'm now getting -EBUSY and -EAGAIN running i2cdetect on R8A7791
>> base Henninger board. Only when I comment out the above 2 lines, I can
>> get the bus scanned, otherwise I don't see any devices at all.

> i2c-detect does not work well on the i2c-rcar due to it insisting
> on sending or receiving at-least one byte of data.

   I've noticed that it works more or less reliable only the first time I run 
it, on subsequent runs it only sees devices for which a driver is bound, IIRC.

> I think it
> is possible that it confuses some of the bus devices.

    Yes, it seems to be the case. However, with these lines commented out, it 
still works the first time...

WBR, Sergei

