From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Sat, 27 Sep 2008 17:12:29 +0000
Subject: Re: SH7722 serial scif
Message-Id: <aec7e5c30809271012s749ce1a0hc110fe2a9d5fc6e7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
In-Reply-To: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 25, 2008 at 6:17 PM, Michael Trimarchi
<trimarchimichael@yahoo.it> wrote:
>> Ok, that's interesting. There are a couple things to consider here:
>>
>>     - startup/shutdown both set and clear the RX and TX IRQ enable
>>       bits
>>     - the base SCSCR initialization is maintained across the lifetime
>>       of the port, and is directly manipulated by the termios value.
>>
>> We need the initialization in the set_termios path for things like the
>> system console, which can be suspended/resumed, as well as handling
>> rate changes directly (not related to the frequency notifier).
>>
>> Given that, moving this out to the startup/shutdown path is definitely
>> not what we want to do, but we do need to figure out what your SCSCR
>> register state is at the time of startup and shutdown. There are a couple
>> of possibilities:
>>
>>     - IRQ not properly acked and cleared at shutdown time, despite
>>       the TX/RX bits being cleared.
>>     - Some bit setting in the SCSCR_INIT definition for your platform
>>       that we need to be more careful in handling.
>>
>> If we look at the setting for 7722, it's the usual mix of TE/RE/REIE and
>> nothing particularly exotic, so we can probably just swallow these up in
>> the sci_start_tx/rx()/sci_stop_tx/rx() pairs, and that should
>> subsequently get your SCSCR value pretty much back to 0 at shutdown time.
>
> After revert my code, and take a look to the SCSCR register before
> open and shutdown, this is the result.
>
> I found a SCSCR equal to 0x38 after and before, so the bit are not cleared but if I do an sci_out of 0
> to the register, all seems to be ok.
>
> It is very strange, it seems the SCSCR status does't change
> after the sci_stop_tx e sci_stop_rx
>
>
> Any idea?

This may be far off, but is the MSTPCR clock stop bit setup properly
for your particular SCIF channel?

/ magnus
