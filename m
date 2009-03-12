From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Thu, 12 Mar 2009 08:54:23 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <49B8CDBF.9090307@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
>
> Yeah, notification is needed.
... Yes unfortunately...
>
>>> Are you using cpuidle?
>> Not currently and I think it will be not so easy to use for us.
>
> Because of A-SMP?
Yes
> I have a cpuidle prototype running, but I need to improve the clock
> framework code to track dependencies better before I can integrate it
> upstream.
Interesting when available I will see it.
>
>>> What about cpufreq?
>> Supported.
>
> Still on my TODO-list. The SuperH Mobile devices have quite a few
> restrictions on which divider combinations that are allowed for the
> system clocks. So if someone changes the processor clock for instance,
> many other clocks may need to follow.
Yes I understand... the famous sh4_clk/sh4_per/module_clk ratios..) ...
We still have some platform with these constraints...
What I can say you is that the timer-tmu.c is already ready for this kind
 of operation and you will have no impact on the system timer or No_HZ 
system.

>
> I see. Some partial system suspend (some devices suspended only) would
> be good to have, don't you think?
Yes I agree. But I prefer a tool to leave the people free to create 
their own 'profile'.

Ciao
 Francesco
