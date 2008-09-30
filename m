From: "Francis Moreau" <francis.moro@gmail.com>
Date: Tue, 30 Sep 2008 18:51:08 +0000
Subject: Re: HOTPLUG_CPU is not defined
Message-Id: <38b2ab8a0809301151g3a89a1cck4d1cdbaafa2ceeb3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <6iabdp61h3.fsf@mars.wyplay.int>
In-Reply-To: <6iabdp61h3.fsf@mars.wyplay.int>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 8:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Sep 30, 2008 at 06:30:00PM +0200, Francis Moreau wrote:
>> Any reasons why this macro is not defined for SH ?
>>
> Yes, it's not implemented.
>

Well, it doesn't really matter and it avoids some warnings emitted
by Kconfig because of this in kernel/power/Kconfig:


config PM_SLEEP_SMP
        bool
        ....
        select HOTPLUG_CPU
        default y

thanks
-- 
Francis
