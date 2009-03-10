From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Mar 2009 10:52:45 +0000
Subject: Re: [PATCH] input: add suspend wakeup support to sh_keysc
Message-Id: <aec7e5c30903100352o611e6cake0ddd50fed1d6975@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 10, 2009 at 7:43 PM, Trilok Soni <soni.trilok@gmail.com> wrote:
>>> Please add device_init_wakeup(&pdev->dev, 0) in sh_keysc_remove.
>>
>> Isn't this just flagging the device as wakeup capable? My first guess
>> would be that the the wakeup state of a removed device is irrelevant
>> since it won't be suspended anyway. Or am I misunderstanding? Please
>> explain in more detail.
>
> I may not have complete answer, but I am thinking of someone depending/reading
> on wakeup file state to determine the state of your device in userspace will get
> confused, so better to disable to wakeup capability on remove.

I think the per device wakeup file will disappear from sysfs when the
device gets removed, so resetting the flag in the remove() callback
just makes the driver code more confusing in my opinion. =)

Cheers,

/ magnus
