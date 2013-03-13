From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 13 Mar 2013 10:31:44 +0000
Subject: Re: Serial port RTPM/Suspend issues
Message-Id: <CABYn4szWhpYJhma1Q=yW_Au6mKcasY==w3d3v8kXDsUhpf_V1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
In-Reply-To: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2013/3/13 Bastian Hecht <hechtb@gmail.com>:
> Hi Paul,
>
> 2013/3/12 Paul Mundt <lethal@linux-sh.org>:
>> On Tue, Mar 12, 2013 at 04:31:57PM +0100, Bastian Hecht wrote:
>>> 2013/3/12 Paul Mundt <lethal@linux-sh.org>:
>>> > On Tue, Mar 12, 2013 at 03:50:42PM +0100, Bastian Hecht wrote:
>>> >> To avoid confusion, let me add: Garbage is produced when waking, not
>>> >> in the shutdown process.
>>> >
>>> > I assume this is just data left in the FIFO that hasn't been drained that
>>> > comes back in an undefined state due to losing the clock?
>>>
>>> The port hangs after printing a couple of dozens of characters. The
>>> system itself seems stable - I can log into it using ssh.
>>> Does this fit with your theory?
>>>
>> There are two theories really, residual FIFO data or baud rate generation
>> issues. Your dozens of characters thing seems to support the former,
>> given the FIFO size -- the latter would more likely generate a lot more
>> spew.
>
> Ok I dumped the output into a file and realized that the garbage is
> just one line but this contains 7343 characters - so a bit more than a
> couple of dozens.
>
>>> By the way I am using a shallow sleep to test it. Just cpu_do_idle().
>>
>> Can you see how it goes booting with nohlt? We have seen issues between
>> BL bit and sleep interactivity before.
>
> nohlt didn't improve things.

Ok I found out that the SUB clock gets turned off when all depending
devices are off. And skipping the shut down of the SUB clock let's the
sci.1 survive.
