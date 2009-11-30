From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 30 Nov 2009 11:19:36 +0000
Subject: Re: [PATCH 02/02] clocksource: Start CMT at clocksource resume
Message-Id: <aec7e5c30911300319i115efdb6p215984377cb97f22@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091125081235.25416.32481.sendpatchset@rxone.opensource.se>
	 <20091125081255.25416.85126.sendpatchset@rxone.opensource.se>
	 <alpine.LFD.2.00.0911281457560.24119@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0911281457560.24119@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-sh@vger.kernel.org, johnstul@us.ibm.com, lethal@linux-sh.org

Hi Thomas,

On Sat, Nov 28, 2009 at 11:00 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 25 Nov 2009, Magnus Damm wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add code to start the CMT timer on clocksource resume.
>>
>> This makes sure the timer is started during sysdev_resume().
>> Without this patch the clocksource may be read as suspended,
>> this after sysdev resume but before platform device resume.
>
> Hmm, don't you have the same situation on suspend ?
>
> platform device suspend stops the clock, but the generic code expects
> it to be running until sysdev shutdown.

You are correct, the same situation exists on suspend.

> Another thing is that you now run both, the sysdev and the platform
> resume. Is that by design or accident ?

By incorrect design. =)

To fix this properly I was thinking of adding a clocksource suspend()
callback and ditch the platform ops all together. If you don't mind
then I'll post a patch for that tomorrow!

Thank you!

/ magnus
